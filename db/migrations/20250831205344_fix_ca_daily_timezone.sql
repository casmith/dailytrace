-- migrate:up
-- Remove existing refresh policy (if present) and the old CA
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_daily');
EXCEPTION WHEN undefined_function OR undefined_object THEN
  -- no existing policy, ignore
END$$;

DROP MATERIALIZED VIEW IF EXISTS ca_daily;

-- Recreate daily CA using America/Chicago day buckets
CREATE MATERIALIZED VIEW ca_daily
WITH (timescaledb.continuous) AS
SELECT
  metric_key,
  time_bucket(INTERVAL '1 day', occurred_at, 'America/Chicago') AS bucket_start,
  SUM((payload->>'value')::numeric) AS value
FROM events
WHERE type = 'MetricRecorded'
GROUP BY 1,2
WITH NO DATA;

-- Add back the refresh policy
SELECT add_continuous_aggregate_policy('ca_daily',
  start_offset => INTERVAL '32 days',
  end_offset   => INTERVAL '1 day',
  schedule_interval => INTERVAL '15 minutes');

-- migrate:down
-- Remove policy + drop the CA (revert to none)
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_daily');
EXCEPTION WHEN undefined_function OR undefined_object THEN
  -- no existing policy, ignore
END$$;

DROP MATERIALIZED VIEW IF EXISTS ca_daily;

