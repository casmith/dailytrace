import React from "react";

const WEEKDAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

export function ActivityMap({ entries, limit = 2 }: { entries: { date: string; drinks: number }[]; limit?: number }) {
  // Build a map of date to drinks
  const data: Record<string, number> = {};
  entries.forEach((e) => {
    data[e.date] = e.drinks;
  });

  // Get the last 12 months (or less if not enough data)
  const today = new Date();
  const start = new Date(today.getFullYear(), today.getMonth() - 11, 1);
  const days: string[] = [];
  for (let d = new Date(start); d <= today; d.setDate(d.getDate() + 1)) {
    days.push(d.toISOString().slice(0, 10));
  }

  // Group days by week (GitHub style: columns = weeks, rows = days of week)
  const weeks: string[][] = [];
  let week: string[] = [];
  for (let i = 0; i < days.length; i++) {
    const date = days[i];
    const dayOfWeek = new Date(date).getDay();
    if (i === 0 && dayOfWeek !== 0) {
      // pad first week
      for (let pad = 0; pad < dayOfWeek; pad++) week.push("");
    }
    week.push(date);
    if (week.length === 7) {
      weeks.push(week);
      week = [];
    }
  }
  if (week.length) {
    while (week.length < 7) week.push("");
    weeks.push(week);
  }

  // Month labels (top row)
  const monthLabels: string[] = [];
  let lastMonth = "";
  weeks.forEach((week, i) => {
    const firstDate = week.find((d) => d);
    if (firstDate) {
      const month = new Date(firstDate).toLocaleString("default", { month: "short" });
      if (month !== lastMonth) {
        monthLabels[i] = month;
        lastMonth = month;
      } else {
        monthLabels[i] = "";
      }
    } else {
      monthLabels[i] = "";
    }
  });

  // Color scale: 0 = brightest, closer to limit = darker green, >limit = red, missing = grey
  function getColor(val: number | undefined) {
  if (val === undefined) return "#bdbdbd"; // missing data
  if (val === 0) return "#39d353"; // bright green (GitHub style)
  if (val > limit) return "#ff5252"; // red
  // interpolate green darkness by value
  const percent = Math.min(val / limit, 1);
  // from #39d353 (bright) to #007f00 (dark)
  const r = Math.round(57 - percent * (57 - 0));
  const g = Math.round(211 - percent * (211 - 127));
  const b = Math.round(83 - percent * (83 - 0));
  return `rgb(${r},${g},${b})`;
  }

  return (
    <div style={{ display: "flex", flexDirection: "column", alignItems: "center", margin: "24px 0" }}>
      {/* Month labels */}
      <div style={{ display: "flex", marginLeft: 40, marginBottom: 4 }}>
        {monthLabels.map((label, i) => (
          <div key={i} style={{ width: 14, textAlign: "center", fontSize: 12, color: "#ccc" }}>{label}</div>
        ))}
      </div>
      <div style={{ display: "flex" }}>
        {/* Weekday labels */}
        <div style={{ display: "flex", flexDirection: "column", marginRight: 4 }}>
          {WEEKDAYS.map((wd, i) => (
            (i % 2 === 1) ? (
              <div key={wd} style={{ height: 14, fontSize: 12, color: "#ccc", textAlign: "right", lineHeight: "14px" }}>{wd}</div>
            ) : <div key={wd} style={{ height: 14 }} />
          ))}
        </div>
        {/* Grid */}
        <div style={{ display: "flex" }}>
          {weeks.map((week, wi) => (
            <div key={wi} style={{ display: "flex", flexDirection: "column" }}>
              {week.map((date, di) => (
                <div
                  key={date || `${wi}-${di}`}
                  title={date ? (data[date] !== undefined ? `${date}: ${data[date]} drinks` : `${date}: no data`) : ""}
                  style={{
                    width: 12,
                    height: 12,
                    margin: 1,
                    background: date ? getColor(data[date]) : "transparent",
                    borderRadius: 2,
                    border: date ? "1px solid #222" : "none",
                    transition: "background 0.2s",
                  }}
                />
              ))}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
