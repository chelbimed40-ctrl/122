--
-- PostgreSQL database dump
--

\restrict 5ZPTiChXRQHhJy2UavO2QcOjbMKVunK5CgJFGnQz7h1T58eGSS3Iy6L60JbhaIc

-- Dumped from database version 15.19 (Debian 15.19-0+deb12u1)
-- Dumped by pg_dump version 15.19 (Debian 15.19-0+deb12u1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answer_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer_images (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    student_id integer NOT NULL,
    session_id integer NOT NULL,
    question_id integer NOT NULL,
    file_key character varying(64) NOT NULL,
    mime character varying(40) NOT NULL,
    bytes integer NOT NULL,
    data bytea NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    annotated_data bytea,
    annotated_at timestamp with time zone
);


ALTER TABLE public.answer_images OWNER TO postgres;

--
-- Name: answer_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answer_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_images_id_seq OWNER TO postgres;

--
-- Name: answer_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answer_images_id_seq OWNED BY public.answer_images.id;


--
-- Name: exercise_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercise_answers (
    id integer NOT NULL,
    attempt_id integer NOT NULL,
    question_id integer NOT NULL,
    selected_indices jsonb,
    selected_bool boolean,
    is_correct boolean DEFAULT false NOT NULL,
    awarded_points real DEFAULT 0 NOT NULL
);


ALTER TABLE public.exercise_answers OWNER TO postgres;

--
-- Name: exercise_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercise_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercise_answers_id_seq OWNER TO postgres;

--
-- Name: exercise_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercise_answers_id_seq OWNED BY public.exercise_answers.id;


--
-- Name: exercise_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercise_attempts (
    id integer NOT NULL,
    exercise_id integer NOT NULL,
    student_id integer NOT NULL,
    total_points real DEFAULT 0 NOT NULL,
    max_points real DEFAULT 0 NOT NULL,
    correct_count integer DEFAULT 0 NOT NULL,
    wrong_count integer DEFAULT 0 NOT NULL,
    total_questions integer DEFAULT 0 NOT NULL,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    finished_at timestamp with time zone
);


ALTER TABLE public.exercise_attempts OWNER TO postgres;

--
-- Name: exercise_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercise_attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercise_attempts_id_seq OWNER TO postgres;

--
-- Name: exercise_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercise_attempts_id_seq OWNED BY public.exercise_attempts.id;


--
-- Name: exercise_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercise_questions (
    id integer NOT NULL,
    exercise_id integer NOT NULL,
    order_index integer DEFAULT 0 NOT NULL,
    prompt text NOT NULL,
    prompt_image_url text,
    type character varying(12) DEFAULT 'qcm'::character varying NOT NULL,
    options jsonb,
    correct_indices jsonb,
    correct_bool boolean,
    multiple_answers boolean DEFAULT false NOT NULL,
    points integer DEFAULT 1 NOT NULL,
    explanation text DEFAULT ''::text
);


ALTER TABLE public.exercise_questions OWNER TO postgres;

--
-- Name: exercise_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercise_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercise_questions_id_seq OWNER TO postgres;

--
-- Name: exercise_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercise_questions_id_seq OWNED BY public.exercise_questions.id;


--
-- Name: exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercises (
    id integer NOT NULL,
    teacher_id integer NOT NULL,
    group_id integer,
    title character varying(200) NOT NULL,
    description text DEFAULT ''::text,
    type character varying(12) DEFAULT 'qcm'::character varying NOT NULL,
    time_limit_min integer DEFAULT 0 NOT NULL,
    show_correction boolean DEFAULT false NOT NULL,
    status character varying(12) DEFAULT 'draft'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    published_at timestamp with time zone,
    closed_at timestamp with time zone
);


ALTER TABLE public.exercises OWNER TO postgres;

--
-- Name: exercises_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercises_id_seq OWNER TO postgres;

--
-- Name: exercises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercises_id_seq OWNED BY public.exercises.id;


--
-- Name: grade_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grade_audit (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    session_id integer NOT NULL,
    question_id integer NOT NULL,
    student_id integer NOT NULL,
    teacher_id integer NOT NULL,
    old_points real NOT NULL,
    new_points real NOT NULL,
    feedback text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.grade_audit OWNER TO postgres;

--
-- Name: grade_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.grade_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grade_audit_id_seq OWNER TO postgres;

--
-- Name: grade_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.grade_audit_id_seq OWNED BY public.grade_audit.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    teacher_id integer NOT NULL,
    name character varying(140) NOT NULL,
    grade character varying(80) DEFAULT ''::character varying,
    invite_token character varying(40) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.memberships (
    id integer NOT NULL,
    group_id integer NOT NULL,
    student_id integer NOT NULL,
    status character varying(12) DEFAULT 'pending'::character varying NOT NULL,
    cumulative_points real DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    approved_at timestamp with time zone
);


ALTER TABLE public.memberships OWNER TO postgres;

--
-- Name: memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.memberships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.memberships_id_seq OWNER TO postgres;

--
-- Name: memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.memberships_id_seq OWNED BY public.memberships.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participants (
    id integer NOT NULL,
    session_id integer NOT NULL,
    student_id integer NOT NULL,
    total_points real DEFAULT 0 NOT NULL,
    correct_count integer DEFAULT 0 NOT NULL,
    answered_count integer DEFAULT 0 NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.participants OWNER TO postgres;

--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.participants_id_seq OWNER TO postgres;

--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participants_id_seq OWNED BY public.participants.id;


--
-- Name: poll_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poll_votes (
    id integer NOT NULL,
    poll_id integer NOT NULL,
    student_id integer NOT NULL,
    option_index integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.poll_votes OWNER TO postgres;

--
-- Name: poll_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.poll_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.poll_votes_id_seq OWNER TO postgres;

--
-- Name: poll_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.poll_votes_id_seq OWNED BY public.poll_votes.id;


--
-- Name: polls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.polls (
    id integer NOT NULL,
    teacher_id integer NOT NULL,
    group_id integer NOT NULL,
    question text NOT NULL,
    options jsonb NOT NULL,
    status character varying(8) DEFAULT 'open'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    closed_at timestamp with time zone
);


ALTER TABLE public.polls OWNER TO postgres;

--
-- Name: polls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.polls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polls_id_seq OWNER TO postgres;

--
-- Name: polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.polls_id_seq OWNED BY public.polls.id;


--
-- Name: question_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_images (
    id integer NOT NULL,
    question_id integer NOT NULL,
    file_key character varying(64) NOT NULL,
    mime character varying(40) NOT NULL,
    bytes integer NOT NULL,
    order_index integer DEFAULT 0 NOT NULL,
    data bytea NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.question_images OWNER TO postgres;

--
-- Name: question_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_images_id_seq OWNER TO postgres;

--
-- Name: question_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_images_id_seq OWNED BY public.question_images.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    quiz_id integer NOT NULL,
    order_index integer DEFAULT 0 NOT NULL,
    type character varying(12) NOT NULL,
    prompt text NOT NULL,
    points integer DEFAULT 1 NOT NULL,
    options jsonb,
    correct_option integer,
    correct_bool boolean,
    correct_number text,
    tolerance text DEFAULT '0'::text,
    accepted_answers jsonb,
    allow_images boolean DEFAULT false NOT NULL,
    max_images integer DEFAULT 3 NOT NULL,
    allow_explanation boolean DEFAULT true NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quizzes (
    id integer NOT NULL,
    teacher_id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text DEFAULT ''::text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.quizzes OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quizzes_id_seq OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    quiz_id integer NOT NULL,
    group_id integer NOT NULL,
    teacher_id integer NOT NULL,
    code character varying(8) NOT NULL,
    status character varying(12) DEFAULT 'lobby'::character varying NOT NULL,
    current_index integer DEFAULT '-1'::integer NOT NULL,
    time_limit_sec integer DEFAULT 60 NOT NULL,
    question_started_at timestamp with time zone,
    started_at timestamp with time zone,
    ended_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    password_hash text DEFAULT ''::text NOT NULL,
    login_code character varying(3)
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submissions (
    id integer NOT NULL,
    session_id integer NOT NULL,
    question_id integer NOT NULL,
    student_id integer NOT NULL,
    answer_option integer,
    answer_bool boolean,
    answer_number text,
    answer_text text,
    needs_manual boolean DEFAULT false NOT NULL,
    is_correct boolean,
    awarded_points real DEFAULT 0 NOT NULL,
    submitted_at timestamp with time zone DEFAULT now() NOT NULL,
    graded_at timestamp with time zone,
    graded_by integer,
    feedback text DEFAULT ''::text NOT NULL,
    review_status character varying(16) DEFAULT 'pending'::character varying NOT NULL,
    grade_released boolean DEFAULT false NOT NULL
);


ALTER TABLE public.submissions OWNER TO postgres;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.submissions_id_seq OWNER TO postgres;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    username character varying(60) NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    reset_token character varying(64),
    reset_token_expiry timestamp with time zone
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teachers_id_seq OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- Name: answer_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_images ALTER COLUMN id SET DEFAULT nextval('public.answer_images_id_seq'::regclass);


--
-- Name: exercise_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_answers ALTER COLUMN id SET DEFAULT nextval('public.exercise_answers_id_seq'::regclass);


--
-- Name: exercise_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_attempts ALTER COLUMN id SET DEFAULT nextval('public.exercise_attempts_id_seq'::regclass);


--
-- Name: exercise_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_questions ALTER COLUMN id SET DEFAULT nextval('public.exercise_questions_id_seq'::regclass);


--
-- Name: exercises id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises ALTER COLUMN id SET DEFAULT nextval('public.exercises_id_seq'::regclass);


--
-- Name: grade_audit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade_audit ALTER COLUMN id SET DEFAULT nextval('public.grade_audit_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: memberships id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships ALTER COLUMN id SET DEFAULT nextval('public.memberships_id_seq'::regclass);


--
-- Name: participants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participants ALTER COLUMN id SET DEFAULT nextval('public.participants_id_seq'::regclass);


--
-- Name: poll_votes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_votes ALTER COLUMN id SET DEFAULT nextval('public.poll_votes_id_seq'::regclass);


--
-- Name: polls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polls ALTER COLUMN id SET DEFAULT nextval('public.polls_id_seq'::regclass);


--
-- Name: question_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_images ALTER COLUMN id SET DEFAULT nextval('public.question_images_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Data for Name: answer_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answer_images (id, submission_id, student_id, session_id, question_id, file_key, mime, bytes, data, created_at, annotated_data, annotated_at) FROM stdin;
\.


--
-- Data for Name: exercise_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_answers (id, attempt_id, question_id, selected_indices, selected_bool, is_correct, awarded_points) FROM stdin;
\.


--
-- Data for Name: exercise_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_attempts (id, exercise_id, student_id, total_points, max_points, correct_count, wrong_count, total_questions, started_at, finished_at) FROM stdin;
\.


--
-- Data for Name: exercise_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercise_questions (id, exercise_id, order_index, prompt, prompt_image_url, type, options, correct_indices, correct_bool, multiple_answers, points, explanation) FROM stdin;
4	3	0	4+3=12	\N	tf	\N	\N	f	f	1	
5	3	1	6+8=14	\N	tf	\N	\N	t	f	1	
6	3	2	22-2=12	\N	tf	\N	\N	f	f	1	
7	4	0	1+3=	\N	qcm	["4", "2", "7", "0"]	[0]	\N	f	1	
\.


--
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (id, teacher_id, group_id, title, description, type, time_limit_min, show_correction, status, created_at, published_at, closed_at) FROM stdin;
3	3	\N	تمرين مراجعة		tf	0	t	published	2026-10-27 14:10:19.95591+00	2026-10-27 14:14:54.942+00	\N
4	3	\N	تمريين		qcm	0	t	published	2026-10-27 14:19:30.930274+00	2026-10-27 19:34:09.884+00	\N
\.


--
-- Data for Name: grade_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grade_audit (id, submission_id, session_id, question_id, student_id, teacher_id, old_points, new_points, feedback, created_at) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, teacher_id, name, grade, invite_token, created_at) FROM stdin;
10	3	تحدي الابطال	السابعة أساسي	6603	2026-10-24 12:30:17.519142+00
12	3	نحو التميز	التاسعة أساسي	4854	2026-10-24 12:30:58.778869+00
11	3	لنتفوق في الرياضيات	الثامنة أساسي	9327	2026-10-24 12:30:42.169443+00
\.


--
-- Data for Name: memberships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.memberships (id, group_id, student_id, status, cumulative_points, created_at, approved_at) FROM stdin;
13	10	16	approved	0	2026-10-24 17:38:40.14516+00	2026-10-24 17:39:37.335+00
12	10	15	approved	0	2026-10-24 17:36:34.1641+00	2026-10-24 17:39:38.738+00
14	10	17	approved	0	2026-10-24 17:40:54.587081+00	2026-10-24 17:42:02.158+00
15	11	18	approved	0	2026-10-24 17:51:03.006264+00	2026-10-24 17:51:26.72+00
16	11	19	approved	0	2026-10-24 18:00:36.649565+00	2026-10-24 18:17:37.835+00
17	10	20	approved	0	2026-10-24 18:14:56.765065+00	2026-10-24 18:18:18.717+00
18	12	21	approved	0	2026-10-24 18:50:25.119866+00	2026-10-24 18:52:10.826+00
20	12	23	approved	0	2026-10-24 18:51:00.69026+00	2026-10-24 18:52:11.775+00
22	12	25	approved	0	2026-10-24 18:52:02.795786+00	2026-10-24 18:52:12.595+00
21	12	24	approved	0	2026-10-24 18:51:40.086005+00	2026-10-24 18:52:14.34+00
23	12	26	rejected	0	2026-10-24 20:04:32.963359+00	\N
25	11	28	approved	0	2026-10-24 20:08:38.822731+00	2026-10-24 20:12:51.714+00
24	10	27	approved	0	2026-10-24 20:08:37.308597+00	2026-10-24 20:13:13.006+00
27	12	30	approved	0	2026-10-24 20:18:04.397758+00	2026-10-24 20:18:35.385+00
26	12	29	approved	0	2026-10-24 20:15:15.363933+00	2026-10-24 20:18:36.521+00
28	12	31	approved	0	2026-10-24 21:33:44.214224+00	2026-10-24 21:36:19.16+00
33	10	14	rejected	0	2026-10-26 15:32:25.5249+00	\N
36	11	34	approved	0	2026-10-26 16:40:00.531185+00	2026-10-26 16:41:23.541+00
35	11	22	rejected	0	2026-10-26 16:38:36.186251+00	\N
37	12	35	rejected	0	2026-10-26 16:42:13.375509+00	\N
34	12	33	rejected	0	2026-10-26 16:38:01.324567+00	\N
40	12	38	approved	0	2026-10-26 17:04:18.04413+00	2026-10-26 17:24:29.396+00
39	12	37	approved	0	2026-10-26 16:50:29.420225+00	2026-10-26 17:24:30.794+00
38	11	36	approved	0	2026-10-26 16:50:06.898034+00	2026-10-26 17:24:50.174+00
41	12	39	approved	0	2026-10-26 17:26:19.619566+00	2026-10-26 17:33:59.935+00
42	12	40	approved	0	2026-10-26 18:27:18.461788+00	2026-10-26 19:38:11.267+00
43	12	41	approved	0	2026-10-26 19:40:16.368816+00	2026-10-26 19:43:52.215+00
44	12	42	approved	0	2026-10-26 20:04:55.203336+00	2026-10-26 20:08:37.721+00
49	10	45	rejected	0	2026-10-29 20:32:39.194338+00	\N
50	10	46	approved	0	2026-10-29 20:42:11.087269+00	2026-10-29 20:42:35.423+00
53	10	49	approved	0	2026-11-02 06:47:33.254106+00	2026-11-02 06:47:48.31+00
55	10	51	rejected	0	2026-11-02 22:41:51.224391+00	\N
57	10	53	rejected	0	2026-11-02 23:38:37.676255+00	\N
59	10	55	approved	0	2026-11-03 05:55:26.676433+00	2026-11-03 05:55:43.964+00
60	10	56	approved	1	2026-11-03 05:56:42.724955+00	2026-11-03 05:57:01.767+00
\.


--
-- Data for Name: participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participants (id, session_id, student_id, total_points, correct_count, answered_count, joined_at) FROM stdin;
48	50	56	1	1	1	2026-11-03 05:58:26.237202+00
\.


--
-- Data for Name: poll_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.poll_votes (id, poll_id, student_id, option_index, created_at) FROM stdin;
7	3	43	4	2026-10-26 21:50:29.213798+00
\.


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.polls (id, teacher_id, group_id, question, options, status, created_at, closed_at) FROM stdin;
3	3	12	ماهو اهم سبب يواجهك ويؤدي بك لعدم إنجاز فرض الرياضيات كما يجب بصراحة؟	["-ضعف فهم الدروس.", "-نقص التدريب الفردي بالقلم والورقة.", "-ضعف المكتسبات السابقة.", "-سوء تنظيم الوقت والتسرّع.", "-الخوف والتوتر أثناء الفرض."]	open	2026-10-26 21:47:50.951243+00	\N
\.


--
-- Data for Name: question_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_images (id, question_id, file_key, mime, bytes, order_index, data, created_at) FROM stdin;
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, quiz_id, order_index, type, prompt, points, options, correct_option, correct_bool, correct_number, tolerance, accepted_answers, allow_images, max_images, allow_explanation) FROM stdin;
41	35	0	mcq	أجب \n26+3(3×4-1)	1	["59", "-12", "42"]	0	\N	\N	0	\N	f	3	t
\.


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quizzes (id, teacher_id, title, description, created_at) FROM stdin;
35	3	رياضيات		2026-11-03 05:50:16.399717+00
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, quiz_id, group_id, teacher_id, code, status, current_index, time_limit_sec, question_started_at, started_at, ended_at, created_at) FROM stdin;
50	35	10	3	Q8GF5J	ended	0	45	2026-11-03 05:58:34.732+00	2026-11-03 05:58:34.732+00	2026-11-03 05:59:02.679+00	2026-11-03 05:57:52.838129+00
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, name, created_at, password_hash, login_code) FROM stdin;
1	أحمد سامي	2026-10-24 04:49:00.569874+00		\N
2	سارة محمود	2026-10-24 06:39:57.589917+00		\N
3	جاد شلبي	2026-10-24 08:14:51.337238+00		\N
11	تلميذ مجتهد	2026-10-24 08:43:39.744529+00		\N
12	سلسبيل لوحيشي	2026-10-24 12:44:36.312102+00		\N
13	محمد شلبي	2026-10-24 13:36:15.550768+00		\N
14	سلسبيل الوحيشي	2026-10-24 15:37:07.88436+00		\N
15	سليم بالحاج خليفة	2026-10-24 17:36:34.161916+00		\N
16	احمد امين العيدودي	2026-10-24 17:38:40.143181+00		\N
17	نرمين الوسلاتي	2026-10-24 17:40:54.577235+00		\N
18	Selim koumi	2026-10-24 17:51:03.004207+00		\N
19	محمد ايوب الجابري	2026-10-24 18:00:36.647684+00		\N
20	سندرا الجعايبي	2026-10-24 18:14:56.763484+00		\N
21	يوسف بلدي	2026-10-24 18:50:25.11586+00		\N
22	محمد أيوب الجابري	2026-10-24 18:50:41.064049+00		\N
23	آزر كثيري	2026-10-24 18:51:00.688172+00		\N
24	حسام شعار	2026-10-24 18:51:40.084355+00		\N
25	أحمد ياسين الجابري	2026-10-24 18:52:02.794143+00		\N
26	احمد وسلاتي	2026-10-24 20:04:32.961635+00		\N
27	نورسان بن عمر	2026-10-24 20:08:37.306507+00		\N
28	ندين زخامة	2026-10-24 20:08:38.821393+00		\N
29	نادين مولهي	2026-10-24 20:15:15.361839+00		\N
30	سارة العيدودي	2026-10-24 20:18:04.39576+00		\N
31	اسيل عماري	2026-10-24 21:33:44.212385+00		\N
32	ليان شلبي	2026-10-26 15:26:30.41965+00		\N
33	خليل	2026-10-26 16:38:01.316774+00		\N
34	شادلي	2026-10-26 16:40:00.528839+00		\N
35	Hossem chazr	2026-10-26 16:42:13.373795+00		\N
36	مريم علاية	2026-10-26 16:50:06.894826+00		\N
37	شهد بالحاج	2026-10-26 16:50:29.41834+00		\N
38	Oussema benzid	2026-10-26 17:04:18.03533+00		\N
39	خليل بن حميدة	2026-10-26 17:26:19.617793+00		\N
40	ياسمين فرشيشي	2026-10-26 18:27:18.452351+00		\N
41	يوسف عوادي	2026-10-26 19:40:16.366634+00		\N
42	محمد عزيز سلامي	2026-10-26 20:04:55.19482+00		\N
43	جاد	2026-10-26 21:49:30.572658+00		\N
44	طالب جديد	2026-10-29 20:07:18.007337+00	a1b0adea85da3af0b90d1fa86afc2206:285d28031f746a31caab4baf0f0063f79a3f3e2235c13764a7a5820a124a623f2fc470f8c1d6a3c35e1fdaad649368024456485cc84b63b088245864e217f322	\N
45	تلميذ اختبار	2026-10-29 20:32:39.191038+00	342ddac1bda8273a9287c51dde0df665:3177376547a71eb4b108a4f8553f2799a581d23dc150ae4019188664e5ba25fb779e21f9c1a6ed8bf47873fd14bf0c6907b48c95a4a9ab4336cab3a873d1079a	\N
46	أحمد شريف	2026-10-29 20:42:11.082934+00	b79f5683a7fb064cb0b52181090ab56b:ba6e5b58d4c3af9d77adb33b12586bad80b3c19aa18169e885ca168c40a177abc2b031c0bd6e4c4fb74543053342b39746936fc929ab159d5d4863b77e403a7d	\N
47	Chelbi Mohamed	2026-10-30 22:11:31.822114+00	68f5c3cbabd62694ac06d6a435ce9009:22eaff9fb3cf736f2808c13bf3b0ea9810f77fb750c5691bbbdc1edb33d3473fb387ea5c1b1bcd41203927b5bc2de9a6c3d05757545aa0a77a336bf54aa3e282	\N
48	ugd	2026-10-31 23:35:57.173281+00	ad563aaf5b37b09054d4501f84d3f3ae:ad222a98193cc7ece620414eba5b3425b7e796fd194c910a66122cee70bd4a3c058f4b91c36ab1580b2267725bb40a892dd3131ff39bb51e1d25564f8c3882eb	\N
49	محمد يحي	2026-11-02 06:47:33.251419+00	f377bbdda981f912c59e43ed428bfbf0:ae1433f52fe96f060ad3455fa8b7f92f3112daa3d51510d0e984ab4a3d6bf3eb2dabc613ca8f8e2f738078159194dea3ce3c274ef3aa3ac43d8eb9bb7c3a0409	631
50	ليندا	2026-11-02 16:59:33.628082+00	ff8375647f69df587006f3aef3844456:b475bb20cd430d7f2dde690abdcd8dec9a91a4ebf012d50815a41a10e68dbd6be3e23ed79c7c2d0db7058f0afc862da7927cfd40f6ea82a4065bd6a9e9d0d05f	345
51	kkks	2026-11-02 22:41:51.221871+00	6c0c940e52b1cffd6005c6a59409dd04:cfbc9d51be0667aa92f6856c58cc6756f9b66f4b0dd650af86565cd345d898487d7cb7d2a0f1035980b9d20f5b4da84369bc95ec2c761938641e5f308e0568b8	221
52	Gjghjj	2026-11-02 23:13:34.866719+00	0344bf779639752db3c9bcbda7c2f2b7:99da262a6388858118b0b1161b9a4984969ceeecdbc42bc28262b87ec55af262c0a11cf1f42bff3129cce3a5d268d949f53df7d3abe29f22c6b58ab5d3b80e10	965
53	تلميذ جديد تجربة	2026-11-02 23:38:37.673467+00	b28cd1c10b7b0367d3fefbc04be2f246:03efbec9b66d4083fc23afa3d8f5778ba164660651cc1d63f27888a10933d2031242876db7cc553c252801d3cc38a115cb80427866af76db2ff0eec72ec91a02	456
54	محمد علي	2026-11-02 23:43:35.556745+00	b0fc2e7bb715ee777bcd8e6d69c1c55c:f08eeaab81757980699de0429791586208fcc1bc4594f83697989b9ae66276c00b2eaa13247b175dd35eaca14a4f542310941c7dc8f81a8243a06df7c4b283e5	365
55	علي خميس	2026-11-03 05:55:26.673002+00	60f6b3907de9305b59637da0c4f61b8f:f273723a9ba68091b3dd0e0cdd8c1d01392c39dd3fb9d68ba4286770c1713ba401cd35966f8da8b1e08581293f816029ec717b5244afccf2733f96bd9f026162	563
56	علي	2026-11-03 05:56:42.722547+00	eb6da7366991afd4d59cf4b4a2676116:c5de15cccfd56ad7651c18ba8bf12d5b6933177934bd61d2ab8c192b7f6bab073b42aa7d9826c2ac0c25e4713be71bbf44b0f6da15b599b62b5aa50f11b5d740	123
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submissions (id, session_id, question_id, student_id, answer_option, answer_bool, answer_number, answer_text, needs_manual, is_correct, awarded_points, submitted_at, graded_at, graded_by, feedback, review_status, grade_released) FROM stdin;
54	50	41	56	0	\N	\N	\N	f	t	1	2026-11-03 05:58:49.924067+00	2026-11-03 05:58:49.923+00	\N		pending	f
\.


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (id, name, username, password_hash, created_at, reset_token, reset_token_expiry) FROM stdin;
3	الأستاذ محمد شلبي	ChelbiMohamed-42	f2d2e24a3c46828d3038fa393218b1c0:31eb69c6c944431534499cfb7faaca64133ce47ac6c36a7724a8a854270a1457f0e0106c84f505109bcb12f45a628209045a19c6a291db31bcd5ea9563e158f7	2026-10-24 11:23:13.113313+00	\N	\N
\.


--
-- Name: answer_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_images_id_seq', 14, true);


--
-- Name: exercise_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercise_answers_id_seq', 4, true);


--
-- Name: exercise_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercise_attempts_id_seq', 2, true);


--
-- Name: exercise_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercise_questions_id_seq', 7, true);


--
-- Name: exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercises_id_seq', 4, true);


--
-- Name: grade_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grade_audit_id_seq', 30, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groups_id_seq', 12, true);


--
-- Name: memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.memberships_id_seq', 60, true);


--
-- Name: participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participants_id_seq', 48, true);


--
-- Name: poll_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.poll_votes_id_seq', 7, true);


--
-- Name: polls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.polls_id_seq', 3, true);


--
-- Name: question_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_images_id_seq', 18, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 41, true);


--
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quizzes_id_seq', 35, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_id_seq', 50, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 56, true);


--
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.submissions_id_seq', 54, true);


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_id_seq', 3, true);


--
-- Name: answer_images answer_images_file_key_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_images
    ADD CONSTRAINT answer_images_file_key_unique UNIQUE (file_key);


--
-- Name: answer_images answer_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_images
    ADD CONSTRAINT answer_images_pkey PRIMARY KEY (id);


--
-- Name: exercise_answers exercise_answers_attempt_id_question_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_answers
    ADD CONSTRAINT exercise_answers_attempt_id_question_id_key UNIQUE (attempt_id, question_id);


--
-- Name: exercise_answers exercise_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_answers
    ADD CONSTRAINT exercise_answers_pkey PRIMARY KEY (id);


--
-- Name: exercise_attempts exercise_attempts_exercise_id_student_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_attempts
    ADD CONSTRAINT exercise_attempts_exercise_id_student_id_key UNIQUE (exercise_id, student_id);


--
-- Name: exercise_attempts exercise_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_attempts
    ADD CONSTRAINT exercise_attempts_pkey PRIMARY KEY (id);


--
-- Name: exercise_questions exercise_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_questions
    ADD CONSTRAINT exercise_questions_pkey PRIMARY KEY (id);


--
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- Name: grade_audit grade_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade_audit
    ADD CONSTRAINT grade_audit_pkey PRIMARY KEY (id);


--
-- Name: groups groups_invite_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_invite_token_unique UNIQUE (invite_token);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: participants participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (id);


--
-- Name: poll_votes poll_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT poll_votes_pkey PRIMARY KEY (id);


--
-- Name: polls polls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_pkey PRIMARY KEY (id);


--
-- Name: question_images question_images_file_key_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_images
    ADD CONSTRAINT question_images_file_key_unique UNIQUE (file_key);


--
-- Name: question_images question_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_images
    ADD CONSTRAINT question_images_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_code_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_code_unique UNIQUE (code);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_username_unique UNIQUE (username);


--
-- Name: attempt_exercise_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX attempt_exercise_idx ON public.exercise_attempts USING btree (exercise_id);


--
-- Name: audit_submission_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX audit_submission_idx ON public.grade_audit USING btree (submission_id);


--
-- Name: eq_exercise_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eq_exercise_idx ON public.exercise_questions USING btree (exercise_id);


--
-- Name: images_session_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX images_session_idx ON public.answer_images USING btree (session_id);


--
-- Name: images_submission_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX images_submission_idx ON public.answer_images USING btree (submission_id);


--
-- Name: membership_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX membership_unique ON public.memberships USING btree (group_id, student_id);


--
-- Name: participant_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX participant_unique ON public.participants USING btree (session_id, student_id);


--
-- Name: qimg_question_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qimg_question_idx ON public.question_images USING btree (question_id);


--
-- Name: questions_quiz_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX questions_quiz_idx ON public.questions USING btree (quiz_id);


--
-- Name: sessions_teacher_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_teacher_idx ON public.sessions USING btree (teacher_id);


--
-- Name: submission_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX submission_unique ON public.submissions USING btree (session_id, question_id, student_id);


--
-- Name: vote_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX vote_unique ON public.poll_votes USING btree (poll_id, student_id);


--
-- Name: answer_images answer_images_question_id_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_images
    ADD CONSTRAINT answer_images_question_id_questions_id_fk FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: answer_images answer_images_session_id_sessions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_images
    ADD CONSTRAINT answer_images_session_id_sessions_id_fk FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;


--
-- Name: answer_images answer_images_student_id_students_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_images
    ADD CONSTRAINT answer_images_student_id_students_id_fk FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: answer_images answer_images_submission_id_submissions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_images
    ADD CONSTRAINT answer_images_submission_id_submissions_id_fk FOREIGN KEY (submission_id) REFERENCES public.submissions(id) ON DELETE CASCADE;


--
-- Name: exercise_answers exercise_answers_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_answers
    ADD CONSTRAINT exercise_answers_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.exercise_attempts(id) ON DELETE CASCADE;


--
-- Name: exercise_answers exercise_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_answers
    ADD CONSTRAINT exercise_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.exercise_questions(id) ON DELETE CASCADE;


--
-- Name: exercise_attempts exercise_attempts_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_attempts
    ADD CONSTRAINT exercise_attempts_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- Name: exercise_attempts exercise_attempts_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_attempts
    ADD CONSTRAINT exercise_attempts_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: exercise_questions exercise_questions_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercise_questions
    ADD CONSTRAINT exercise_questions_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- Name: exercises exercises_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE SET NULL;


--
-- Name: exercises exercises_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: grade_audit grade_audit_submission_id_submissions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grade_audit
    ADD CONSTRAINT grade_audit_submission_id_submissions_id_fk FOREIGN KEY (submission_id) REFERENCES public.submissions(id) ON DELETE CASCADE;


--
-- Name: groups groups_teacher_id_teachers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_teacher_id_teachers_id_fk FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: memberships memberships_group_id_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_group_id_groups_id_fk FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: memberships memberships_student_id_students_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_student_id_students_id_fk FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: participants participants_session_id_sessions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_session_id_sessions_id_fk FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;


--
-- Name: participants participants_student_id_students_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_student_id_students_id_fk FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: poll_votes poll_votes_poll_id_polls_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT poll_votes_poll_id_polls_id_fk FOREIGN KEY (poll_id) REFERENCES public.polls(id) ON DELETE CASCADE;


--
-- Name: poll_votes poll_votes_student_id_students_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poll_votes
    ADD CONSTRAINT poll_votes_student_id_students_id_fk FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- Name: polls polls_group_id_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_group_id_groups_id_fk FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: polls polls_teacher_id_teachers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.polls
    ADD CONSTRAINT polls_teacher_id_teachers_id_fk FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: question_images question_images_question_id_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_images
    ADD CONSTRAINT question_images_question_id_questions_id_fk FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: questions questions_quiz_id_quizzes_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_quiz_id_quizzes_id_fk FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: quizzes quizzes_teacher_id_teachers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_teacher_id_teachers_id_fk FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_group_id_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_group_id_groups_id_fk FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_quiz_id_quizzes_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_quiz_id_quizzes_id_fk FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_teacher_id_teachers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_teacher_id_teachers_id_fk FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) ON DELETE CASCADE;


--
-- Name: submissions submissions_question_id_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_question_id_questions_id_fk FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: submissions submissions_session_id_sessions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_session_id_sessions_id_fk FOREIGN KEY (session_id) REFERENCES public.sessions(id) ON DELETE CASCADE;


--
-- Name: submissions submissions_student_id_students_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_student_id_students_id_fk FOREIGN KEY (student_id) REFERENCES public.students(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 5ZPTiChXRQHhJy2UavO2QcOjbMKVunK5CgJFGnQz7h1T58eGSS3Iy6L60JbhaIc

