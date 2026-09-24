"use client";

import React from "react";
import Box from "@mui/material/Box";
import ButtonBase from "@mui/material/ButtonBase";
import IconButton from "@mui/material/IconButton";
import Typography from "@mui/material/Typography";
import { DateKey, formatDay, shiftKey } from "@/lib/date";
import { v } from "@/theme/tokens";

const CHOICES = [0, 1, 2, 3, 4, 5, 6];

interface Props {
  selected: DateKey;
  value: number | undefined;
  todayKey: DateKey;
  cap: number;
  /** True when the selected day is the one the form opened on. */
  isNextCheckin: boolean;
  busy: boolean;
  onSelectDate: (key: DateKey) => void;
  onLog: (value: number) => void;
}

export function CheckIn({
  selected,
  value,
  todayKey,
  cap,
  isNextCheckin,
  busy,
  onSelectDate,
  onLog,
}: Props) {
  const atToday = selected >= todayKey;

  const chipColors = (choice: number, active: boolean) => {
    if (!active) {
      return { background: v("surface-2"), borderColor: v("line"), color: v("ink-2") };
    }
    if (choice === 0) return { background: v("clear"), borderColor: v("clear"), color: v("on-clear") };
    if (choice > cap) return { background: v("over"), borderColor: v("over"), color: v("on-over") };
    return { background: v("accent"), borderColor: v("accent"), color: v("on-accent") };
  };

  return (
    <Box component="section" sx={{ px: 2.25, py: 2.5 }}>
      <Box sx={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 1 }}>
        <Typography variant="overline" sx={{ color: v("ink-3") }}>
          Check in
        </Typography>
        <Box sx={{ display: "flex", alignItems: "center", gap: 0.25 }}>
          <IconButton
            size="small"
            aria-label="Previous day"
            onClick={() => onSelectDate(shiftKey(selected, -1))}
            sx={{ color: v("ink-3"), fontSize: 15, width: 26, height: 26 }}
          >
            ‹
          </IconButton>
          <Box className="dt-num" sx={{ fontSize: 13, minWidth: 124, textAlign: "center" }}>
            {formatDay(selected, todayKey)}
          </Box>
          <IconButton
            size="small"
            aria-label="Next day"
            disabled={atToday}
            onClick={() => onSelectDate(shiftKey(selected, 1))}
            sx={{ color: v("ink-3"), fontSize: 15, width: 26, height: 26 }}
          >
            ›
          </IconButton>
        </Box>
      </Box>

      <Box sx={{ mt: 1.25, minHeight: 20 }}>
        {isNextCheckin && value === undefined && (
          <Box
            component="span"
            sx={{
              fontSize: 10,
              fontWeight: 600,
              letterSpacing: "0.06em",
              textTransform: "uppercase",
              color: v("accent"),
              background: v("accent-soft"),
              px: 0.9,
              py: 0.4,
              borderRadius: 10,
            }}
          >
            next day after your last check-in
          </Box>
        )}
      </Box>

      <Box sx={{ display: "grid", gridTemplateColumns: "repeat(7, 1fr)", gap: 0.75, mt: 1.75 }}>
        {CHOICES.map((choice) => {
          const isOpenEnded = choice === CHOICES.length - 1;
          const active = value !== undefined && (isOpenEnded ? value >= choice : value === choice);
          const label = isOpenEnded ? (active ? String(value) : `${choice}+`) : String(choice);
          // Tapping the open-ended chip again keeps counting up.
          const next = isOpenEnded && active ? (value as number) + 1 : choice;
          return (
            <ButtonBase
              key={choice}
              disabled={busy}
              onClick={() => onLog(next)}
              aria-label={`Log ${label} ${choice === 1 ? "drink" : "drinks"} for ${formatDay(selected, todayKey)}`}
              aria-pressed={active}
              className="dt-num"
              sx={{
                height: 46,
                borderRadius: "12px",
                border: "1px solid",
                fontSize: 15,
                fontWeight: active ? 500 : 400,
                transition: "transform .08s ease, background .12s ease",
                opacity: busy ? 0.5 : 1,
                "&:active": { transform: "scale(.94)" },
                "&:hover": active ? {} : { borderColor: v("ink-3"), color: v("ink") },
                ...chipColors(choice, active),
              }}
            >
              {label}
            </ButtonBase>
          );
        })}
      </Box>

      <Typography sx={{ mt: 1.5, fontSize: 11, lineHeight: 1.45, color: v("ink-3") }}>
        One standard drink ≈ <b style={{ color: v("ink-2"), fontWeight: 500 }}>12 oz beer</b>,{" "}
        <b style={{ color: v("ink-2"), fontWeight: 500 }}>5 oz wine</b>, or{" "}
        <b style={{ color: v("ink-2"), fontWeight: 500 }}>1.5 oz spirits</b> (14 g alcohol). Cap is{" "}
        {cap} a day.
      </Typography>
    </Box>
  );
}
