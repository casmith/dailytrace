-- migrate:up
-- Remove policies (ignore errors) and old rollups
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_daily');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_monthly');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_quarterly');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_yearly');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;

DROP MATERIALIZED VIEW IF EXISTS ca_yearly;
DROP MATERIALIZED VIEW IF EXISTS ca_quarterly;
DROP MATERIALIZED VIEW IF EXISTS ca_monthly;
DROP MATERIALIZED VIEW IF EXISTS ca_daily;

-- Daily rollup (America/Chicago):
-- If any daily TOTAL exists -> take the latest one that day.
-- Else -> sum of INCREMENTS that day.
CREATE MATERIALIZED VIEW ca_daily
WITH (timescaledb.continuous) AS
SELECT
  e.metric_key,
  time_bucket(INTERVAL '1 day', e.occurred_at, 'America/Chicago') AS bucket_start,
  COALESCE(
    last( (e.payload->>'value')::numeric, e.recorded_at )
      FILTER (WHERE e.type = 'MetricRecorded'),
    SUM( (e.payload->>'value')::numeric )
      FILTER (WHERE e.type = 'MetricIncremented')
  ) AS value
FROM events e
WHERE e.type IN ('MetricRecorded', 'MetricIncremented')
GROUP BY 1, 2
WITH NO DATA;

-- Monthly/Quarterly/Yearly rollups now sum the already-decided daily values
CREATE MATERIALIZED VIEW ca_monthly
WITH (timescaledb.continuous) AS
SELECT
  d.metric_key,
  time_bucket(INTERVAL '1 month', d.bucket_start, 'America/Chicago') AS bucket_start,
  SUM(d.value) AS value
FROM ca_daily d
GROUP BY 1, 2
WITH NO DATA;

CREATE MATERIALIZED VIEW ca_quarterly
WITH (timescaledb.continuous) AS
SELECT
  d.metric_key,
  time_bucket(INTERVAL '3 month', d.bucket_start, 'America/Chicago') AS bucket_start,
  SUM(d.value) AS value
FROM ca_daily d
GROUP BY 1, 2
WITH NO DATA;

CREATE MATERIALIZED VIEW ca_yearly
WITH (timescaledb.continuous) AS
SELECT
  d.metric_key,
  time_bucket(INTERVAL '1 year', d.bucket_start, 'America/Chicago') AS bucket_start,
  SUM(d.value) AS value
FROM ca_daily d
GROUP BY 1, 2
WITH NO DATA;

-- Refresh policies
SELECT add_continuous_aggregate_policy('ca_daily',
  start_offset => INTERVAL '32 days',
  end_offset   => INTERVAL '1 day',
  schedule_interval => INTERVAL '15 minutes');

SELECT add_continuous_aggregate_policy('ca_monthly',
  start_offset => INTERVAL '18 months',
  end_offset   => INTERVAL '1 day',
  schedule_interval => INTERVAL '1 hour');

SELECT add_continuous_aggregate_policy('ca_quarterly',
  start_offset => INTERVAL '24 months',
  end_offset   => INTERVAL '1 day',
  schedule_interval => INTERVAL '2 hours');

SELECT add_continuous_aggregate_policy('ca_yearly',
  start_offset => INTERVAL '6 years',
  end_offset   => INTERVAL '1 day',
  schedule_interval => INTERVAL '1 day');

-- Optional helper index (speeds filters by type)
CREATE INDEX IF NOT EXISTS idx_events_type_time ON events (type, occurred_at);

ALTER MATERIALIZED VIEW ca_daily SET (timescaledb.materialized_only = false);

-- migrate:down
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_yearly');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_quarterly');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_monthly');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;
DO $$
BEGIN
  PERFORM remove_continuous_aggregate_policy('ca_daily');
EXCEPTION WHEN undefined_function OR undefined_object THEN END$$;

DROP MATERIALIZED VIEW IF EXISTS ca_yearly;
DROP MATERIALIZED VIEW IF EXISTS ca_quarterly;
DROP MATERIALIZED VIEW IF EXISTS ca_monthly;
DROP MATERIALIZED VIEW IF EXISTS ca_daily;

