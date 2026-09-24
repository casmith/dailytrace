import { createTheme, Theme } from "@mui/material/styles";
import { Mode, palettes } from "./tokens";

/** MUI theme built from the same tokens the CSS variables come from. */
export function createAppTheme(mode: Mode): Theme {
  const t = palettes[mode];
  return createTheme({
    palette: {
      mode,
      primary: { main: t.accent, contrastText: t["on-accent"] },
      error: { main: t.over },
      success: { main: t.clear },
      background: { default: t.bg, paper: t.surface },
      text: { primary: t.ink, secondary: t["ink-2"], disabled: t["ink-3"] },
      divider: t["line"],
    },
    shape: { borderRadius: 12 },
    typography: {
      fontFamily: "var(--font-ui), system-ui, sans-serif",
      button: { textTransform: "none", fontWeight: 600 },
      overline: {
        fontSize: 10.5,
        fontWeight: 600,
        letterSpacing: "0.13em",
        lineHeight: 1.6,
      },
    },
    components: {
      MuiCssBaseline: {
        styleOverrides: {
          body: { backgroundColor: t.bg, color: t.ink },
          "*:focus-visible": { outline: `2px solid ${t.focus}`, outlineOffset: 2 },
        },
      },
      MuiPaper: { defaultProps: { elevation: 0 } },
      MuiTooltip: {
        styleOverrides: {
          tooltip: {
            backgroundColor: t["surface-2"],
            color: t.ink,
            border: `1px solid ${t.line}`,
            fontSize: 11.5,
          },
        },
      },
    },
  });
}
