import { addDays, buildWeeks, formatDay, fromKey, shiftKey, toKey } from "./date";

describe("date keys", () => {
  it("uses the local calendar day, not UTC", () => {
    // 11pm local on the 22nd is still the 22nd, even where toISOString() would
    // roll it forward (east of UTC) or back (west of UTC).
    expect(toKey(new Date(2025, 8, 22, 23, 30))).toBe("2025-09-22");
    expect(toKey(new Date(2025, 8, 22, 0, 15))).toBe("2025-09-22");
  });

  it("round-trips a key", () => {
    expect(toKey(fromKey("2026-02-28"))).toBe("2026-02-28");
  });

  it("shifts across month and year boundaries", () => {
    expect(shiftKey("2025-08-31", 1)).toBe("2025-09-01");
    expect(shiftKey("2024-12-31", 1)).toBe("2025-01-01");
    expect(shiftKey("2025-03-01", -1)).toBe("2025-02-28");
    expect(shiftKey("2024-03-01", -1)).toBe("2024-02-29");
  });

  it("keeps midnight when crossing a DST boundary", () => {
    // US spring forward, 2025-03-09.
    expect(toKey(addDays(new Date(2025, 2, 8), 1))).toBe("2025-03-09");
    expect(toKey(addDays(new Date(2025, 2, 9), 1))).toBe("2025-03-10");
  });
});

describe("formatDay", () => {
  it("omits the year within the current year", () => {
    expect(formatDay("2025-09-22", "2025-09-24", "en-US")).toBe("Mon, Sep 22");
  });

  it("shows the year for any other year", () => {
    expect(formatDay("2024-09-22", "2025-09-24", "en-US")).toBe("Sun, Sep 22, 2024");
  });
});

describe("buildWeeks", () => {
  const weeks = buildWeeks("2025-09-24", 364);

  it("starts each column on a Sunday", () => {
    for (const week of weeks) {
      const first = week.find((key): key is string => key !== null);
      if (first && week[0] !== null) expect(fromKey(first).getDay()).toBe(0);
    }
  });

  it("pads the first column and ends on today", () => {
    expect(weeks[0].some((key) => key === null)).toBe(true);
    const flat = weeks.flat().filter((key): key is string => key !== null);
    expect(flat[flat.length - 1]).toBe("2025-09-24");
    expect(flat).toHaveLength(364);
  });
});
