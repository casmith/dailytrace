-- migrate:up
-- Daily
CREATE MATERIALIZED VIEW IF NOT EXISTS ca_daily
WITH (timescaledb.continuous) AS
SELECT
  metric_key,
  time_bucket(INTERVAL '1 day', occurred_at) AS bucket_start,
  SUM((payload->>'value')::numeric) AS value
FROM events
WHERE type = 'MetricRecorded'
GROUP BY 1,2
WITH NO DATA;

-- Monthly
CREATE MATERIALIZED VIEW IF NOT EXISTS ca_monthly
WITH (timescaledb.continuous) AS
SELECT
  metric_key,
  time_bucket(INTERVAL '1 month', occurred_at) AS bucket_start,
  SUM((payload->>'value')::numeric) AS value
FROM events
WHERE type = 'MetricRecorded'
GROUP BY 1,2
WITH NO DATA;

-- Quarterly
CREATE MATERIALIZED VIEW IF NOT EXISTS ca_quarterly
WITH (timescaledb.continuous) AS
SELECT
  metric_key,
  time_bucket(INTERVAL '3 month', occurred_at) AS bucket_start,
  SUM((payload->>'value')::numeric) AS value
FROM events
WHERE type = 'MetricRecorded'
GROUP BY 1,2
WITH NO DATA;

-- Yearly
CREATE MATERIALIZED VIEW IF NOT EXISTS ca_yearly
WITH (timescaledb.continuous) AS
SELECT
  metric_key,
  time_bucket(INTERVAL '1 year', occurred_at) AS bucket_start,
  SUM((payload->>'value')::numeric) AS value
FROM events
WHERE type = 'MetricRecorded'
GROUP BY 1,2
WITH NO DATA;

-- Policies (these are fine in a transaction)
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

-- migrate:down
SELECT remove_continuous_aggregate_policy('ca_yearly');
SELECT remove_continuous_aggregate_policy('ca_quarterly');
SELECT remove_continuous_aggregate_policy('ca_monthly');
SELECT remove_continuous_aggregate_policy('ca_daily');

DROP MATERIALIZED VIEW IF EXISTS ca_yearly;
DROP MATERIALIZED VIEW IF EXISTS ca_quarterly;
DROP MATERIALIZED VIEW IF EXISTS ca_monthly;
DROP MATERIALIZED VIEW IF EXISTS ca_daily;

SELECT remove_compression_policy('events');
ALTER TABLE events RESET (timescaledb.compress, timescaledb.compress_segmentby);

