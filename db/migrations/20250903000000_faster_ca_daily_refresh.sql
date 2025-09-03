-- migrate:up
-- Make ca_daily refresh every minute for near real-time updates
SELECT remove_continuous_aggregate_policy('ca_daily');
SELECT add_continuous_aggregate_policy('ca_daily',
  start_offset => INTERVAL '32 days',
  end_offset   => INTERVAL '1 day',
  schedule_interval => INTERVAL '1 minute');

-- migrate:down
-- Restore previous 15 minute refresh interval
SELECT remove_continuous_aggregate_policy('ca_daily');
SELECT add_continuous_aggregate_policy('ca_daily',
  start_offset => INTERVAL '32 days',
  end_offset   => INTERVAL '1 day',
  schedule_interval => INTERVAL '15 minutes');
