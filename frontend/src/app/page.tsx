"use client";

import React, { useCallback, useEffect, useMemo, useState } from "react";
import Alert from "@mui/material/Alert";
import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import Skeleton from "@mui/material/Skeleton";
import Snackbar from "@mui/material/Snackbar";
import { ActivityMap } from "@/components/ActivityMap";
import { CheckIn } from "@/components/CheckIn";
import { Section } from "@/components/Section";
import { StatStrip } from "@/components/StatStrip";
import { StreakHero } from "@/components/StreakHero";
import { TopBar } from "@/components/TopBar";
import { fetchSeries, recordDailyTotal } from "@/lib/api";
import { DAILY_CAP, HISTORY_DAYS } from "@/lib/config";
import { DateKey, formatDay, fromKey, shiftKey, startOfToday, toKey } from "@/lib/date";
import {
  EntryMap,
  currentStreak,
  lastLoggedDate,
  longestStreak,
  nextCheckinDate,
  summarize,
  toEntryMap,
} from "@/lib/stats";
import { v } from "@/theme/tokens";

interface Undoable {
  date: DateKey;
  previous: number | undefined;
  message: string;
}

export default function Home() {
  // Resolved on the client: the static HTML must not bake in the build date.
  const [todayKey, setTodayKey] = useState<DateKey | null>(null);
  const [entries, setEntries] = useState<EntryMap>({});
  const [selected, setSelected] = useState<DateKey | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [toast, setToast] = useState<Undoable | null>(null);

  const load = useCallback(async (today: DateKey, selectDefault: boolean) => {
    setError(null);
    try {
      const map = toEntryMap(await fetchSeries());
      setEntries(map);
      if (selectDefault) setSelected(nextCheckinDate(map, today));
    } catch {
      setError("Couldn't reach the API. Check the backend and try again.");
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    const today = toKey(startOfToday());
    setTodayKey(today);
    setSelected(today);
    void load(today, true);
  }, [load]);

  const summary = useMemo(
    () => summarize(entries, DAILY_CAP, todayKey ?? ""),
    [entries, todayKey],
  );
  const lastDay = todayKey ? lastLoggedDate(entries, todayKey) : null;
  const nextDay = todayKey ? nextCheckinDate(entries, todayKey) : null;

  const log = async (value: number) => {
    if (!selected || !todayKey) return;
    const date = selected;
    const previous = entries[date];
    setBusy(true);
    setEntries((current) => ({ ...current, [date]: value })); // optimistic
    try {
      await recordDailyTotal(date, value);
      setToast({
        date,
        previous,
        message: `Logged ${value} for ${formatDay(date, todayKey)}`,
      });
      // Move on to the next day that needs a check-in.
      setSelected(nextCheckinDate({ ...entries, [date]: value }, todayKey));
      void load(todayKey, false);
    } catch {
      setEntries((current) => {
        const reverted = { ...current };
        if (previous === undefined) delete reverted[date];
        else reverted[date] = previous;
        return reverted;
      });
      setError(`Couldn't save ${formatDay(date, todayKey)}. Nothing was recorded.`);
    } finally {
      setBusy(false);
    }
  };

  const undo = async () => {
    if (!toast || toast.previous === undefined || !todayKey) return;
    const { date, previous } = toast;
    setToast(null);
    setBusy(true);
    try {
      await recordDailyTotal(date, previous);
      setEntries((current) => ({ ...current, [date]: previous }));
      setSelected(date);
      void load(todayKey, false);
    } catch {
      setError("Couldn't undo that check-in.");
    } finally {
      setBusy(false);
    }
  };

  const ready = todayKey !== null && selected !== null && !loading;

  return (
    <Box sx={{ minHeight: "100vh", background: v("bg"), py: { xs: 2, sm: 5 }, px: 1.5 }}>
      <Box
        sx={{
          position: "relative",
          maxWidth: 424,
          mx: "auto",
          background: v("surface"),
          border: `1px solid ${v("line")}`,
          borderRadius: { xs: "20px", sm: "26px" },
          overflow: "hidden",
          boxShadow: "0 24px 60px -30px rgba(0,0,0,.55)",
        }}
      >
        <TopBar />

        <StreakHero
          streak={ready ? currentStreak(entries, DAILY_CAP, todayKey) : 0}
          best={ready ? longestStreak(entries, DAILY_CAP, todayKey) : 0}
          lastDay={ready && lastDay ? formatDay(lastDay, todayKey) : null}
          cap={DAILY_CAP}
          loading={!ready}
        />

        <Section
          title="Daily standard drinks"
          aside={
            ready ? (
              <Box className="dt-num" sx={{ fontSize: 11, color: v("ink-3") }}>
                {`${fromKey(shiftKey(todayKey, -(HISTORY_DAYS - 1))).toLocaleDateString(undefined, {
                  month: "short",
                  year: "numeric",
                })} → today`}
              </Box>
            ) : null
          }
        >
          {ready ? (
            <ActivityMap
              entries={entries}
              cap={DAILY_CAP}
              todayKey={todayKey}
              selected={selected}
              onSelect={setSelected}
              days={HISTORY_DAYS}
            />
          ) : (
            <Skeleton variant="rounded" height={116} />
          )}
        </Section>

        {ready ? (
          <StatStrip summary={summary} />
        ) : (
          <Section>
            <Skeleton variant="rounded" height={44} />
          </Section>
        )}

        {ready && (
          <CheckIn
            selected={selected}
            value={entries[selected]}
            todayKey={todayKey}
            cap={DAILY_CAP}
            isNextCheckin={selected === nextDay}
            busy={busy}
            onSelectDate={setSelected}
            onLog={log}
          />
        )}

        {error && (
          <Box sx={{ px: 2.25, pb: 2.25 }}>
            <Alert
              severity="error"
              variant="outlined"
              action={
                todayKey && (
                  <Button color="inherit" size="small" onClick={() => void load(todayKey, !selected)}>
                    Retry
                  </Button>
                )
              }
            >
              {error}
            </Alert>
          </Box>
        )}

        <Snackbar
          open={toast !== null}
          autoHideDuration={4500}
          onClose={() => setToast(null)}
          anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
          sx={{ position: "absolute", left: 14, right: 14, bottom: 14, transform: "none" }}
          message={toast?.message}
          action={
            toast?.previous !== undefined ? (
              <Button size="small" onClick={() => void undo()} sx={{ color: v("accent") }}>
                Undo
              </Button>
            ) : undefined
          }
          ContentProps={{
            sx: {
              width: "100%",
              background: v("surface-2"),
              color: v("ink"),
              border: `1px solid ${v("line")}`,
              fontSize: 12.5,
              boxShadow: "0 14px 30px -18px rgba(0,0,0,.8)",
            },
          }}
        />
      </Box>
    </Box>
  );
}
