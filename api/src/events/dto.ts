import { z } from "zod";

// All event types your system knows
export const EventTypeSchema = z.enum(["MetricRecorded", "MetricIncremented"]);
export type EventType = z.infer<typeof EventTypeSchema>;

// Generic event shape
export const EventSchema = z.object({
  eventId: z.string().uuid().optional(),
  metricKey: z.string().min(1),
  type: EventTypeSchema,                // allow both
  actor: z.string().optional(),
  occurredAt: z.string().datetime(),
  recordedAt: z.string().datetime().optional(),
  payload: z.object({
    value: z.number().nonnegative(),
    unit: z.string().default("drink"),
  }),
});
export type EventInput = z.infer<typeof EventSchema>;

// Command for setting total
export const RecordDailySchema = z.object({
  metricKey: z.string().min(1),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  value: z.number().nonnegative(),
  unit: z.string().default("drink"),
});
export type RecordDailyInput = z.infer<typeof RecordDailySchema>;

// Command for incrementing
export const AddIncrementSchema = z.object({
  metricKey: z.string().min(1),
  date: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  amount: z.number().positive(),
  unit: z.string().default("drink"),
});
export type AddIncrementInput = z.infer<typeof AddIncrementSchema>;