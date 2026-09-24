/** The metric this UI tracks. The API itself is metric-agnostic. */
export const METRIC_KEY = "alcoholic_drinks";

export const UNIT = "drink";

/** Daily cap the activity map and streak are measured against. */
export const DAILY_CAP = 4;

/** How much history the activity map shows. */
export const HISTORY_DAYS = 364;

export const BACKEND_URL = process.env.NEXT_PUBLIC_BACKEND_URL
  ? `${process.env.NEXT_PUBLIC_BACKEND_URL}/api`
  : "https://dailytrace.kalde.in/api";
