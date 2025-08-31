-- migrate:up
CREATE EXTENSION IF NOT EXISTS timescaledb;

CREATE TABLE IF NOT EXISTS events (
  event_id     uuid NOT NULL,
  metric_key   text NOT NULL,
  type         text NOT NULL,
  actor        text,
  occurred_at  timestamptz NOT NULL,
  recorded_at  timestamptz NOT NULL DEFAULT now(),
  payload      jsonb NOT NULL,
  command_id   uuid,
  PRIMARY KEY (event_id, occurred_at)
);

CREATE INDEX IF NOT EXISTS idx_events_metric_time ON events (metric_key, occurred_at);
CREATE INDEX IF NOT EXISTS idx_events_payload_gin ON events USING gin (payload);
CREATE INDEX IF NOT EXISTS idx_events_command
  ON events(command_id) WHERE command_id IS NOT NULL;
SELECT create_hypertable('events','occurred_at', if_not_exists => TRUE);

-- migrate:down
DROP INDEX IF EXISTS uq_events_command;
DROP INDEX IF EXISTS idx_events_payload_gin;
DROP INDEX IF EXISTS idx_events_metric_time;
DROP TABLE IF EXISTS events;
DROP EXTENSION IF EXISTS timescaledb;

