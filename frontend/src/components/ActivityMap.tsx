"use client";

import React, { useEffect, useMemo, useRef, useState } from "react";
import Box from "@mui/material/Box";
import { DateKey, buildWeeks, formatDay, formatMonth, fromKey, shiftKey } from "@/lib/date";
import { EntryMap } from "@/lib/stats";
import { Tokens, v } from "@/theme/tokens";

const CELL = 13;
const GAP = 3;
const COLUMN = CELL + GAP;
const WEEKDAY_LABELS = ["", "Mon", "", "Wed", "", "Fri", ""];

interface Props {
  entries: EntryMap;
  cap: number;
  todayKey: DateKey;
  selected: DateKey;
  onSelect: (key: DateKey) => void;
  days?: number;
}

/** Magnitude on one ramp; zero and over-cap are their own states. */
function cellStyle(value: number | undefined, cap: number): React.CSSProperties {
  if (value === undefined) {
    return { background: "transparent", boxShadow: `inset 0 0 0 1px ${v("cell-line")}` };
  }
  if (value === 0) return { background: v("clear") };
  if (value > cap) {
    return { background: v("over"), boxShadow: `inset 0 0 0 1.5px ${v("over-ring")}` };
  }
  const step = Math.min(Math.max(Math.ceil((value / cap) * 4), 1), 4);
  return { background: v(`ramp-${step}` as keyof Tokens) };
}

function describe(key: DateKey, value: number | undefined, todayKey: DateKey): string {
  const day = formatDay(key, todayKey);
  if (value === undefined) return `${day} — no check-in`;
  return `${day} — ${value} ${value === 1 ? "drink" : "drinks"}`;
}

export function ActivityMap({ entries, cap, todayKey, selected, onSelect, days = 364 }: Props) {
  const scroller = useRef<HTMLDivElement>(null);
  const grid = useRef<HTMLDivElement>(null);
  const [tip, setTip] = useState<{ text: string; x: number; y: number } | null>(null);

  const weeks = useMemo(() => buildWeeks(todayKey, days), [todayKey, days]);

  // Open on today rather than a year ago.
  useEffect(() => {
    const el = scroller.current;
    if (el) el.scrollLeft = el.scrollWidth;
  }, []);

  const months = useMemo(
    () =>
      weeks.map((week) => {
        const first = week.find((key): key is DateKey => key !== null);
        if (!first) return "";
        const date = fromKey(first);
        return date.getDate() <= 7 ? formatMonth(first) : "";
      }),
    [weeks],
  );

  const showTip = (key: DateKey, target: HTMLElement) => {
    const rect = target.getBoundingClientRect();
    setTip({
      text: describe(key, entries[key], todayKey),
      x: rect.left + rect.width / 2,
      y: rect.top - 8,
    });
  };

  const onKeyDown = (event: React.KeyboardEvent) => {
    const moves: Record<string, number> = {
      ArrowLeft: -1,
      ArrowRight: 1,
      ArrowUp: -7,
      ArrowDown: 7,
    };
    const step = moves[event.key];
    if (step === undefined) return;
    event.preventDefault();
    const next = shiftKey(selected, step);
    if (next > todayKey || next < (weeks[0].find(Boolean) as DateKey)) return;
    onSelect(next);
    requestAnimationFrame(() => {
      grid.current?.querySelector<HTMLElement>(`[data-key="${next}"]`)?.focus();
    });
  };

  return (
    <Box>
      <Box
        ref={scroller}
        onScroll={() => setTip(null)}
        sx={{
          overflowX: "auto",
          overflowY: "hidden",
          pb: 0.5,
          scrollbarWidth: "thin",
          scrollbarColor: `${v("line")} transparent`,
          "&::-webkit-scrollbar": { height: 6 },
          "&::-webkit-scrollbar-thumb": { background: v("line"), borderRadius: 3 },
        }}
      >
        <Box sx={{ display: "flex", gap: "6px", width: "max-content" }}>
          {/* Weekday rail: stays put while the year scrolls past it. */}
          <Box
            aria-hidden
            sx={{
              display: "flex",
              flexDirection: "column",
              gap: `${GAP}px`,
              pt: "17px",
              pr: "5px",
              position: "sticky",
              left: 0,
              zIndex: 2,
              background: v("surface"),
            }}
          >
            {WEEKDAY_LABELS.map((label, i) => (
              <Box
                key={i}
                sx={{
                  height: CELL,
                  lineHeight: `${CELL}px`,
                  width: 18,
                  fontSize: 9,
                  textAlign: "right",
                  color: v("ink-3"),
                }}
              >
                {label}
              </Box>
            ))}
          </Box>

          <Box sx={{ display: "flex", flexDirection: "column", gap: "4px" }}>
            <Box aria-hidden sx={{ display: "flex", height: 13 }}>
              {months.map((label, i) => (
                <Box key={i} sx={{ position: "relative", width: COLUMN, flex: "none" }}>
                  {label && (
                    <Box
                      component="span"
                      sx={{
                        position: "absolute",
                        left: 0,
                        top: 0,
                        fontSize: 9.5,
                        letterSpacing: "0.04em",
                        textTransform: "uppercase",
                        whiteSpace: "nowrap",
                        color: v("ink-3"),
                      }}
                    >
                      {label}
                    </Box>
                  )}
                </Box>
              ))}
            </Box>

            <Box
              ref={grid}
              onKeyDown={onKeyDown}
              onMouseLeave={() => setTip(null)}
              sx={{ display: "flex", gap: `${GAP}px` }}
            >
              {weeks.map((week, wi) => (
                <Box key={wi} sx={{ display: "flex", flexDirection: "column", gap: `${GAP}px` }}>
                  {week.map((key, di) =>
                    key === null ? (
                      <Box key={`${wi}-${di}`} sx={{ width: CELL, height: CELL }} />
                    ) : (
                      <Box
                        key={key}
                        component="button"
                        type="button"
                        data-key={key}
                        tabIndex={key === selected ? 0 : -1}
                        aria-label={describe(key, entries[key], todayKey)}
                        aria-current={key === selected ? "date" : undefined}
                        onClick={() => onSelect(key)}
                        onMouseEnter={(e: React.MouseEvent<HTMLElement>) =>
                          showTip(key, e.currentTarget)
                        }
                        onFocus={(e: React.FocusEvent<HTMLElement>) => showTip(key, e.currentTarget)}
                        onBlur={() => setTip(null)}
                        style={cellStyle(entries[key], cap)}
                        sx={{
                          width: CELL,
                          height: CELL,
                          p: 0,
                          border: "none",
                          borderRadius: "3px",
                          cursor: "pointer",
                          outline: key === selected ? `2px solid ${v("ink")}` : "none",
                          outlineOffset: "1px",
                          "&:hover": { outline: `2px solid ${v("ink-2")}`, outlineOffset: "1px" },
                        }}
                      />
                    ),
                  )}
                </Box>
              ))}
            </Box>
          </Box>
        </Box>
      </Box>

      <Legend cap={cap} />

      {tip && (
        <Box
          role="presentation"
          sx={{
            position: "fixed",
            left: tip.x,
            top: tip.y,
            transform: "translate(-50%, -100%)",
            zIndex: 40,
            pointerEvents: "none",
            px: 1.1,
            py: 0.6,
            borderRadius: "8px",
            fontSize: 11.5,
            whiteSpace: "nowrap",
            background: v("surface-2"),
            color: v("ink"),
            border: `1px solid ${v("line")}`,
            boxShadow: "0 8px 22px -12px rgba(0,0,0,.7)",
          }}
        >
          {tip.text}
        </Box>
      )}
    </Box>
  );
}

function Swatch({ style }: { style: React.CSSProperties }) {
  return <Box sx={{ width: 11, height: 11, borderRadius: "3px" }} style={style} />;
}

function Legend({ cap }: { cap: number }) {
  return (
    <Box
      sx={{
        display: "flex",
        alignItems: "center",
        flexWrap: "wrap",
        gap: 1.25,
        mt: 1.75,
        fontSize: 10.5,
        color: v("ink-3"),
      }}
    >
      <span>none</span>
      <Swatch style={cellStyle(undefined, cap)} />
      <span>dry</span>
      <Swatch style={cellStyle(0, cap)} />
      <Box sx={{ display: "flex", gap: "3px" }}>
        {[1, 2, 3, 4].map((step) => (
          <Swatch key={step} style={{ background: v(`ramp-${step}` as keyof Tokens) }} />
        ))}
      </Box>
      <span>1–{cap}</span>
      <Swatch style={cellStyle(cap + 1, cap)} />
      <span>over cap</span>
    </Box>
  );
}
