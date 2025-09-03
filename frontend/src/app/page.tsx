
"use client";
import React, { useState, useEffect } from "react";
import {
  Container,
  Typography,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TextField,
  Button,
  Stack,
} from "@mui/material";

interface DrinkEntry {
  date: string;
  drinks: number;
}

export default function Home() {
  const [date, setDate] = useState(() => {
    const today = new Date();
    return today.toISOString().slice(0, 10);
  });
  const [drinks, setDrinks] = useState<number>(0);
  const [entries, setEntries] = useState<DrinkEntry[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Fetch recent entries from API
  useEffect(() => {
    const fetchEntries = async () => {
      try {
        const res = await fetch("http://localhost:8081/metrics/alcoholic_drinks/series");
        if (!res.ok) throw new Error("Failed to fetch entries");
        const data = await res.json();
        // Map API response to DrinkEntry[]
        const mapped: DrinkEntry[] = data
          .map((row: any) => ({
            date: row.time.slice(0, 10),
            drinks: Number(row.value),
          }))
          .sort((a: DrinkEntry, b: DrinkEntry) => b.date.localeCompare(a.date));
        setEntries(mapped);
      } catch (err) {
        setError("Failed to fetch entries.");
      }
    };
    fetchEntries();
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    try {
      const res = await fetch("http://localhost:8081/commands/record-daily-total", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          metricKey: "alcoholic_drinks",
          date,
          value: drinks,
          unit: "drink",
        }),
      });
      if (!res.ok) throw new Error("Failed to log drinks");
      // Refresh entries after successful log
      const fetchEntries = async () => {
        try {
          const res = await fetch("http://localhost:8081/metrics/alcoholic_drinks/series");
          if (!res.ok) throw new Error("Failed to fetch entries");
          const data = await res.json();
          const mapped: DrinkEntry[] = data
            .map((row: any) => ({
              date: row.time.slice(0, 10),
              drinks: Number(row.value),
            }))
            .sort((a: DrinkEntry, b: DrinkEntry) => b.date.localeCompare(a.date));
          setEntries(mapped);
        } catch (err) {
          setError("Failed to fetch entries.");
        }
      };
      await fetchEntries();
      setDrinks(0);
    } catch (err: any) {
      setError("Failed to log drinks.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Container maxWidth="sm" sx={{ py: 4 }}>
      <Typography variant="h4" align="center" gutterBottom>
        Daily Drinks Tracker
      </Typography>
      <Paper elevation={3} sx={{ p: 3, mb: 4 }}>
        <form onSubmit={handleSubmit}>
          <Stack spacing={2}>
            <TextField
              label="Date"
              type="date"
              value={date}
              onChange={(e) => setDate(e.target.value)}
              InputLabelProps={{ shrink: true }}
              fullWidth
            />
            <TextField
              label="Drinks"
              type="number"
              value={drinks}
              onChange={(e) => setDrinks(Number(e.target.value))}
              inputProps={{ min: 0 }}
              fullWidth
            />
            <Button type="submit" variant="contained" disabled={loading}>
              {loading ? "Logging..." : "Log Drinks"}
            </Button>
            {error && (
              <Typography color="error" variant="body2">
                {error}
              </Typography>
            )}
          </Stack>
        </form>
      </Paper>
      <Typography variant="h6" gutterBottom>
        Recent Entries
      </Typography>
      <TableContainer component={Paper}>
        <Table size="small">
          <TableHead>
            <TableRow>
              <TableCell>Date</TableCell>
              <TableCell align="right">Drinks</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {entries.map((entry) => (
              <TableRow key={entry.date}>
                <TableCell>{entry.date}</TableCell>
                <TableCell align="right">{entry.drinks}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </Container>
  );
}
