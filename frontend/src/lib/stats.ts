import { DateKey, shiftKey } from "./date";

export interface Entry {
  date: DateKey;
  drinks: number;
}

/** Day -> drinks. A day with no check-in is simply absent. */
export type EntryMap = Record<DateKey, number>;

export function toEntryMap(entries: Entry[]): EntryMap {
  const map: EntryMap = {};
  for (const e of entries) map[e.date] = e.drinks;
  return map;
}

/** The most recent day that actually has a check-in, at or before today. */
export function lastLoggedDate(map: EntryMap, todayKey: DateKey): DateKey | null {
  let latest: DateKey | null = null;
  for (const key of Object.keys(map)) {
    if (key <= todayKey && (latest === null || key > latest)) latest = key;
  }
  return latest;
}

/**
 * The day the check-in form should open on: the day after your last actual
 * check-in, never later than today.
 *
 * It deliberately does not hunt for the earliest hole in the history — a gap
 * from a week you were away stays a gap until you step back to it on purpose.
 */
export function nextCheckinDate(map: EntryMap, todayKey: DateKey): DateKey {
  const last = lastLoggedDate(map, todayKey);
  if (!last) return todayKey;
  const next = shiftKey(last, 1);
  return next > todayKey ? todayKey : next;
}

/** Consecutive days at or under `cap`, counting back from the last check-in. */
export function currentStreak(map: EntryMap, cap: number, todayKey: DateKey): number {
  let key = lastLoggedDate(map, todayKey);
  let days = 0;
  while (key) {
    const value = map[key];
    if (value === undefined || value > cap) break;
    days += 1;
    key = shiftKey(key, -1);
  }
  return days;
}

/** The longest such run anywhere in the history. A missing day breaks a run. */
export function longestStreak(map: EntryMap, cap: number, todayKey: DateKey): number {
  const keys = Object.keys(map)
    .filter((key) => key <= todayKey)
    .sort();
  if (keys.length === 0) return 0;

  const end = keys[keys.length - 1];
  let cursor = keys[0];
  let best = 0;
  let run = 0;
  while (cursor <= end) {
    const value = map[cursor];
    if (value !== undefined && value <= cap) {
      run += 1;
      if (run > best) best = run;
    } else {
      run = 0;
    }
    cursor = shiftKey(cursor, 1);
  }
  return best;
}

export interface Summary {
  /** Drinks logged in the last 7 days. */
  total7: number;
  /** Average per logged day over the last 7 days; null when nothing is logged. */
  average7: number | null;
  /** Days with zero drinks in the last 30. */
  dry30: number;
  /** Days over the cap in the last 30. */
  over30: number;
}

function valuesInWindow(map: EntryMap, todayKey: DateKey, days: number): number[] {
  const values: number[] = [];
  for (let i = 0; i < days; i++) {
    const value = map[shiftKey(todayKey, -i)];
    if (value !== undefined) values.push(value);
  }
  return values;
}

export function summarize(map: EntryMap, cap: number, todayKey: DateKey): Summary {
  const week = valuesInWindow(map, todayKey, 7);
  const month = valuesInWindow(map, todayKey, 30);
  const total7 = week.reduce((a, b) => a + b, 0);
  return {
    total7,
    average7: week.length ? total7 / week.length : null,
    dry30: month.filter((v) => v === 0).length,
    over30: month.filter((v) => v > cap).length,
  };
}
