"use client";

import React from "react";
import Box from "@mui/material/Box";
import Typography from "@mui/material/Typography";
import { v } from "@/theme/tokens";

/** One band of the app column, separated by a hairline rather than a card. */
export function Section({
  title,
  aside,
  children,
  sx,
}: {
  title?: string;
  aside?: React.ReactNode;
  children: React.ReactNode;
  sx?: object;
}) {
  return (
    <Box
      component="section"
      sx={{ px: 2.25, py: 2.5, borderBottom: `1px solid ${v("line-soft")}`, ...sx }}
    >
      {(title || aside) && (
        <Box
          sx={{
            display: "flex",
            alignItems: "baseline",
            justifyContent: "space-between",
            gap: 1,
            mb: 1.75,
          }}
        >
          {title && (
            <Typography variant="overline" sx={{ color: v("ink-3") }}>
              {title}
            </Typography>
          )}
          {aside}
        </Box>
      )}
      {children}
    </Box>
  );
}
