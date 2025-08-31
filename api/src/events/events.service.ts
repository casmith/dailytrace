import { Inject, Injectable, BadRequestException } from '@nestjs/common';
import { Pool } from 'pg';
import { randomUUID } from 'crypto';

@Injectable()
export class EventsService {
  constructor(@Inject('PG_POOL') private pool: Pool) {}

  async insertEvent(input: {
    eventId?: string;
    metricKey: string;
    type: 'MetricRecorded';
    actor?: string;
    occurredAt: string;   // ISO
    recordedAt?: string;  // ISO
    payload: { value: number; unit: string };
    idempotencyKey?: string; // from header (uuid recommended)
  }) {
    const client = await this.pool.connect();
    try {
      await client.query('BEGIN');

      let eventId = input.eventId ?? randomUUID();
      // if you pass Idempotency-Key, claim it in command_ids first
      if (input.idempotencyKey) {
        const cmd = input.idempotencyKey;
        await client.query(
          `INSERT INTO command_ids (command_id, event_id)
           VALUES ($1::uuid, $2::uuid)
           ON CONFLICT (command_id) DO NOTHING`,
          [cmd, eventId],
        );
        // If someone else already claimed the key, fetch its event_id and return early (idempotent)
        const row = await client.query(
          `SELECT event_id FROM command_ids WHERE command_id = $1::uuid`,
          [cmd],
        );
        if (row.rows[0]?.event_id !== eventId) {
          await client.query('ROLLBACK');
          return { ok: true, eventId: row.rows[0].event_id, idempotent: true };
        }
      }

      // Insert event (composite PK event_id + occurred_at OR no PK per your schema)
      await client.query(
        `INSERT INTO events (event_id, metric_key, type, actor, occurred_at, recorded_at, payload, command_id)
         VALUES ($1::uuid, $2, $3, $4, $5::timestamptz, COALESCE($6::timestamptz, now()), $7::jsonb, $8::uuid)`,
        [
          eventId,
          input.metricKey,
          input.type,
          input.actor ?? 'api',
          input.occurredAt,
          input.recordedAt ?? null,
          JSON.stringify(input.payload),
          input.idempotencyKey ?? null,
        ],
      );

      await client.query('COMMIT');
      return { ok: true, eventId };
    } catch (e: any) {
      await client.query('ROLLBACK');
      // if unique violation on command_ids, treat as idempotent
      if (e.code === '23505' && String(e.detail || '').includes('command_ids_pkey')) {
        return { ok: true, idempotent: true };
      }
      throw new BadRequestException(e?.message ?? 'insert failed');
    } finally {
      client.release();
    }
  }

  /**
   * Record a daily total for a local calendar date.
   * We store occurred_at at "noon" America/Chicago to avoid DST-midnight edge cases.
   */
  async recordDailyTotal(input: { metricKey: string; date: string; value: number; unit: string; idempotencyKey?: string }) {
    const occurredAt = `${input.date} 12:00:00 ${this.tzOffset()}`; // e.g. "2025-08-30 12:00:00 -05"
    return this.insertEvent({
      metricKey: input.metricKey,
      type: 'MetricRecorded',
      occurredAt,
      payload: { value: input.value, unit: input.unit },
      idempotencyKey: input.idempotencyKey,
      actor: 'api',
    });
  }

  /**
   * Read time series from ca_daily between from..to
   */
  async series(metricKey: string, fromIso?: string, toIso?: string) {
    const r = await this.pool.query(
      `SELECT bucket_start AS time, value
         FROM ca_daily
        WHERE metric_key = $1
          AND ($2::timestamptz IS NULL OR bucket_start >= $2::timestamptz)
          AND ($3::timestamptz IS NULL OR bucket_start <  $3::timestamptz)
        ORDER BY bucket_start`,
      [metricKey, fromIso ?? null, toIso ?? null],
    );
    return r.rows;
  }

  private tzOffset(): string {
    // simple offset string for America/Chicago at runtime
    const now = new Date();
    const minutes = now.getTimezoneOffset(); // in minutes, e.g. 300 or 360
    const sign = minutes > 0 ? '-' : '+';
    const mm = Math.abs(minutes);
    const hh = String(Math.floor(mm / 60)).padStart(2, '0');
    const m = String(mm % 60).padStart(2, '0');
    return `${sign}${hh}:${m}`;
  }
}

