import { BACKEND_URL, METRIC_KEY, UNIT } from "./config";
import { DateKey } from "./date";
import { Entry } from "./stats";

interface SeriesRow {
  time: string;
  value: number | string;
}

/** Maps `/metrics/{key}/series` rows to entries, newest first. */
export function mapSeries(rows: SeriesRow[]): Entry[] {
  return rows
    .map((row) => ({
      date: row.time.slice(0, 10) as DateKey,
      drinks: Number(row.value),
    }))
    .sort((a, b) => b.date.localeCompare(a.date));
}

export async function fetchSeries(signal?: AbortSignal): Promise<Entry[]> {
  const res = await fetch(`${BACKEND_URL}/metrics/${METRIC_KEY}/series`, { signal });
  if (!res.ok) throw new Error(`Series request failed (${res.status})`);
  return mapSeries(await res.json());
}

/** Sets the total for a day. The API treats this as last-write-wins. */
export async function recordDailyTotal(date: DateKey, value: number): Promise<void> {
  const res = await fetch(`${BACKEND_URL}/commands/record-daily-total`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ metricKey: METRIC_KEY, date, value, unit: UNIT }),
  });
  if (!res.ok) throw new Error(`Check-in failed (${res.status})`);
}
