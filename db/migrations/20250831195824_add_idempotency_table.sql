-- migrate:up
CREATE TABLE IF NOT EXISTS command_ids (
  command_id uuid PRIMARY KEY,
  event_id   uuid NOT NULL UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- migrate:down
DROP TABLE IF EXISTS command_ids;

