/**
 * Local-date helpers.
 *
 * Everything here works from the *local* calendar day. `toISOString()` is
 * deliberately never used to derive a day: west of UTC it rolls a local
 * midnight back into the previous day, which shifted the whole activity grid
 * by one.
 */

/** A calendar day, `YYYY-MM-DD`. Sorts correctly as a string. */
export type DateKey = string;

const pad = (n: number) => (n < 10 ? `0${n}` : `${n}`);

/** The local calendar day of `d`. */
export function toKey(d: Date): DateKey {
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
}

/** Local midnight on `key`. */
export function fromKey(key: DateKey): Date {
  const [y, m, d] = key.split("-").map(Number);
  return new Date(y, m - 1, d);
}

/** Local midnight today. */
export function startOfToday(): Date {
  const now = new Date();
  return new Date(now.getFullYear(), now.getMonth(), now.getDate());
}

/** `d` moved by `n` days, at local midnight. DST-safe. */
export function addDays(d: Date, n: number): Date {
  const copy = new Date(d.getFullYear(), d.getMonth(), d.getDate());
  copy.setDate(copy.getDate() + n);
  return copy;
}

/** `key` moved by `n` days. */
export function shiftKey(key: DateKey, n: number): DateKey {
  return toKey(addDays(fromKey(key), n));
}

/** "Tue, Sep 22", adding the year only when it isn't the current one. */
export function formatDay(key: DateKey, todayKey: DateKey, locale?: string): string {
  const d = fromKey(key);
  const options: Intl.DateTimeFormatOptions = {
    weekday: "short",
    month: "short",
    day: "numeric",
  };
  if (d.getFullYear() !== fromKey(todayKey).getFullYear()) options.year = "numeric";
  return d.toLocaleDateString(locale, options);
}

/** "Sep 2025" */
export function formatMonth(key: DateKey, locale?: string): string {
  return fromKey(key).toLocaleDateString(locale, { month: "short" });
}

/**
 * The activity grid: columns are weeks, rows are days of the week starting on
 * Sunday. The first column is padded with nulls so every row is a weekday, and
 * the last cell is today.
 */
export function buildWeeks(todayKey: DateKey, days = 364): (DateKey | null)[][] {
  const today = fromKey(todayKey);
  const first = addDays(today, -(days - 1));
  const start = addDays(first, -first.getDay()); // back up to Sunday

  const weeks: (DateKey | null)[][] = [];
  let cursor = start;
  while (cursor <= today) {
    const week: (DateKey | null)[] = [];
    for (let i = 0; i < 7; i++) {
      week.push(cursor < first || cursor > today ? null : toKey(cursor));
      cursor = addDays(cursor, 1);
    }
    weeks.push(week);
  }
  return weeks;
}
