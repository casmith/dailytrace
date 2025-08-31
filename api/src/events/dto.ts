import { z } from 'zod';

// POST /events (raw)
export const EventSchema = z.object({
  eventId: z.string().uuid().optional(),        // server can generate
  metricKey: z.string().min(1),
  type: z.literal('MetricRecorded'),
  actor: z.string().optional(),
  occurredAt: z.string().datetime(),            // ISO 8601 with offset or 'YYYY-MM-DD' (we’ll normalize)
  recordedAt: z.string().datetime().optional(),
  payload: z.object({
    value: z.number().nonnegative(),
    unit: z.string().default('drink'),
  }),
});

export type EventInput = z.infer<typeof EventSchema>;

// POST /commands/record-daily-total
export const RecordDailySchema = z.object({
  metricKey: z.string().min(1),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/), // local date like 2025-08-30
  value: z.number().nonnegative(),
  unit: z.string().default('drink'),
});

export type RecordDailyInput = z.infer<typeof RecordDailySchema>;

