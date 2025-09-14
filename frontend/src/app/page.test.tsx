// TypeScript interfaces for type safety
interface DrinkEntry {
  date: string;
  drinks: number;
}

interface ApiResponse {
  time: string;
  value: number;
}

// Test the date calculation logic without rendering the full component
describe("Home page date default logic", () => {
  // Test the date calculation function directly
  function calculateDefaultDate(entries: DrinkEntry[]): string {
    if (entries.length > 0) {
      const lastDate = entries[0].date;
      const nextDate = new Date(lastDate);
      nextDate.setDate(nextDate.getDate() + 1);
      return nextDate.toISOString().slice(0, 10);
    } else {
      const today = new Date();
      return today.toISOString().slice(0, 10);
    }
  }

  // Test the entries mapping from API response
  function mapApiResponseToEntries(apiData: ApiResponse[]): DrinkEntry[] {
    return apiData
      .map((row: ApiResponse) => ({
        date: row.time.slice(0, 10),
        drinks: Number(row.value),
      }))
      .sort((a: DrinkEntry, b: DrinkEntry) => b.date.localeCompare(a.date));
  }

  describe("calculateDefaultDate", (): void => {
    it("calculates next day after last check-in", (): void => {
      const mockEntries: DrinkEntry[] = [
        { date: "2025-09-09", drinks: 2 },
        { date: "2025-09-08", drinks: 1 },
      ];
      const result: string = calculateDefaultDate(mockEntries);
      expect(result).toBe("2025-09-10");
    });

    test("defaults to today when no entries exist", (): void => {
    const today: string = new Date().toISOString().slice(0, 10);
    const defaultDate: string = calculateDefaultDate([]);
    expect(defaultDate).toBe(today);
  });

    it("handles edge case with single entry", (): void => {
      const mockEntries: DrinkEntry[] = [{ date: "2025-09-01", drinks: 5 }];
      const result: string = calculateDefaultDate(mockEntries);
      expect(result).toBe("2025-09-02");
    });

    it("handles month boundary correctly", () => {
      const mockEntries = [{ date: "2025-08-31", drinks: 2 }];
      const result = calculateDefaultDate(mockEntries);
      expect(result).toBe("2025-09-01");
    });

    it("handles year boundary correctly", () => {
      const mockEntries = [{ date: "2024-12-31", drinks: 1 }];
      const result = calculateDefaultDate(mockEntries);
      expect(result).toBe("2025-01-01");
    });
  });

    describe("mapApiResponseToEntries", (): void => {
    it("maps API response to entries correctly", (): void => {
      const mockApiData: ApiResponse[] = [
        { time: "2025-09-09T00:00:00.000Z", value: 2 },
        { time: "2025-09-08T00:00:00.000Z", value: 1 },
      ];
      const result: DrinkEntry[] = mapApiResponseToEntries(mockApiData);
      expect(result).toEqual([
        { date: "2025-09-09", drinks: 2 },
        { date: "2025-09-08", drinks: 1 },
      ]);
    });

    it("sorts entries by date descending", (): void => {
      const mockApiData: ApiResponse[] = [
        { time: "2025-09-07T00:00:00.000Z", value: 1 },
        { time: "2025-09-09T00:00:00.000Z", value: 3 },
        { time: "2025-09-08T00:00:00.000Z", value: 2 },
      ];
      const result: DrinkEntry[] = mapApiResponseToEntries(mockApiData);
      expect(result).toEqual([
        { date: "2025-09-09", drinks: 3 },
        { date: "2025-09-08", drinks: 2 },
        { date: "2025-09-07", drinks: 1 },
      ]);
    });

    it("handles empty API response", () => {
      const apiResponse: ApiResponse[] = [];
      const result: DrinkEntry[] = mapApiResponseToEntries(apiResponse);
      expect(result).toEqual([]);
    });
  });

  describe("date update after submission workflow", (): void => {
    it("updates date correctly after new entry submission", (): void => {
      // Simulate initial state with entries up to 9/3
      const initialEntries: DrinkEntry[] = [
        { date: "2025-09-03", drinks: 2 },
        { date: "2025-09-02", drinks: 1 },
      ];
      let currentDate: string = calculateDefaultDate(initialEntries);
      expect(currentDate).toBe("2025-09-04");

      // Simulate adding new entry for 9/4
      const updatedEntries: DrinkEntry[] = [
        { date: "2025-09-04", drinks: 3 }, // New entry
        { date: "2025-09-03", drinks: 2 },
        { date: "2025-09-02", drinks: 1 },
      ];
      currentDate = calculateDefaultDate(updatedEntries);
      expect(currentDate).toBe("2025-09-05");
    });

    it("handles first-time user correctly", (): void => {
      // No entries initially
      let currentDate: string = calculateDefaultDate([]);
      const today: string = new Date().toISOString().slice(0, 10);
      expect(currentDate).toBe(today);

      // After first entry
      const firstEntry: DrinkEntry[] = [{ date: today, drinks: 1 }];
      currentDate = calculateDefaultDate(firstEntry);
      const tomorrow: Date = new Date();
      tomorrow.setDate(tomorrow.getDate() + 1);
      expect(currentDate).toBe(tomorrow.toISOString().slice(0, 10));
    });

    it("simulates the exact user scenario: 9/3 -> 9/4 -> 9/5", (): void => {
      // User's current state: last check-in was 9/3
      const currentEntries: DrinkEntry[] = [{ date: "2025-09-03", drinks: 2 }];
      let defaultDate: string = calculateDefaultDate(currentEntries);
      expect(defaultDate).toBe("2025-09-04"); // Form should default to 9/4

      // User submits entry for 9/4
      const afterSubmission: DrinkEntry[] = [
        { date: "2025-09-04", drinks: 1 }, // New entry
        { date: "2025-09-03", drinks: 2 },
      ];
      defaultDate = calculateDefaultDate(afterSubmission);
      expect(defaultDate).toBe("2025-09-05"); // Form should now default to 9/5
    });
  });
});