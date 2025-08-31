SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data (Community Edition)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _materialized_hypertable_7; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_7 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: ca_daily; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_daily AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_7;


--
-- Name: _direct_view_10; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_10 AS
 SELECT metric_key,
    public.time_bucket('1 year'::interval, bucket_start, 'America/Chicago'::text) AS bucket_start,
    sum(value) AS value
   FROM public.ca_daily d
  GROUP BY metric_key, (public.time_bucket('1 year'::interval, bucket_start, 'America/Chicago'::text));


--
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    event_id uuid NOT NULL,
    metric_key text NOT NULL,
    type text NOT NULL,
    actor text,
    occurred_at timestamp with time zone NOT NULL,
    recorded_at timestamp with time zone DEFAULT now() NOT NULL,
    payload jsonb NOT NULL,
    command_id uuid
);


--
-- Name: _direct_view_7; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_7 AS
 SELECT metric_key,
    public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text) AS bucket_start,
    COALESCE(public.last(((payload ->> 'value'::text))::numeric, recorded_at) FILTER (WHERE (type = 'MetricRecorded'::text)), sum(((payload ->> 'value'::text))::numeric) FILTER (WHERE (type = 'MetricIncremented'::text))) AS value
   FROM public.events e
  WHERE (type = ANY (ARRAY['MetricRecorded'::text, 'MetricIncremented'::text]))
  GROUP BY metric_key, (public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text));


--
-- Name: _direct_view_8; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_8 AS
 SELECT metric_key,
    public.time_bucket('1 mon'::interval, bucket_start, 'America/Chicago'::text) AS bucket_start,
    sum(value) AS value
   FROM public.ca_daily d
  GROUP BY metric_key, (public.time_bucket('1 mon'::interval, bucket_start, 'America/Chicago'::text));


--
-- Name: _direct_view_9; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_9 AS
 SELECT metric_key,
    public.time_bucket('3 mons'::interval, bucket_start, 'America/Chicago'::text) AS bucket_start,
    sum(value) AS value
   FROM public.ca_daily d
  GROUP BY metric_key, (public.time_bucket('3 mons'::interval, bucket_start, 'America/Chicago'::text));


--
-- Name: _materialized_hypertable_10; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_10 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: _materialized_hypertable_8; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_8 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: _materialized_hypertable_9; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_9 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: _partial_view_10; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_10 AS
 SELECT metric_key,
    public.time_bucket('1 year'::interval, bucket_start, 'America/Chicago'::text) AS bucket_start,
    sum(value) AS value
   FROM public.ca_daily d
  GROUP BY metric_key, (public.time_bucket('1 year'::interval, bucket_start, 'America/Chicago'::text));


--
-- Name: _partial_view_7; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_7 AS
 SELECT metric_key,
    public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text) AS bucket_start,
    COALESCE(public.last(((payload ->> 'value'::text))::numeric, recorded_at) FILTER (WHERE (type = 'MetricRecorded'::text)), sum(((payload ->> 'value'::text))::numeric) FILTER (WHERE (type = 'MetricIncremented'::text))) AS value
   FROM public.events e
  WHERE (type = ANY (ARRAY['MetricRecorded'::text, 'MetricIncremented'::text]))
  GROUP BY metric_key, (public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text));


--
-- Name: _partial_view_8; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_8 AS
 SELECT metric_key,
    public.time_bucket('1 mon'::interval, bucket_start, 'America/Chicago'::text) AS bucket_start,
    sum(value) AS value
   FROM public.ca_daily d
  GROUP BY metric_key, (public.time_bucket('1 mon'::interval, bucket_start, 'America/Chicago'::text));


--
-- Name: _partial_view_9; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_9 AS
 SELECT metric_key,
    public.time_bucket('3 mons'::interval, bucket_start, 'America/Chicago'::text) AS bucket_start,
    sum(value) AS value
   FROM public.ca_daily d
  GROUP BY metric_key, (public.time_bucket('3 mons'::interval, bucket_start, 'America/Chicago'::text));


--
-- Name: ca_monthly; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_monthly AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_8;


--
-- Name: ca_quarterly; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_quarterly AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_9;


--
-- Name: ca_yearly; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_yearly AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_10;


--
-- Name: command_ids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.command_ids (
    command_id uuid NOT NULL,
    event_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: command_ids command_ids_event_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_ids
    ADD CONSTRAINT command_ids_event_id_key UNIQUE (event_id);


--
-- Name: command_ids command_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.command_ids
    ADD CONSTRAINT command_ids_pkey PRIMARY KEY (command_id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id, occurred_at);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: _materialized_hypertable_10_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_10_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_10 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_10_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_10_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_10 USING btree (metric_key, bucket_start DESC);


--
-- Name: _materialized_hypertable_7_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_7_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_7 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_7_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_7_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_7 USING btree (metric_key, bucket_start DESC);


--
-- Name: _materialized_hypertable_8_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_8_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_8 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_8_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_8_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_8 USING btree (metric_key, bucket_start DESC);


--
-- Name: _materialized_hypertable_9_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_9_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_9 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_9_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_9_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_9 USING btree (metric_key, bucket_start DESC);


--
-- Name: events_occurred_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_occurred_at_idx ON public.events USING btree (occurred_at DESC);


--
-- Name: idx_events_command; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_command ON public.events USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: idx_events_metric_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_metric_time ON public.events USING btree (metric_key, occurred_at);


--
-- Name: idx_events_payload_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_payload_gin ON public.events USING gin (payload);


--
-- Name: idx_events_type_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_events_type_time ON public.events USING btree (type, occurred_at);


--
-- Name: _materialized_hypertable_7 ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._materialized_hypertable_7 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('7');


--
-- Name: _materialized_hypertable_10 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_10 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_7 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_7 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_8 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_8 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_9 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_9 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: events ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON public.events FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: events ts_insert_blocker; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON public.events FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20250831175834'),
    ('20250831175931'),
    ('20250831195824'),
    ('20250831205344'),
    ('20250831205354');
