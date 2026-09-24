import {
  currentStreak,
  lastLoggedDate,
  longestStreak,
  nextCheckinDate,
  summarize,
  toEntryMap,
} from "./stats";

const CAP = 4;
const TODAY = "2025-09-24";

describe("nextCheckinDate", () => {
  it("is the day after the last check-in", () => {
    const map = toEntryMap([
      { date: "2025-09-22", drinks: 2 },
      { date: "2025-09-21", drinks: 0 },
    ]);
    expect(nextCheckinDate(map, TODAY)).toBe("2025-09-23");
  });

  it("ignores older gaps in the history", () => {
    // A week away in June is never offered up again.
    const map = toEntryMap([
      { date: "2025-06-01", drinks: 1 },
      { date: "2025-09-22", drinks: 2 },
    ]);
    expect(nextCheckinDate(map, TODAY)).toBe("2025-09-23");
  });

  it("never runs past today", () => {
    const map = toEntryMap([{ date: TODAY, drinks: 1 }]);
    expect(nextCheckinDate(map, TODAY)).toBe(TODAY);
  });

  it("is today for a first-time user", () => {
    expect(nextCheckinDate({}, TODAY)).toBe(TODAY);
  });

  it("walks forward one day per check-in", () => {
    let map = toEntryMap([{ date: "2025-09-20", drinks: 2 }]);
    expect(nextCheckinDate(map, TODAY)).toBe("2025-09-21");
    map = { ...map, "2025-09-21": 1 };
    expect(nextCheckinDate(map, TODAY)).toBe("2025-09-22");
  });
});

describe("lastLoggedDate", () => {
  it("ignores days after today", () => {
    const map = toEntryMap([
      { date: "2025-09-22", drinks: 1 },
      { date: "2025-09-30", drinks: 3 },
    ]);
    expect(lastLoggedDate(map, TODAY)).toBe("2025-09-22");
  });

  it("is null with no entries", () => {
    expect(lastLoggedDate({}, TODAY)).toBeNull();
  });
});

describe("streaks", () => {
  it("counts back from the last check-in while at or under the cap", () => {
    const map = toEntryMap([
      { date: "2025-09-22", drinks: 2 },
      { date: "2025-09-21", drinks: 0 },
      { date: "2025-09-20", drinks: 4 },
      { date: "2025-09-19", drinks: 6 },
    ]);
    expect(currentStreak(map, CAP, TODAY)).toBe(3);
  });

  it("breaks on a missing day", () => {
    const map = toEntryMap([
      { date: "2025-09-22", drinks: 1 },
      { date: "2025-09-20", drinks: 1 },
    ]);
    expect(currentStreak(map, CAP, TODAY)).toBe(1);
  });

  it("finds the longest run in the history", () => {
    const map = toEntryMap([
      { date: "2025-09-16", drinks: 0 },
      { date: "2025-09-17", drinks: 1 },
      { date: "2025-09-18", drinks: 2 },
      { date: "2025-09-19", drinks: 9 },
      { date: "2025-09-20", drinks: 0 },
      { date: "2025-09-21", drinks: 0 },
    ]);
    expect(longestStreak(map, CAP, TODAY)).toBe(3);
    expect(currentStreak(map, CAP, TODAY)).toBe(2);
  });

  it("is zero with no entries", () => {
    expect(currentStreak({}, CAP, TODAY)).toBe(0);
    expect(longestStreak({}, CAP, TODAY)).toBe(0);
  });
});

describe("summarize", () => {
  it("averages over logged days only, and counts dry and over-cap days", () => {
    const map = toEntryMap([
      { date: "2025-09-24", drinks: 0 },
      { date: "2025-09-23", drinks: 3 },
      { date: "2025-09-22", drinks: 6 },
      // 2025-09-21 missing
      { date: "2025-09-20", drinks: 1 },
    ]);
    const summary = summarize(map, CAP, TODAY);
    expect(summary.total7).toBe(10);
    expect(summary.average7).toBeCloseTo(2.5);
    expect(summary.dry30).toBe(1);
    expect(summary.over30).toBe(1);
  });

  it("reports no average when nothing is logged", () => {
    expect(summarize({}, CAP, TODAY).average7).toBeNull();
  });
});
