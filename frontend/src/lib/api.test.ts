import { mapSeries } from "./api";

describe("mapSeries", () => {
  it("maps rows to entries, newest first", () => {
    expect(
      mapSeries([
        { time: "2025-09-07T05:00:00.000Z", value: 1 },
        { time: "2025-09-09T05:00:00.000Z", value: "3" },
        { time: "2025-09-08T05:00:00.000Z", value: 2 },
      ]),
    ).toEqual([
      { date: "2025-09-09", drinks: 3 },
      { date: "2025-09-08", drinks: 2 },
      { date: "2025-09-07", drinks: 1 },
    ]);
  });

  it("handles an empty series", () => {
    expect(mapSeries([])).toEqual([]);
  });
});
