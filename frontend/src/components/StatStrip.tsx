"use client";

import React from "react";
import Box from "@mui/material/Box";
import { Summary } from "@/lib/stats";
import { v } from "@/theme/tokens";

function Stat({ value, suffix, label }: { value: string; suffix?: string; label: string }) {
  return (
    <Box
      sx={{
        px: 1.25,
        borderLeft: `1px solid ${v("line-soft")}`,
        "&:first-of-type": { pl: 0, borderLeft: "none" },
      }}
    >
      <Box className="dt-num" sx={{ fontSize: 19, fontWeight: 500, letterSpacing: "-0.02em" }}>
        {value}
        {suffix && <Box component="small" sx={{ fontSize: 11, color: v("ink-3"), ml: "1px" }}>{suffix}</Box>}
      </Box>
      <Box sx={{ mt: 0.4, fontSize: 10, lineHeight: 1.3, color: v("ink-3") }}>{label}</Box>
    </Box>
  );
}

export function StatStrip({ summary }: { summary: Summary }) {
  return (
    <Box component="section" sx={{ px: 2.25, py: 2.5, display: "grid", gridTemplateColumns: "repeat(4, 1fr)", borderBottom: `1px solid ${v("line-soft")}` }}>
      <Stat value={String(summary.total7)} label="drinks last 7d" />
      <Stat value={summary.average7 === null ? "—" : summary.average7.toFixed(1)} label="avg per day" />
      <Stat value={String(summary.dry30)} suffix="/30" label="dry days" />
      <Stat value={String(summary.over30)} label="days over cap" />
    </Box>
  );
}
