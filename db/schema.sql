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
-- Name: _direct_view_3; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_3 AS
 SELECT metric_key,
    public.time_bucket('1 mon'::interval, occurred_at) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('1 mon'::interval, occurred_at));


--
-- Name: _direct_view_4; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_4 AS
 SELECT metric_key,
    public.time_bucket('3 mons'::interval, occurred_at) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('3 mons'::interval, occurred_at));


--
-- Name: _direct_view_5; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_5 AS
 SELECT metric_key,
    public.time_bucket('1 year'::interval, occurred_at) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('1 year'::interval, occurred_at));


--
-- Name: _direct_view_6; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._direct_view_6 AS
 SELECT metric_key,
    public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text));


--
-- Name: _hyper_1_100_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_100_chunk (
    CONSTRAINT constraint_100 CHECK (((occurred_at >= '2022-11-23 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-11-30 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_101_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_101_chunk (
    CONSTRAINT constraint_101 CHECK (((occurred_at >= '2022-11-30 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-12-07 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_102_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_102_chunk (
    CONSTRAINT constraint_102 CHECK (((occurred_at >= '2022-12-07 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-12-14 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_103_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_103_chunk (
    CONSTRAINT constraint_103 CHECK (((occurred_at >= '2022-12-14 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-12-21 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_104_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_104_chunk (
    CONSTRAINT constraint_104 CHECK (((occurred_at >= '2022-12-21 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-12-28 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_105_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_105_chunk (
    CONSTRAINT constraint_105 CHECK (((occurred_at >= '2022-12-28 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-01-04 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_106_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_106_chunk (
    CONSTRAINT constraint_106 CHECK (((occurred_at >= '2023-01-04 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-01-11 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_107_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_107_chunk (
    CONSTRAINT constraint_107 CHECK (((occurred_at >= '2023-01-11 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-01-18 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_108_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_108_chunk (
    CONSTRAINT constraint_108 CHECK (((occurred_at >= '2023-01-18 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-01-25 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_109_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_109_chunk (
    CONSTRAINT constraint_109 CHECK (((occurred_at >= '2023-01-25 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-02-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_10_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_10_chunk (
    CONSTRAINT constraint_10 CHECK (((occurred_at >= '2021-03-03 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-03-10 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_110_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_110_chunk (
    CONSTRAINT constraint_110 CHECK (((occurred_at >= '2023-02-01 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-02-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_111_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_111_chunk (
    CONSTRAINT constraint_111 CHECK (((occurred_at >= '2023-02-08 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-02-15 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_112_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_112_chunk (
    CONSTRAINT constraint_112 CHECK (((occurred_at >= '2023-02-15 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-02-22 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_113_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_113_chunk (
    CONSTRAINT constraint_113 CHECK (((occurred_at >= '2023-02-22 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-03-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_114_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_114_chunk (
    CONSTRAINT constraint_114 CHECK (((occurred_at >= '2023-03-01 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-03-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_115_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_115_chunk (
    CONSTRAINT constraint_115 CHECK (((occurred_at >= '2023-03-08 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-03-15 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_116_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_116_chunk (
    CONSTRAINT constraint_116 CHECK (((occurred_at >= '2023-03-15 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-03-22 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_117_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_117_chunk (
    CONSTRAINT constraint_117 CHECK (((occurred_at >= '2023-03-22 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-03-29 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_118_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_118_chunk (
    CONSTRAINT constraint_118 CHECK (((occurred_at >= '2023-03-29 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-04-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_119_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_119_chunk (
    CONSTRAINT constraint_119 CHECK (((occurred_at >= '2023-04-05 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-04-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_11_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_11_chunk (
    CONSTRAINT constraint_11 CHECK (((occurred_at >= '2021-03-10 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-03-17 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_120_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_120_chunk (
    CONSTRAINT constraint_120 CHECK (((occurred_at >= '2023-04-12 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-04-19 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_121_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_121_chunk (
    CONSTRAINT constraint_121 CHECK (((occurred_at >= '2023-04-19 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-04-26 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_122_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_122_chunk (
    CONSTRAINT constraint_122 CHECK (((occurred_at >= '2023-04-26 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-05-03 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_123_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_123_chunk (
    CONSTRAINT constraint_123 CHECK (((occurred_at >= '2023-05-03 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-05-10 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_124_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_124_chunk (
    CONSTRAINT constraint_124 CHECK (((occurred_at >= '2023-05-10 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-05-17 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_125_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_125_chunk (
    CONSTRAINT constraint_125 CHECK (((occurred_at >= '2023-05-17 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-05-24 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_126_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_126_chunk (
    CONSTRAINT constraint_126 CHECK (((occurred_at >= '2023-05-24 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-05-31 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_127_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_127_chunk (
    CONSTRAINT constraint_127 CHECK (((occurred_at >= '2023-05-31 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-06-07 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_128_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_128_chunk (
    CONSTRAINT constraint_128 CHECK (((occurred_at >= '2023-06-07 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-06-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_129_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_129_chunk (
    CONSTRAINT constraint_129 CHECK (((occurred_at >= '2023-06-14 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-06-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_12_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_12_chunk (
    CONSTRAINT constraint_12 CHECK (((occurred_at >= '2021-03-17 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-03-24 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_130_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_130_chunk (
    CONSTRAINT constraint_130 CHECK (((occurred_at >= '2023-06-21 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-06-28 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_131_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_131_chunk (
    CONSTRAINT constraint_131 CHECK (((occurred_at >= '2023-06-28 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-07-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_132_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_132_chunk (
    CONSTRAINT constraint_132 CHECK (((occurred_at >= '2023-07-05 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-07-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_133_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_133_chunk (
    CONSTRAINT constraint_133 CHECK (((occurred_at >= '2023-07-12 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-07-19 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_134_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_134_chunk (
    CONSTRAINT constraint_134 CHECK (((occurred_at >= '2023-07-19 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-07-26 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_135_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_135_chunk (
    CONSTRAINT constraint_135 CHECK (((occurred_at >= '2023-07-26 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-08-02 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_136_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_136_chunk (
    CONSTRAINT constraint_136 CHECK (((occurred_at >= '2023-08-02 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-08-09 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_137_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_137_chunk (
    CONSTRAINT constraint_137 CHECK (((occurred_at >= '2023-08-09 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-08-16 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_138_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_138_chunk (
    CONSTRAINT constraint_138 CHECK (((occurred_at >= '2023-08-16 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-08-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_139_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_139_chunk (
    CONSTRAINT constraint_139 CHECK (((occurred_at >= '2023-08-23 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-08-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_13_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_13_chunk (
    CONSTRAINT constraint_13 CHECK (((occurred_at >= '2021-03-24 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-03-31 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_140_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_140_chunk (
    CONSTRAINT constraint_140 CHECK (((occurred_at >= '2023-08-30 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-09-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_141_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_141_chunk (
    CONSTRAINT constraint_141 CHECK (((occurred_at >= '2023-09-06 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-09-13 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_142_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_142_chunk (
    CONSTRAINT constraint_142 CHECK (((occurred_at >= '2023-09-13 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-09-20 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_143_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_143_chunk (
    CONSTRAINT constraint_143 CHECK (((occurred_at >= '2023-09-20 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-09-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_144_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_144_chunk (
    CONSTRAINT constraint_144 CHECK (((occurred_at >= '2023-09-27 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-10-04 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_145_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_145_chunk (
    CONSTRAINT constraint_145 CHECK (((occurred_at >= '2023-10-04 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-10-11 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_146_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_146_chunk (
    CONSTRAINT constraint_146 CHECK (((occurred_at >= '2023-10-11 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-10-18 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_147_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_147_chunk (
    CONSTRAINT constraint_147 CHECK (((occurred_at >= '2023-10-18 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-10-25 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_148_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_148_chunk (
    CONSTRAINT constraint_148 CHECK (((occurred_at >= '2023-10-25 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-11-01 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_149_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_149_chunk (
    CONSTRAINT constraint_149 CHECK (((occurred_at >= '2023-11-01 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2023-11-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_14_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_14_chunk (
    CONSTRAINT constraint_14 CHECK (((occurred_at >= '2021-03-31 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-04-07 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_150_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_150_chunk (
    CONSTRAINT constraint_150 CHECK (((occurred_at >= '2023-11-08 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-11-15 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_151_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_151_chunk (
    CONSTRAINT constraint_151 CHECK (((occurred_at >= '2023-11-15 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-11-22 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_152_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_152_chunk (
    CONSTRAINT constraint_152 CHECK (((occurred_at >= '2023-11-22 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-11-29 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_153_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_153_chunk (
    CONSTRAINT constraint_153 CHECK (((occurred_at >= '2023-12-06 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-12-13 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_154_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_154_chunk (
    CONSTRAINT constraint_154 CHECK (((occurred_at >= '2023-12-13 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-12-20 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_155_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_155_chunk (
    CONSTRAINT constraint_155 CHECK (((occurred_at >= '2023-12-20 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2023-12-27 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_156_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_156_chunk (
    CONSTRAINT constraint_156 CHECK (((occurred_at >= '2023-12-27 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-01-03 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_157_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_157_chunk (
    CONSTRAINT constraint_157 CHECK (((occurred_at >= '2024-01-03 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-01-10 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_158_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_158_chunk (
    CONSTRAINT constraint_158 CHECK (((occurred_at >= '2024-01-10 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-01-17 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_159_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_159_chunk (
    CONSTRAINT constraint_159 CHECK (((occurred_at >= '2024-01-17 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-01-24 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_15_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_15_chunk (
    CONSTRAINT constraint_15 CHECK (((occurred_at >= '2021-04-07 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-04-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_160_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_160_chunk (
    CONSTRAINT constraint_160 CHECK (((occurred_at >= '2024-01-24 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-01-31 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_161_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_161_chunk (
    CONSTRAINT constraint_161 CHECK (((occurred_at >= '2024-01-31 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-02-07 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_162_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_162_chunk (
    CONSTRAINT constraint_162 CHECK (((occurred_at >= '2024-02-07 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-02-14 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_163_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_163_chunk (
    CONSTRAINT constraint_163 CHECK (((occurred_at >= '2024-02-14 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-02-21 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_164_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_164_chunk (
    CONSTRAINT constraint_164 CHECK (((occurred_at >= '2024-02-21 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-02-28 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_165_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_165_chunk (
    CONSTRAINT constraint_165 CHECK (((occurred_at >= '2024-02-28 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-03-06 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_166_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_166_chunk (
    CONSTRAINT constraint_166 CHECK (((occurred_at >= '2024-03-06 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-03-13 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_167_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_167_chunk (
    CONSTRAINT constraint_167 CHECK (((occurred_at >= '2024-03-13 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-03-20 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_168_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_168_chunk (
    CONSTRAINT constraint_168 CHECK (((occurred_at >= '2024-03-20 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-03-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_169_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_169_chunk (
    CONSTRAINT constraint_169 CHECK (((occurred_at >= '2024-03-27 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-04-03 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_16_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_16_chunk (
    CONSTRAINT constraint_16 CHECK (((occurred_at >= '2021-04-14 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-04-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_170_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_170_chunk (
    CONSTRAINT constraint_170 CHECK (((occurred_at >= '2024-04-03 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-04-10 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_171_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_171_chunk (
    CONSTRAINT constraint_171 CHECK (((occurred_at >= '2024-04-10 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-04-17 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_172_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_172_chunk (
    CONSTRAINT constraint_172 CHECK (((occurred_at >= '2024-04-17 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-04-24 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_173_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_173_chunk (
    CONSTRAINT constraint_173 CHECK (((occurred_at >= '2024-04-24 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-05-01 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_174_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_174_chunk (
    CONSTRAINT constraint_174 CHECK (((occurred_at >= '2024-05-01 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-05-08 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_175_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_175_chunk (
    CONSTRAINT constraint_175 CHECK (((occurred_at >= '2024-05-08 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-05-15 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_176_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_176_chunk (
    CONSTRAINT constraint_176 CHECK (((occurred_at >= '2024-05-15 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-05-22 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_177_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_177_chunk (
    CONSTRAINT constraint_177 CHECK (((occurred_at >= '2024-05-22 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-05-29 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_178_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_178_chunk (
    CONSTRAINT constraint_178 CHECK (((occurred_at >= '2024-05-29 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-06-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_179_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_179_chunk (
    CONSTRAINT constraint_179 CHECK (((occurred_at >= '2024-06-05 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-06-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_17_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_17_chunk (
    CONSTRAINT constraint_17 CHECK (((occurred_at >= '2021-04-21 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-04-28 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_180_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_180_chunk (
    CONSTRAINT constraint_180 CHECK (((occurred_at >= '2024-06-12 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-06-19 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_181_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_181_chunk (
    CONSTRAINT constraint_181 CHECK (((occurred_at >= '2024-06-19 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-06-26 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_182_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_182_chunk (
    CONSTRAINT constraint_182 CHECK (((occurred_at >= '2024-06-26 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-07-03 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_183_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_183_chunk (
    CONSTRAINT constraint_183 CHECK (((occurred_at >= '2024-07-03 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-07-10 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_184_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_184_chunk (
    CONSTRAINT constraint_184 CHECK (((occurred_at >= '2024-07-10 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-07-17 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_185_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_185_chunk (
    CONSTRAINT constraint_185 CHECK (((occurred_at >= '2024-07-17 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-07-24 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_186_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_186_chunk (
    CONSTRAINT constraint_186 CHECK (((occurred_at >= '2024-07-24 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-07-31 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_187_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_187_chunk (
    CONSTRAINT constraint_187 CHECK (((occurred_at >= '2024-07-31 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-08-07 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_188_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_188_chunk (
    CONSTRAINT constraint_188 CHECK (((occurred_at >= '2024-08-07 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-08-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_189_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_189_chunk (
    CONSTRAINT constraint_189 CHECK (((occurred_at >= '2024-08-14 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-08-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_18_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_18_chunk (
    CONSTRAINT constraint_18 CHECK (((occurred_at >= '2021-04-28 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-05-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_190_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_190_chunk (
    CONSTRAINT constraint_190 CHECK (((occurred_at >= '2024-08-21 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-08-28 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_191_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_191_chunk (
    CONSTRAINT constraint_191 CHECK (((occurred_at >= '2024-08-28 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-09-04 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_192_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_192_chunk (
    CONSTRAINT constraint_192 CHECK (((occurred_at >= '2024-09-04 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-09-11 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_193_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_193_chunk (
    CONSTRAINT constraint_193 CHECK (((occurred_at >= '2024-09-11 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-09-18 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_194_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_194_chunk (
    CONSTRAINT constraint_194 CHECK (((occurred_at >= '2024-09-18 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-09-25 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_195_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_195_chunk (
    CONSTRAINT constraint_195 CHECK (((occurred_at >= '2024-09-25 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-10-02 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_196_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_196_chunk (
    CONSTRAINT constraint_196 CHECK (((occurred_at >= '2024-10-02 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-10-09 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_197_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_197_chunk (
    CONSTRAINT constraint_197 CHECK (((occurred_at >= '2024-10-09 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-10-16 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_198_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_198_chunk (
    CONSTRAINT constraint_198 CHECK (((occurred_at >= '2024-10-16 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-10-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_199_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_199_chunk (
    CONSTRAINT constraint_199 CHECK (((occurred_at >= '2024-10-23 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-10-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_19_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_19_chunk (
    CONSTRAINT constraint_19 CHECK (((occurred_at >= '2021-05-05 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-05-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_1_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_1_chunk (
    CONSTRAINT constraint_1 CHECK (((occurred_at >= '2020-12-30 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-01-06 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_200_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_200_chunk (
    CONSTRAINT constraint_200 CHECK (((occurred_at >= '2024-10-30 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2024-11-06 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_201_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_201_chunk (
    CONSTRAINT constraint_201 CHECK (((occurred_at >= '2024-11-06 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-11-13 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_202_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_202_chunk (
    CONSTRAINT constraint_202 CHECK (((occurred_at >= '2024-11-13 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-11-20 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_203_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_203_chunk (
    CONSTRAINT constraint_203 CHECK (((occurred_at >= '2024-11-20 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-11-27 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_204_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_204_chunk (
    CONSTRAINT constraint_204 CHECK (((occurred_at >= '2024-11-27 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-12-04 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_205_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_205_chunk (
    CONSTRAINT constraint_205 CHECK (((occurred_at >= '2024-12-04 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-12-11 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_206_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_206_chunk (
    CONSTRAINT constraint_206 CHECK (((occurred_at >= '2024-12-11 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-12-18 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_207_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_207_chunk (
    CONSTRAINT constraint_207 CHECK (((occurred_at >= '2024-12-18 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2024-12-25 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_208_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_208_chunk (
    CONSTRAINT constraint_208 CHECK (((occurred_at >= '2024-12-25 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-01-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_209_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_209_chunk (
    CONSTRAINT constraint_209 CHECK (((occurred_at >= '2025-01-01 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-01-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_20_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_20_chunk (
    CONSTRAINT constraint_20 CHECK (((occurred_at >= '2021-05-12 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-05-19 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_210_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_210_chunk (
    CONSTRAINT constraint_210 CHECK (((occurred_at >= '2025-01-08 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-01-15 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_211_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_211_chunk (
    CONSTRAINT constraint_211 CHECK (((occurred_at >= '2025-01-15 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-01-22 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_212_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_212_chunk (
    CONSTRAINT constraint_212 CHECK (((occurred_at >= '2025-01-22 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-01-29 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_213_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_213_chunk (
    CONSTRAINT constraint_213 CHECK (((occurred_at >= '2025-01-29 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-02-05 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_214_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_214_chunk (
    CONSTRAINT constraint_214 CHECK (((occurred_at >= '2025-02-05 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-02-12 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_215_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_215_chunk (
    CONSTRAINT constraint_215 CHECK (((occurred_at >= '2025-02-12 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-02-19 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_216_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_216_chunk (
    CONSTRAINT constraint_216 CHECK (((occurred_at >= '2025-02-19 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-02-26 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_217_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_217_chunk (
    CONSTRAINT constraint_217 CHECK (((occurred_at >= '2025-02-26 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-03-05 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_218_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_218_chunk (
    CONSTRAINT constraint_218 CHECK (((occurred_at >= '2025-03-05 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2025-03-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_219_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_219_chunk (
    CONSTRAINT constraint_219 CHECK (((occurred_at >= '2025-03-12 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-03-19 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_21_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_21_chunk (
    CONSTRAINT constraint_21 CHECK (((occurred_at >= '2021-05-19 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-05-26 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_220_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_220_chunk (
    CONSTRAINT constraint_220 CHECK (((occurred_at >= '2025-03-19 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-03-26 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_221_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_221_chunk (
    CONSTRAINT constraint_221 CHECK (((occurred_at >= '2025-03-26 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-04-02 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_222_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_222_chunk (
    CONSTRAINT constraint_222 CHECK (((occurred_at >= '2025-04-02 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-04-09 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_223_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_223_chunk (
    CONSTRAINT constraint_223 CHECK (((occurred_at >= '2025-04-09 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-04-16 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_224_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_224_chunk (
    CONSTRAINT constraint_224 CHECK (((occurred_at >= '2025-04-16 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-04-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_225_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_225_chunk (
    CONSTRAINT constraint_225 CHECK (((occurred_at >= '2025-04-23 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-04-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_226_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_226_chunk (
    CONSTRAINT constraint_226 CHECK (((occurred_at >= '2025-04-30 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-05-07 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_227_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_227_chunk (
    CONSTRAINT constraint_227 CHECK (((occurred_at >= '2025-05-07 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-05-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_228_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_228_chunk (
    CONSTRAINT constraint_228 CHECK (((occurred_at >= '2025-05-14 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-05-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_229_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_229_chunk (
    CONSTRAINT constraint_229 CHECK (((occurred_at >= '2025-05-21 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-05-28 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_22_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_22_chunk (
    CONSTRAINT constraint_22 CHECK (((occurred_at >= '2021-05-26 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-06-02 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_230_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_230_chunk (
    CONSTRAINT constraint_230 CHECK (((occurred_at >= '2025-05-28 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-06-04 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_231_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_231_chunk (
    CONSTRAINT constraint_231 CHECK (((occurred_at >= '2025-06-04 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-06-11 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_232_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_232_chunk (
    CONSTRAINT constraint_232 CHECK (((occurred_at >= '2025-06-11 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-06-18 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_233_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_233_chunk (
    CONSTRAINT constraint_233 CHECK (((occurred_at >= '2025-06-18 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-06-25 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_234_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_234_chunk (
    CONSTRAINT constraint_234 CHECK (((occurred_at >= '2025-06-25 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-07-02 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_235_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_235_chunk (
    CONSTRAINT constraint_235 CHECK (((occurred_at >= '2025-07-02 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-07-09 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_236_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_236_chunk (
    CONSTRAINT constraint_236 CHECK (((occurred_at >= '2025-07-09 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-07-16 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_237_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_237_chunk (
    CONSTRAINT constraint_237 CHECK (((occurred_at >= '2025-07-16 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-07-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_238_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_238_chunk (
    CONSTRAINT constraint_238 CHECK (((occurred_at >= '2025-07-23 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-07-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_239_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_239_chunk (
    CONSTRAINT constraint_239 CHECK (((occurred_at >= '2025-07-30 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-08-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_23_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_23_chunk (
    CONSTRAINT constraint_23 CHECK (((occurred_at >= '2021-06-02 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-06-09 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_240_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_240_chunk (
    CONSTRAINT constraint_240 CHECK (((occurred_at >= '2025-08-06 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-08-13 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_241_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_241_chunk (
    CONSTRAINT constraint_241 CHECK (((occurred_at >= '2025-08-13 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-08-20 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_242_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_242_chunk (
    CONSTRAINT constraint_242 CHECK (((occurred_at >= '2025-08-20 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-08-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_243_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_243_chunk (
    CONSTRAINT constraint_243 CHECK (((occurred_at >= '2025-08-27 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2025-09-03 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_24_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_24_chunk (
    CONSTRAINT constraint_24 CHECK (((occurred_at >= '2021-06-09 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-06-16 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_25_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_25_chunk (
    CONSTRAINT constraint_25 CHECK (((occurred_at >= '2021-06-16 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-06-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_26_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_26_chunk (
    CONSTRAINT constraint_26 CHECK (((occurred_at >= '2021-06-23 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-06-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_27_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_27_chunk (
    CONSTRAINT constraint_27 CHECK (((occurred_at >= '2021-06-30 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-07-07 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_28_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_28_chunk (
    CONSTRAINT constraint_28 CHECK (((occurred_at >= '2021-07-07 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-07-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_29_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_29_chunk (
    CONSTRAINT constraint_29 CHECK (((occurred_at >= '2021-07-14 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-07-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_2_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_2_chunk (
    CONSTRAINT constraint_2 CHECK (((occurred_at >= '2021-01-06 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-01-13 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_30_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_30_chunk (
    CONSTRAINT constraint_30 CHECK (((occurred_at >= '2021-07-21 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-07-28 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_31_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_31_chunk (
    CONSTRAINT constraint_31 CHECK (((occurred_at >= '2021-07-28 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-08-04 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_32_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_32_chunk (
    CONSTRAINT constraint_32 CHECK (((occurred_at >= '2021-08-04 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-08-11 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_33_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_33_chunk (
    CONSTRAINT constraint_33 CHECK (((occurred_at >= '2021-08-11 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-08-18 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_34_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_34_chunk (
    CONSTRAINT constraint_34 CHECK (((occurred_at >= '2021-08-18 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-08-25 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_35_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_35_chunk (
    CONSTRAINT constraint_35 CHECK (((occurred_at >= '2021-08-25 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-09-01 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_36_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_36_chunk (
    CONSTRAINT constraint_36 CHECK (((occurred_at >= '2021-09-01 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-09-08 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_37_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_37_chunk (
    CONSTRAINT constraint_37 CHECK (((occurred_at >= '2021-09-08 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-09-15 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_38_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_38_chunk (
    CONSTRAINT constraint_38 CHECK (((occurred_at >= '2021-09-15 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-09-22 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_39_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_39_chunk (
    CONSTRAINT constraint_39 CHECK (((occurred_at >= '2021-09-22 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-09-29 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_3_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_3_chunk (
    CONSTRAINT constraint_3 CHECK (((occurred_at >= '2021-01-13 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-01-20 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_40_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_40_chunk (
    CONSTRAINT constraint_40 CHECK (((occurred_at >= '2021-09-29 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-10-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_41_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_41_chunk (
    CONSTRAINT constraint_41 CHECK (((occurred_at >= '2021-10-06 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-10-13 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_42_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_42_chunk (
    CONSTRAINT constraint_42 CHECK (((occurred_at >= '2021-10-13 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-10-20 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_43_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_43_chunk (
    CONSTRAINT constraint_43 CHECK (((occurred_at >= '2021-10-20 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-10-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_44_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_44_chunk (
    CONSTRAINT constraint_44 CHECK (((occurred_at >= '2021-10-27 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-11-03 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_45_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_45_chunk (
    CONSTRAINT constraint_45 CHECK (((occurred_at >= '2021-11-03 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2021-11-10 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_46_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_46_chunk (
    CONSTRAINT constraint_46 CHECK (((occurred_at >= '2021-11-10 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-11-17 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_47_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_47_chunk (
    CONSTRAINT constraint_47 CHECK (((occurred_at >= '2021-11-17 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-11-24 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_48_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_48_chunk (
    CONSTRAINT constraint_48 CHECK (((occurred_at >= '2021-11-24 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-12-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_49_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_49_chunk (
    CONSTRAINT constraint_49 CHECK (((occurred_at >= '2021-12-01 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-12-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_4_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_4_chunk (
    CONSTRAINT constraint_4 CHECK (((occurred_at >= '2021-01-20 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-01-27 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_50_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_50_chunk (
    CONSTRAINT constraint_50 CHECK (((occurred_at >= '2021-12-08 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-12-15 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_51_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_51_chunk (
    CONSTRAINT constraint_51 CHECK (((occurred_at >= '2021-12-15 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-12-22 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_52_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_52_chunk (
    CONSTRAINT constraint_52 CHECK (((occurred_at >= '2021-12-22 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-12-29 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_53_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_53_chunk (
    CONSTRAINT constraint_53 CHECK (((occurred_at >= '2021-12-29 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-01-05 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_54_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_54_chunk (
    CONSTRAINT constraint_54 CHECK (((occurred_at >= '2022-01-05 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-01-12 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_55_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_55_chunk (
    CONSTRAINT constraint_55 CHECK (((occurred_at >= '2022-01-12 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-01-19 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_56_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_56_chunk (
    CONSTRAINT constraint_56 CHECK (((occurred_at >= '2022-01-19 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-01-26 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_57_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_57_chunk (
    CONSTRAINT constraint_57 CHECK (((occurred_at >= '2022-01-26 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-02-02 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_58_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_58_chunk (
    CONSTRAINT constraint_58 CHECK (((occurred_at >= '2022-02-02 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-02-09 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_59_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_59_chunk (
    CONSTRAINT constraint_59 CHECK (((occurred_at >= '2022-02-09 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-02-16 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_5_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_5_chunk (
    CONSTRAINT constraint_5 CHECK (((occurred_at >= '2021-01-27 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-02-03 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_60_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_60_chunk (
    CONSTRAINT constraint_60 CHECK (((occurred_at >= '2022-02-16 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-02-23 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_61_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_61_chunk (
    CONSTRAINT constraint_61 CHECK (((occurred_at >= '2022-02-23 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-03-02 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_62_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_62_chunk (
    CONSTRAINT constraint_62 CHECK (((occurred_at >= '2022-03-02 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-03-09 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_63_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_63_chunk (
    CONSTRAINT constraint_63 CHECK (((occurred_at >= '2022-03-09 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-03-16 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_64_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_64_chunk (
    CONSTRAINT constraint_64 CHECK (((occurred_at >= '2022-03-16 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-03-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_65_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_65_chunk (
    CONSTRAINT constraint_65 CHECK (((occurred_at >= '2022-03-23 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-03-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_66_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_66_chunk (
    CONSTRAINT constraint_66 CHECK (((occurred_at >= '2022-03-30 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-04-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_67_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_67_chunk (
    CONSTRAINT constraint_67 CHECK (((occurred_at >= '2022-04-06 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-04-13 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_68_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_68_chunk (
    CONSTRAINT constraint_68 CHECK (((occurred_at >= '2022-04-13 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-04-20 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_69_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_69_chunk (
    CONSTRAINT constraint_69 CHECK (((occurred_at >= '2022-04-20 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-04-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_6_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_6_chunk (
    CONSTRAINT constraint_6 CHECK (((occurred_at >= '2021-02-03 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-02-10 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_70_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_70_chunk (
    CONSTRAINT constraint_70 CHECK (((occurred_at >= '2022-04-27 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-05-04 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_71_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_71_chunk (
    CONSTRAINT constraint_71 CHECK (((occurred_at >= '2022-05-04 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-05-11 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_72_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_72_chunk (
    CONSTRAINT constraint_72 CHECK (((occurred_at >= '2022-05-11 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-05-18 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_73_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_73_chunk (
    CONSTRAINT constraint_73 CHECK (((occurred_at >= '2022-05-18 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-05-25 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_74_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_74_chunk (
    CONSTRAINT constraint_74 CHECK (((occurred_at >= '2022-05-25 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-06-01 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_75_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_75_chunk (
    CONSTRAINT constraint_75 CHECK (((occurred_at >= '2022-06-01 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-06-08 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_76_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_76_chunk (
    CONSTRAINT constraint_76 CHECK (((occurred_at >= '2022-06-08 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-06-15 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_77_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_77_chunk (
    CONSTRAINT constraint_77 CHECK (((occurred_at >= '2022-06-15 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-06-22 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_78_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_78_chunk (
    CONSTRAINT constraint_78 CHECK (((occurred_at >= '2022-06-22 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-06-29 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_79_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_79_chunk (
    CONSTRAINT constraint_79 CHECK (((occurred_at >= '2022-06-29 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-07-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_7_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_7_chunk (
    CONSTRAINT constraint_7 CHECK (((occurred_at >= '2021-02-10 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-02-17 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_80_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_80_chunk (
    CONSTRAINT constraint_80 CHECK (((occurred_at >= '2022-07-06 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-07-13 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_81_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_81_chunk (
    CONSTRAINT constraint_81 CHECK (((occurred_at >= '2022-07-13 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-07-20 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_82_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_82_chunk (
    CONSTRAINT constraint_82 CHECK (((occurred_at >= '2022-07-20 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-07-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_83_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_83_chunk (
    CONSTRAINT constraint_83 CHECK (((occurred_at >= '2022-07-27 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-08-03 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_84_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_84_chunk (
    CONSTRAINT constraint_84 CHECK (((occurred_at >= '2022-08-03 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-08-10 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_85_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_85_chunk (
    CONSTRAINT constraint_85 CHECK (((occurred_at >= '2022-08-10 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-08-17 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_86_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_86_chunk (
    CONSTRAINT constraint_86 CHECK (((occurred_at >= '2022-08-17 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-08-24 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_87_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_87_chunk (
    CONSTRAINT constraint_87 CHECK (((occurred_at >= '2022-08-24 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-08-31 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_88_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_88_chunk (
    CONSTRAINT constraint_88 CHECK (((occurred_at >= '2022-08-31 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-09-07 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_89_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_89_chunk (
    CONSTRAINT constraint_89 CHECK (((occurred_at >= '2022-09-07 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-09-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_8_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_8_chunk (
    CONSTRAINT constraint_8 CHECK (((occurred_at >= '2021-02-17 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-02-24 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_90_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_90_chunk (
    CONSTRAINT constraint_90 CHECK (((occurred_at >= '2022-09-14 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-09-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_91_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_91_chunk (
    CONSTRAINT constraint_91 CHECK (((occurred_at >= '2022-09-21 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-09-28 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_92_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_92_chunk (
    CONSTRAINT constraint_92 CHECK (((occurred_at >= '2022-09-28 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-10-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_93_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_93_chunk (
    CONSTRAINT constraint_93 CHECK (((occurred_at >= '2022-10-05 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-10-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_94_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_94_chunk (
    CONSTRAINT constraint_94 CHECK (((occurred_at >= '2022-10-12 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-10-19 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_95_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_95_chunk (
    CONSTRAINT constraint_95 CHECK (((occurred_at >= '2022-10-19 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-10-26 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_96_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_96_chunk (
    CONSTRAINT constraint_96 CHECK (((occurred_at >= '2022-10-26 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-11-02 19:00:00-05'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_97_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_97_chunk (
    CONSTRAINT constraint_97 CHECK (((occurred_at >= '2022-11-02 19:00:00-05'::timestamp with time zone) AND (occurred_at < '2022-11-09 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_98_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_98_chunk (
    CONSTRAINT constraint_98 CHECK (((occurred_at >= '2022-11-09 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-11-16 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_99_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_99_chunk (
    CONSTRAINT constraint_99 CHECK (((occurred_at >= '2022-11-16 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2022-11-23 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_1_9_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_1_9_chunk (
    CONSTRAINT constraint_9 CHECK (((occurred_at >= '2021-02-24 18:00:00-06'::timestamp with time zone) AND (occurred_at < '2021-03-03 18:00:00-06'::timestamp with time zone)))
)
INHERITS (public.events);


--
-- Name: _materialized_hypertable_3; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_3 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: _hyper_3_269_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_269_chunk (
    CONSTRAINT constraint_269 CHECK (((bucket_start >= '2020-12-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2021-03-03 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_270_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_270_chunk (
    CONSTRAINT constraint_270 CHECK (((bucket_start >= '2023-06-21 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-08-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_271_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_271_chunk (
    CONSTRAINT constraint_271 CHECK (((bucket_start >= '2021-12-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2022-02-16 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_272_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_272_chunk (
    CONSTRAINT constraint_272 CHECK (((bucket_start >= '2022-04-27 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-07-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_273_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_273_chunk (
    CONSTRAINT constraint_273 CHECK (((bucket_start >= '2024-03-27 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-06-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_274_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_274_chunk (
    CONSTRAINT constraint_274 CHECK (((bucket_start >= '2025-03-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-05-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_275_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_275_chunk (
    CONSTRAINT constraint_275 CHECK (((bucket_start >= '2021-07-21 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-09-29 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_276_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_276_chunk (
    CONSTRAINT constraint_276 CHECK (((bucket_start >= '2024-01-17 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2024-03-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_277_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_277_chunk (
    CONSTRAINT constraint_277 CHECK (((bucket_start >= '2024-08-14 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-10-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_278_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_278_chunk (
    CONSTRAINT constraint_278 CHECK (((bucket_start >= '2023-04-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-06-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_279_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_279_chunk (
    CONSTRAINT constraint_279 CHECK (((bucket_start >= '2023-02-01 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2023-04-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_280_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_280_chunk (
    CONSTRAINT constraint_280 CHECK (((bucket_start >= '2022-02-16 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2022-04-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_281_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_281_chunk (
    CONSTRAINT constraint_281 CHECK (((bucket_start >= '2023-08-30 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-11-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_282_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_282_chunk (
    CONSTRAINT constraint_282 CHECK (((bucket_start >= '2025-01-01 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2025-03-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_283_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_283_chunk (
    CONSTRAINT constraint_283 CHECK (((bucket_start >= '2024-10-23 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-01-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_284_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_284_chunk (
    CONSTRAINT constraint_284 CHECK (((bucket_start >= '2025-05-21 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-07-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_285_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_285_chunk (
    CONSTRAINT constraint_285 CHECK (((bucket_start >= '2021-09-29 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-12-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_286_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_286_chunk (
    CONSTRAINT constraint_286 CHECK (((bucket_start >= '2022-09-14 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-11-23 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_287_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_287_chunk (
    CONSTRAINT constraint_287 CHECK (((bucket_start >= '2021-05-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-07-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_288_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_288_chunk (
    CONSTRAINT constraint_288 CHECK (((bucket_start >= '2021-03-03 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2021-05-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_289_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_289_chunk (
    CONSTRAINT constraint_289 CHECK (((bucket_start >= '2024-06-05 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-08-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_290_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_290_chunk (
    CONSTRAINT constraint_290 CHECK (((bucket_start >= '2022-07-06 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-09-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_291_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_291_chunk (
    CONSTRAINT constraint_291 CHECK (((bucket_start >= '2023-11-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2024-01-17 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _hyper_3_292_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_3_292_chunk (
    CONSTRAINT constraint_292 CHECK (((bucket_start >= '2022-11-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2023-02-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_3);


--
-- Name: _materialized_hypertable_4; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_4 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: _hyper_4_293_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_293_chunk (
    CONSTRAINT constraint_293 CHECK (((bucket_start >= '2021-12-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2022-02-16 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_294_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_294_chunk (
    CONSTRAINT constraint_294 CHECK (((bucket_start >= '2022-04-27 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-07-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_295_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_295_chunk (
    CONSTRAINT constraint_295 CHECK (((bucket_start >= '2024-03-27 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-06-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_296_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_296_chunk (
    CONSTRAINT constraint_296 CHECK (((bucket_start >= '2025-03-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-05-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_297_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_297_chunk (
    CONSTRAINT constraint_297 CHECK (((bucket_start >= '2023-06-21 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-08-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_298_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_298_chunk (
    CONSTRAINT constraint_298 CHECK (((bucket_start >= '2024-08-14 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-10-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_299_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_299_chunk (
    CONSTRAINT constraint_299 CHECK (((bucket_start >= '2023-02-01 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2023-04-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_300_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_300_chunk (
    CONSTRAINT constraint_300 CHECK (((bucket_start >= '2023-08-30 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-11-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_301_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_301_chunk (
    CONSTRAINT constraint_301 CHECK (((bucket_start >= '2022-02-16 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2022-04-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_302_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_302_chunk (
    CONSTRAINT constraint_302 CHECK (((bucket_start >= '2022-09-14 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-11-23 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_303_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_303_chunk (
    CONSTRAINT constraint_303 CHECK (((bucket_start >= '2021-05-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-07-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_304_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_304_chunk (
    CONSTRAINT constraint_304 CHECK (((bucket_start >= '2024-10-23 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-01-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_305_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_305_chunk (
    CONSTRAINT constraint_305 CHECK (((bucket_start >= '2021-03-03 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2021-05-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_306_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_306_chunk (
    CONSTRAINT constraint_306 CHECK (((bucket_start >= '2024-06-05 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-08-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_307_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_307_chunk (
    CONSTRAINT constraint_307 CHECK (((bucket_start >= '2023-11-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2024-01-17 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_308_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_308_chunk (
    CONSTRAINT constraint_308 CHECK (((bucket_start >= '2021-09-29 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-12-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_309_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_309_chunk (
    CONSTRAINT constraint_309 CHECK (((bucket_start >= '2020-12-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2021-03-03 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _hyper_4_310_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_4_310_chunk (
    CONSTRAINT constraint_310 CHECK (((bucket_start >= '2022-11-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2023-02-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_4);


--
-- Name: _materialized_hypertable_5; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_5 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: _hyper_5_311_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_5_311_chunk (
    CONSTRAINT constraint_311 CHECK (((bucket_start >= '2021-12-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2022-02-16 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_5);


--
-- Name: _hyper_5_312_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_5_312_chunk (
    CONSTRAINT constraint_312 CHECK (((bucket_start >= '2023-11-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2024-01-17 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_5);


--
-- Name: _hyper_5_313_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_5_313_chunk (
    CONSTRAINT constraint_313 CHECK (((bucket_start >= '2020-12-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2021-03-03 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_5);


--
-- Name: _hyper_5_314_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_5_314_chunk (
    CONSTRAINT constraint_314 CHECK (((bucket_start >= '2022-11-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2023-02-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_5);


--
-- Name: _materialized_hypertable_6; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._materialized_hypertable_6 (
    metric_key text,
    bucket_start timestamp with time zone NOT NULL,
    value numeric
);


--
-- Name: _hyper_6_315_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_315_chunk (
    CONSTRAINT constraint_315 CHECK (((bucket_start >= '2025-07-30 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-10-08 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_316_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_316_chunk (
    CONSTRAINT constraint_316 CHECK (((bucket_start >= '2025-05-21 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-07-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_317_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_317_chunk (
    CONSTRAINT constraint_317 CHECK (((bucket_start >= '2024-03-27 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-06-05 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_318_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_318_chunk (
    CONSTRAINT constraint_318 CHECK (((bucket_start >= '2025-03-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-05-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_319_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_319_chunk (
    CONSTRAINT constraint_319 CHECK (((bucket_start >= '2023-02-01 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2023-04-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_320_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_320_chunk (
    CONSTRAINT constraint_320 CHECK (((bucket_start >= '2021-12-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2022-02-16 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_321_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_321_chunk (
    CONSTRAINT constraint_321 CHECK (((bucket_start >= '2023-08-30 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-11-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_322_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_322_chunk (
    CONSTRAINT constraint_322 CHECK (((bucket_start >= '2021-03-03 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2021-05-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_323_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_323_chunk (
    CONSTRAINT constraint_323 CHECK (((bucket_start >= '2022-04-27 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-07-06 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_324_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_324_chunk (
    CONSTRAINT constraint_324 CHECK (((bucket_start >= '2020-12-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2021-03-03 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_325_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_325_chunk (
    CONSTRAINT constraint_325 CHECK (((bucket_start >= '2024-08-14 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-10-23 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_326_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_326_chunk (
    CONSTRAINT constraint_326 CHECK (((bucket_start >= '2021-09-29 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-12-08 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_327_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_327_chunk (
    CONSTRAINT constraint_327 CHECK (((bucket_start >= '2023-06-21 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-08-30 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_328_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_328_chunk (
    CONSTRAINT constraint_328 CHECK (((bucket_start >= '2021-05-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-07-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_329_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_329_chunk (
    CONSTRAINT constraint_329 CHECK (((bucket_start >= '2022-11-23 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2023-02-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_330_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_330_chunk (
    CONSTRAINT constraint_330 CHECK (((bucket_start >= '2024-10-23 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2025-01-01 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_331_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_331_chunk (
    CONSTRAINT constraint_331 CHECK (((bucket_start >= '2023-11-08 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2024-01-17 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_332_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_332_chunk (
    CONSTRAINT constraint_332 CHECK (((bucket_start >= '2023-04-12 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2023-06-21 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_333_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_333_chunk (
    CONSTRAINT constraint_333 CHECK (((bucket_start >= '2022-07-06 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-09-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_334_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_334_chunk (
    CONSTRAINT constraint_334 CHECK (((bucket_start >= '2024-06-05 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2024-08-14 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_335_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_335_chunk (
    CONSTRAINT constraint_335 CHECK (((bucket_start >= '2021-07-21 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2021-09-29 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_336_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_336_chunk (
    CONSTRAINT constraint_336 CHECK (((bucket_start >= '2022-09-14 19:00:00-05'::timestamp with time zone) AND (bucket_start < '2022-11-23 18:00:00-06'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_337_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_337_chunk (
    CONSTRAINT constraint_337 CHECK (((bucket_start >= '2025-01-01 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2025-03-12 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_338_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_338_chunk (
    CONSTRAINT constraint_338 CHECK (((bucket_start >= '2022-02-16 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2022-04-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _hyper_6_339_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_6_339_chunk (
    CONSTRAINT constraint_339 CHECK (((bucket_start >= '2024-01-17 18:00:00-06'::timestamp with time zone) AND (bucket_start < '2024-03-27 19:00:00-05'::timestamp with time zone)))
)
INHERITS (_timescaledb_internal._materialized_hypertable_6);


--
-- Name: _partial_view_3; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_3 AS
 SELECT metric_key,
    public.time_bucket('1 mon'::interval, occurred_at) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('1 mon'::interval, occurred_at));


--
-- Name: _partial_view_4; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_4 AS
 SELECT metric_key,
    public.time_bucket('3 mons'::interval, occurred_at) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('3 mons'::interval, occurred_at));


--
-- Name: _partial_view_5; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_5 AS
 SELECT metric_key,
    public.time_bucket('1 year'::interval, occurred_at) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('1 year'::interval, occurred_at));


--
-- Name: _partial_view_6; Type: VIEW; Schema: _timescaledb_internal; Owner: -
--

CREATE VIEW _timescaledb_internal._partial_view_6 AS
 SELECT metric_key,
    public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text) AS bucket_start,
    sum(((payload ->> 'value'::text))::numeric) AS value
   FROM public.events
  WHERE (type = 'MetricRecorded'::text)
  GROUP BY metric_key, (public.time_bucket('1 day'::interval, occurred_at, 'America/Chicago'::text));


--
-- Name: ca_daily; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_daily AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_6;


--
-- Name: ca_monthly; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_monthly AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_3;


--
-- Name: ca_quarterly; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_quarterly AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_4;


--
-- Name: ca_yearly; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.ca_yearly AS
 SELECT metric_key,
    bucket_start,
    value
   FROM _timescaledb_internal._materialized_hypertable_5;


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
-- Name: _hyper_1_100_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_100_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_101_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_101_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_102_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_102_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_103_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_103_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_104_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_104_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_105_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_105_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_106_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_106_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_107_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_107_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_108_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_108_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_109_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_109_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_10_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_10_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_110_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_110_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_111_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_111_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_112_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_112_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_113_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_113_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_114_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_114_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_115_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_115_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_116_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_116_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_117_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_117_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_118_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_118_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_119_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_119_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_11_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_11_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_120_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_120_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_121_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_121_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_122_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_122_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_123_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_123_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_124_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_124_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_125_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_125_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_126_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_126_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_127_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_127_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_128_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_128_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_129_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_129_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_12_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_12_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_130_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_130_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_131_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_131_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_132_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_132_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_133_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_133_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_134_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_134_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_135_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_135_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_136_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_136_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_137_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_137_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_138_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_138_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_139_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_139_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_13_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_13_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_140_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_140_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_141_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_141_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_142_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_142_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_143_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_143_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_144_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_144_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_145_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_145_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_146_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_146_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_147_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_147_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_148_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_148_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_149_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_149_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_14_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_14_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_150_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_150_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_151_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_151_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_152_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_152_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_153_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_153_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_154_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_154_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_155_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_155_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_156_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_156_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_157_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_157_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_158_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_158_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_159_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_159_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_15_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_15_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_160_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_160_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_161_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_161_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_162_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_162_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_163_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_163_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_164_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_164_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_165_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_165_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_166_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_166_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_167_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_167_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_168_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_168_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_169_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_169_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_16_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_16_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_170_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_170_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_171_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_171_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_172_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_172_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_173_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_173_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_174_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_174_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_175_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_175_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_176_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_176_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_177_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_177_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_178_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_178_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_179_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_179_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_17_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_17_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_180_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_180_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_181_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_181_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_182_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_182_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_183_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_183_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_184_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_184_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_185_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_185_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_186_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_186_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_187_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_187_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_188_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_188_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_189_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_189_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_18_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_18_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_190_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_190_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_191_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_191_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_192_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_192_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_193_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_193_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_194_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_194_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_195_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_195_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_196_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_196_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_197_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_197_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_198_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_198_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_199_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_199_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_19_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_19_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_1_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_1_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_200_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_200_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_201_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_201_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_202_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_202_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_203_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_203_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_204_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_204_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_205_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_205_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_206_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_206_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_207_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_207_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_208_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_208_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_209_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_209_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_20_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_20_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_210_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_210_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_211_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_211_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_212_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_212_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_213_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_213_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_214_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_214_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_215_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_215_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_216_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_216_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_217_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_217_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_218_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_218_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_219_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_219_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_21_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_21_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_220_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_220_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_221_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_221_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_222_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_222_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_223_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_223_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_224_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_224_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_225_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_225_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_226_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_226_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_227_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_227_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_228_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_228_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_229_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_229_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_22_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_22_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_230_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_230_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_231_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_231_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_232_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_232_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_233_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_233_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_234_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_234_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_235_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_235_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_236_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_236_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_237_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_237_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_238_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_238_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_239_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_239_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_23_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_23_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_240_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_240_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_241_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_241_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_242_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_242_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_243_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_243_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_24_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_24_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_25_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_25_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_26_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_26_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_27_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_27_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_28_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_28_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_29_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_29_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_2_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_2_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_30_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_30_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_31_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_31_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_32_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_32_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_33_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_33_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_34_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_34_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_35_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_35_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_36_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_36_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_37_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_37_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_38_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_38_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_39_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_39_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_3_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_3_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_40_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_40_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_41_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_41_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_42_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_42_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_43_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_43_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_44_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_44_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_45_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_45_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_46_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_46_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_47_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_47_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_48_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_48_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_49_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_49_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_4_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_4_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_50_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_50_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_51_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_51_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_52_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_52_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_53_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_53_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_54_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_54_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_55_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_55_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_56_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_56_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_57_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_57_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_58_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_58_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_59_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_59_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_5_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_5_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_60_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_60_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_61_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_61_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_62_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_62_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_63_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_63_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_64_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_64_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_65_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_65_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_66_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_66_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_67_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_67_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_68_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_68_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_69_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_69_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_6_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_6_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_70_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_70_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_71_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_71_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_72_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_72_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_73_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_73_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_74_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_74_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_75_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_75_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_76_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_76_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_77_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_77_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_78_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_78_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_79_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_79_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_7_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_7_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_80_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_80_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_81_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_81_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_82_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_82_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_83_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_83_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_84_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_84_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_85_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_85_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_86_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_86_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_87_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_87_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_88_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_88_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_89_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_89_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_8_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_8_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_90_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_90_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_91_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_91_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_92_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_92_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_93_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_93_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_94_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_94_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_95_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_95_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_96_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_96_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_97_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_97_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_98_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_98_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_99_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_99_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_9_chunk recorded_at; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_9_chunk ALTER COLUMN recorded_at SET DEFAULT now();


--
-- Name: _hyper_1_100_chunk 100_100_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_100_chunk
    ADD CONSTRAINT "100_100_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_101_chunk 101_101_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_101_chunk
    ADD CONSTRAINT "101_101_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_102_chunk 102_102_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_102_chunk
    ADD CONSTRAINT "102_102_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_103_chunk 103_103_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_103_chunk
    ADD CONSTRAINT "103_103_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_104_chunk 104_104_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_104_chunk
    ADD CONSTRAINT "104_104_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_105_chunk 105_105_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_105_chunk
    ADD CONSTRAINT "105_105_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_106_chunk 106_106_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_106_chunk
    ADD CONSTRAINT "106_106_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_107_chunk 107_107_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_107_chunk
    ADD CONSTRAINT "107_107_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_108_chunk 108_108_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_108_chunk
    ADD CONSTRAINT "108_108_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_109_chunk 109_109_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_109_chunk
    ADD CONSTRAINT "109_109_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_10_chunk 10_10_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_10_chunk
    ADD CONSTRAINT "10_10_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_110_chunk 110_110_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_110_chunk
    ADD CONSTRAINT "110_110_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_111_chunk 111_111_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_111_chunk
    ADD CONSTRAINT "111_111_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_112_chunk 112_112_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_112_chunk
    ADD CONSTRAINT "112_112_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_113_chunk 113_113_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_113_chunk
    ADD CONSTRAINT "113_113_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_114_chunk 114_114_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_114_chunk
    ADD CONSTRAINT "114_114_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_115_chunk 115_115_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_115_chunk
    ADD CONSTRAINT "115_115_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_116_chunk 116_116_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_116_chunk
    ADD CONSTRAINT "116_116_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_117_chunk 117_117_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_117_chunk
    ADD CONSTRAINT "117_117_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_118_chunk 118_118_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_118_chunk
    ADD CONSTRAINT "118_118_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_119_chunk 119_119_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_119_chunk
    ADD CONSTRAINT "119_119_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_11_chunk 11_11_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_11_chunk
    ADD CONSTRAINT "11_11_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_120_chunk 120_120_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_120_chunk
    ADD CONSTRAINT "120_120_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_121_chunk 121_121_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_121_chunk
    ADD CONSTRAINT "121_121_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_122_chunk 122_122_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_122_chunk
    ADD CONSTRAINT "122_122_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_123_chunk 123_123_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_123_chunk
    ADD CONSTRAINT "123_123_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_124_chunk 124_124_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_124_chunk
    ADD CONSTRAINT "124_124_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_125_chunk 125_125_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_125_chunk
    ADD CONSTRAINT "125_125_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_126_chunk 126_126_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_126_chunk
    ADD CONSTRAINT "126_126_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_127_chunk 127_127_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_127_chunk
    ADD CONSTRAINT "127_127_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_128_chunk 128_128_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_128_chunk
    ADD CONSTRAINT "128_128_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_129_chunk 129_129_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_129_chunk
    ADD CONSTRAINT "129_129_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_12_chunk 12_12_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_12_chunk
    ADD CONSTRAINT "12_12_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_130_chunk 130_130_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_130_chunk
    ADD CONSTRAINT "130_130_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_131_chunk 131_131_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_131_chunk
    ADD CONSTRAINT "131_131_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_132_chunk 132_132_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_132_chunk
    ADD CONSTRAINT "132_132_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_133_chunk 133_133_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_133_chunk
    ADD CONSTRAINT "133_133_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_134_chunk 134_134_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_134_chunk
    ADD CONSTRAINT "134_134_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_135_chunk 135_135_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_135_chunk
    ADD CONSTRAINT "135_135_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_136_chunk 136_136_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_136_chunk
    ADD CONSTRAINT "136_136_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_137_chunk 137_137_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_137_chunk
    ADD CONSTRAINT "137_137_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_138_chunk 138_138_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_138_chunk
    ADD CONSTRAINT "138_138_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_139_chunk 139_139_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_139_chunk
    ADD CONSTRAINT "139_139_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_13_chunk 13_13_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_13_chunk
    ADD CONSTRAINT "13_13_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_140_chunk 140_140_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_140_chunk
    ADD CONSTRAINT "140_140_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_141_chunk 141_141_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_141_chunk
    ADD CONSTRAINT "141_141_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_142_chunk 142_142_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_142_chunk
    ADD CONSTRAINT "142_142_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_143_chunk 143_143_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_143_chunk
    ADD CONSTRAINT "143_143_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_144_chunk 144_144_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_144_chunk
    ADD CONSTRAINT "144_144_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_145_chunk 145_145_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_145_chunk
    ADD CONSTRAINT "145_145_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_146_chunk 146_146_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_146_chunk
    ADD CONSTRAINT "146_146_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_147_chunk 147_147_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_147_chunk
    ADD CONSTRAINT "147_147_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_148_chunk 148_148_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_148_chunk
    ADD CONSTRAINT "148_148_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_149_chunk 149_149_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_149_chunk
    ADD CONSTRAINT "149_149_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_14_chunk 14_14_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_14_chunk
    ADD CONSTRAINT "14_14_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_150_chunk 150_150_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_150_chunk
    ADD CONSTRAINT "150_150_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_151_chunk 151_151_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_151_chunk
    ADD CONSTRAINT "151_151_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_152_chunk 152_152_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_152_chunk
    ADD CONSTRAINT "152_152_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_153_chunk 153_153_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_153_chunk
    ADD CONSTRAINT "153_153_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_154_chunk 154_154_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_154_chunk
    ADD CONSTRAINT "154_154_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_155_chunk 155_155_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_155_chunk
    ADD CONSTRAINT "155_155_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_156_chunk 156_156_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_156_chunk
    ADD CONSTRAINT "156_156_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_157_chunk 157_157_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_157_chunk
    ADD CONSTRAINT "157_157_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_158_chunk 158_158_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_158_chunk
    ADD CONSTRAINT "158_158_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_159_chunk 159_159_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_159_chunk
    ADD CONSTRAINT "159_159_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_15_chunk 15_15_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_15_chunk
    ADD CONSTRAINT "15_15_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_160_chunk 160_160_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_160_chunk
    ADD CONSTRAINT "160_160_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_161_chunk 161_161_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_161_chunk
    ADD CONSTRAINT "161_161_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_162_chunk 162_162_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_162_chunk
    ADD CONSTRAINT "162_162_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_163_chunk 163_163_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_163_chunk
    ADD CONSTRAINT "163_163_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_164_chunk 164_164_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_164_chunk
    ADD CONSTRAINT "164_164_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_165_chunk 165_165_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_165_chunk
    ADD CONSTRAINT "165_165_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_166_chunk 166_166_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_166_chunk
    ADD CONSTRAINT "166_166_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_167_chunk 167_167_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_167_chunk
    ADD CONSTRAINT "167_167_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_168_chunk 168_168_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_168_chunk
    ADD CONSTRAINT "168_168_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_169_chunk 169_169_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_169_chunk
    ADD CONSTRAINT "169_169_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_16_chunk 16_16_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_16_chunk
    ADD CONSTRAINT "16_16_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_170_chunk 170_170_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_170_chunk
    ADD CONSTRAINT "170_170_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_171_chunk 171_171_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_171_chunk
    ADD CONSTRAINT "171_171_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_172_chunk 172_172_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_172_chunk
    ADD CONSTRAINT "172_172_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_173_chunk 173_173_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_173_chunk
    ADD CONSTRAINT "173_173_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_174_chunk 174_174_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_174_chunk
    ADD CONSTRAINT "174_174_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_175_chunk 175_175_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_175_chunk
    ADD CONSTRAINT "175_175_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_176_chunk 176_176_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_176_chunk
    ADD CONSTRAINT "176_176_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_177_chunk 177_177_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_177_chunk
    ADD CONSTRAINT "177_177_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_178_chunk 178_178_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_178_chunk
    ADD CONSTRAINT "178_178_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_179_chunk 179_179_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_179_chunk
    ADD CONSTRAINT "179_179_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_17_chunk 17_17_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_17_chunk
    ADD CONSTRAINT "17_17_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_180_chunk 180_180_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_180_chunk
    ADD CONSTRAINT "180_180_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_181_chunk 181_181_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_181_chunk
    ADD CONSTRAINT "181_181_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_182_chunk 182_182_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_182_chunk
    ADD CONSTRAINT "182_182_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_183_chunk 183_183_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_183_chunk
    ADD CONSTRAINT "183_183_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_184_chunk 184_184_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_184_chunk
    ADD CONSTRAINT "184_184_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_185_chunk 185_185_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_185_chunk
    ADD CONSTRAINT "185_185_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_186_chunk 186_186_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_186_chunk
    ADD CONSTRAINT "186_186_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_187_chunk 187_187_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_187_chunk
    ADD CONSTRAINT "187_187_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_188_chunk 188_188_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_188_chunk
    ADD CONSTRAINT "188_188_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_189_chunk 189_189_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_189_chunk
    ADD CONSTRAINT "189_189_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_18_chunk 18_18_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_18_chunk
    ADD CONSTRAINT "18_18_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_190_chunk 190_190_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_190_chunk
    ADD CONSTRAINT "190_190_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_191_chunk 191_191_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_191_chunk
    ADD CONSTRAINT "191_191_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_192_chunk 192_192_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_192_chunk
    ADD CONSTRAINT "192_192_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_193_chunk 193_193_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_193_chunk
    ADD CONSTRAINT "193_193_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_194_chunk 194_194_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_194_chunk
    ADD CONSTRAINT "194_194_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_195_chunk 195_195_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_195_chunk
    ADD CONSTRAINT "195_195_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_196_chunk 196_196_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_196_chunk
    ADD CONSTRAINT "196_196_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_197_chunk 197_197_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_197_chunk
    ADD CONSTRAINT "197_197_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_198_chunk 198_198_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_198_chunk
    ADD CONSTRAINT "198_198_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_199_chunk 199_199_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_199_chunk
    ADD CONSTRAINT "199_199_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_19_chunk 19_19_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_19_chunk
    ADD CONSTRAINT "19_19_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_1_chunk 1_1_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_1_chunk
    ADD CONSTRAINT "1_1_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_200_chunk 200_200_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_200_chunk
    ADD CONSTRAINT "200_200_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_201_chunk 201_201_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_201_chunk
    ADD CONSTRAINT "201_201_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_202_chunk 202_202_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_202_chunk
    ADD CONSTRAINT "202_202_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_203_chunk 203_203_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_203_chunk
    ADD CONSTRAINT "203_203_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_204_chunk 204_204_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_204_chunk
    ADD CONSTRAINT "204_204_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_205_chunk 205_205_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_205_chunk
    ADD CONSTRAINT "205_205_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_206_chunk 206_206_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_206_chunk
    ADD CONSTRAINT "206_206_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_207_chunk 207_207_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_207_chunk
    ADD CONSTRAINT "207_207_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_208_chunk 208_208_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_208_chunk
    ADD CONSTRAINT "208_208_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_209_chunk 209_209_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_209_chunk
    ADD CONSTRAINT "209_209_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_20_chunk 20_20_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_20_chunk
    ADD CONSTRAINT "20_20_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_210_chunk 210_210_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_210_chunk
    ADD CONSTRAINT "210_210_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_211_chunk 211_211_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_211_chunk
    ADD CONSTRAINT "211_211_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_212_chunk 212_212_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_212_chunk
    ADD CONSTRAINT "212_212_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_213_chunk 213_213_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_213_chunk
    ADD CONSTRAINT "213_213_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_214_chunk 214_214_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_214_chunk
    ADD CONSTRAINT "214_214_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_215_chunk 215_215_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_215_chunk
    ADD CONSTRAINT "215_215_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_216_chunk 216_216_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_216_chunk
    ADD CONSTRAINT "216_216_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_217_chunk 217_217_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_217_chunk
    ADD CONSTRAINT "217_217_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_218_chunk 218_218_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_218_chunk
    ADD CONSTRAINT "218_218_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_219_chunk 219_219_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_219_chunk
    ADD CONSTRAINT "219_219_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_21_chunk 21_21_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_21_chunk
    ADD CONSTRAINT "21_21_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_220_chunk 220_220_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_220_chunk
    ADD CONSTRAINT "220_220_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_221_chunk 221_221_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_221_chunk
    ADD CONSTRAINT "221_221_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_222_chunk 222_222_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_222_chunk
    ADD CONSTRAINT "222_222_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_223_chunk 223_223_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_223_chunk
    ADD CONSTRAINT "223_223_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_224_chunk 224_224_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_224_chunk
    ADD CONSTRAINT "224_224_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_225_chunk 225_225_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_225_chunk
    ADD CONSTRAINT "225_225_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_226_chunk 226_226_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_226_chunk
    ADD CONSTRAINT "226_226_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_227_chunk 227_227_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_227_chunk
    ADD CONSTRAINT "227_227_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_228_chunk 228_228_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_228_chunk
    ADD CONSTRAINT "228_228_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_229_chunk 229_229_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_229_chunk
    ADD CONSTRAINT "229_229_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_22_chunk 22_22_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_22_chunk
    ADD CONSTRAINT "22_22_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_230_chunk 230_230_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_230_chunk
    ADD CONSTRAINT "230_230_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_231_chunk 231_231_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_231_chunk
    ADD CONSTRAINT "231_231_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_232_chunk 232_232_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_232_chunk
    ADD CONSTRAINT "232_232_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_233_chunk 233_233_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_233_chunk
    ADD CONSTRAINT "233_233_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_234_chunk 234_234_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_234_chunk
    ADD CONSTRAINT "234_234_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_235_chunk 235_235_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_235_chunk
    ADD CONSTRAINT "235_235_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_236_chunk 236_236_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_236_chunk
    ADD CONSTRAINT "236_236_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_237_chunk 237_237_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_237_chunk
    ADD CONSTRAINT "237_237_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_238_chunk 238_238_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_238_chunk
    ADD CONSTRAINT "238_238_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_239_chunk 239_239_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_239_chunk
    ADD CONSTRAINT "239_239_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_23_chunk 23_23_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_23_chunk
    ADD CONSTRAINT "23_23_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_240_chunk 240_240_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_240_chunk
    ADD CONSTRAINT "240_240_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_241_chunk 241_241_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_241_chunk
    ADD CONSTRAINT "241_241_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_242_chunk 242_242_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_242_chunk
    ADD CONSTRAINT "242_242_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_243_chunk 243_243_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_243_chunk
    ADD CONSTRAINT "243_243_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_24_chunk 24_24_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_24_chunk
    ADD CONSTRAINT "24_24_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_25_chunk 25_25_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_25_chunk
    ADD CONSTRAINT "25_25_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_26_chunk 26_26_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_26_chunk
    ADD CONSTRAINT "26_26_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_27_chunk 27_27_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_27_chunk
    ADD CONSTRAINT "27_27_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_28_chunk 28_28_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_28_chunk
    ADD CONSTRAINT "28_28_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_29_chunk 29_29_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_29_chunk
    ADD CONSTRAINT "29_29_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_2_chunk 2_2_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_2_chunk
    ADD CONSTRAINT "2_2_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_30_chunk 30_30_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_30_chunk
    ADD CONSTRAINT "30_30_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_31_chunk 31_31_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_31_chunk
    ADD CONSTRAINT "31_31_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_32_chunk 32_32_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_32_chunk
    ADD CONSTRAINT "32_32_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_33_chunk 33_33_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_33_chunk
    ADD CONSTRAINT "33_33_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_34_chunk 34_34_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_34_chunk
    ADD CONSTRAINT "34_34_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_35_chunk 35_35_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_35_chunk
    ADD CONSTRAINT "35_35_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_36_chunk 36_36_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_36_chunk
    ADD CONSTRAINT "36_36_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_37_chunk 37_37_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_37_chunk
    ADD CONSTRAINT "37_37_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_38_chunk 38_38_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_38_chunk
    ADD CONSTRAINT "38_38_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_39_chunk 39_39_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_39_chunk
    ADD CONSTRAINT "39_39_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_3_chunk 3_3_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_3_chunk
    ADD CONSTRAINT "3_3_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_40_chunk 40_40_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_40_chunk
    ADD CONSTRAINT "40_40_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_41_chunk 41_41_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_41_chunk
    ADD CONSTRAINT "41_41_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_42_chunk 42_42_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_42_chunk
    ADD CONSTRAINT "42_42_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_43_chunk 43_43_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_43_chunk
    ADD CONSTRAINT "43_43_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_44_chunk 44_44_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_44_chunk
    ADD CONSTRAINT "44_44_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_45_chunk 45_45_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_45_chunk
    ADD CONSTRAINT "45_45_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_46_chunk 46_46_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_46_chunk
    ADD CONSTRAINT "46_46_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_47_chunk 47_47_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_47_chunk
    ADD CONSTRAINT "47_47_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_48_chunk 48_48_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_48_chunk
    ADD CONSTRAINT "48_48_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_49_chunk 49_49_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_49_chunk
    ADD CONSTRAINT "49_49_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_4_chunk 4_4_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_4_chunk
    ADD CONSTRAINT "4_4_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_50_chunk 50_50_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_50_chunk
    ADD CONSTRAINT "50_50_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_51_chunk 51_51_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_51_chunk
    ADD CONSTRAINT "51_51_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_52_chunk 52_52_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_52_chunk
    ADD CONSTRAINT "52_52_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_53_chunk 53_53_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_53_chunk
    ADD CONSTRAINT "53_53_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_54_chunk 54_54_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_54_chunk
    ADD CONSTRAINT "54_54_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_55_chunk 55_55_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_55_chunk
    ADD CONSTRAINT "55_55_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_56_chunk 56_56_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_56_chunk
    ADD CONSTRAINT "56_56_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_57_chunk 57_57_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_57_chunk
    ADD CONSTRAINT "57_57_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_58_chunk 58_58_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_58_chunk
    ADD CONSTRAINT "58_58_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_59_chunk 59_59_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_59_chunk
    ADD CONSTRAINT "59_59_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_5_chunk 5_5_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_5_chunk
    ADD CONSTRAINT "5_5_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_60_chunk 60_60_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_60_chunk
    ADD CONSTRAINT "60_60_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_61_chunk 61_61_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_61_chunk
    ADD CONSTRAINT "61_61_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_62_chunk 62_62_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_62_chunk
    ADD CONSTRAINT "62_62_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_63_chunk 63_63_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_63_chunk
    ADD CONSTRAINT "63_63_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_64_chunk 64_64_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_64_chunk
    ADD CONSTRAINT "64_64_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_65_chunk 65_65_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_65_chunk
    ADD CONSTRAINT "65_65_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_66_chunk 66_66_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_66_chunk
    ADD CONSTRAINT "66_66_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_67_chunk 67_67_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_67_chunk
    ADD CONSTRAINT "67_67_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_68_chunk 68_68_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_68_chunk
    ADD CONSTRAINT "68_68_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_69_chunk 69_69_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_69_chunk
    ADD CONSTRAINT "69_69_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_6_chunk 6_6_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_6_chunk
    ADD CONSTRAINT "6_6_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_70_chunk 70_70_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_70_chunk
    ADD CONSTRAINT "70_70_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_71_chunk 71_71_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_71_chunk
    ADD CONSTRAINT "71_71_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_72_chunk 72_72_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_72_chunk
    ADD CONSTRAINT "72_72_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_73_chunk 73_73_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_73_chunk
    ADD CONSTRAINT "73_73_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_74_chunk 74_74_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_74_chunk
    ADD CONSTRAINT "74_74_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_75_chunk 75_75_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_75_chunk
    ADD CONSTRAINT "75_75_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_76_chunk 76_76_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_76_chunk
    ADD CONSTRAINT "76_76_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_77_chunk 77_77_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_77_chunk
    ADD CONSTRAINT "77_77_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_78_chunk 78_78_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_78_chunk
    ADD CONSTRAINT "78_78_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_79_chunk 79_79_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_79_chunk
    ADD CONSTRAINT "79_79_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_7_chunk 7_7_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_7_chunk
    ADD CONSTRAINT "7_7_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_80_chunk 80_80_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_80_chunk
    ADD CONSTRAINT "80_80_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_81_chunk 81_81_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_81_chunk
    ADD CONSTRAINT "81_81_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_82_chunk 82_82_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_82_chunk
    ADD CONSTRAINT "82_82_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_83_chunk 83_83_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_83_chunk
    ADD CONSTRAINT "83_83_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_84_chunk 84_84_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_84_chunk
    ADD CONSTRAINT "84_84_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_85_chunk 85_85_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_85_chunk
    ADD CONSTRAINT "85_85_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_86_chunk 86_86_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_86_chunk
    ADD CONSTRAINT "86_86_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_87_chunk 87_87_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_87_chunk
    ADD CONSTRAINT "87_87_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_88_chunk 88_88_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_88_chunk
    ADD CONSTRAINT "88_88_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_89_chunk 89_89_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_89_chunk
    ADD CONSTRAINT "89_89_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_8_chunk 8_8_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_8_chunk
    ADD CONSTRAINT "8_8_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_90_chunk 90_90_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_90_chunk
    ADD CONSTRAINT "90_90_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_91_chunk 91_91_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_91_chunk
    ADD CONSTRAINT "91_91_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_92_chunk 92_92_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_92_chunk
    ADD CONSTRAINT "92_92_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_93_chunk 93_93_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_93_chunk
    ADD CONSTRAINT "93_93_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_94_chunk 94_94_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_94_chunk
    ADD CONSTRAINT "94_94_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_95_chunk 95_95_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_95_chunk
    ADD CONSTRAINT "95_95_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_96_chunk 96_96_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_96_chunk
    ADD CONSTRAINT "96_96_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_97_chunk 97_97_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_97_chunk
    ADD CONSTRAINT "97_97_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_98_chunk 98_98_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_98_chunk
    ADD CONSTRAINT "98_98_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_99_chunk 99_99_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_99_chunk
    ADD CONSTRAINT "99_99_events_pkey" PRIMARY KEY (event_id, occurred_at);


--
-- Name: _hyper_1_9_chunk 9_9_events_pkey; Type: CONSTRAINT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_1_9_chunk
    ADD CONSTRAINT "9_9_events_pkey" PRIMARY KEY (event_id, occurred_at);


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
-- Name: _hyper_1_100_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_100_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_100_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_100_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_100_chunk_idx_events_command ON _timescaledb_internal._hyper_1_100_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_100_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_100_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_100_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_100_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_100_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_100_chunk USING gin (payload);


--
-- Name: _hyper_1_101_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_101_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_101_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_101_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_101_chunk_idx_events_command ON _timescaledb_internal._hyper_1_101_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_101_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_101_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_101_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_101_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_101_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_101_chunk USING gin (payload);


--
-- Name: _hyper_1_102_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_102_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_102_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_102_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_102_chunk_idx_events_command ON _timescaledb_internal._hyper_1_102_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_102_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_102_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_102_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_102_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_102_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_102_chunk USING gin (payload);


--
-- Name: _hyper_1_103_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_103_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_103_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_103_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_103_chunk_idx_events_command ON _timescaledb_internal._hyper_1_103_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_103_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_103_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_103_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_103_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_103_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_103_chunk USING gin (payload);


--
-- Name: _hyper_1_104_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_104_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_104_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_104_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_104_chunk_idx_events_command ON _timescaledb_internal._hyper_1_104_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_104_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_104_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_104_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_104_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_104_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_104_chunk USING gin (payload);


--
-- Name: _hyper_1_105_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_105_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_105_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_105_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_105_chunk_idx_events_command ON _timescaledb_internal._hyper_1_105_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_105_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_105_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_105_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_105_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_105_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_105_chunk USING gin (payload);


--
-- Name: _hyper_1_106_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_106_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_106_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_106_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_106_chunk_idx_events_command ON _timescaledb_internal._hyper_1_106_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_106_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_106_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_106_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_106_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_106_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_106_chunk USING gin (payload);


--
-- Name: _hyper_1_107_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_107_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_107_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_107_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_107_chunk_idx_events_command ON _timescaledb_internal._hyper_1_107_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_107_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_107_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_107_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_107_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_107_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_107_chunk USING gin (payload);


--
-- Name: _hyper_1_108_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_108_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_108_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_108_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_108_chunk_idx_events_command ON _timescaledb_internal._hyper_1_108_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_108_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_108_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_108_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_108_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_108_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_108_chunk USING gin (payload);


--
-- Name: _hyper_1_109_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_109_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_109_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_109_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_109_chunk_idx_events_command ON _timescaledb_internal._hyper_1_109_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_109_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_109_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_109_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_109_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_109_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_109_chunk USING gin (payload);


--
-- Name: _hyper_1_10_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_10_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_10_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_10_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_10_chunk_idx_events_command ON _timescaledb_internal._hyper_1_10_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_10_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_10_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_10_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_10_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_10_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_10_chunk USING gin (payload);


--
-- Name: _hyper_1_110_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_110_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_110_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_110_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_110_chunk_idx_events_command ON _timescaledb_internal._hyper_1_110_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_110_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_110_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_110_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_110_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_110_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_110_chunk USING gin (payload);


--
-- Name: _hyper_1_111_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_111_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_111_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_111_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_111_chunk_idx_events_command ON _timescaledb_internal._hyper_1_111_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_111_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_111_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_111_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_111_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_111_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_111_chunk USING gin (payload);


--
-- Name: _hyper_1_112_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_112_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_112_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_112_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_112_chunk_idx_events_command ON _timescaledb_internal._hyper_1_112_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_112_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_112_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_112_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_112_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_112_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_112_chunk USING gin (payload);


--
-- Name: _hyper_1_113_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_113_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_113_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_113_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_113_chunk_idx_events_command ON _timescaledb_internal._hyper_1_113_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_113_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_113_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_113_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_113_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_113_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_113_chunk USING gin (payload);


--
-- Name: _hyper_1_114_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_114_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_114_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_114_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_114_chunk_idx_events_command ON _timescaledb_internal._hyper_1_114_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_114_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_114_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_114_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_114_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_114_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_114_chunk USING gin (payload);


--
-- Name: _hyper_1_115_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_115_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_115_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_115_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_115_chunk_idx_events_command ON _timescaledb_internal._hyper_1_115_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_115_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_115_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_115_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_115_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_115_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_115_chunk USING gin (payload);


--
-- Name: _hyper_1_116_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_116_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_116_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_116_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_116_chunk_idx_events_command ON _timescaledb_internal._hyper_1_116_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_116_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_116_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_116_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_116_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_116_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_116_chunk USING gin (payload);


--
-- Name: _hyper_1_117_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_117_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_117_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_117_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_117_chunk_idx_events_command ON _timescaledb_internal._hyper_1_117_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_117_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_117_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_117_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_117_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_117_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_117_chunk USING gin (payload);


--
-- Name: _hyper_1_118_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_118_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_118_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_118_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_118_chunk_idx_events_command ON _timescaledb_internal._hyper_1_118_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_118_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_118_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_118_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_118_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_118_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_118_chunk USING gin (payload);


--
-- Name: _hyper_1_119_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_119_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_119_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_119_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_119_chunk_idx_events_command ON _timescaledb_internal._hyper_1_119_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_119_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_119_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_119_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_119_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_119_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_119_chunk USING gin (payload);


--
-- Name: _hyper_1_11_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_11_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_11_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_11_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_11_chunk_idx_events_command ON _timescaledb_internal._hyper_1_11_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_11_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_11_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_11_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_11_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_11_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_11_chunk USING gin (payload);


--
-- Name: _hyper_1_120_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_120_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_120_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_120_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_120_chunk_idx_events_command ON _timescaledb_internal._hyper_1_120_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_120_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_120_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_120_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_120_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_120_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_120_chunk USING gin (payload);


--
-- Name: _hyper_1_121_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_121_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_121_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_121_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_121_chunk_idx_events_command ON _timescaledb_internal._hyper_1_121_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_121_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_121_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_121_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_121_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_121_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_121_chunk USING gin (payload);


--
-- Name: _hyper_1_122_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_122_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_122_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_122_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_122_chunk_idx_events_command ON _timescaledb_internal._hyper_1_122_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_122_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_122_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_122_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_122_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_122_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_122_chunk USING gin (payload);


--
-- Name: _hyper_1_123_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_123_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_123_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_123_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_123_chunk_idx_events_command ON _timescaledb_internal._hyper_1_123_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_123_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_123_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_123_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_123_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_123_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_123_chunk USING gin (payload);


--
-- Name: _hyper_1_124_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_124_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_124_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_124_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_124_chunk_idx_events_command ON _timescaledb_internal._hyper_1_124_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_124_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_124_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_124_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_124_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_124_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_124_chunk USING gin (payload);


--
-- Name: _hyper_1_125_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_125_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_125_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_125_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_125_chunk_idx_events_command ON _timescaledb_internal._hyper_1_125_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_125_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_125_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_125_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_125_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_125_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_125_chunk USING gin (payload);


--
-- Name: _hyper_1_126_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_126_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_126_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_126_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_126_chunk_idx_events_command ON _timescaledb_internal._hyper_1_126_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_126_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_126_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_126_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_126_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_126_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_126_chunk USING gin (payload);


--
-- Name: _hyper_1_127_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_127_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_127_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_127_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_127_chunk_idx_events_command ON _timescaledb_internal._hyper_1_127_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_127_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_127_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_127_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_127_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_127_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_127_chunk USING gin (payload);


--
-- Name: _hyper_1_128_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_128_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_128_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_128_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_128_chunk_idx_events_command ON _timescaledb_internal._hyper_1_128_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_128_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_128_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_128_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_128_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_128_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_128_chunk USING gin (payload);


--
-- Name: _hyper_1_129_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_129_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_129_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_129_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_129_chunk_idx_events_command ON _timescaledb_internal._hyper_1_129_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_129_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_129_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_129_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_129_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_129_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_129_chunk USING gin (payload);


--
-- Name: _hyper_1_12_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_12_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_12_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_12_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_12_chunk_idx_events_command ON _timescaledb_internal._hyper_1_12_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_12_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_12_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_12_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_12_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_12_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_12_chunk USING gin (payload);


--
-- Name: _hyper_1_130_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_130_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_130_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_130_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_130_chunk_idx_events_command ON _timescaledb_internal._hyper_1_130_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_130_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_130_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_130_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_130_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_130_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_130_chunk USING gin (payload);


--
-- Name: _hyper_1_131_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_131_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_131_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_131_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_131_chunk_idx_events_command ON _timescaledb_internal._hyper_1_131_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_131_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_131_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_131_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_131_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_131_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_131_chunk USING gin (payload);


--
-- Name: _hyper_1_132_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_132_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_132_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_132_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_132_chunk_idx_events_command ON _timescaledb_internal._hyper_1_132_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_132_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_132_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_132_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_132_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_132_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_132_chunk USING gin (payload);


--
-- Name: _hyper_1_133_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_133_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_133_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_133_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_133_chunk_idx_events_command ON _timescaledb_internal._hyper_1_133_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_133_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_133_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_133_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_133_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_133_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_133_chunk USING gin (payload);


--
-- Name: _hyper_1_134_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_134_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_134_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_134_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_134_chunk_idx_events_command ON _timescaledb_internal._hyper_1_134_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_134_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_134_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_134_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_134_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_134_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_134_chunk USING gin (payload);


--
-- Name: _hyper_1_135_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_135_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_135_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_135_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_135_chunk_idx_events_command ON _timescaledb_internal._hyper_1_135_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_135_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_135_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_135_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_135_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_135_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_135_chunk USING gin (payload);


--
-- Name: _hyper_1_136_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_136_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_136_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_136_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_136_chunk_idx_events_command ON _timescaledb_internal._hyper_1_136_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_136_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_136_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_136_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_136_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_136_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_136_chunk USING gin (payload);


--
-- Name: _hyper_1_137_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_137_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_137_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_137_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_137_chunk_idx_events_command ON _timescaledb_internal._hyper_1_137_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_137_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_137_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_137_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_137_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_137_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_137_chunk USING gin (payload);


--
-- Name: _hyper_1_138_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_138_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_138_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_138_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_138_chunk_idx_events_command ON _timescaledb_internal._hyper_1_138_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_138_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_138_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_138_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_138_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_138_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_138_chunk USING gin (payload);


--
-- Name: _hyper_1_139_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_139_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_139_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_139_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_139_chunk_idx_events_command ON _timescaledb_internal._hyper_1_139_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_139_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_139_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_139_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_139_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_139_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_139_chunk USING gin (payload);


--
-- Name: _hyper_1_13_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_13_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_13_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_13_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_13_chunk_idx_events_command ON _timescaledb_internal._hyper_1_13_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_13_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_13_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_13_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_13_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_13_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_13_chunk USING gin (payload);


--
-- Name: _hyper_1_140_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_140_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_140_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_140_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_140_chunk_idx_events_command ON _timescaledb_internal._hyper_1_140_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_140_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_140_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_140_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_140_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_140_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_140_chunk USING gin (payload);


--
-- Name: _hyper_1_141_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_141_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_141_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_141_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_141_chunk_idx_events_command ON _timescaledb_internal._hyper_1_141_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_141_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_141_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_141_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_141_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_141_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_141_chunk USING gin (payload);


--
-- Name: _hyper_1_142_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_142_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_142_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_142_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_142_chunk_idx_events_command ON _timescaledb_internal._hyper_1_142_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_142_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_142_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_142_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_142_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_142_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_142_chunk USING gin (payload);


--
-- Name: _hyper_1_143_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_143_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_143_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_143_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_143_chunk_idx_events_command ON _timescaledb_internal._hyper_1_143_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_143_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_143_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_143_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_143_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_143_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_143_chunk USING gin (payload);


--
-- Name: _hyper_1_144_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_144_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_144_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_144_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_144_chunk_idx_events_command ON _timescaledb_internal._hyper_1_144_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_144_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_144_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_144_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_144_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_144_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_144_chunk USING gin (payload);


--
-- Name: _hyper_1_145_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_145_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_145_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_145_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_145_chunk_idx_events_command ON _timescaledb_internal._hyper_1_145_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_145_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_145_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_145_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_145_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_145_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_145_chunk USING gin (payload);


--
-- Name: _hyper_1_146_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_146_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_146_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_146_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_146_chunk_idx_events_command ON _timescaledb_internal._hyper_1_146_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_146_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_146_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_146_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_146_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_146_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_146_chunk USING gin (payload);


--
-- Name: _hyper_1_147_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_147_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_147_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_147_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_147_chunk_idx_events_command ON _timescaledb_internal._hyper_1_147_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_147_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_147_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_147_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_147_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_147_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_147_chunk USING gin (payload);


--
-- Name: _hyper_1_148_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_148_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_148_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_148_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_148_chunk_idx_events_command ON _timescaledb_internal._hyper_1_148_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_148_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_148_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_148_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_148_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_148_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_148_chunk USING gin (payload);


--
-- Name: _hyper_1_149_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_149_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_149_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_149_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_149_chunk_idx_events_command ON _timescaledb_internal._hyper_1_149_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_149_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_149_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_149_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_149_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_149_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_149_chunk USING gin (payload);


--
-- Name: _hyper_1_14_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_14_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_14_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_14_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_14_chunk_idx_events_command ON _timescaledb_internal._hyper_1_14_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_14_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_14_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_14_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_14_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_14_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_14_chunk USING gin (payload);


--
-- Name: _hyper_1_150_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_150_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_150_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_150_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_150_chunk_idx_events_command ON _timescaledb_internal._hyper_1_150_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_150_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_150_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_150_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_150_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_150_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_150_chunk USING gin (payload);


--
-- Name: _hyper_1_151_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_151_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_151_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_151_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_151_chunk_idx_events_command ON _timescaledb_internal._hyper_1_151_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_151_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_151_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_151_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_151_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_151_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_151_chunk USING gin (payload);


--
-- Name: _hyper_1_152_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_152_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_152_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_152_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_152_chunk_idx_events_command ON _timescaledb_internal._hyper_1_152_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_152_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_152_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_152_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_152_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_152_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_152_chunk USING gin (payload);


--
-- Name: _hyper_1_153_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_153_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_153_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_153_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_153_chunk_idx_events_command ON _timescaledb_internal._hyper_1_153_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_153_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_153_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_153_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_153_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_153_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_153_chunk USING gin (payload);


--
-- Name: _hyper_1_154_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_154_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_154_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_154_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_154_chunk_idx_events_command ON _timescaledb_internal._hyper_1_154_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_154_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_154_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_154_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_154_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_154_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_154_chunk USING gin (payload);


--
-- Name: _hyper_1_155_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_155_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_155_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_155_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_155_chunk_idx_events_command ON _timescaledb_internal._hyper_1_155_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_155_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_155_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_155_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_155_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_155_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_155_chunk USING gin (payload);


--
-- Name: _hyper_1_156_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_156_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_156_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_156_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_156_chunk_idx_events_command ON _timescaledb_internal._hyper_1_156_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_156_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_156_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_156_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_156_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_156_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_156_chunk USING gin (payload);


--
-- Name: _hyper_1_157_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_157_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_157_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_157_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_157_chunk_idx_events_command ON _timescaledb_internal._hyper_1_157_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_157_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_157_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_157_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_157_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_157_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_157_chunk USING gin (payload);


--
-- Name: _hyper_1_158_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_158_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_158_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_158_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_158_chunk_idx_events_command ON _timescaledb_internal._hyper_1_158_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_158_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_158_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_158_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_158_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_158_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_158_chunk USING gin (payload);


--
-- Name: _hyper_1_159_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_159_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_159_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_159_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_159_chunk_idx_events_command ON _timescaledb_internal._hyper_1_159_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_159_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_159_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_159_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_159_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_159_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_159_chunk USING gin (payload);


--
-- Name: _hyper_1_15_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_15_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_15_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_15_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_15_chunk_idx_events_command ON _timescaledb_internal._hyper_1_15_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_15_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_15_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_15_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_15_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_15_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_15_chunk USING gin (payload);


--
-- Name: _hyper_1_160_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_160_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_160_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_160_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_160_chunk_idx_events_command ON _timescaledb_internal._hyper_1_160_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_160_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_160_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_160_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_160_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_160_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_160_chunk USING gin (payload);


--
-- Name: _hyper_1_161_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_161_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_161_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_161_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_161_chunk_idx_events_command ON _timescaledb_internal._hyper_1_161_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_161_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_161_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_161_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_161_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_161_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_161_chunk USING gin (payload);


--
-- Name: _hyper_1_162_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_162_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_162_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_162_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_162_chunk_idx_events_command ON _timescaledb_internal._hyper_1_162_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_162_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_162_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_162_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_162_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_162_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_162_chunk USING gin (payload);


--
-- Name: _hyper_1_163_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_163_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_163_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_163_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_163_chunk_idx_events_command ON _timescaledb_internal._hyper_1_163_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_163_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_163_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_163_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_163_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_163_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_163_chunk USING gin (payload);


--
-- Name: _hyper_1_164_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_164_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_164_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_164_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_164_chunk_idx_events_command ON _timescaledb_internal._hyper_1_164_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_164_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_164_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_164_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_164_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_164_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_164_chunk USING gin (payload);


--
-- Name: _hyper_1_165_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_165_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_165_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_165_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_165_chunk_idx_events_command ON _timescaledb_internal._hyper_1_165_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_165_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_165_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_165_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_165_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_165_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_165_chunk USING gin (payload);


--
-- Name: _hyper_1_166_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_166_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_166_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_166_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_166_chunk_idx_events_command ON _timescaledb_internal._hyper_1_166_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_166_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_166_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_166_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_166_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_166_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_166_chunk USING gin (payload);


--
-- Name: _hyper_1_167_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_167_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_167_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_167_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_167_chunk_idx_events_command ON _timescaledb_internal._hyper_1_167_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_167_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_167_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_167_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_167_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_167_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_167_chunk USING gin (payload);


--
-- Name: _hyper_1_168_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_168_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_168_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_168_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_168_chunk_idx_events_command ON _timescaledb_internal._hyper_1_168_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_168_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_168_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_168_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_168_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_168_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_168_chunk USING gin (payload);


--
-- Name: _hyper_1_169_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_169_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_169_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_169_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_169_chunk_idx_events_command ON _timescaledb_internal._hyper_1_169_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_169_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_169_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_169_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_169_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_169_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_169_chunk USING gin (payload);


--
-- Name: _hyper_1_16_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_16_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_16_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_16_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_16_chunk_idx_events_command ON _timescaledb_internal._hyper_1_16_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_16_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_16_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_16_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_16_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_16_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_16_chunk USING gin (payload);


--
-- Name: _hyper_1_170_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_170_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_170_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_170_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_170_chunk_idx_events_command ON _timescaledb_internal._hyper_1_170_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_170_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_170_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_170_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_170_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_170_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_170_chunk USING gin (payload);


--
-- Name: _hyper_1_171_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_171_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_171_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_171_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_171_chunk_idx_events_command ON _timescaledb_internal._hyper_1_171_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_171_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_171_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_171_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_171_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_171_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_171_chunk USING gin (payload);


--
-- Name: _hyper_1_172_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_172_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_172_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_172_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_172_chunk_idx_events_command ON _timescaledb_internal._hyper_1_172_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_172_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_172_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_172_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_172_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_172_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_172_chunk USING gin (payload);


--
-- Name: _hyper_1_173_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_173_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_173_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_173_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_173_chunk_idx_events_command ON _timescaledb_internal._hyper_1_173_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_173_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_173_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_173_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_173_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_173_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_173_chunk USING gin (payload);


--
-- Name: _hyper_1_174_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_174_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_174_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_174_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_174_chunk_idx_events_command ON _timescaledb_internal._hyper_1_174_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_174_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_174_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_174_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_174_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_174_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_174_chunk USING gin (payload);


--
-- Name: _hyper_1_175_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_175_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_175_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_175_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_175_chunk_idx_events_command ON _timescaledb_internal._hyper_1_175_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_175_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_175_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_175_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_175_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_175_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_175_chunk USING gin (payload);


--
-- Name: _hyper_1_176_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_176_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_176_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_176_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_176_chunk_idx_events_command ON _timescaledb_internal._hyper_1_176_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_176_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_176_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_176_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_176_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_176_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_176_chunk USING gin (payload);


--
-- Name: _hyper_1_177_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_177_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_177_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_177_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_177_chunk_idx_events_command ON _timescaledb_internal._hyper_1_177_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_177_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_177_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_177_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_177_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_177_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_177_chunk USING gin (payload);


--
-- Name: _hyper_1_178_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_178_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_178_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_178_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_178_chunk_idx_events_command ON _timescaledb_internal._hyper_1_178_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_178_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_178_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_178_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_178_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_178_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_178_chunk USING gin (payload);


--
-- Name: _hyper_1_179_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_179_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_179_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_179_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_179_chunk_idx_events_command ON _timescaledb_internal._hyper_1_179_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_179_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_179_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_179_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_179_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_179_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_179_chunk USING gin (payload);


--
-- Name: _hyper_1_17_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_17_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_17_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_17_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_17_chunk_idx_events_command ON _timescaledb_internal._hyper_1_17_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_17_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_17_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_17_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_17_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_17_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_17_chunk USING gin (payload);


--
-- Name: _hyper_1_180_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_180_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_180_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_180_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_180_chunk_idx_events_command ON _timescaledb_internal._hyper_1_180_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_180_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_180_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_180_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_180_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_180_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_180_chunk USING gin (payload);


--
-- Name: _hyper_1_181_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_181_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_181_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_181_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_181_chunk_idx_events_command ON _timescaledb_internal._hyper_1_181_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_181_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_181_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_181_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_181_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_181_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_181_chunk USING gin (payload);


--
-- Name: _hyper_1_182_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_182_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_182_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_182_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_182_chunk_idx_events_command ON _timescaledb_internal._hyper_1_182_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_182_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_182_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_182_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_182_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_182_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_182_chunk USING gin (payload);


--
-- Name: _hyper_1_183_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_183_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_183_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_183_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_183_chunk_idx_events_command ON _timescaledb_internal._hyper_1_183_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_183_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_183_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_183_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_183_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_183_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_183_chunk USING gin (payload);


--
-- Name: _hyper_1_184_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_184_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_184_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_184_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_184_chunk_idx_events_command ON _timescaledb_internal._hyper_1_184_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_184_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_184_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_184_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_184_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_184_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_184_chunk USING gin (payload);


--
-- Name: _hyper_1_185_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_185_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_185_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_185_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_185_chunk_idx_events_command ON _timescaledb_internal._hyper_1_185_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_185_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_185_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_185_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_185_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_185_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_185_chunk USING gin (payload);


--
-- Name: _hyper_1_186_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_186_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_186_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_186_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_186_chunk_idx_events_command ON _timescaledb_internal._hyper_1_186_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_186_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_186_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_186_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_186_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_186_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_186_chunk USING gin (payload);


--
-- Name: _hyper_1_187_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_187_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_187_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_187_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_187_chunk_idx_events_command ON _timescaledb_internal._hyper_1_187_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_187_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_187_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_187_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_187_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_187_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_187_chunk USING gin (payload);


--
-- Name: _hyper_1_188_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_188_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_188_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_188_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_188_chunk_idx_events_command ON _timescaledb_internal._hyper_1_188_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_188_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_188_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_188_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_188_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_188_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_188_chunk USING gin (payload);


--
-- Name: _hyper_1_189_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_189_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_189_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_189_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_189_chunk_idx_events_command ON _timescaledb_internal._hyper_1_189_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_189_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_189_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_189_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_189_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_189_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_189_chunk USING gin (payload);


--
-- Name: _hyper_1_18_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_18_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_18_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_18_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_18_chunk_idx_events_command ON _timescaledb_internal._hyper_1_18_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_18_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_18_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_18_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_18_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_18_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_18_chunk USING gin (payload);


--
-- Name: _hyper_1_190_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_190_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_190_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_190_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_190_chunk_idx_events_command ON _timescaledb_internal._hyper_1_190_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_190_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_190_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_190_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_190_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_190_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_190_chunk USING gin (payload);


--
-- Name: _hyper_1_191_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_191_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_191_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_191_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_191_chunk_idx_events_command ON _timescaledb_internal._hyper_1_191_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_191_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_191_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_191_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_191_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_191_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_191_chunk USING gin (payload);


--
-- Name: _hyper_1_192_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_192_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_192_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_192_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_192_chunk_idx_events_command ON _timescaledb_internal._hyper_1_192_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_192_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_192_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_192_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_192_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_192_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_192_chunk USING gin (payload);


--
-- Name: _hyper_1_193_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_193_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_193_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_193_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_193_chunk_idx_events_command ON _timescaledb_internal._hyper_1_193_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_193_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_193_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_193_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_193_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_193_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_193_chunk USING gin (payload);


--
-- Name: _hyper_1_194_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_194_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_194_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_194_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_194_chunk_idx_events_command ON _timescaledb_internal._hyper_1_194_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_194_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_194_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_194_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_194_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_194_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_194_chunk USING gin (payload);


--
-- Name: _hyper_1_195_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_195_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_195_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_195_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_195_chunk_idx_events_command ON _timescaledb_internal._hyper_1_195_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_195_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_195_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_195_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_195_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_195_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_195_chunk USING gin (payload);


--
-- Name: _hyper_1_196_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_196_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_196_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_196_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_196_chunk_idx_events_command ON _timescaledb_internal._hyper_1_196_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_196_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_196_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_196_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_196_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_196_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_196_chunk USING gin (payload);


--
-- Name: _hyper_1_197_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_197_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_197_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_197_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_197_chunk_idx_events_command ON _timescaledb_internal._hyper_1_197_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_197_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_197_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_197_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_197_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_197_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_197_chunk USING gin (payload);


--
-- Name: _hyper_1_198_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_198_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_198_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_198_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_198_chunk_idx_events_command ON _timescaledb_internal._hyper_1_198_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_198_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_198_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_198_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_198_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_198_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_198_chunk USING gin (payload);


--
-- Name: _hyper_1_199_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_199_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_199_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_199_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_199_chunk_idx_events_command ON _timescaledb_internal._hyper_1_199_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_199_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_199_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_199_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_199_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_199_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_199_chunk USING gin (payload);


--
-- Name: _hyper_1_19_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_19_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_19_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_19_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_19_chunk_idx_events_command ON _timescaledb_internal._hyper_1_19_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_19_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_19_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_19_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_19_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_19_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_19_chunk USING gin (payload);


--
-- Name: _hyper_1_1_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_1_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_1_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_1_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_1_chunk_idx_events_command ON _timescaledb_internal._hyper_1_1_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_1_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_1_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_1_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_1_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_1_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_1_chunk USING gin (payload);


--
-- Name: _hyper_1_200_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_200_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_200_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_200_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_200_chunk_idx_events_command ON _timescaledb_internal._hyper_1_200_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_200_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_200_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_200_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_200_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_200_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_200_chunk USING gin (payload);


--
-- Name: _hyper_1_201_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_201_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_201_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_201_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_201_chunk_idx_events_command ON _timescaledb_internal._hyper_1_201_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_201_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_201_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_201_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_201_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_201_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_201_chunk USING gin (payload);


--
-- Name: _hyper_1_202_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_202_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_202_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_202_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_202_chunk_idx_events_command ON _timescaledb_internal._hyper_1_202_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_202_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_202_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_202_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_202_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_202_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_202_chunk USING gin (payload);


--
-- Name: _hyper_1_203_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_203_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_203_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_203_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_203_chunk_idx_events_command ON _timescaledb_internal._hyper_1_203_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_203_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_203_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_203_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_203_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_203_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_203_chunk USING gin (payload);


--
-- Name: _hyper_1_204_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_204_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_204_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_204_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_204_chunk_idx_events_command ON _timescaledb_internal._hyper_1_204_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_204_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_204_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_204_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_204_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_204_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_204_chunk USING gin (payload);


--
-- Name: _hyper_1_205_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_205_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_205_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_205_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_205_chunk_idx_events_command ON _timescaledb_internal._hyper_1_205_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_205_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_205_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_205_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_205_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_205_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_205_chunk USING gin (payload);


--
-- Name: _hyper_1_206_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_206_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_206_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_206_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_206_chunk_idx_events_command ON _timescaledb_internal._hyper_1_206_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_206_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_206_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_206_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_206_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_206_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_206_chunk USING gin (payload);


--
-- Name: _hyper_1_207_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_207_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_207_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_207_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_207_chunk_idx_events_command ON _timescaledb_internal._hyper_1_207_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_207_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_207_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_207_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_207_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_207_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_207_chunk USING gin (payload);


--
-- Name: _hyper_1_208_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_208_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_208_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_208_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_208_chunk_idx_events_command ON _timescaledb_internal._hyper_1_208_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_208_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_208_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_208_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_208_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_208_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_208_chunk USING gin (payload);


--
-- Name: _hyper_1_209_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_209_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_209_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_209_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_209_chunk_idx_events_command ON _timescaledb_internal._hyper_1_209_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_209_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_209_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_209_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_209_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_209_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_209_chunk USING gin (payload);


--
-- Name: _hyper_1_20_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_20_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_20_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_20_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_20_chunk_idx_events_command ON _timescaledb_internal._hyper_1_20_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_20_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_20_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_20_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_20_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_20_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_20_chunk USING gin (payload);


--
-- Name: _hyper_1_210_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_210_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_210_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_210_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_210_chunk_idx_events_command ON _timescaledb_internal._hyper_1_210_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_210_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_210_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_210_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_210_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_210_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_210_chunk USING gin (payload);


--
-- Name: _hyper_1_211_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_211_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_211_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_211_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_211_chunk_idx_events_command ON _timescaledb_internal._hyper_1_211_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_211_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_211_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_211_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_211_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_211_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_211_chunk USING gin (payload);


--
-- Name: _hyper_1_212_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_212_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_212_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_212_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_212_chunk_idx_events_command ON _timescaledb_internal._hyper_1_212_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_212_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_212_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_212_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_212_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_212_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_212_chunk USING gin (payload);


--
-- Name: _hyper_1_213_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_213_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_213_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_213_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_213_chunk_idx_events_command ON _timescaledb_internal._hyper_1_213_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_213_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_213_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_213_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_213_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_213_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_213_chunk USING gin (payload);


--
-- Name: _hyper_1_214_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_214_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_214_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_214_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_214_chunk_idx_events_command ON _timescaledb_internal._hyper_1_214_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_214_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_214_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_214_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_214_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_214_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_214_chunk USING gin (payload);


--
-- Name: _hyper_1_215_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_215_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_215_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_215_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_215_chunk_idx_events_command ON _timescaledb_internal._hyper_1_215_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_215_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_215_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_215_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_215_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_215_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_215_chunk USING gin (payload);


--
-- Name: _hyper_1_216_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_216_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_216_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_216_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_216_chunk_idx_events_command ON _timescaledb_internal._hyper_1_216_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_216_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_216_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_216_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_216_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_216_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_216_chunk USING gin (payload);


--
-- Name: _hyper_1_217_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_217_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_217_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_217_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_217_chunk_idx_events_command ON _timescaledb_internal._hyper_1_217_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_217_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_217_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_217_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_217_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_217_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_217_chunk USING gin (payload);


--
-- Name: _hyper_1_218_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_218_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_218_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_218_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_218_chunk_idx_events_command ON _timescaledb_internal._hyper_1_218_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_218_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_218_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_218_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_218_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_218_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_218_chunk USING gin (payload);


--
-- Name: _hyper_1_219_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_219_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_219_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_219_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_219_chunk_idx_events_command ON _timescaledb_internal._hyper_1_219_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_219_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_219_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_219_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_219_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_219_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_219_chunk USING gin (payload);


--
-- Name: _hyper_1_21_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_21_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_21_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_21_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_21_chunk_idx_events_command ON _timescaledb_internal._hyper_1_21_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_21_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_21_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_21_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_21_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_21_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_21_chunk USING gin (payload);


--
-- Name: _hyper_1_220_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_220_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_220_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_220_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_220_chunk_idx_events_command ON _timescaledb_internal._hyper_1_220_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_220_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_220_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_220_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_220_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_220_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_220_chunk USING gin (payload);


--
-- Name: _hyper_1_221_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_221_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_221_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_221_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_221_chunk_idx_events_command ON _timescaledb_internal._hyper_1_221_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_221_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_221_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_221_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_221_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_221_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_221_chunk USING gin (payload);


--
-- Name: _hyper_1_222_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_222_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_222_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_222_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_222_chunk_idx_events_command ON _timescaledb_internal._hyper_1_222_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_222_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_222_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_222_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_222_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_222_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_222_chunk USING gin (payload);


--
-- Name: _hyper_1_223_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_223_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_223_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_223_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_223_chunk_idx_events_command ON _timescaledb_internal._hyper_1_223_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_223_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_223_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_223_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_223_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_223_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_223_chunk USING gin (payload);


--
-- Name: _hyper_1_224_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_224_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_224_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_224_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_224_chunk_idx_events_command ON _timescaledb_internal._hyper_1_224_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_224_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_224_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_224_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_224_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_224_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_224_chunk USING gin (payload);


--
-- Name: _hyper_1_225_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_225_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_225_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_225_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_225_chunk_idx_events_command ON _timescaledb_internal._hyper_1_225_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_225_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_225_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_225_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_225_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_225_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_225_chunk USING gin (payload);


--
-- Name: _hyper_1_226_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_226_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_226_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_226_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_226_chunk_idx_events_command ON _timescaledb_internal._hyper_1_226_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_226_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_226_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_226_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_226_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_226_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_226_chunk USING gin (payload);


--
-- Name: _hyper_1_227_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_227_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_227_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_227_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_227_chunk_idx_events_command ON _timescaledb_internal._hyper_1_227_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_227_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_227_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_227_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_227_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_227_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_227_chunk USING gin (payload);


--
-- Name: _hyper_1_228_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_228_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_228_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_228_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_228_chunk_idx_events_command ON _timescaledb_internal._hyper_1_228_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_228_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_228_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_228_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_228_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_228_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_228_chunk USING gin (payload);


--
-- Name: _hyper_1_229_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_229_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_229_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_229_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_229_chunk_idx_events_command ON _timescaledb_internal._hyper_1_229_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_229_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_229_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_229_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_229_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_229_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_229_chunk USING gin (payload);


--
-- Name: _hyper_1_22_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_22_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_22_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_22_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_22_chunk_idx_events_command ON _timescaledb_internal._hyper_1_22_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_22_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_22_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_22_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_22_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_22_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_22_chunk USING gin (payload);


--
-- Name: _hyper_1_230_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_230_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_230_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_230_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_230_chunk_idx_events_command ON _timescaledb_internal._hyper_1_230_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_230_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_230_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_230_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_230_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_230_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_230_chunk USING gin (payload);


--
-- Name: _hyper_1_231_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_231_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_231_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_231_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_231_chunk_idx_events_command ON _timescaledb_internal._hyper_1_231_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_231_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_231_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_231_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_231_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_231_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_231_chunk USING gin (payload);


--
-- Name: _hyper_1_232_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_232_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_232_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_232_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_232_chunk_idx_events_command ON _timescaledb_internal._hyper_1_232_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_232_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_232_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_232_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_232_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_232_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_232_chunk USING gin (payload);


--
-- Name: _hyper_1_233_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_233_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_233_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_233_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_233_chunk_idx_events_command ON _timescaledb_internal._hyper_1_233_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_233_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_233_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_233_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_233_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_233_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_233_chunk USING gin (payload);


--
-- Name: _hyper_1_234_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_234_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_234_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_234_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_234_chunk_idx_events_command ON _timescaledb_internal._hyper_1_234_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_234_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_234_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_234_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_234_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_234_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_234_chunk USING gin (payload);


--
-- Name: _hyper_1_235_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_235_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_235_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_235_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_235_chunk_idx_events_command ON _timescaledb_internal._hyper_1_235_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_235_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_235_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_235_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_235_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_235_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_235_chunk USING gin (payload);


--
-- Name: _hyper_1_236_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_236_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_236_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_236_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_236_chunk_idx_events_command ON _timescaledb_internal._hyper_1_236_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_236_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_236_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_236_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_236_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_236_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_236_chunk USING gin (payload);


--
-- Name: _hyper_1_237_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_237_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_237_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_237_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_237_chunk_idx_events_command ON _timescaledb_internal._hyper_1_237_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_237_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_237_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_237_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_237_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_237_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_237_chunk USING gin (payload);


--
-- Name: _hyper_1_238_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_238_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_238_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_238_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_238_chunk_idx_events_command ON _timescaledb_internal._hyper_1_238_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_238_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_238_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_238_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_238_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_238_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_238_chunk USING gin (payload);


--
-- Name: _hyper_1_239_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_239_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_239_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_239_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_239_chunk_idx_events_command ON _timescaledb_internal._hyper_1_239_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_239_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_239_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_239_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_239_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_239_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_239_chunk USING gin (payload);


--
-- Name: _hyper_1_23_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_23_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_23_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_23_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_23_chunk_idx_events_command ON _timescaledb_internal._hyper_1_23_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_23_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_23_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_23_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_23_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_23_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_23_chunk USING gin (payload);


--
-- Name: _hyper_1_240_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_240_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_240_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_240_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_240_chunk_idx_events_command ON _timescaledb_internal._hyper_1_240_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_240_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_240_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_240_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_240_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_240_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_240_chunk USING gin (payload);


--
-- Name: _hyper_1_241_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_241_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_241_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_241_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_241_chunk_idx_events_command ON _timescaledb_internal._hyper_1_241_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_241_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_241_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_241_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_241_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_241_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_241_chunk USING gin (payload);


--
-- Name: _hyper_1_242_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_242_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_242_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_242_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_242_chunk_idx_events_command ON _timescaledb_internal._hyper_1_242_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_242_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_242_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_242_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_242_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_242_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_242_chunk USING gin (payload);


--
-- Name: _hyper_1_243_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_243_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_243_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_243_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_243_chunk_idx_events_command ON _timescaledb_internal._hyper_1_243_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_243_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_243_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_243_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_243_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_243_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_243_chunk USING gin (payload);


--
-- Name: _hyper_1_24_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_24_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_24_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_24_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_24_chunk_idx_events_command ON _timescaledb_internal._hyper_1_24_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_24_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_24_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_24_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_24_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_24_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_24_chunk USING gin (payload);


--
-- Name: _hyper_1_25_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_25_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_25_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_25_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_25_chunk_idx_events_command ON _timescaledb_internal._hyper_1_25_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_25_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_25_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_25_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_25_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_25_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_25_chunk USING gin (payload);


--
-- Name: _hyper_1_26_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_26_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_26_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_26_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_26_chunk_idx_events_command ON _timescaledb_internal._hyper_1_26_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_26_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_26_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_26_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_26_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_26_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_26_chunk USING gin (payload);


--
-- Name: _hyper_1_27_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_27_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_27_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_27_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_27_chunk_idx_events_command ON _timescaledb_internal._hyper_1_27_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_27_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_27_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_27_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_27_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_27_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_27_chunk USING gin (payload);


--
-- Name: _hyper_1_28_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_28_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_28_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_28_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_28_chunk_idx_events_command ON _timescaledb_internal._hyper_1_28_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_28_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_28_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_28_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_28_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_28_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_28_chunk USING gin (payload);


--
-- Name: _hyper_1_29_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_29_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_29_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_29_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_29_chunk_idx_events_command ON _timescaledb_internal._hyper_1_29_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_29_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_29_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_29_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_29_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_29_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_29_chunk USING gin (payload);


--
-- Name: _hyper_1_2_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_2_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_2_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_2_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_2_chunk_idx_events_command ON _timescaledb_internal._hyper_1_2_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_2_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_2_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_2_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_2_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_2_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_2_chunk USING gin (payload);


--
-- Name: _hyper_1_30_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_30_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_30_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_30_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_30_chunk_idx_events_command ON _timescaledb_internal._hyper_1_30_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_30_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_30_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_30_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_30_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_30_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_30_chunk USING gin (payload);


--
-- Name: _hyper_1_31_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_31_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_31_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_31_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_31_chunk_idx_events_command ON _timescaledb_internal._hyper_1_31_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_31_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_31_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_31_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_31_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_31_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_31_chunk USING gin (payload);


--
-- Name: _hyper_1_32_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_32_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_32_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_32_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_32_chunk_idx_events_command ON _timescaledb_internal._hyper_1_32_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_32_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_32_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_32_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_32_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_32_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_32_chunk USING gin (payload);


--
-- Name: _hyper_1_33_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_33_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_33_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_33_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_33_chunk_idx_events_command ON _timescaledb_internal._hyper_1_33_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_33_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_33_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_33_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_33_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_33_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_33_chunk USING gin (payload);


--
-- Name: _hyper_1_34_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_34_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_34_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_34_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_34_chunk_idx_events_command ON _timescaledb_internal._hyper_1_34_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_34_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_34_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_34_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_34_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_34_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_34_chunk USING gin (payload);


--
-- Name: _hyper_1_35_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_35_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_35_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_35_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_35_chunk_idx_events_command ON _timescaledb_internal._hyper_1_35_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_35_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_35_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_35_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_35_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_35_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_35_chunk USING gin (payload);


--
-- Name: _hyper_1_36_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_36_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_36_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_36_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_36_chunk_idx_events_command ON _timescaledb_internal._hyper_1_36_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_36_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_36_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_36_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_36_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_36_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_36_chunk USING gin (payload);


--
-- Name: _hyper_1_37_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_37_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_37_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_37_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_37_chunk_idx_events_command ON _timescaledb_internal._hyper_1_37_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_37_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_37_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_37_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_37_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_37_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_37_chunk USING gin (payload);


--
-- Name: _hyper_1_38_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_38_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_38_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_38_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_38_chunk_idx_events_command ON _timescaledb_internal._hyper_1_38_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_38_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_38_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_38_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_38_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_38_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_38_chunk USING gin (payload);


--
-- Name: _hyper_1_39_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_39_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_39_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_39_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_39_chunk_idx_events_command ON _timescaledb_internal._hyper_1_39_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_39_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_39_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_39_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_39_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_39_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_39_chunk USING gin (payload);


--
-- Name: _hyper_1_3_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_3_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_3_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_3_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_3_chunk_idx_events_command ON _timescaledb_internal._hyper_1_3_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_3_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_3_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_3_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_3_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_3_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_3_chunk USING gin (payload);


--
-- Name: _hyper_1_40_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_40_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_40_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_40_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_40_chunk_idx_events_command ON _timescaledb_internal._hyper_1_40_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_40_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_40_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_40_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_40_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_40_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_40_chunk USING gin (payload);


--
-- Name: _hyper_1_41_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_41_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_41_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_41_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_41_chunk_idx_events_command ON _timescaledb_internal._hyper_1_41_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_41_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_41_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_41_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_41_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_41_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_41_chunk USING gin (payload);


--
-- Name: _hyper_1_42_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_42_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_42_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_42_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_42_chunk_idx_events_command ON _timescaledb_internal._hyper_1_42_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_42_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_42_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_42_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_42_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_42_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_42_chunk USING gin (payload);


--
-- Name: _hyper_1_43_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_43_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_43_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_43_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_43_chunk_idx_events_command ON _timescaledb_internal._hyper_1_43_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_43_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_43_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_43_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_43_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_43_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_43_chunk USING gin (payload);


--
-- Name: _hyper_1_44_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_44_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_44_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_44_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_44_chunk_idx_events_command ON _timescaledb_internal._hyper_1_44_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_44_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_44_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_44_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_44_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_44_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_44_chunk USING gin (payload);


--
-- Name: _hyper_1_45_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_45_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_45_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_45_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_45_chunk_idx_events_command ON _timescaledb_internal._hyper_1_45_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_45_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_45_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_45_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_45_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_45_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_45_chunk USING gin (payload);


--
-- Name: _hyper_1_46_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_46_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_46_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_46_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_46_chunk_idx_events_command ON _timescaledb_internal._hyper_1_46_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_46_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_46_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_46_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_46_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_46_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_46_chunk USING gin (payload);


--
-- Name: _hyper_1_47_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_47_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_47_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_47_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_47_chunk_idx_events_command ON _timescaledb_internal._hyper_1_47_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_47_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_47_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_47_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_47_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_47_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_47_chunk USING gin (payload);


--
-- Name: _hyper_1_48_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_48_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_48_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_48_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_48_chunk_idx_events_command ON _timescaledb_internal._hyper_1_48_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_48_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_48_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_48_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_48_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_48_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_48_chunk USING gin (payload);


--
-- Name: _hyper_1_49_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_49_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_49_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_49_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_49_chunk_idx_events_command ON _timescaledb_internal._hyper_1_49_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_49_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_49_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_49_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_49_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_49_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_49_chunk USING gin (payload);


--
-- Name: _hyper_1_4_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_4_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_4_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_4_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_4_chunk_idx_events_command ON _timescaledb_internal._hyper_1_4_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_4_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_4_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_4_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_4_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_4_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_4_chunk USING gin (payload);


--
-- Name: _hyper_1_50_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_50_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_50_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_50_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_50_chunk_idx_events_command ON _timescaledb_internal._hyper_1_50_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_50_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_50_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_50_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_50_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_50_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_50_chunk USING gin (payload);


--
-- Name: _hyper_1_51_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_51_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_51_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_51_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_51_chunk_idx_events_command ON _timescaledb_internal._hyper_1_51_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_51_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_51_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_51_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_51_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_51_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_51_chunk USING gin (payload);


--
-- Name: _hyper_1_52_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_52_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_52_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_52_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_52_chunk_idx_events_command ON _timescaledb_internal._hyper_1_52_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_52_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_52_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_52_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_52_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_52_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_52_chunk USING gin (payload);


--
-- Name: _hyper_1_53_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_53_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_53_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_53_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_53_chunk_idx_events_command ON _timescaledb_internal._hyper_1_53_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_53_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_53_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_53_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_53_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_53_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_53_chunk USING gin (payload);


--
-- Name: _hyper_1_54_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_54_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_54_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_54_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_54_chunk_idx_events_command ON _timescaledb_internal._hyper_1_54_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_54_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_54_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_54_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_54_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_54_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_54_chunk USING gin (payload);


--
-- Name: _hyper_1_55_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_55_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_55_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_55_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_55_chunk_idx_events_command ON _timescaledb_internal._hyper_1_55_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_55_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_55_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_55_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_55_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_55_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_55_chunk USING gin (payload);


--
-- Name: _hyper_1_56_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_56_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_56_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_56_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_56_chunk_idx_events_command ON _timescaledb_internal._hyper_1_56_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_56_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_56_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_56_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_56_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_56_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_56_chunk USING gin (payload);


--
-- Name: _hyper_1_57_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_57_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_57_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_57_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_57_chunk_idx_events_command ON _timescaledb_internal._hyper_1_57_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_57_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_57_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_57_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_57_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_57_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_57_chunk USING gin (payload);


--
-- Name: _hyper_1_58_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_58_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_58_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_58_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_58_chunk_idx_events_command ON _timescaledb_internal._hyper_1_58_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_58_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_58_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_58_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_58_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_58_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_58_chunk USING gin (payload);


--
-- Name: _hyper_1_59_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_59_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_59_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_59_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_59_chunk_idx_events_command ON _timescaledb_internal._hyper_1_59_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_59_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_59_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_59_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_59_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_59_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_59_chunk USING gin (payload);


--
-- Name: _hyper_1_5_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_5_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_5_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_5_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_5_chunk_idx_events_command ON _timescaledb_internal._hyper_1_5_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_5_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_5_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_5_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_5_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_5_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_5_chunk USING gin (payload);


--
-- Name: _hyper_1_60_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_60_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_60_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_60_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_60_chunk_idx_events_command ON _timescaledb_internal._hyper_1_60_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_60_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_60_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_60_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_60_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_60_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_60_chunk USING gin (payload);


--
-- Name: _hyper_1_61_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_61_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_61_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_61_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_61_chunk_idx_events_command ON _timescaledb_internal._hyper_1_61_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_61_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_61_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_61_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_61_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_61_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_61_chunk USING gin (payload);


--
-- Name: _hyper_1_62_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_62_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_62_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_62_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_62_chunk_idx_events_command ON _timescaledb_internal._hyper_1_62_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_62_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_62_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_62_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_62_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_62_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_62_chunk USING gin (payload);


--
-- Name: _hyper_1_63_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_63_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_63_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_63_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_63_chunk_idx_events_command ON _timescaledb_internal._hyper_1_63_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_63_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_63_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_63_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_63_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_63_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_63_chunk USING gin (payload);


--
-- Name: _hyper_1_64_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_64_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_64_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_64_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_64_chunk_idx_events_command ON _timescaledb_internal._hyper_1_64_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_64_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_64_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_64_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_64_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_64_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_64_chunk USING gin (payload);


--
-- Name: _hyper_1_65_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_65_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_65_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_65_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_65_chunk_idx_events_command ON _timescaledb_internal._hyper_1_65_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_65_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_65_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_65_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_65_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_65_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_65_chunk USING gin (payload);


--
-- Name: _hyper_1_66_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_66_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_66_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_66_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_66_chunk_idx_events_command ON _timescaledb_internal._hyper_1_66_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_66_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_66_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_66_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_66_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_66_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_66_chunk USING gin (payload);


--
-- Name: _hyper_1_67_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_67_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_67_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_67_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_67_chunk_idx_events_command ON _timescaledb_internal._hyper_1_67_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_67_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_67_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_67_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_67_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_67_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_67_chunk USING gin (payload);


--
-- Name: _hyper_1_68_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_68_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_68_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_68_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_68_chunk_idx_events_command ON _timescaledb_internal._hyper_1_68_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_68_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_68_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_68_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_68_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_68_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_68_chunk USING gin (payload);


--
-- Name: _hyper_1_69_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_69_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_69_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_69_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_69_chunk_idx_events_command ON _timescaledb_internal._hyper_1_69_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_69_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_69_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_69_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_69_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_69_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_69_chunk USING gin (payload);


--
-- Name: _hyper_1_6_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_6_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_6_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_6_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_6_chunk_idx_events_command ON _timescaledb_internal._hyper_1_6_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_6_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_6_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_6_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_6_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_6_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_6_chunk USING gin (payload);


--
-- Name: _hyper_1_70_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_70_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_70_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_70_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_70_chunk_idx_events_command ON _timescaledb_internal._hyper_1_70_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_70_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_70_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_70_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_70_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_70_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_70_chunk USING gin (payload);


--
-- Name: _hyper_1_71_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_71_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_71_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_71_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_71_chunk_idx_events_command ON _timescaledb_internal._hyper_1_71_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_71_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_71_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_71_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_71_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_71_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_71_chunk USING gin (payload);


--
-- Name: _hyper_1_72_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_72_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_72_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_72_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_72_chunk_idx_events_command ON _timescaledb_internal._hyper_1_72_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_72_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_72_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_72_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_72_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_72_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_72_chunk USING gin (payload);


--
-- Name: _hyper_1_73_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_73_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_73_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_73_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_73_chunk_idx_events_command ON _timescaledb_internal._hyper_1_73_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_73_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_73_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_73_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_73_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_73_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_73_chunk USING gin (payload);


--
-- Name: _hyper_1_74_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_74_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_74_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_74_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_74_chunk_idx_events_command ON _timescaledb_internal._hyper_1_74_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_74_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_74_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_74_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_74_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_74_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_74_chunk USING gin (payload);


--
-- Name: _hyper_1_75_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_75_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_75_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_75_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_75_chunk_idx_events_command ON _timescaledb_internal._hyper_1_75_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_75_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_75_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_75_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_75_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_75_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_75_chunk USING gin (payload);


--
-- Name: _hyper_1_76_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_76_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_76_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_76_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_76_chunk_idx_events_command ON _timescaledb_internal._hyper_1_76_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_76_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_76_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_76_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_76_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_76_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_76_chunk USING gin (payload);


--
-- Name: _hyper_1_77_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_77_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_77_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_77_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_77_chunk_idx_events_command ON _timescaledb_internal._hyper_1_77_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_77_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_77_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_77_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_77_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_77_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_77_chunk USING gin (payload);


--
-- Name: _hyper_1_78_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_78_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_78_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_78_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_78_chunk_idx_events_command ON _timescaledb_internal._hyper_1_78_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_78_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_78_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_78_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_78_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_78_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_78_chunk USING gin (payload);


--
-- Name: _hyper_1_79_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_79_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_79_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_79_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_79_chunk_idx_events_command ON _timescaledb_internal._hyper_1_79_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_79_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_79_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_79_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_79_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_79_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_79_chunk USING gin (payload);


--
-- Name: _hyper_1_7_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_7_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_7_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_7_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_7_chunk_idx_events_command ON _timescaledb_internal._hyper_1_7_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_7_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_7_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_7_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_7_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_7_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_7_chunk USING gin (payload);


--
-- Name: _hyper_1_80_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_80_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_80_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_80_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_80_chunk_idx_events_command ON _timescaledb_internal._hyper_1_80_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_80_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_80_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_80_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_80_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_80_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_80_chunk USING gin (payload);


--
-- Name: _hyper_1_81_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_81_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_81_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_81_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_81_chunk_idx_events_command ON _timescaledb_internal._hyper_1_81_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_81_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_81_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_81_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_81_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_81_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_81_chunk USING gin (payload);


--
-- Name: _hyper_1_82_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_82_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_82_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_82_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_82_chunk_idx_events_command ON _timescaledb_internal._hyper_1_82_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_82_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_82_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_82_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_82_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_82_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_82_chunk USING gin (payload);


--
-- Name: _hyper_1_83_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_83_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_83_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_83_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_83_chunk_idx_events_command ON _timescaledb_internal._hyper_1_83_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_83_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_83_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_83_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_83_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_83_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_83_chunk USING gin (payload);


--
-- Name: _hyper_1_84_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_84_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_84_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_84_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_84_chunk_idx_events_command ON _timescaledb_internal._hyper_1_84_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_84_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_84_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_84_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_84_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_84_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_84_chunk USING gin (payload);


--
-- Name: _hyper_1_85_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_85_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_85_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_85_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_85_chunk_idx_events_command ON _timescaledb_internal._hyper_1_85_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_85_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_85_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_85_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_85_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_85_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_85_chunk USING gin (payload);


--
-- Name: _hyper_1_86_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_86_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_86_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_86_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_86_chunk_idx_events_command ON _timescaledb_internal._hyper_1_86_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_86_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_86_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_86_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_86_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_86_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_86_chunk USING gin (payload);


--
-- Name: _hyper_1_87_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_87_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_87_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_87_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_87_chunk_idx_events_command ON _timescaledb_internal._hyper_1_87_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_87_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_87_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_87_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_87_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_87_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_87_chunk USING gin (payload);


--
-- Name: _hyper_1_88_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_88_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_88_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_88_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_88_chunk_idx_events_command ON _timescaledb_internal._hyper_1_88_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_88_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_88_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_88_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_88_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_88_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_88_chunk USING gin (payload);


--
-- Name: _hyper_1_89_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_89_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_89_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_89_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_89_chunk_idx_events_command ON _timescaledb_internal._hyper_1_89_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_89_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_89_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_89_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_89_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_89_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_89_chunk USING gin (payload);


--
-- Name: _hyper_1_8_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_8_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_8_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_8_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_8_chunk_idx_events_command ON _timescaledb_internal._hyper_1_8_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_8_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_8_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_8_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_8_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_8_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_8_chunk USING gin (payload);


--
-- Name: _hyper_1_90_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_90_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_90_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_90_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_90_chunk_idx_events_command ON _timescaledb_internal._hyper_1_90_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_90_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_90_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_90_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_90_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_90_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_90_chunk USING gin (payload);


--
-- Name: _hyper_1_91_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_91_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_91_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_91_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_91_chunk_idx_events_command ON _timescaledb_internal._hyper_1_91_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_91_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_91_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_91_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_91_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_91_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_91_chunk USING gin (payload);


--
-- Name: _hyper_1_92_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_92_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_92_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_92_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_92_chunk_idx_events_command ON _timescaledb_internal._hyper_1_92_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_92_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_92_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_92_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_92_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_92_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_92_chunk USING gin (payload);


--
-- Name: _hyper_1_93_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_93_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_93_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_93_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_93_chunk_idx_events_command ON _timescaledb_internal._hyper_1_93_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_93_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_93_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_93_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_93_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_93_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_93_chunk USING gin (payload);


--
-- Name: _hyper_1_94_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_94_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_94_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_94_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_94_chunk_idx_events_command ON _timescaledb_internal._hyper_1_94_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_94_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_94_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_94_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_94_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_94_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_94_chunk USING gin (payload);


--
-- Name: _hyper_1_95_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_95_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_95_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_95_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_95_chunk_idx_events_command ON _timescaledb_internal._hyper_1_95_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_95_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_95_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_95_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_95_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_95_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_95_chunk USING gin (payload);


--
-- Name: _hyper_1_96_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_96_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_96_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_96_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_96_chunk_idx_events_command ON _timescaledb_internal._hyper_1_96_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_96_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_96_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_96_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_96_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_96_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_96_chunk USING gin (payload);


--
-- Name: _hyper_1_97_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_97_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_97_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_97_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_97_chunk_idx_events_command ON _timescaledb_internal._hyper_1_97_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_97_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_97_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_97_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_97_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_97_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_97_chunk USING gin (payload);


--
-- Name: _hyper_1_98_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_98_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_98_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_98_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_98_chunk_idx_events_command ON _timescaledb_internal._hyper_1_98_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_98_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_98_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_98_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_98_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_98_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_98_chunk USING gin (payload);


--
-- Name: _hyper_1_99_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_99_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_99_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_99_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_99_chunk_idx_events_command ON _timescaledb_internal._hyper_1_99_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_99_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_99_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_99_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_99_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_99_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_99_chunk USING gin (payload);


--
-- Name: _hyper_1_9_chunk_events_occurred_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_9_chunk_events_occurred_at_idx ON _timescaledb_internal._hyper_1_9_chunk USING btree (occurred_at DESC);


--
-- Name: _hyper_1_9_chunk_idx_events_command; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_9_chunk_idx_events_command ON _timescaledb_internal._hyper_1_9_chunk USING btree (command_id) WHERE (command_id IS NOT NULL);


--
-- Name: _hyper_1_9_chunk_idx_events_metric_time; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_9_chunk_idx_events_metric_time ON _timescaledb_internal._hyper_1_9_chunk USING btree (metric_key, occurred_at);


--
-- Name: _hyper_1_9_chunk_idx_events_payload_gin; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_1_9_chunk_idx_events_payload_gin ON _timescaledb_internal._hyper_1_9_chunk USING gin (payload);


--
-- Name: _hyper_3_269_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_269_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_269_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_269_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_269_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_269_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_270_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_270_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_270_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_270_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_270_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_270_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_271_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_271_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_271_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_271_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_271_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_271_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_272_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_272_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_272_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_272_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_272_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_272_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_273_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_273_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_273_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_273_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_273_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_273_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_274_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_274_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_274_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_274_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_274_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_274_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_275_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_275_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_275_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_275_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_275_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_275_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_276_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_276_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_276_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_276_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_276_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_276_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_277_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_277_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_277_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_277_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_277_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_277_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_278_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_278_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_278_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_278_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_278_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_278_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_279_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_279_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_279_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_279_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_279_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_279_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_280_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_280_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_280_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_280_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_280_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_280_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_281_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_281_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_281_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_281_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_281_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_281_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_282_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_282_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_282_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_282_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_282_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_282_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_283_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_283_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_283_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_283_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_283_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_283_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_284_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_284_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_284_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_284_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_284_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_284_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_285_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_285_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_285_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_285_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_285_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_285_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_286_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_286_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_286_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_286_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_286_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_286_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_287_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_287_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_287_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_287_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_287_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_287_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_288_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_288_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_288_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_288_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_288_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_288_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_289_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_289_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_289_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_289_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_289_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_289_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_290_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_290_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_290_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_290_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_290_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_290_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_291_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_291_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_291_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_291_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_291_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_291_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_3_292_chunk__materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_292_chunk__materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._hyper_3_292_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_3_292_chunk__materialized_hypertable_3_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_3_292_chunk__materialized_hypertable_3_metric_key_bucket ON _timescaledb_internal._hyper_3_292_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_293_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_293_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_293_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_293_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_293_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_293_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_294_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_294_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_294_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_294_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_294_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_294_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_295_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_295_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_295_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_295_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_295_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_295_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_296_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_296_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_296_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_296_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_296_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_296_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_297_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_297_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_297_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_297_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_297_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_297_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_298_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_298_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_298_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_298_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_298_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_298_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_299_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_299_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_299_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_299_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_299_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_299_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_300_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_300_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_300_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_300_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_300_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_300_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_301_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_301_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_301_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_301_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_301_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_301_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_302_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_302_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_302_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_302_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_302_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_302_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_303_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_303_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_303_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_303_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_303_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_303_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_304_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_304_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_304_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_304_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_304_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_304_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_305_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_305_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_305_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_305_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_305_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_305_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_306_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_306_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_306_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_306_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_306_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_306_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_307_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_307_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_307_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_307_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_307_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_307_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_308_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_308_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_308_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_308_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_308_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_308_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_309_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_309_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_309_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_309_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_309_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_309_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_4_310_chunk__materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_310_chunk__materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._hyper_4_310_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_4_310_chunk__materialized_hypertable_4_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_4_310_chunk__materialized_hypertable_4_metric_key_bucket ON _timescaledb_internal._hyper_4_310_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_5_311_chunk__materialized_hypertable_5_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_311_chunk__materialized_hypertable_5_bucket_start_idx ON _timescaledb_internal._hyper_5_311_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_5_311_chunk__materialized_hypertable_5_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_311_chunk__materialized_hypertable_5_metric_key_bucket ON _timescaledb_internal._hyper_5_311_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_5_312_chunk__materialized_hypertable_5_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_312_chunk__materialized_hypertable_5_bucket_start_idx ON _timescaledb_internal._hyper_5_312_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_5_312_chunk__materialized_hypertable_5_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_312_chunk__materialized_hypertable_5_metric_key_bucket ON _timescaledb_internal._hyper_5_312_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_5_313_chunk__materialized_hypertable_5_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_313_chunk__materialized_hypertable_5_bucket_start_idx ON _timescaledb_internal._hyper_5_313_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_5_313_chunk__materialized_hypertable_5_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_313_chunk__materialized_hypertable_5_metric_key_bucket ON _timescaledb_internal._hyper_5_313_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_5_314_chunk__materialized_hypertable_5_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_314_chunk__materialized_hypertable_5_bucket_start_idx ON _timescaledb_internal._hyper_5_314_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_5_314_chunk__materialized_hypertable_5_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_314_chunk__materialized_hypertable_5_metric_key_bucket ON _timescaledb_internal._hyper_5_314_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_315_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_315_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_315_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_315_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_315_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_315_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_316_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_316_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_316_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_316_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_316_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_316_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_317_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_317_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_317_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_317_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_317_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_317_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_318_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_318_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_318_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_318_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_318_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_318_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_319_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_319_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_319_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_319_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_319_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_319_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_320_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_320_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_320_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_320_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_320_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_320_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_321_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_321_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_321_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_321_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_321_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_321_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_322_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_322_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_322_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_322_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_322_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_322_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_323_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_323_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_323_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_323_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_323_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_323_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_324_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_324_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_324_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_324_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_324_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_324_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_325_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_325_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_325_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_325_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_325_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_325_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_326_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_326_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_326_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_326_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_326_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_326_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_327_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_327_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_327_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_327_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_327_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_327_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_328_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_328_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_328_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_328_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_328_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_328_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_329_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_329_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_329_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_329_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_329_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_329_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_330_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_330_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_330_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_330_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_330_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_330_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_331_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_331_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_331_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_331_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_331_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_331_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_332_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_332_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_332_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_332_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_332_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_332_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_333_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_333_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_333_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_333_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_333_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_333_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_334_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_334_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_334_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_334_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_334_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_334_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_335_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_335_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_335_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_335_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_335_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_335_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_336_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_336_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_336_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_336_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_336_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_336_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_337_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_337_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_337_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_337_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_337_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_337_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_338_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_338_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_338_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_338_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_338_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_338_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _hyper_6_339_chunk__materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_339_chunk__materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._hyper_6_339_chunk USING btree (bucket_start DESC);


--
-- Name: _hyper_6_339_chunk__materialized_hypertable_6_metric_key_bucket; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_6_339_chunk__materialized_hypertable_6_metric_key_bucket ON _timescaledb_internal._hyper_6_339_chunk USING btree (metric_key, bucket_start DESC);


--
-- Name: _materialized_hypertable_3_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_3_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_3 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_3_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_3_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_3 USING btree (metric_key, bucket_start DESC);


--
-- Name: _materialized_hypertable_4_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_4_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_4 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_4_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_4_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_4 USING btree (metric_key, bucket_start DESC);


--
-- Name: _materialized_hypertable_5_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_5_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_5 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_5_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_5_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_5 USING btree (metric_key, bucket_start DESC);


--
-- Name: _materialized_hypertable_6_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_6_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_6 USING btree (bucket_start DESC);


--
-- Name: _materialized_hypertable_6_metric_key_bucket_start_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _materialized_hypertable_6_metric_key_bucket_start_idx ON _timescaledb_internal._materialized_hypertable_6 USING btree (metric_key, bucket_start DESC);


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
-- Name: _hyper_1_100_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_100_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_101_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_101_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_102_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_102_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_103_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_103_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_104_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_104_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_105_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_105_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_106_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_106_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_107_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_107_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_108_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_108_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_109_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_109_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_10_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_10_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_110_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_110_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_111_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_111_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_112_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_112_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_113_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_113_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_114_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_114_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_115_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_115_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_116_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_116_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_117_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_117_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_118_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_118_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_119_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_119_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_11_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_11_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_120_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_120_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_121_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_121_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_122_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_122_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_123_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_123_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_124_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_124_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_125_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_125_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_126_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_126_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_127_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_127_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_128_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_128_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_129_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_129_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_12_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_12_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_130_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_130_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_131_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_131_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_132_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_132_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_133_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_133_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_134_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_134_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_135_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_135_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_136_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_136_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_137_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_137_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_138_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_138_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_139_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_139_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_13_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_13_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_140_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_140_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_141_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_141_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_142_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_142_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_143_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_143_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_144_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_144_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_145_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_145_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_146_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_146_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_147_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_147_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_148_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_148_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_149_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_149_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_14_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_14_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_150_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_150_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_151_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_151_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_152_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_152_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_153_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_153_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_154_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_154_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_155_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_155_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_156_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_156_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_157_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_157_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_158_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_158_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_159_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_159_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_15_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_15_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_160_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_160_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_161_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_161_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_162_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_162_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_163_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_163_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_164_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_164_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_165_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_165_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_166_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_166_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_167_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_167_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_168_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_168_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_169_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_169_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_16_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_16_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_170_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_170_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_171_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_171_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_172_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_172_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_173_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_173_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_174_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_174_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_175_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_175_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_176_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_176_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_177_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_177_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_178_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_178_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_179_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_179_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_17_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_17_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_180_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_180_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_181_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_181_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_182_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_182_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_183_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_183_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_184_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_184_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_185_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_185_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_186_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_186_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_187_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_187_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_188_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_188_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_189_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_189_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_18_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_18_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_190_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_190_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_191_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_191_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_192_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_192_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_193_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_193_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_194_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_194_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_195_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_195_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_196_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_196_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_197_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_197_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_198_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_198_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_199_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_199_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_19_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_19_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_1_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_1_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_200_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_200_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_201_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_201_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_202_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_202_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_203_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_203_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_204_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_204_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_205_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_205_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_206_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_206_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_207_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_207_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_208_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_208_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_209_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_209_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_20_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_20_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_210_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_210_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_211_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_211_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_212_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_212_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_213_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_213_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_214_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_214_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_215_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_215_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_216_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_216_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_217_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_217_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_218_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_218_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_219_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_219_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_21_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_21_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_220_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_220_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_221_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_221_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_222_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_222_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_223_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_223_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_224_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_224_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_225_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_225_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_226_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_226_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_227_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_227_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_228_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_228_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_229_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_229_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_22_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_22_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_230_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_230_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_231_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_231_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_232_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_232_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_233_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_233_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_234_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_234_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_235_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_235_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_236_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_236_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_237_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_237_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_238_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_238_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_239_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_239_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_23_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_23_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_240_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_240_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_241_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_241_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_242_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_242_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_243_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_243_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_24_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_24_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_25_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_25_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_26_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_26_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_27_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_27_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_28_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_28_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_29_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_29_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_2_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_2_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_30_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_30_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_31_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_31_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_32_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_32_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_33_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_33_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_34_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_34_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_35_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_35_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_36_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_36_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_37_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_37_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_38_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_38_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_39_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_39_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_3_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_3_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_40_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_40_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_41_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_41_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_42_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_42_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_43_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_43_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_44_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_44_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_45_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_45_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_46_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_46_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_47_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_47_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_48_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_48_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_49_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_49_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_4_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_4_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_50_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_50_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_51_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_51_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_52_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_52_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_53_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_53_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_54_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_54_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_55_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_55_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_56_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_56_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_57_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_57_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_58_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_58_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_59_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_59_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_5_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_5_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_60_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_60_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_61_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_61_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_62_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_62_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_63_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_63_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_64_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_64_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_65_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_65_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_66_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_66_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_67_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_67_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_68_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_68_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_69_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_69_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_6_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_6_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_70_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_70_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_71_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_71_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_72_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_72_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_73_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_73_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_74_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_74_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_75_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_75_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_76_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_76_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_77_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_77_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_78_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_78_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_79_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_79_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_7_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_7_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_80_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_80_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_81_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_81_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_82_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_82_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_83_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_83_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_84_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_84_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_85_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_85_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_86_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_86_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_87_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_87_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_88_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_88_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_89_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_89_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_8_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_8_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_90_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_90_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_91_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_91_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_92_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_92_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_93_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_93_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_94_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_94_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_95_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_95_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_96_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_96_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_97_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_97_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_98_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_98_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_99_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_99_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _hyper_1_9_chunk ts_cagg_invalidation_trigger; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_cagg_invalidation_trigger AFTER INSERT OR DELETE OR UPDATE ON _timescaledb_internal._hyper_1_9_chunk FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.continuous_agg_invalidation_trigger('1');


--
-- Name: _materialized_hypertable_3 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_3 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_4 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_4 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_5 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_5 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


--
-- Name: _materialized_hypertable_6 ts_insert_blocker; Type: TRIGGER; Schema: _timescaledb_internal; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON _timescaledb_internal._materialized_hypertable_6 FOR EACH ROW EXECUTE FUNCTION _timescaledb_functions.insert_blocker();


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
    ('20250902');
