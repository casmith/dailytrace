"use client";

import React from "react";
import Box from "@mui/material/Box";
import Skeleton from "@mui/material/Skeleton";
import { v } from "@/theme/tokens";

interface Props {
  streak: number;
  best: number;
  lastDay: string | null;
  cap: number;
  loading?: boolean;
}

export function StreakHero({ streak, best, lastDay, cap, loading }: Props) {
  return (
    <Box component="section" sx={{ px: 2.25, pt: 2.75, pb: 2.5, borderBottom: `1px solid ${v("line-soft")}` }}>
      <Box sx={{ display: "flex", alignItems: "baseline", gap: 1.25 }}>
        {loading ? (
          <Skeleton variant="text" width={86} height={58} sx={{ transform: "none" }} />
        ) : (
          <Box
            className="dt-num"
            sx={{
              fontSize: 58,
              fontWeight: 500,
              lineHeight: 1,
              letterSpacing: "-0.04em",
              color: v("accent"),
            }}
          >
            {streak}
          </Box>
        )}
        <Box sx={{ fontSize: 15, fontWeight: 500 }}>days at or under {cap}</Box>
      </Box>
      <Box sx={{ mt: 1, fontSize: 12.5, color: v("ink-3") }}>
        {loading ? (
          <Skeleton variant="text" width={220} />
        ) : (
          <>
            Longest run <b className="dt-num" style={{ color: v("ink-2"), fontWeight: 500 }}>{best}</b>
            {" · "}last check-in{" "}
            <b className="dt-num" style={{ color: v("ink-2"), fontWeight: 500 }}>{lastDay ?? "—"}</b>
          </>
        )}
      </Box>
    </Box>
  );
}
