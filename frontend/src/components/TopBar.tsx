"use client";

import React from "react";
import Box from "@mui/material/Box";
import IconButton from "@mui/material/IconButton";
import Typography from "@mui/material/Typography";
import { useColorMode } from "@/app/providers";
import { METRIC_KEY } from "@/lib/config";
import { v } from "@/theme/tokens";

const stroke = {
  fill: "none",
  stroke: "currentColor",
  strokeWidth: 1.8,
  strokeLinecap: "round" as const,
  strokeLinejoin: "round" as const,
};

export function TopBar() {
  const { mode, toggle } = useColorMode();
  const label = mode === "dark" ? "Switch to light theme" : "Switch to dark theme";

  return (
    <Box
      sx={{
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        px: 2.25,
        pt: 2,
        pb: 1.75,
        borderBottom: `1px solid ${v("line-soft")}`,
      }}
    >
      <Box sx={{ display: "flex", alignItems: "baseline", gap: 1 }}>
        <Typography component="h1" sx={{ fontSize: 14, fontWeight: 700, letterSpacing: "-0.01em" }}>
          DailyTrace
        </Typography>
        <Box className="dt-num" sx={{ fontSize: 10.5, color: v("ink-3") }}>
          {METRIC_KEY}
        </Box>
      </Box>
      <IconButton onClick={toggle} aria-label={label} title={label} size="small" sx={{ color: v("ink-2") }}>
        <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true">
          {mode === "dark" ? (
            <g {...stroke}>
              <circle cx="12" cy="12" r="4" />
              <path d="M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4" />
            </g>
          ) : (
            <path {...stroke} d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8z" />
          )}
        </svg>
      </IconButton>
    </Box>
  );
}
