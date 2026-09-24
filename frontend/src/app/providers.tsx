"use client";

import React, { createContext, useContext, useEffect, useMemo, useState } from "react";
import CssBaseline from "@mui/material/CssBaseline";
import { ThemeProvider } from "@mui/material/styles";
import { createAppTheme } from "@/theme/theme";
import { Mode } from "@/theme/tokens";

export const THEME_STORAGE_KEY = "dailytrace-theme";

/**
 * Applies a stored theme choice before first paint, so the page never flashes
 * the other theme. Kept in sync with `providers.tsx` by the storage key above.
 */
export const THEME_INIT_SCRIPT = `try{var t=localStorage.getItem(${JSON.stringify(
  THEME_STORAGE_KEY,
)});if(t==="dark"||t==="light")document.documentElement.setAttribute("data-theme",t)}catch(e){}`;

interface ColorModeValue {
  mode: Mode;
  toggle: () => void;
}

const ColorModeContext = createContext<ColorModeValue>({ mode: "dark", toggle: () => {} });

export const useColorMode = () => useContext(ColorModeContext);

function resolveMode(): Mode {
  const chosen = document.documentElement.getAttribute("data-theme");
  if (chosen === "light" || chosen === "dark") return chosen;
  return window.matchMedia("(prefers-color-scheme: light)").matches ? "light" : "dark";
}

export function Providers({ children }: { children: React.ReactNode }) {
  // Dark is the pre-hydration default; the effect below corrects it if the
  // viewer has chosen, or prefers, light.
  const [mode, setMode] = useState<Mode>("dark");

  useEffect(() => {
    setMode(resolveMode());
    const media = window.matchMedia("(prefers-color-scheme: light)");
    const onChange = () => {
      if (!document.documentElement.getAttribute("data-theme")) setMode(resolveMode());
    };
    media.addEventListener("change", onChange);
    return () => media.removeEventListener("change", onChange);
  }, []);

  const value = useMemo<ColorModeValue>(
    () => ({
      mode,
      toggle: () => {
        const next: Mode = mode === "dark" ? "light" : "dark";
        document.documentElement.setAttribute("data-theme", next);
        try {
          localStorage.setItem(THEME_STORAGE_KEY, next);
        } catch {
          // private mode, or storage disabled: the choice just won't persist
        }
        setMode(next);
      },
    }),
    [mode],
  );

  const theme = useMemo(() => createAppTheme(mode), [mode]);

  return (
    <ColorModeContext.Provider value={value}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        {children}
      </ThemeProvider>
    </ColorModeContext.Provider>
  );
}
