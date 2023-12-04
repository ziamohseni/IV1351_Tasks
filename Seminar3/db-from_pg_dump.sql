--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0

-- Started on 2023-12-04 21:15:53 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 894 (class 1247 OID 26994)
-- Name: day_of_week; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.day_of_week AS ENUM (
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
);


ALTER TYPE public.day_of_week OWNER TO postgres;

--
-- TOC entry 882 (class 1247 OID 26950)
-- Name: instrument_brand; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.instrument_brand AS ENUM (
    'Yamaha',
    'Gibson',
    'Fender',
    'Steinway',
    'Kawai',
    'Roland',
    'Taylor',
    'Martin',
    'Ibanez',
    'Casio'
);


ALTER TYPE public.instrument_brand OWNER TO postgres;

--
-- TOC entry 879 (class 1247 OID 26939)
-- Name: instrument_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.instrument_type AS ENUM (
    'Guitar',
    'Piano',
    'Violin',
    'Drums',
    'Other'
);


ALTER TYPE public.instrument_type OWNER TO postgres;

--
-- TOC entry 888 (class 1247 OID 26980)
-- Name: lesson_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.lesson_type AS ENUM (
    'Individual',
    'Group',
    'Ensemble'
);


ALTER TYPE public.lesson_type OWNER TO postgres;

--
-- TOC entry 885 (class 1247 OID 26972)
-- Name: level_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.level_type AS ENUM (
    'Beginner',
    'Intermediate',
    'Advanced'
);


ALTER TYPE public.level_type OWNER TO postgres;

--
-- TOC entry 891 (class 1247 OID 26988)
-- Name: target_genre; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.target_genre AS ENUM (
    'Punk Rock',
    'Gospel Band'
);


ALTER TYPE public.target_genre OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 27010)
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    address_id integer NOT NULL,
    street character varying(200) NOT NULL,
    zip character varying(5) NOT NULL,
    city character varying(100) NOT NULL
);


ALTER TABLE public.address OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 27009)
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.address ALTER COLUMN address_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 249 (class 1259 OID 27127)
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    booking_id integer NOT NULL,
    student_id integer NOT NULL,
    lesson_id integer NOT NULL,
    lesson_type character varying(100) NOT NULL,
    instructor_timeslot_id integer NOT NULL,
    booking_date date NOT NULL,
    price_info_id integer NOT NULL
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 27126)
-- Name: booking_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.booking ALTER COLUMN booking_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.booking_booking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 27022)
-- Name: ensemble; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ensemble (
    ensemble_id integer NOT NULL,
    minimum_students integer NOT NULL,
    maximum_students integer NOT NULL,
    target_genre public.target_genre NOT NULL,
    room character varying(10) NOT NULL,
    planed_date date NOT NULL
);


ALTER TABLE public.ensemble OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 27028)
-- Name: group_lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_lesson (
    group_lesson_id integer NOT NULL,
    number_of_places integer NOT NULL,
    minimum_enrollment integer NOT NULL,
    instrument public.instrument_type NOT NULL,
    room character varying(10) NOT NULL,
    planed_date date NOT NULL
);


ALTER TABLE public.group_lesson OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 27034)
-- Name: individual_lesson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.individual_lesson (
    individual_lesson_id integer NOT NULL,
    instrument public.instrument_type NOT NULL,
    room character varying(10) NOT NULL,
    planed_date date NOT NULL
);


ALTER TABLE public.individual_lesson OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 27232)
-- Name: combined_lessons_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.combined_lessons_view AS
 SELECT individual_lesson.planed_date,
    'Individual'::text AS lesson_type
   FROM public.individual_lesson
UNION ALL
 SELECT group_lesson.planed_date,
    'Group'::text AS lesson_type
   FROM public.group_lesson
UNION ALL
 SELECT ensemble.planed_date,
    'Ensemble'::text AS lesson_type
   FROM public.ensemble;


ALTER VIEW public.combined_lessons_view OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 27016)
-- Name: contact_person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_person (
    contact_person_id integer NOT NULL,
    full_name character varying(100) NOT NULL,
    phone_number character varying(100) NOT NULL,
    email_address character varying(100),
    relationship character varying(100) NOT NULL
);


ALTER TABLE public.contact_person OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 27015)
-- Name: contact_person_contact_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.contact_person ALTER COLUMN contact_person_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contact_person_contact_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 27021)
-- Name: ensemble_ensemble_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ensemble ALTER COLUMN ensemble_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ensemble_ensemble_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 27027)
-- Name: group_lesson_group_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.group_lesson ALTER COLUMN group_lesson_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.group_lesson_group_lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 253 (class 1259 OID 27266)
-- Name: historical_student_lessons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historical_student_lessons (
    lesson_id integer NOT NULL,
    lesson_type public.lesson_type,
    genre public.target_genre,
    instrument public.instrument_type,
    lesson_price numeric(10,2),
    student_name character varying(200) NOT NULL,
    student_email character varying(200),
    booking_date date NOT NULL
);


ALTER TABLE public.historical_student_lessons OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 27033)
-- Name: individual_lesson_individual_lesson_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.individual_lesson ALTER COLUMN individual_lesson_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.individual_lesson_individual_lesson_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 27040)
-- Name: instructor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor (
    instructor_id integer NOT NULL,
    can_teach_ensemble boolean NOT NULL,
    person_number character varying(12),
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email_address character varying(200)
);


ALTER TABLE public.instructor OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 27047)
-- Name: instructor_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_address (
    instructor_id integer NOT NULL,
    address_id integer NOT NULL
);


ALTER TABLE public.instructor_address OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 27039)
-- Name: instructor_instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instructor ALTER COLUMN instructor_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instructor_instructor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 27053)
-- Name: instructor_instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_instrument (
    instructor_instrument_id integer NOT NULL,
    instructor_id integer NOT NULL,
    instrument public.instrument_type NOT NULL
);


ALTER TABLE public.instructor_instrument OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 27052)
-- Name: instructor_instrument_instructor_instrument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instructor_instrument ALTER COLUMN instructor_instrument_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instructor_instrument_instructor_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 244 (class 1259 OID 27110)
-- Name: instructor_timeslot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_timeslot (
    instructor_timeslot_id integer NOT NULL,
    is_available boolean NOT NULL,
    timeslot_id integer NOT NULL,
    instructor_id integer NOT NULL
);


ALTER TABLE public.instructor_timeslot OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 27246)
-- Name: instructor_lessons_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.instructor_lessons_summary AS
 SELECT i.instructor_id,
    i.first_name,
    i.last_name,
    count(*) AS "No of Lessons"
   FROM ((public.instructor i
     JOIN public.instructor_timeslot it ON ((i.instructor_id = it.instructor_id)))
     JOIN public.booking b ON ((it.instructor_timeslot_id = b.instructor_timeslot_id)))
  WHERE ((EXTRACT(month FROM b.booking_date) = EXTRACT(month FROM CURRENT_DATE)) AND (EXTRACT(year FROM b.booking_date) = EXTRACT(year FROM CURRENT_DATE)))
  GROUP BY i.instructor_id, i.first_name, i.last_name
  ORDER BY (count(*)) DESC;


ALTER VIEW public.instructor_lessons_summary OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 27104)
-- Name: instructor_phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instructor_phone (
    instructor_id integer NOT NULL,
    phone_id integer NOT NULL
);


ALTER TABLE public.instructor_phone OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 27109)
-- Name: instructor_timeslot_instructor_timeslot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instructor_timeslot ALTER COLUMN instructor_timeslot_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instructor_timeslot_instructor_timeslot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 27059)
-- Name: instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instrument (
    instrument_id integer NOT NULL,
    instrument_type public.instrument_type NOT NULL,
    brand public.instrument_brand NOT NULL,
    quantity_in_stock integer NOT NULL,
    price numeric(10,0)
);


ALTER TABLE public.instrument OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 27058)
-- Name: instrument_instrument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instrument ALTER COLUMN instrument_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instrument_instrument_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 246 (class 1259 OID 27116)
-- Name: instrument_rental; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instrument_rental (
    rental_id integer NOT NULL,
    instrument_id integer NOT NULL,
    student_id integer NOT NULL,
    rental_start_date date NOT NULL,
    rental_end_date date NOT NULL,
    is_rental_active boolean NOT NULL
);


ALTER TABLE public.instrument_rental OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 27115)
-- Name: instrument_rental_rental_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.instrument_rental ALTER COLUMN rental_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.instrument_rental_rental_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 27065)
-- Name: phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phone (
    phone_id integer NOT NULL,
    phone_number character varying(100) NOT NULL
);


ALTER TABLE public.phone OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 27064)
-- Name: phone_phone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.phone ALTER COLUMN phone_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.phone_phone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 27073)
-- Name: price_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_info (
    price_info_id integer NOT NULL,
    lesson_type public.lesson_type NOT NULL,
    base_price numeric(10,2) NOT NULL,
    lesson_skill_level public.level_type NOT NULL,
    valid_from timestamp without time zone NOT NULL,
    valid_until timestamp without time zone
);


ALTER TABLE public.price_info OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 27072)
-- Name: price_info_price_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.price_info ALTER COLUMN price_info_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.price_info_price_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 247 (class 1259 OID 27121)
-- Name: sibling; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sibling (
    student_id integer NOT NULL,
    sibling_id integer NOT NULL
);


ALTER TABLE public.sibling OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 27079)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    student_id integer NOT NULL,
    enrollment_date date NOT NULL,
    rental_limit integer NOT NULL,
    contact_person_id integer NOT NULL,
    instrument_skill_level character varying(100) NOT NULL,
    person_number character varying(12),
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email_address character varying(200)
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 27088)
-- Name: student_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_address (
    address_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.student_address OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 27093)
-- Name: student_phone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_phone (
    phone_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.student_phone OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 27241)
-- Name: student_sibling_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.student_sibling_summary AS
 SELECT COALESCE(sc.numberofsiblings, (0)::bigint) AS "No of Siblings",
    count(*) AS "No of Students"
   FROM (public.student s
     LEFT JOIN ( SELECT sb.student_id,
            count(sb.sibling_id) AS numberofsiblings
           FROM public.sibling sb
          GROUP BY sb.student_id
         HAVING (count(sb.sibling_id) <= 2)) sc ON ((s.student_id = sc.student_id)))
  GROUP BY sc.numberofsiblings
  ORDER BY COALESCE(sc.numberofsiblings, (0)::bigint);


ALTER VIEW public.student_sibling_summary OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 27078)
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.student ALTER COLUMN student_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.student_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 27099)
-- Name: timeslot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timeslot (
    timeslot_id integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    day_of_week public.day_of_week NOT NULL
);


ALTER TABLE public.timeslot OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 27098)
-- Name: timeslot_timeslot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.timeslot ALTER COLUMN timeslot_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.timeslot_timeslot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 254 (class 1259 OID 27271)
-- Name: upcoming_ensembles; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.upcoming_ensembles AS
 SELECT to_char((e.planed_date)::timestamp with time zone, 'Day'::text) AS day,
    e.target_genre AS genre,
        CASE
            WHEN ((e.maximum_students - count(b.booking_id)) = 0) THEN 'No Seats'::text
            WHEN ((e.maximum_students - count(b.booking_id)) <= 2) THEN '1 or 2 Seats'::text
            ELSE 'Many Seats'::text
        END AS "No of Free Seats"
   FROM (public.ensemble e
     LEFT JOIN public.booking b ON (((e.ensemble_id = b.lesson_id) AND ((b.lesson_type)::text = 'Ensemble'::text))))
  WHERE ((e.planed_date >= CURRENT_DATE) AND (e.planed_date < (CURRENT_DATE + '7 days'::interval)))
  GROUP BY e.planed_date, e.ensemble_id, e.target_genre, e.maximum_students
  ORDER BY e.planed_date, e.target_genre;


ALTER VIEW public.upcoming_ensembles OWNER TO postgres;

--
-- TOC entry 3546 (class 0 OID 27010)
-- Dependencies: 216
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address (address_id, street, zip, city) FROM stdin;
1	123 Elm St	12345	Musicville
2	456 Oak St	54321	Harmonytown
\.


--
-- TOC entry 3579 (class 0 OID 27127)
-- Dependencies: 249
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking (booking_id, student_id, lesson_id, lesson_type, instructor_timeslot_id, booking_date, price_info_id) FROM stdin;
2	2	2	Group	2	2023-11-25	2
5	1	2	Ensemble	1	2023-10-10	1
12	2	1	Individual	2	2023-09-30	2
1	1	1	Individual	1	2023-12-04	1
8	2	1	Ensemble	2	2023-12-06	2
9	1	1	Individual	1	2023-12-09	1
6	2	1	Individual	2	2023-12-22	2
7	1	2	Group	1	2023-12-26	1
3	1	1	Individual	1	2023-12-15	1
10	2	2	Group	2	2023-12-18	2
4	2	2	Group	2	2023-12-20	2
11	1	2	Ensemble	1	2023-12-25	1
17	15	18	Ensemble	1	2023-12-06	3
18	9	18	Ensemble	1	2023-12-06	3
19	7	13	Ensemble	2	2023-12-04	3
20	4	13	Ensemble	2	2023-12-04	3
\.


--
-- TOC entry 3548 (class 0 OID 27016)
-- Dependencies: 218
-- Data for Name: contact_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_person (contact_person_id, full_name, phone_number, email_address, relationship) FROM stdin;
1	John Doe	123-456-7890	johndoe@email.com	Father
2	Jane Smith	098-765-4321	janesmith@email.com	Mother
\.


--
-- TOC entry 3550 (class 0 OID 27022)
-- Dependencies: 220
-- Data for Name: ensemble; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ensemble (ensemble_id, minimum_students, maximum_students, target_genre, room, planed_date) FROM stdin;
1	5	10	Punk Rock	Room 101	2023-12-03
2	4	8	Gospel Band	Room 102	2023-12-04
13	4	4	Gospel Band	E1	2023-12-04
14	5	10	Punk Rock	E2	2023-12-06
15	6	15	Gospel Band	E3	2023-12-07
16	3	8	Punk Rock	E4	2023-12-04
17	7	14	Gospel Band	E5	2023-12-05
18	2	2	Punk Rock	E6	2023-12-06
19	5	11	Gospel Band	E7	2023-12-07
20	6	10	Punk Rock	E8	2023-12-04
21	3	12	Gospel Band	E9	2023-12-07
22	5	10	Punk Rock	E10	2023-12-08
\.


--
-- TOC entry 3552 (class 0 OID 27028)
-- Dependencies: 222
-- Data for Name: group_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_lesson (group_lesson_id, number_of_places, minimum_enrollment, instrument, room, planed_date) FROM stdin;
1	15	5	Guitar	Room 201	2023-12-05
2	12	4	Piano	Room 202	2023-12-06
3	10	5	Guitar	Room 201	2023-12-04
4	12	6	Piano	Room 202	2023-11-02
5	8	4	Violin	Room 203	2023-11-03
6	15	7	Drums	Room 204	2023-11-04
7	9	5	Other	Room 205	2023-11-05
8	10	5	Guitar	Room 206	2023-10-06
9	12	6	Piano	Room 207	2023-10-07
10	8	4	Violin	Room 208	2023-10-08
11	15	7	Drums	Room 209	2023-10-09
12	9	5	Other	Room 210	2023-10-10
\.


--
-- TOC entry 3580 (class 0 OID 27266)
-- Dependencies: 253
-- Data for Name: historical_student_lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historical_student_lessons (lesson_id, lesson_type, genre, instrument, lesson_price, student_name, student_email, booking_date) FROM stdin;
2	Group	\N	Piano	35.00	Diana Doe	dianad@email.com	2023-11-25
2	Ensemble	Gospel Band	\N	50.00	Charlie Chaplin	charliec@email.com	2023-10-10
1	Individual	\N	Violin	35.00	Diana Doe	dianad@email.com	2023-09-30
1	Individual	\N	Violin	50.00	Charlie Chaplin	charliec@email.com	2023-12-04
1	Ensemble	Punk Rock	\N	35.00	Diana Doe	dianad@email.com	2023-12-06
1	Individual	\N	Violin	50.00	Charlie Chaplin	charliec@email.com	2023-12-09
1	Individual	\N	Violin	35.00	Diana Doe	dianad@email.com	2023-12-22
2	Group	\N	Piano	50.00	Charlie Chaplin	charliec@email.com	2023-12-26
1	Individual	\N	Violin	50.00	Charlie Chaplin	charliec@email.com	2023-12-15
2	Group	\N	Piano	35.00	Diana Doe	dianad@email.com	2023-12-18
2	Group	\N	Piano	35.00	Diana Doe	dianad@email.com	2023-12-20
2	Ensemble	Gospel Band	\N	50.00	Charlie Chaplin	charliec@email.com	2023-12-25
18	Ensemble	Punk Rock	\N	30.00	Liam Williams	liamwilliams@email.com	2023-12-06
18	Ensemble	Punk Rock	\N	30.00	Laura Lee	laural@email.com	2023-12-06
13	Ensemble	Gospel Band	\N	30.00	Olivia Olsen	oliviao@email.com	2023-12-04
13	Ensemble	Gospel Band	\N	30.00	Michael Moore	michaelm@email.com	2023-12-04
\.


--
-- TOC entry 3554 (class 0 OID 27034)
-- Dependencies: 224
-- Data for Name: individual_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.individual_lesson (individual_lesson_id, instrument, room, planed_date) FROM stdin;
1	Violin	Room 301	2023-12-07
2	Drums	Room 302	2023-12-08
3	Guitar	Room 101	2023-12-04
4	Piano	Room 102	2023-12-05
5	Violin	Room 103	2023-11-03
6	Drums	Room 104	2023-11-04
7	Other	Room 105	2023-11-05
8	Guitar	Room 106	2023-12-06
9	Piano	Room 107	2023-10-07
10	Violin	Room 108	2023-10-08
11	Drums	Room 109	2023-10-09
12	Other	Room 110	2023-10-10
\.


--
-- TOC entry 3556 (class 0 OID 27040)
-- Dependencies: 226
-- Data for Name: instructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor (instructor_id, can_teach_ensemble, person_number, first_name, last_name, email_address) FROM stdin;
1	t	IN123456	Alice	Anderson	alicea@email.com
2	f	IN654321	Bob	Brown	bobb@email.com
3	t	IN123546	Alex	Anderson	alicea@email.com
4	f	IN614325	Zia	Brown	zibb@email.com
\.


--
-- TOC entry 3557 (class 0 OID 27047)
-- Dependencies: 227
-- Data for Name: instructor_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_address (instructor_id, address_id) FROM stdin;
1	1
2	2
\.


--
-- TOC entry 3559 (class 0 OID 27053)
-- Dependencies: 229
-- Data for Name: instructor_instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_instrument (instructor_instrument_id, instructor_id, instrument) FROM stdin;
1	1	Guitar
2	2	Piano
\.


--
-- TOC entry 3572 (class 0 OID 27104)
-- Dependencies: 242
-- Data for Name: instructor_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_phone (instructor_id, phone_id) FROM stdin;
1	1
2	2
\.


--
-- TOC entry 3574 (class 0 OID 27110)
-- Dependencies: 244
-- Data for Name: instructor_timeslot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor_timeslot (instructor_timeslot_id, is_available, timeslot_id, instructor_id) FROM stdin;
1	t	1	1
2	t	2	2
\.


--
-- TOC entry 3561 (class 0 OID 27059)
-- Dependencies: 231
-- Data for Name: instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrument (instrument_id, instrument_type, brand, quantity_in_stock, price) FROM stdin;
1	Guitar	Gibson	5	500
2	Piano	Yamaha	3	1500
\.


--
-- TOC entry 3576 (class 0 OID 27116)
-- Dependencies: 246
-- Data for Name: instrument_rental; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrument_rental (rental_id, instrument_id, student_id, rental_start_date, rental_end_date, is_rental_active) FROM stdin;
1	1	2	2023-11-01	2023-12-01	t
2	2	1	2023-11-15	2023-12-15	t
\.


--
-- TOC entry 3563 (class 0 OID 27065)
-- Dependencies: 233
-- Data for Name: phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phone (phone_id, phone_number) FROM stdin;
1	555-1234
2	555-5678
\.


--
-- TOC entry 3565 (class 0 OID 27073)
-- Dependencies: 235
-- Data for Name: price_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.price_info (price_info_id, lesson_type, base_price, lesson_skill_level, valid_from, valid_until) FROM stdin;
1	Individual	50.00	Beginner	2023-11-30 00:00:00	\N
2	Group	35.00	Intermediate	2023-11-30 00:00:00	\N
3	Ensemble	30.00	Intermediate	2023-11-30 00:00:00	\N
\.


--
-- TOC entry 3577 (class 0 OID 27121)
-- Dependencies: 247
-- Data for Name: sibling; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sibling (student_id, sibling_id) FROM stdin;
1	2
2	1
3	4
5	6
7	8
9	10
11	12
2	6
9	5
9	8
1	4
1	3
\.


--
-- TOC entry 3567 (class 0 OID 27079)
-- Dependencies: 237
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (student_id, enrollment_date, rental_limit, contact_person_id, instrument_skill_level, person_number, first_name, last_name, email_address) FROM stdin;
1	2023-09-01	2	1	Beginner	ST123456	Charlie	Chaplin	charliec@email.com
2	2023-09-15	3	2	Intermediate	ST654321	Diana	Doe	dianad@email.com
3	2023-01-10	2	1	Beginner	ST000001	Emily	Evans	emilye@email.com
4	2023-01-15	1	2	Intermediate	ST000002	Michael	Moore	michaelm@email.com
5	2023-02-01	3	1	Advanced	ST000003	Sarah	Smith	sarahs@email.com
6	2023-02-20	2	2	Beginner	ST000004	Alex	Anderson	alexa@email.com
7	2023-03-05	1	1	Intermediate	ST000005	Olivia	Olsen	oliviao@email.com
8	2023-03-15	3	2	Advanced	ST000006	Daniel	Davis	danield@email.com
9	2023-04-01	2	1	Beginner	ST000007	Laura	Lee	laural@email.com
10	2023-04-10	1	2	Intermediate	ST000008	George	Green	georgeg@email.com
11	2023-05-05	3	1	Advanced	ST000009	Fiona	Foster	fionaf@email.com
12	2023-05-20	2	2	Beginner	ST000010	Henry	Hill	henryh@email.com
14	2023-09-01	2	1	Beginner	ST100001	Emma	Johnson	emmajohnson@email.com
15	2023-09-15	3	2	Intermediate	ST100002	Liam	Williams	liamwilliams@email.com
16	2023-10-01	1	1	Advanced	ST100003	Olivia	Brown	oliviabrown@email.com
17	2023-10-20	2	2	Beginner	ST100004	Noah	Jones	noahjones@email.com
18	2023-11-05	1	1	Intermediate	ST100005	Ava	Miller	avamiller@email.com
\.


--
-- TOC entry 3568 (class 0 OID 27088)
-- Dependencies: 238
-- Data for Name: student_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_address (address_id, student_id) FROM stdin;
1	1
2	2
\.


--
-- TOC entry 3569 (class 0 OID 27093)
-- Dependencies: 239
-- Data for Name: student_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_phone (phone_id, student_id) FROM stdin;
1	1
2	2
\.


--
-- TOC entry 3571 (class 0 OID 27099)
-- Dependencies: 241
-- Data for Name: timeslot; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timeslot (timeslot_id, start_time, end_time, day_of_week) FROM stdin;
1	08:00:00	10:00:00	Monday
2	10:00:00	12:00:00	Tuesday
\.


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 215
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_address_id_seq', 2, true);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 248
-- Name: booking_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_booking_id_seq', 20, true);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 217
-- Name: contact_person_contact_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_person_contact_person_id_seq', 2, true);


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 219
-- Name: ensemble_ensemble_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ensemble_ensemble_id_seq', 22, true);


--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 221
-- Name: group_lesson_group_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_lesson_group_lesson_id_seq', 12, true);


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 223
-- Name: individual_lesson_individual_lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.individual_lesson_individual_lesson_id_seq', 12, true);


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 225
-- Name: instructor_instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_instructor_id_seq', 4, true);


--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 228
-- Name: instructor_instrument_instructor_instrument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_instrument_instructor_instrument_id_seq', 2, true);


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 243
-- Name: instructor_timeslot_instructor_timeslot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_timeslot_instructor_timeslot_id_seq', 2, true);


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 230
-- Name: instrument_instrument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrument_instrument_id_seq', 2, true);


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 245
-- Name: instrument_rental_rental_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrument_rental_rental_id_seq', 2, true);


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 232
-- Name: phone_phone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phone_phone_id_seq', 2, true);


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 234
-- Name: price_info_price_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.price_info_price_info_id_seq', 3, true);


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 236
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_student_id_seq', 18, true);


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 240
-- Name: timeslot_timeslot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timeslot_timeslot_id_seq', 2, true);


--
-- TOC entry 3378 (class 2606 OID 27270)
-- Name: historical_student_lessons historical_student_lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historical_student_lessons
    ADD CONSTRAINT historical_student_lessons_pkey PRIMARY KEY (lesson_id, student_name, booking_date);


--
-- TOC entry 3342 (class 2606 OID 27044)
-- Name: instructor instructor_person_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_person_number_key UNIQUE (person_number);


--
-- TOC entry 3352 (class 2606 OID 27069)
-- Name: phone phone_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone
    ADD CONSTRAINT phone_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 3332 (class 2606 OID 27014)
-- Name: address pk_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT pk_address PRIMARY KEY (address_id);


--
-- TOC entry 3376 (class 2606 OID 27131)
-- Name: booking pk_booking; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT pk_booking PRIMARY KEY (booking_id, student_id, lesson_id);


--
-- TOC entry 3334 (class 2606 OID 27020)
-- Name: contact_person pk_contact_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_person
    ADD CONSTRAINT pk_contact_person PRIMARY KEY (contact_person_id);


--
-- TOC entry 3336 (class 2606 OID 27026)
-- Name: ensemble pk_ensemble; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ensemble
    ADD CONSTRAINT pk_ensemble PRIMARY KEY (ensemble_id);


--
-- TOC entry 3338 (class 2606 OID 27032)
-- Name: group_lesson pk_group_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_lesson
    ADD CONSTRAINT pk_group_lesson PRIMARY KEY (group_lesson_id);


--
-- TOC entry 3340 (class 2606 OID 27038)
-- Name: individual_lesson pk_individual_lesson; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.individual_lesson
    ADD CONSTRAINT pk_individual_lesson PRIMARY KEY (individual_lesson_id);


--
-- TOC entry 3344 (class 2606 OID 27046)
-- Name: instructor pk_instructor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT pk_instructor PRIMARY KEY (instructor_id);


--
-- TOC entry 3346 (class 2606 OID 27051)
-- Name: instructor_address pk_instructor_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_address
    ADD CONSTRAINT pk_instructor_address PRIMARY KEY (instructor_id, address_id);


--
-- TOC entry 3348 (class 2606 OID 27057)
-- Name: instructor_instrument pk_instructor_instrument; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_instrument
    ADD CONSTRAINT pk_instructor_instrument PRIMARY KEY (instructor_instrument_id, instructor_id);


--
-- TOC entry 3368 (class 2606 OID 27108)
-- Name: instructor_phone pk_instructor_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_phone
    ADD CONSTRAINT pk_instructor_phone PRIMARY KEY (instructor_id, phone_id);


--
-- TOC entry 3370 (class 2606 OID 27114)
-- Name: instructor_timeslot pk_instructor_timeslot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_timeslot
    ADD CONSTRAINT pk_instructor_timeslot PRIMARY KEY (instructor_timeslot_id);


--
-- TOC entry 3350 (class 2606 OID 27063)
-- Name: instrument pk_instrument; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument
    ADD CONSTRAINT pk_instrument PRIMARY KEY (instrument_id);


--
-- TOC entry 3372 (class 2606 OID 27120)
-- Name: instrument_rental pk_instrument_rental; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument_rental
    ADD CONSTRAINT pk_instrument_rental PRIMARY KEY (rental_id, instrument_id, student_id);


--
-- TOC entry 3354 (class 2606 OID 27071)
-- Name: phone pk_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phone
    ADD CONSTRAINT pk_phone PRIMARY KEY (phone_id);


--
-- TOC entry 3356 (class 2606 OID 27077)
-- Name: price_info pk_price_info; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_info
    ADD CONSTRAINT pk_price_info PRIMARY KEY (price_info_id);


--
-- TOC entry 3374 (class 2606 OID 27125)
-- Name: sibling pk_sibling; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sibling
    ADD CONSTRAINT pk_sibling PRIMARY KEY (student_id, sibling_id);


--
-- TOC entry 3358 (class 2606 OID 27087)
-- Name: student pk_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT pk_student PRIMARY KEY (student_id);


--
-- TOC entry 3362 (class 2606 OID 27092)
-- Name: student_address pk_student_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_address
    ADD CONSTRAINT pk_student_address PRIMARY KEY (address_id, student_id);


--
-- TOC entry 3364 (class 2606 OID 27097)
-- Name: student_phone pk_student_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phone
    ADD CONSTRAINT pk_student_phone PRIMARY KEY (phone_id, student_id);


--
-- TOC entry 3366 (class 2606 OID 27103)
-- Name: timeslot pk_timeslot; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timeslot
    ADD CONSTRAINT pk_timeslot PRIMARY KEY (timeslot_id);


--
-- TOC entry 3360 (class 2606 OID 27085)
-- Name: student student_person_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_person_number_key UNIQUE (person_number);


--
-- TOC entry 3395 (class 2606 OID 27212)
-- Name: booking fk_booking_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_booking_0 FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 3396 (class 2606 OID 27217)
-- Name: booking fk_booking_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_booking_1 FOREIGN KEY (instructor_timeslot_id) REFERENCES public.instructor_timeslot(instructor_timeslot_id);


--
-- TOC entry 3397 (class 2606 OID 27222)
-- Name: booking fk_booking_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT fk_booking_2 FOREIGN KEY (price_info_id) REFERENCES public.price_info(price_info_id);


--
-- TOC entry 3379 (class 2606 OID 27132)
-- Name: instructor_address fk_instructor_address_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_address
    ADD CONSTRAINT fk_instructor_address_0 FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);


--
-- TOC entry 3380 (class 2606 OID 27137)
-- Name: instructor_address fk_instructor_address_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_address
    ADD CONSTRAINT fk_instructor_address_1 FOREIGN KEY (address_id) REFERENCES public.address(address_id);


--
-- TOC entry 3381 (class 2606 OID 27142)
-- Name: instructor_instrument fk_instructor_instrument_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_instrument
    ADD CONSTRAINT fk_instructor_instrument_0 FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);


--
-- TOC entry 3387 (class 2606 OID 27172)
-- Name: instructor_phone fk_instructor_phone_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_phone
    ADD CONSTRAINT fk_instructor_phone_0 FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);


--
-- TOC entry 3388 (class 2606 OID 27177)
-- Name: instructor_phone fk_instructor_phone_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_phone
    ADD CONSTRAINT fk_instructor_phone_1 FOREIGN KEY (phone_id) REFERENCES public.phone(phone_id);


--
-- TOC entry 3389 (class 2606 OID 27182)
-- Name: instructor_timeslot fk_instructor_timeslot_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_timeslot
    ADD CONSTRAINT fk_instructor_timeslot_0 FOREIGN KEY (timeslot_id) REFERENCES public.timeslot(timeslot_id);


--
-- TOC entry 3390 (class 2606 OID 27187)
-- Name: instructor_timeslot fk_instructor_timeslot_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instructor_timeslot
    ADD CONSTRAINT fk_instructor_timeslot_1 FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id);


--
-- TOC entry 3391 (class 2606 OID 27192)
-- Name: instrument_rental fk_instrument_rental_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument_rental
    ADD CONSTRAINT fk_instrument_rental_0 FOREIGN KEY (instrument_id) REFERENCES public.instrument(instrument_id);


--
-- TOC entry 3392 (class 2606 OID 27197)
-- Name: instrument_rental fk_instrument_rental_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument_rental
    ADD CONSTRAINT fk_instrument_rental_1 FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 3393 (class 2606 OID 27202)
-- Name: sibling fk_sibling_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sibling
    ADD CONSTRAINT fk_sibling_0 FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 3394 (class 2606 OID 27207)
-- Name: sibling fk_sibling_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sibling
    ADD CONSTRAINT fk_sibling_1 FOREIGN KEY (sibling_id) REFERENCES public.student(student_id);


--
-- TOC entry 3382 (class 2606 OID 27147)
-- Name: student fk_student_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fk_student_0 FOREIGN KEY (contact_person_id) REFERENCES public.contact_person(contact_person_id);


--
-- TOC entry 3383 (class 2606 OID 27152)
-- Name: student_address fk_student_address_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_address
    ADD CONSTRAINT fk_student_address_0 FOREIGN KEY (address_id) REFERENCES public.address(address_id);


--
-- TOC entry 3384 (class 2606 OID 27157)
-- Name: student_address fk_student_address_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_address
    ADD CONSTRAINT fk_student_address_1 FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 3385 (class 2606 OID 27162)
-- Name: student_phone fk_student_phone_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phone
    ADD CONSTRAINT fk_student_phone_0 FOREIGN KEY (phone_id) REFERENCES public.phone(phone_id);


--
-- TOC entry 3386 (class 2606 OID 27167)
-- Name: student_phone fk_student_phone_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_phone
    ADD CONSTRAINT fk_student_phone_1 FOREIGN KEY (student_id) REFERENCES public.student(student_id);


-- Completed on 2023-12-04 21:15:53 UTC

--
-- PostgreSQL database dump complete
--

