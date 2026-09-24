/**
 * The single source of truth for colour.
 *
 * These values are emitted as CSS custom properties into the static HTML (so
 * the page has its ground and ink before any JS runs) *and* fed to the MUI
 * theme, so the two can't drift.
 */

export interface Tokens {
  bg: string;
  surface: string;
  "surface-2": string;
  line: string;
  "line-soft": string;
  ink: string;
  "ink-2": string;
  "ink-3": string;
  accent: string;
  "accent-soft": string;
  "on-accent": string;
  /** Zero-drink days: their own hue, not a step on the ramp. */
  clear: string;
  "on-clear": string;
  /** Over the daily cap. */
  over: string;
  "over-ring": string;
  "on-over": string;
  /** Outline of a day with no check-in. */
  "cell-line": string;
  /** Magnitude ramp, 1 drink -> the cap. */
  "ramp-1": string;
  "ramp-2": string;
  "ramp-3": string;
  "ramp-4": string;
  focus: string;
}

export const dark: Tokens = {
  bg: "#0F1317",
  surface: "#161B21",
  "surface-2": "#1D242B",
  line: "#262E36",
  "line-soft": "#1E252C",
  ink: "#E8EAED",
  "ink-2": "#A3ADB8",
  "ink-3": "#6F7B87",
  accent: "#E3A857",
  "accent-soft": "rgba(227, 168, 87, 0.13)",
  "on-accent": "#12161A",
  clear: "#3E8F82",
  "on-clear": "#08120F",
  over: "#D9694F",
  "over-ring": "#F08A70",
  "on-over": "#1A0A06",
  "cell-line": "#2C353E",
  "ramp-1": "#6B4A20",
  "ramp-2": "#96682A",
  "ramp-3": "#C08935",
  "ramp-4": "#E3A857",
  focus: "#8FC7FF",
};

export const light: Tokens = {
  bg: "#EEF0F2",
  surface: "#FFFFFF",
  "surface-2": "#F6F7F8",
  line: "#E0E4E8",
  "line-soft": "#EAEDF0",
  ink: "#14181C",
  "ink-2": "#515C66",
  "ink-3": "#808C97",
  accent: "#8F5F1E",
  "accent-soft": "rgba(169, 114, 42, 0.11)",
  "on-accent": "#FFFFFF",
  clear: "#4E9C8E",
  "on-clear": "#07231F",
  over: "#B4472F",
  "over-ring": "#8F3420",
  "on-over": "#FFFFFF",
  "cell-line": "#DDE1E5",
  "ramp-1": "#F2DCB9",
  "ramp-2": "#E0BA76",
  "ramp-3": "#C79440",
  "ramp-4": "#A9722A",
  focus: "#1A6FD4",
};

export type Mode = "dark" | "light";

export const palettes: Record<Mode, Tokens> = { dark, light };

/** `var(--dt-ink-2)` and friends, for component styles. */
export const v = (token: keyof Tokens) => `var(--dt-${token})`;

const block = (selector: string, tokens: Tokens) =>
  `${selector}{${Object.entries(tokens)
    .map(([name, value]) => `--dt-${name}:${value};`)
    .join("")}}`;

/**
 * Dark is the design's default. An explicit choice wins in both directions;
 * with no choice stored, the OS preference decides.
 */
export function themeCss(): string {
  return [
    block(":root", dark),
    `@media (prefers-color-scheme: light){${block(':root:not([data-theme="dark"])', light)}}`,
    block(':root[data-theme="light"]', light),
    `:root{color-scheme:dark light}`,
    `:root[data-theme="light"]{color-scheme:light}`,
    `:root[data-theme="dark"]{color-scheme:dark}`,
  ].join("");
}
