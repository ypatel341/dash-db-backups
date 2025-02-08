--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Postgres.app)
-- Dumped by pg_dump version 17.2 (Homebrew)

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

ALTER TABLE IF EXISTS ONLY public.budget_monthly_allocation DROP CONSTRAINT IF EXISTS monthly_budget_allocation_pkey;
ALTER TABLE IF EXISTS ONLY public.clients DROP CONSTRAINT IF EXISTS clients_pkey;
ALTER TABLE IF EXISTS ONLY public.budget_monthly_expenses DROP CONSTRAINT IF EXISTS budget_monthly_expenses_pkey;
ALTER TABLE IF EXISTS public.clients ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.users_roles;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.clients_id_seq;
DROP TABLE IF EXISTS public.clients;
DROP TABLE IF EXISTS public.budget_monthly_expenses;
DROP TABLE IF EXISTS public.budget_monthly_allocation;
DROP EXTENSION IF EXISTS "uuid-ossp";
--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: budget_monthly_allocation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.budget_monthly_allocation (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    category character varying(255) NOT NULL,
    bucketname character varying(255) NOT NULL,
    amount integer,
    household character varying
);


--
-- Name: budget_monthly_expenses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.budget_monthly_expenses (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    person character varying(255),
    bucketname character varying(255) NOT NULL,
    vendor character varying(255),
    amount double precision,
    description character varying,
    expense_date timestamp with time zone DEFAULT now(),
    updatedat timestamp with time zone,
    deletedat timestamp with time zone
);


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    role character varying
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4(),
    first_name character varying,
    last_name character varying,
    email character varying,
    role character varying
);


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users_roles (
    id uuid DEFAULT public.uuid_generate_v4(),
    user_role character varying,
    createdat timestamp with time zone DEFAULT now() NOT NULL,
    updatedat timestamp with time zone,
    deletedat timestamp with time zone
);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Data for Name: budget_monthly_allocation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.budget_monthly_allocation (id, category, bucketname, amount, household) FROM stdin;
0a03dd40-87eb-4054-9d0a-5857d090fe30	needs	rent	3200	domus
8c0cc1c3-4e87-4223-8ce3-e721ff9417e7	needs	electric	140	domus
7a24bf63-aaee-45a1-9bd1-072b8d346e63	needs	internet	70	domus
eea022f6-e307-4eaa-9ccf-dcd7f19b3717	needs	parcel	5	domus
6a106196-e0be-46d9-84cb-2e631c2504cf	needs	groceries	580	domus
4d76327b-b366-4f6b-b9ae-fb018ca4dddb	needs	gas	150	domus
76c046bb-f192-4148-9eda-d714c0c067f9	needs	therapy	125	domus
bfb595cc-f8a2-4914-bd45-034526f205b1	needs	house_supplies	150	domus
a13af0ba-3418-4c9a-9840-a0136c3d09fc	wants	netflix	17	domus
71cd8515-a587-4e40-8435-0c4381f65802	wants	spotify	13	domus
c2239be8-3793-42da-9d9e-ea980ccca2a1	wants	date_night	120	domus
967aec6e-147e-42eb-a616-effa7a46d902	wants	vacation	1000	domus
94300054-ef4c-43de-82d8-d03de6402d50	wants	going_out_yogi	200	domus
c4dd9e5b-7b80-41c6-b6e9-1525dc8925cc	wants	gifts	166	domus
744c5921-5430-4725-a812-1de76b8a0ee5	wants	yogi_activities	200	domus
a0bc7722-ab7d-4925-934d-ae29005ca823	wants	clothes	200	domus
26a0d0aa-5f81-4902-8372-cb4219e66a80	savings	savings_chase_2112	5500	domus
\.


--
-- Data for Name: budget_monthly_expenses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.budget_monthly_expenses (id, person, bucketname, vendor, amount, description, expense_date, updatedat, deletedat) FROM stdin;
3098ac90-d242-4eb1-9fc6-e16679f76c53	Yogi	clothes	test	1	asdfsdf	2025-01-23 22:32:07.196998-05	\N	\N
34adcf64-e03c-401d-96bd-b1ac4af851c5	Both	rent	test	1234	some description	2025-01-25 09:44:57.29747-05	\N	\N
c0e7584e-44e8-40d9-aa29-652238cfd911	Both	rent	test	123	some description	2025-01-27 09:40:33.344986-05	\N	\N
410aefec-8e4e-4e9e-9f67-ba54733a5703	Both	rent	testtt	123	some description	2025-01-27 09:44:01.25575-05	\N	\N
55270f9c-ec09-4d40-93f9-002c7c5a0bf6	Both	rent	testtt	123	some description	2025-01-27 09:44:28.713584-05	\N	\N
c5617c4a-5529-4abe-ab11-364814b6647f	Both	internet	sadf	123	some description	2025-01-27 09:47:35.626811-05	\N	\N
b320d704-f788-4667-b0b1-e778c067f0a5	Yogi	gas	gsgsg	123	some description	2025-01-27 09:48:02.384288-05	\N	\N
b4ee7e03-7d87-4611-96cf-1d52e048d25a	Yogi	gas	gsgsg	\N	some description	2025-01-27 09:48:08.852797-05	\N	\N
76df7093-9efd-4936-85ba-5749e372ebac	Yogi	parcel	dasdf	\N	some description	2025-01-27 10:02:07.845604-05	\N	\N
b2020da2-2b41-4a07-b83e-9f112a7e4159	Both	parcel	asdf	123	some description	2025-01-27 10:14:05.348061-05	\N	\N
81cba94d-1cdc-4806-91dd-01926dd51995	Riddhi	internet	test	1314	asdfasdf	2025-01-27 10:47:25.188307-05	\N	\N
f54d0294-1bfb-4cd1-ba81-7c6a0e41755b	Riddhi	internet	test	131	asdfasdf	2025-01-27 10:47:41.807071-05	\N	\N
c89a1da9-b49d-42e3-b139-35c94d9883c5	Riddhi	rent	test	123123	asdfasdf	2025-01-27 11:06:15.083086-05	\N	\N
842e6620-e1c3-4057-9c8c-6c119027bb75	Yogi	house_supplies	test	1230	asdfasdf	2025-01-27 11:25:52.48967-05	\N	\N
fcab30d7-c3d8-4bf3-8d9c-cfab4d20c161	Yogi	groceries	test	1230	asdfasdf	2025-01-27 11:33:50.235387-05	\N	\N
d0ae80ec-2a22-4206-be2c-d88875452323	Riddhi	parcel	test	1230	asdf	2025-01-27 14:12:37.003815-05	\N	\N
6e387ac3-f3db-421c-9331-366bc0dd94c4	Riddhi	parcel	test	1230	asdf	2025-01-27 14:12:51.193388-05	\N	\N
e3a91811-2a23-41ec-bc77-dbf40d3bfc61	Riddhi	parcel	sadfasdf	134134	asdf	2025-01-27 14:13:13.730692-05	\N	\N
52d31441-2d89-4b07-b546-79fa867e8923	Riddhi	parcel	sadfasdf	134134	asdf	2025-01-27 14:13:35.141175-05	\N	\N
fb7fc34b-a387-450e-912a-a32de8662c9f	Yogi	house_supplies	ateas	12		2025-01-27 14:34:48.053-05	\N	\N
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.clients (id, first_name, last_name, role) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, first_name, last_name, email, role) FROM stdin;
a75ec483-7100-4351-aabd-7b559e9729ce	Yogi	Patel	ypatel341@gmail.com	Admin
f1dcdb21-f312-4c59-8fef-09f5fb0986b4	Riddhi	Amin	riddhiamin95@gmail.com	Admin
\.


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users_roles (id, user_role, createdat, updatedat, deletedat) FROM stdin;
7d277eee-572f-43ca-b63a-a0debef63424	Admin	2024-01-27 14:24:19.172554-05	\N	\N
\.


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clients_id_seq', 1, false);


--
-- Name: budget_monthly_expenses budget_monthly_expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budget_monthly_expenses
    ADD CONSTRAINT budget_monthly_expenses_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: budget_monthly_allocation monthly_budget_allocation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.budget_monthly_allocation
    ADD CONSTRAINT monthly_budget_allocation_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

