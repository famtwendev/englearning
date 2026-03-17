--
-- PostgreSQL database dump
--

\restrict cWAOOd9OC4bRvVysQZYUDg9EFMz7V5pJ7eOq8vDhBUd0nXsHCQubKc8xfvIRLir

-- Dumped from database version 15.17
-- Dumped by pg_dump version 15.17

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
-- Name: achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achievements (
    id bigint NOT NULL,
    condition_key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    reward_xp integer NOT NULL
);


ALTER TABLE public.achievements OWNER TO postgres;

--
-- Name: achievements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.achievements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.achievements_id_seq OWNER TO postgres;

--
-- Name: achievements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.achievements_id_seq OWNED BY public.achievements.id;


--
-- Name: attempt_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attempt_answers (
    attempt_id uuid NOT NULL,
    question_id uuid NOT NULL,
    answer_data jsonb NOT NULL,
    feedback jsonb,
    is_correct boolean,
    score double precision
);


ALTER TABLE public.attempt_answers OWNER TO postgres;

--
-- Name: exam_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exam_attempts (
    id uuid NOT NULL,
    end_time timestamp(6) without time zone,
    start_time timestamp(6) without time zone,
    status character varying(20) NOT NULL,
    total_score double precision,
    user_id uuid NOT NULL,
    template_id uuid NOT NULL
);


ALTER TABLE public.exam_attempts OWNER TO postgres;

--
-- Name: exam_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exam_templates (
    id uuid NOT NULL,
    duration_sec integer,
    level character varying(255) NOT NULL,
    tenant_id bigint,
    title character varying(255) NOT NULL
);


ALTER TABLE public.exam_templates OWNER TO postgres;

--
-- Name: ipa_confusing_pairs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ipa_confusing_pairs (
    id uuid NOT NULL,
    note character varying(255),
    phoneme_id_1 uuid NOT NULL,
    phoneme_id_2 uuid NOT NULL
);


ALTER TABLE public.ipa_confusing_pairs OWNER TO postgres;

--
-- Name: ipa_phonemes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ipa_phonemes (
    id uuid NOT NULL,
    audio_url character varying(255),
    is_consonant boolean NOT NULL,
    is_diphthongs boolean NOT NULL,
    is_monophthongs boolean NOT NULL,
    is_vowel boolean NOT NULL,
    symbol character varying(10) NOT NULL
);


ALTER TABLE public.ipa_phonemes OWNER TO postgres;

--
-- Name: ipa_words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ipa_words (
    id uuid NOT NULL,
    audio_url character varying(255),
    ipa_text character varying(255),
    text character varying(255) NOT NULL,
    primary_phoneme_id uuid
);


ALTER TABLE public.ipa_words OWNER TO postgres;

--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id uuid NOT NULL,
    content jsonb NOT NULL,
    max_score double precision NOT NULL,
    order_index integer,
    question_type character varying(50) NOT NULL,
    template_id uuid NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: quiz_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_attempts (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone,
    is_correct boolean NOT NULL,
    response_time integer,
    user_id bigint NOT NULL,
    vocab_id bigint NOT NULL
);


ALTER TABLE public.quiz_attempts OWNER TO postgres;

--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.quiz_attempts_id_seq OWNER TO postgres;

--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_attempts_id_seq OWNED BY public.quiz_attempts.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics (
    id bigint NOT NULL,
    description text,
    difficulty character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: user_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_progress (
    id bigint NOT NULL,
    accuracy double precision NOT NULL,
    is_learned boolean NOT NULL,
    last_practiced timestamp(6) without time zone,
    user_id bigint NOT NULL,
    vocab_id bigint NOT NULL
);


ALTER TABLE public.user_progress OWNER TO postgres;

--
-- Name: user_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_progress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_progress_id_seq OWNER TO postgres;

--
-- Name: user_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_progress_id_seq OWNED BY public.user_progress.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone,
    email character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    level integer,
    password character varying(255) NOT NULL,
    role character varying(255),
    streak integer,
    total_xp integer,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['USER'::character varying, 'ADMIN'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vocabularies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vocabularies (
    id bigint NOT NULL,
    audio_url character varying(255),
    difficulty_level character varying(255),
    example text,
    ipa character varying(255),
    meaning character varying(255) NOT NULL,
    part_of_speech character varying(255),
    word character varying(255) NOT NULL,
    topic_id bigint NOT NULL
);


ALTER TABLE public.vocabularies OWNER TO postgres;

--
-- Name: vocabularies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vocabularies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vocabularies_id_seq OWNER TO postgres;

--
-- Name: vocabularies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vocabularies_id_seq OWNED BY public.vocabularies.id;


--
-- Name: achievements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements ALTER COLUMN id SET DEFAULT nextval('public.achievements_id_seq'::regclass);


--
-- Name: quiz_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempts_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: user_progress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_progress ALTER COLUMN id SET DEFAULT nextval('public.user_progress_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vocabularies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vocabularies ALTER COLUMN id SET DEFAULT nextval('public.vocabularies_id_seq'::regclass);


--
-- Data for Name: achievements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achievements (id, condition_key, name, reward_xp) FROM stdin;
\.


--
-- Data for Name: attempt_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attempt_answers (attempt_id, question_id, answer_data, feedback, is_correct, score) FROM stdin;
\.


--
-- Data for Name: exam_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exam_attempts (id, end_time, start_time, status, total_score, user_id, template_id) FROM stdin;
\.


--
-- Data for Name: exam_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exam_templates (id, duration_sec, level, tenant_id, title) FROM stdin;
\.


--
-- Data for Name: ipa_confusing_pairs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ipa_confusing_pairs (id, note, phoneme_id_1, phoneme_id_2) FROM stdin;
\.


--
-- Data for Name: ipa_phonemes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ipa_phonemes (id, audio_url, is_consonant, is_diphthongs, is_monophthongs, is_vowel, symbol) FROM stdin;
a3fd369d-9724-4782-a607-eb1d28c82595		f	f	t	t	i:
34249eb4-b673-4ace-84d1-de8eb043da73		f	f	t	t	ɪ
834340e6-815d-44b2-b6a0-1629f5618866		f	f	t	t	ʊ
5e71788a-57cb-48b9-a128-1ff99eebe43d		f	f	t	t	u:
18c8d645-50f6-428c-be8e-0e7d51237e3d		f	f	t	t	e
88c47723-3316-4d95-acf2-bdbe923a049f		f	f	t	t	ə
5e784106-2911-4e83-8e51-3df99bab8fb7		f	f	t	t	ɜ:
890d8b51-55e5-405d-9a38-831932ae3735		f	f	t	t	ɔ:
c6c0babb-fec2-410f-a2b8-c1adb9e23f62		f	f	t	t	æ
11fc70c7-fe63-40a5-99bc-853dcee163a4		f	f	t	t	ʌ
750ba5f9-c3cd-40eb-865e-56234199d75d		f	f	t	t	ɑ:
3d952ca3-13d7-4b08-8c94-19531d6122ed		f	f	t	t	ɒ
9b053efb-771d-4f78-9d48-438feb3b4849		f	t	f	t	ɪə
ce9f7f16-0ba1-4fda-95e9-131be32632d6		f	t	f	t	eɪ
40d965ff-8747-4be0-a686-a9e9dcc285ec		f	t	f	t	ʊə
3b0ed2a5-fb91-4643-8fd4-6e48b102a907		f	t	f	t	ɔɪ
1facbfdf-c89c-422a-8ddc-3a3c0fdd930f		f	t	f	t	əʊ
a8ea13ed-ddd5-4143-a50d-0b7d53a36a03		f	t	f	t	eə
46a37a50-a3e7-4c68-a1ad-40c6f4e80cbe		f	t	f	t	aɪ
336077f7-2d32-4556-a30e-2e56b29250b8		f	t	f	t	aʊ
856a45cb-1756-4e46-b208-b672f50854cf		t	f	f	f	p
0583487c-62b5-42c5-b385-ef5a68edb560		t	f	f	f	b
906f40f1-31ab-4b28-ba8b-ce0f55ce9ae4		t	f	f	f	t
26879e28-ce3b-4f6b-9665-f86b7eef789f		t	f	f	f	d
c26dbe8b-3cd3-440b-94a4-a85916e4107c		t	f	f	f	k
a5fb8156-0f08-424f-905c-d8769fa86e10		t	f	f	f	g
277f32f2-5e3d-4798-a83f-e4ec1ce7fe00		t	f	f	f	f
0f2bbd5b-1f3b-4ddb-934b-266d94538945		t	f	f	f	v
eb577327-a262-40fe-966f-37446b246cc7		t	f	f	f	θ
0c14bc46-9c0d-457d-90fd-d419a0684e6c		t	f	f	f	ð
cabd6a61-c385-48ac-8dcc-109f5f2ff5f5		t	f	f	f	s
9098a332-68a3-48c8-aa6f-008e7abd5792		t	f	f	f	z
9f0556c7-165a-4279-b7dd-b76f0e76cb36		t	f	f	f	ʃ
e795c85b-2686-4e64-9b5f-dee52b8a1e0e		t	f	f	f	ʒ
75ec989f-2694-4f51-bef8-5e36c74991dc		t	f	f	f	h
9fbea04f-10e1-49b5-93a1-50e8fc483236		t	f	f	f	m
a38531bf-c110-4188-8078-9cf4a7bd877c		t	f	f	f	n
e301cabe-dfc7-461d-ae5a-d0e464f909ee		t	f	f	f	ŋ
e46a19b0-fec9-455e-82ab-062e34792043		t	f	f	f	l
37b3070f-47fb-419a-b0b4-ef5861a21088		t	f	f	f	r
de076c46-4918-4664-8c64-0b1d579d8a26		t	f	f	f	j
5c23f74f-5655-405d-83ee-efc31e34649f		t	f	f	f	w
6f326ede-0b7a-416f-addc-09ea493067a4		t	f	f	f	tʃ
c3dd693b-c1c6-49d6-b42e-0c74d074c828		t	f	f	f	dʒ
\.


--
-- Data for Name: ipa_words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ipa_words (id, audio_url, ipa_text, text, primary_phoneme_id) FROM stdin;
dc486a96-6bd9-4def-a7eb-4d23c6b333e5		/si:/	see	a3fd369d-9724-4782-a607-eb1d28c82595
f93baa95-cffb-4248-ac72-c89cf2cf5a55		/si:/	see	a3fd369d-9724-4782-a607-eb1d28c82595
7aa73123-da7c-41e4-8564-7158a1e6d314		/sɪt/	sit	34249eb4-b673-4ace-84d1-de8eb043da73
79f82af5-8cb9-4cab-bb8f-0680ad8c8e8a		/bʊk/	book	834340e6-815d-44b2-b6a0-1629f5618866
81f50bbc-9d53-4eaa-b381-3e4e24ac2cc0		/fuːd/	food	5e71788a-57cb-48b9-a128-1ff99eebe43d
e122fa28-5518-4f80-9881-b362b6dae41b		/bed/	bed	18c8d645-50f6-428c-be8e-0e7d51237e3d
2d8e1ddd-3870-4d19-9c31-e365249712d0		/əˈbaʊt/	about	88c47723-3316-4d95-acf2-bdbe923a049f
aeae6dae-8c4d-4354-bf78-55011d85e270		/bɜːd/	bird	5e784106-2911-4e83-8e51-3df99bab8fb7
1ef578c6-77ec-4607-9d53-81339c34488d		/lɔː/	law	890d8b51-55e5-405d-9a38-831932ae3735
f089c0d0-16bb-4259-aa47-c63f9607f4ed		/kæt/	cat	c6c0babb-fec2-410f-a2b8-c1adb9e23f62
79cb00a2-d34d-422c-b3fd-91518817cf4b		/kʌp/	cup	11fc70c7-fe63-40a5-99bc-853dcee163a4
cc4a00f1-b1b8-48a5-b676-4c1c7277798f		/ˈfɑːðə/	father	750ba5f9-c3cd-40eb-865e-56234199d75d
fb9e330d-0516-4a09-a833-ec6c36dbd066		/hɒt/	hot	3d952ca3-13d7-4b08-8c94-19531d6122ed
76908d2e-62f4-4c56-aa18-ea172ca7ca9b		/hɪə/	here	9b053efb-771d-4f78-9d48-438feb3b4849
b32dea87-8cca-4a0d-9b2e-0518551bd3bc		/deɪ/	day	ce9f7f16-0ba1-4fda-95e9-131be32632d6
8522ca79-bb23-43a8-9d6c-2cf958e1f820		/tʊə/	tour	40d965ff-8747-4be0-a686-a9e9dcc285ec
77b1f9aa-24d0-43c5-9550-508ec6d5cb4b		/bɔɪ/	boy	3b0ed2a5-fb91-4643-8fd4-6e48b102a907
2b2f0c66-7153-4c48-a1f6-cd16c8074ada		/gəʊ/	go	1facbfdf-c89c-422a-8ddc-3a3c0fdd930f
46732ce1-9842-4147-972b-570ff9f236a7		/heə/	hair	a8ea13ed-ddd5-4143-a50d-0b7d53a36a03
c73ea506-f5a1-455f-8a34-8efc21d84df9		/taɪm/	time	46a37a50-a3e7-4c68-a1ad-40c6f4e80cbe
fa41afbf-a61b-4315-82e6-bb65e502e0da		/haʊs/	house	336077f7-2d32-4556-a30e-2e56b29250b8
a4051a8b-e58b-4ecc-afe9-1d0c5fc438b0		/pen/	pen	856a45cb-1756-4e46-b208-b672f50854cf
1b439b42-5c7d-442c-9ebe-9e0bf4651d51		/bæt/	bat	0583487c-62b5-42c5-b385-ef5a68edb560
bc8b9196-76d0-4627-a06c-ca511468cc08		/tɒp/	top	906f40f1-31ab-4b28-ba8b-ce0f55ce9ae4
4de597a1-b9e1-4df4-b8f0-765d0dec04ef		/dɒg/	dog	26879e28-ce3b-4f6b-9665-f86b7eef789f
bc815df1-e16c-467c-b334-978ac12e6bf0		/kæt/	cat	c26dbe8b-3cd3-440b-94a4-a85916e4107c
53cbaeeb-9877-4325-9045-4f95d90a809f		/gəʊ/	go	a5fb8156-0f08-424f-905c-d8769fa86e10
baec875f-0031-4fea-ac2b-272d3a5f2b40		/fɪʃ/	fish	277f32f2-5e3d-4798-a83f-e4ec1ce7fe00
123eaf72-0100-42a5-86f5-36d9dff74948		/væn/	van	0f2bbd5b-1f3b-4ddb-934b-266d94538945
c7aae1d6-e1a4-4f2d-a580-ea14de3f4a8d		/θɪŋk/	think	eb577327-a262-40fe-966f-37446b246cc7
cedd80fb-0d22-4d5b-8d87-257635bcad97		/ðɪs/	this	0c14bc46-9c0d-457d-90fd-d419a0684e6c
93886052-f77a-4749-95bd-44e10ad144e5		/sʌn/	sun	cabd6a61-c385-48ac-8dcc-109f5f2ff5f5
3021eb29-8363-4a8d-886b-95ca57119950		/zuː/	zoo	9098a332-68a3-48c8-aa6f-008e7abd5792
34c312d1-2d32-404c-b4f5-0b741e07f65c		/ʃɪp/	ship	9f0556c7-165a-4279-b7dd-b76f0e76cb36
067c90da-947e-4d15-985f-a88b8208922a		/ˈvɪʒən/	vision	e795c85b-2686-4e64-9b5f-dee52b8a1e0e
d8000980-498c-4c4c-ae16-b63e8d403d0b		/hæt/	hat	75ec989f-2694-4f51-bef8-5e36c74991dc
cedf8238-529b-4d28-beb7-4bc81cb94389		/mæn/	man	9fbea04f-10e1-49b5-93a1-50e8fc483236
f31c96a3-8e76-4bd3-bcb6-9a6c1fad414f		/nəʊ/	no	a38531bf-c110-4188-8078-9cf4a7bd877c
caa29691-9f3f-4d7e-9d96-b595b5b1b2eb		/sɪŋ/	sing	e301cabe-dfc7-461d-ae5a-d0e464f909ee
1179cc80-1593-4e30-acd1-67a8d88c109a		/laɪt/	light	e46a19b0-fec9-455e-82ab-062e34792043
0105312d-e71c-4178-bacf-97662cf07d87		/red/	red	37b3070f-47fb-419a-b0b4-ef5861a21088
fe2e20a0-2abb-43d9-8074-85344c424b5a		/jes/	yes	de076c46-4918-4664-8c64-0b1d579d8a26
c580f109-e339-40d2-8adf-be5e9d4d9270		/wiː/	we	5c23f74f-5655-405d-83ee-efc31e34649f
a4f6ae7d-0545-4ef8-a4bf-cabbc5624c85		/tʃeə/	chair	6f326ede-0b7a-416f-addc-09ea493067a4
aee87693-882c-4cf5-923c-4731607ca501		/dʒɒb/	job	c3dd693b-c1c6-49d6-b42e-0c74d074c828
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, content, max_score, order_index, question_type, template_id) FROM stdin;
\.


--
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quiz_attempts (id, created_at, is_correct, response_time, user_id, vocab_id) FROM stdin;
1	2026-03-17 20:56:08.552778	f	5825	3	512
2	2026-03-17 20:56:14.135142	f	4076	3	513
3	2026-03-17 20:56:23.593291	f	7951	3	514
4	2026-03-17 20:56:35.085421	f	9989	3	515
5	2026-03-17 20:56:41.151933	f	4586	3	516
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, description, difficulty, name) FROM stdin;
1	Relationships, families,and early learning	LOW	Growin Up
2	The body, the mind	LOW	Mental And Physical Development
3	Diet, health and exercise.	LOW	Keeping Fit
4	Life, leisure	LOW	Lifestyles
5	Study, education, research.	LOW	Student Life
6	Language, linguistics	LOW	Effective Communication
7	Tourism, travel.	LOW	On the Move
9	Flora and fauna, agriculture	LOW	The Natural World
10	Space, the planets.	LOW	Reaching for the Skies
8	Time ,historical	LOW	Through the Ages
11	Essential words frequently appearing in the TOEIC exam, covering various parts of speech.	MEDIUM	TOEIC Common Vocabulary Part 1
12	Essential TOEIC words covering business operations, professional services, and logistics.	MEDIUM	TOEIC Common Vocabulary Part 2
14	Essential TOEIC terms focusing on workplace duties, office procedures, and commercial travel.	MEDIUM	TOEIC Common Vocabulary Part 4
15	Essential TOEIC terms covering workplace behavior, office supplies, business growth, and travel services.	MEDIUM	TOEIC Common Vocabulary Part 5
16	Essential TOEIC terms focusing on financial calculations, recruitment, professional qualities, and business operations.	MEDIUM	TOEIC Common Vocabulary Part 6
17	Essential TOEIC terms focusing on travel, legal claims, professional competition, and workplace interactions.	MEDIUM	TOEIC Common Vocabulary Part 7
18	Focusing on workplace compliance, consumer behavior, and professional conduct.	MEDIUM	TOEIC Common Vocabulary Part 8
19	Essential TOEIC vocabulary covering corporate structure, customer service, financial terms, and critical evaluation.	MEDIUM	TOEIC Common Vocabulary Part 9
20	Essential TOEIC terms focusing on finances, professional commitment, logistics, and office administration.	MEDIUM	TOEIC Common Vocabulary Part 10
21	Essential TOEIC terms focusing on logistics, finance, corporate restructuring, and economic principles.	MEDIUM	TOEIC Common Vocabulary Part 12
22	Essential TOEIC terms focusing on operational efficiency, professional development, and workplace rights.	MEDIUM	TOEIC Common Vocabulary Part 13
13	Focusing on administrative procedures, recruitment, evaluation, and professional interactions.	MEDIUM	TOEIC Common Vocabulary Part 3
23	Essential TOEIC terms focusing on professional development, office technology, conflict resolution, and retail operations.	MEDIUM	TOEIC Common Vocabulary Part 11
24	Essential TOEIC terms focusing on evaluation, business expansion, corporate leadership, and financial spending.	MEDIUM	TOEIC Common Vocabulary Part 14
25	Essential TOEIC terms focusing on logistics, contract extensions, financial figures, and travel services.	MEDIUM	TOEIC Common Vocabulary Part 15
26	Essential TOEIC terms focusing on market trends, office organization, forecasting, and workplace relations.	MEDIUM	TOEIC Common Vocabulary Part 16
27	Essential TOEIC terms focusing on business growth, operations, workplace safety, and professional behavior.	MEDIUM	TOEIC Common Vocabulary Part 17
\.


--
-- Data for Name: user_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_progress (id, accuracy, is_learned, last_practiced, user_id, vocab_id) FROM stdin;
1	0	f	2026-03-17 20:56:08.573206	3	512
2	0	f	2026-03-17 20:56:14.152919	3	513
3	0	f	2026-03-17 20:56:23.602129	3	514
4	0	f	2026-03-17 20:56:35.096181	3	515
5	0	f	2026-03-17 20:56:41.164397	3	516
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, created_at, email, first_name, last_name, level, password, role, streak, total_xp) FROM stdin;
8	2026-03-03 17:36:52.494787	test5@test.com	Post3	Test3	1	$2a$10$m6EATzr2Oho3VWiz6Kn8f.SvlWo1BBhzjT8smyH93VfFUZ8zKFErS	USER	0	0
3	2026-03-03 15:58:07.021391	phamtuyen121314@gmail.com	Tuyên	Nguyễn Phạm	3	$2a$10$rpmMNeBibfaVF5NKTy6JHeZ5VEA3.JwAg8kfH96/R.5k3eAxrJ9SS	ADMIN	0	0
9	2026-03-04 11:38:16.371241	admin@system.com	System	Admin	\N	$2a$10$rpmMNeBibfaVF5NKTy6JHeZ5VEA3.JwAg8kfH96/R.5k3eAxrJ9SS	ADMIN	\N	\N
\.


--
-- Data for Name: vocabularies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vocabularies (id, audio_url, difficulty_level, example, ipa, meaning, part_of_speech, word, topic_id) FROM stdin;
1	\N	LOW	Adolescence is often a period of significant emotional and physical change.	/ˌædəˈlesəns/	tuổi vị thành niên, tuổi dậy thì	n	adolescence	1
2	\N	LOW	Taking on financial responsibility is a key part of entering adulthood.	/ˈædʌlthʊd/	tuổi trưởng thành	n	adulthood	1
3	\N	LOW	The bond between the two brothers strengthened after their long journey together.	/bɒnd/	sự gắn kết (tình cảm)	n	bond	1
4	\N	LOW	The soldiers shared a strong sense of brotherhood born out of shared hardships.	/ˈbrʌðəhʊd/	tình huynh đệ	n	brotherhood	1
5	\N	LOW	Difficult experiences can often help build a person's character.	/ˈkærəktə(r)/	tính cách, nhân cách	n	character	1
6	\N	LOW	She had a very happy childhood growing up in the countryside.	/ˈtʃaɪldhʊd/	tuổi thơ	n	childhood	1
7	\N	LOW	It is natural for there to be some conflict between parents and teenagers.	/ˈkɒnflɪkt/	xung đột, mâu thuẫn	n	conflict	1
8	\N	LOW	There is a strong connection between a healthy diet and mental well-being.	/kəˈnekʃn/	sự kết nối, mối liên hệ	n	connection	1
9	\N	LOW	Fatherhood has given him a new perspective on what is truly important in life.	/ˈfɑːðəhʊd/	thiên chức làm cha	n	fatherhood	1
10	\N	LOW	Their friendship has lasted for over twenty years.	/ˈfrendʃɪp/	tình bạn	n	friendship	1
11	\N	LOW	Birds have an instinct to migrate south for the winter.	/ˈɪnstɪŋkt/	bản năng	n	instinct	1
12	\N	LOW	Social interaction is crucial for the development of young children.	/ˌɪntərˈrækʃn/	sự tương tác	n	interaction	1
13	\N	LOW	She managed to balance the demands of motherhood with a full-time career.	/ˈmʌðəhʊd/	thiên chức làm mẹ	n	motherhood	1
14	\N	LOW	It is simply his nature to be helpful and kind to everyone.	/ˈneɪtʃə(r)/	bản chất, thiên hướng	n	nature	1
15	\N	LOW	Being a good parent requires a lot of patience and understanding.	/ˈpeərənt/	cha hoặc mẹ	n	parent	1
16	\N	LOW	The company maintains a good relation with its primary suppliers.	/rɪˈleɪʃn/	mối quan hệ	n	relation	1
17	\N	LOW	He has a very close relationship with his sister.	/rɪˈleɪʃnʃɪp/	mối quan hệ (giữa/ với)	n	relationship	1
18	\N	LOW	Most of my relatives live in the northern part of the country.	/ˈrelətɪv/	người thân, họ hàng	n	relative	1
19	\N	LOW	There is a clear resemblance between the boy and his father.	/rɪˈzembləns/	sự giống nhau	n	resemblance	1
20	\N	LOW	The rivalry between the two sports teams has existed for decades.	/ˈraɪvəlri/	sự ganh đua	n	rivalry	1
21	\N	LOW	Do you have any siblings, or are you an only child?	/ˈsɪblɪŋ/	anh/chị/em ruột	n	sibling	1
22	\N	LOW	Many teenagers face pressure from their peers to fit in.	/ˈtiːneɪdʒə(r)/	thanh thiếu niên	n	teenager	1
23	\N	LOW	The two brothers have very different temperaments; one is calm while the other is impulsive.	/ˈtemprəmənt/	khí chất, tính khí	n	temperament	1
24	\N	LOW	The country is trying to strengthen its economic ties with its neighbors.	/taɪz/	mối ràng buộc, liên kết	n	ties	1
25	\N	LOW	His strict upbringing made him a very disciplined adult.	/ˈʌpbrɪŋɪŋ/	sự nuôi dạy	n	upbringing	1
26	\N	LOW	The father decided to take an active role in his children's education.	/ˈæktɪv rəʊl/	vai trò tích cực	n	active role	1
27	\N	LOW	During the holidays, we usually gather with our entire extended family.	/ɪkˈstendɪd ˈfæməli/	đại gia đình	n	extended family	1
28	\N	LOW	Lunar New Year is a perfect time for a family gathering.	/ˈfæməli ˈɡæðərɪŋ/	buổi họp mặt gia đình	n	family gathering	1
29	\N	LOW	She only invited her immediate family to the small wedding ceremony.	/ɪˈmiːdiət ˈfæməli/	gia đình ruột thịt	n	immediate family	1
30	\N	LOW	The mother’s maternal instinct told her that something was wrong with the baby.	/məˈtɜːnl ˈɪnstɪŋkt/	bản năng làm mẹ	n	maternal instinct	1
31	\N	LOW	Sibling rivalry can sometimes lead to arguments, but it is a normal part of growing up.	/ˈsɪblɪŋ ˈraɪvəlri/	sự ganh đua giữa anh chị em	n	sibling rivalry	1
32	\N	LOW	A stable upbringing provides children with a strong foundation for the future.	/ˈsteɪbl ˈʌpbrɪŋɪŋ/	sự nuôi dạy ổn định	n	stable upbringing	1
33	\N	LOW	There is a striking resemblance between the two cousins; they look like twins.	/ˈstraɪkɪŋ rɪˈzembləns/	sự giống nhau nổi bật	n	striking resemblance	1
34	\N	LOW	The school tries to accommodate the needs of students with different learning styles.	/əˈkɒmədeɪt/	đáp ứng, thích nghi	v	accommodate	1
35	\N	LOW	They decided to adopt a child who had lost his parents in the war.	/əˈdɒpt/	nhận nuôi / tiếp nhận	v	adopt	1
36	\N	LOW	Communication issues often cause relationships to break down.	/breɪk daʊn/	đổ vỡ, tan vỡ	v	break down	1
37	\N	LOW	Children develop social skills through playing with their peers.	/dɪˈveləp/	phát triển	v	develop	1
38	\N	LOW	Some friendships are strong enough to endure even the most difficult times.	/ɪnˈdjʊə(r)/	chịu đựng	v	endure	1
39	\N	LOW	It is important to establish clear boundaries in any relationship.	/ɪˈstæblɪʃ/	xây dựng, thiết lập	v	establish	1
40	\N	LOW	Although they are brothers, they don't have many interests in common.	/hæv ˈsʌmθɪŋ ɪn ˈkɒmən/	có điểm chung	v	have sth in common	1
41	\N	LOW	She inherited her curly hair and blue eyes from her grandmother.	/ɪnˈherɪt/	thừa hưởng	v	inherit	1
42	\N	LOW	Teachers should encourage students to interact more with each other in class.	/ˌɪntərˈrækt/	tương tác	v	interact	1
43	\N	LOW	Parents should nurture their children's talents from an early age.	/ˈnɜːtʃə(r)/	nuôi dưỡng	v	nurture	1
44	\N	LOW	Diet and exercise play a crucial role in maintaining good health.	/pleɪ ə rəʊl/	đóng vai trò	v	play a role	1
45	\N	LOW	Many parents find it hard to relate to their children's modern lifestyles.	/rɪˈleɪt/	liên hệ, đồng cảm	v	relate (to)	1
46	\N	LOW	The system has the ability to run multiple programs at once.	/əˈbɪləti/	khả năng	n	ability	2
47	\N	LOW	Many adolescents experience mood swings during puberty.	/ˌædəˈlesnt/	thanh thiếu niên	n	adolescent	2
48	\N	LOW	The teacher noticed a change in the student's behaviour.	/bɪˈheɪvjər/	hành vi, cư xử	n	behaviour	2
49	\N	LOW	She had a very happy childhood in the countryside.	/ˈtʃaɪldhʊd/	tuổi thơ	n	childhood	2
50	\N	LOW	Infants gradually learn the concept of cause and effect.	/ˈkɒnsept/	ý tưởng, khái niệm	n	concept	2
51	\N	LOW	You must accept the consequences of your actions.	/ˈkɒnsɪkwəns/	hậu quả	n	consequence	2
52	\N	LOW	He made a rude gesture with his hand.	/ˈdʒestʃə(r)/	cử chỉ	n	gesture	2
53	\N	LOW	The baby's growth was monitored closely by the doctor.	/ɡrəʊθ/	sự phát triển	n	growth	2
54	\N	LOW	She is the same height as her mother.	/haɪt/	chiều cao	n	height	2
55	\N	LOW	Children often have a very vivid imagination.	/ɪˌmædʒɪˈneɪʃn/	trí tưởng tượng	n	imagination	2
56	\N	LOW	The disease is rare in infancy.	/ˈɪnfənsi/	thời kỳ sơ sinh	n	infancy	2
57	\N	LOW	The infant was sleeping peacefully in the crib.	/ˈɪnfənt/	trẻ sơ sinh	n	infant	2
58	\N	LOW	He has a deep knowledge of ancient history.	/ˈnɒlɪdʒ/	kiến thức	n	knowledge	2
59	\N	LOW	The boy showed great maturity in handling the problem.	/məˈtʃʊərəti/	sự trưởng thành	n	maturity	2
60	\N	LOW	I have a very poor memory for names.	/ˈmeməri/	trí nhớ	n	memory	2
61	\N	LOW	Walking is a major milestone in a child's development.	/ˈmaɪlstəʊn/	cột mốc (phát triển)	n	milestone	2
62	\N	LOW	Keep your mind active by reading regularly.	/maɪnd/	trí óc	n	mind	2
63	\N	LOW	Teenagers are often influenced by their peers.	/pɪəz/	bạn bè đồng trang lứa	n	peers	2
64	\N	LOW	The study covered a period of ten years.	/ˈpɪəriəd/	giai đoạn	n	period	2
65	\N	LOW	The project is now in its final phase.	/feɪz/	giai đoạn	n	phase	2
66	\N	LOW	Children grow at an astonishing rate.	/reɪt/	tốc độ, tỷ lệ	n	rate	2
67	\N	LOW	The scars served as a constant reminder of the accident.	/rɪˈmaɪndə(r)/	lời nhắc	n	reminder	2
68	\N	LOW	Playing with others helps children develop social skills.	/ˈsəʊʃl skɪlz/	kỹ năng xã hội	n	social skills	2
69	\N	LOW	Learning to cook is a useful life skill.	/skɪl/	kỹ năng	n	skill	2
70	\N	LOW	They are in the early stages of the investigation.	/steɪdʒ/	giai đoạn, sân khấu	n	stage	2
71	\N	LOW	The toddler was taking his first wobbly steps.	/ˈtɑːd.lɚ/	trẻ mới biết đi	n	toddler	2
72	\N	LOW	The transition from childhood to adulthood can be difficult.	/trænˈzɪʃn/	sự chuyển tiếp	n	transition	2
73	\N	LOW	Young children find it hard to understand abstract concepts like 'time'.	/ˈæbstrækt/	trừu tượng	adj	abstract	2
74	\N	LOW	Reading helps a child's cognitive development.	/ˈkɒɡnətɪv/	thuộc nhận thức	adj	cognitive	2
75	\N	LOW	I'm so clumsy; I just dropped another glass.	/ˈklʌmzi/	vụng về	adj	clumsy	2
76	\N	LOW	She has fond memories of her grandmother.	/fɑːnd/	yêu thích	adj	fond	2
77	\N	LOW	A fully-grown elephant is quite massive.	/ˌfʊli ˈɡrəʊn/	phát triển hoàn toàn	adj	fully-grown	2
78	\N	LOW	He is very immature for his age.	/ˌɪməˈtʃʊə(r)/	chưa trưởng thành	adj	immature	2
79	\N	LOW	She is a very independent young woman.	/ˌɪndɪˈpendənt/	độc lập	adj	independent	2
80	\N	LOW	It would be irresponsible to leave the child alone.	/ˌɪrɪˈspɒnsəbl/	vô trách nhiệm	adj	irresponsible	2
81	\N	LOW	She is more mature than most people her age.	/məˈtʃʊə(r)/	trưởng thành	adj	mature	2
82	\N	LOW	You need to be patient when teaching children.	/ˈpeɪʃnt/	kiên nhẫn	adj	patient	2
83	\N	LOW	She went through a rebellious phase in her teens.	/rɪˈbeljəs/	nổi loạn	adj	rebellious	2
84	\N	LOW	There has been a significant increase in prices.	/sɪɡˈnɪfɪkənt/	đáng kể, quan trọng	adj	significant	2
85	\N	LOW	We should be more tolerant of different views.	/ˈtɒlərənt/	khoan dung	adj	tolerant	2
86	\N	LOW	The baby took a few unsteady steps towards her dad.	/ʌnˈstɛdi/	không ổn định	adj	unsteady	2
87	\N	LOW	Children acquire language skills very quickly.	/əˈkwaɪə(r)/	đạt được, tiếp thu	v	acquire	2
88	\N	LOW	The company is developing a new software program.	/dɪˈveləp/	phát triển	v	develop	2
89	\N	LOW	The business has grown rapidly this year.	/ɡrəʊ/	lớn lên, phát triển	v	grow	2
90	\N	LOW	Parrots can imitate human speech.	/ˈɪmɪteɪt/	bắt chước	v	imitate	2
91	\N	LOW	When I look back on my school days, I realize how lucky I was.	/lʊk bæk/	nhìn lại, hồi tưởng	phr v	look back	2
92	\N	LOW	It takes years to master a foreign language.	/ˈmɑːstə(r)/	thành thạo	v	master	2
93	\N	LOW	I don't remember seeing him at the party.	/rɪˈmembə(r)/	nhớ	v	remember	2
94	\N	LOW	Please remind me to call her tomorrow.	/rɪˈmaɪnd/	nhắc nhở	v	remind	2
95	\N	LOW	My grandparents love to reminisce about the old days.	/ˌremɪˈnɪs/	hồi tưởng	v	reminisce	2
96	\N	LOW	The toddler threw a tantrum because he couldn't have the toy.	/θrəʊ ə ˈtæntrəm/	ăn vạ, nổi cơn giận	v phr	throw a tantrum	2
97	\N	LOW	Try to visualise the final result before you start.	/ˈvɪʒuəlaɪz/	hình dung	v	visualise	2
98	\N	LOW	He developed a severe nut allergy as a child.	/ˈælərdʒi/	dị ứng	n	allergy	3
99	\N	LOW	Yoga and meditation are effective ways to manage anxiety.	/æŋˈzaɪəti/	lo âu, sự lo lắng	n	anxiety	3
100	\N	LOW	A walk in the fresh air always gives me a good appetite.	/ˈæpɪtaɪt/	sự thèm ăn	n	appetite	3
101	\N	LOW	Hardening of the arteries is a major cause of heart disease.	/ˈɑːtəri/	động mạch	n	artery	3
102	\N	LOW	Good health is arguably the most valuable asset a person can have.	/ˈæset/	tài sản	n	asset	3
103	\N	LOW	The health benefits of a balanced diet are well-documented.	/ˈbɛnɪfɪt/	lợi ích	n	benefit	3
104	\N	LOW	Many people struggle with cravings for sugary snacks in the afternoon.	/ˈkreɪvɪŋz/	cảm giác thèm ăn mạnh mẽ	n	cravings	3
105	\N	LOW	Regular physical activity can help alleviate symptoms of depression.	/dɪˈprɛʃən/	trầm cảm	n	depression	3
106	\N	LOW	The doctor is still waiting for the results before making a final diagnosis.	/ˌdaɪəɡˈnəʊsɪs/	chẩn đoán	n	diagnosis	3
107	\N	LOW	It is important to maintain a healthy, balanced diet.	/ˈdaɪət/	chế độ ăn uống	n	diet	3
108	\N	LOW	The dietician recommended increasing the intake of leafy greens.	/ˌdaɪəˈtɪʃən/	chuyên gia dinh dưỡng	n	dietician	3
109	\N	LOW	Chronic diseases like diabetes require long-term management.	/dɪˈziːz/	bệnh lý	n	disease	3
110	\N	LOW	He was treated for a minor digestive disorder.	/dɪsˈɔːdə(r)/	rối loạn	n	disorder	3
111	\N	LOW	Lack of exercise is a leading cause of obesity.	/ˈɛksəsaɪz/	bài tập thể dục	n	exercise	3
112	\N	LOW	Stress is often a contributing factor to high blood pressure.	/ˈfæktə(r)/	yếu tố	n	factor	3
113	\N	LOW	The high salt content in fast food can be detrimental to your health.	/ˈfæst fuːd/	thực phẩm nhanh	n	fast food	3
114	\N	LOW	Try to cut down on foods that are high in saturated fat.	/fæt/	mỡ, chất béo	n	fat	3
115	\N	LOW	Smoking causes serious harm to the lungs.	/hɑːm/	sự tổn hại, thiệt hại	n	harm	3
116	\N	LOW	Public health campaigns aim to reduce the rate of smoking.	/hɛlθ/	sức khỏe	n	health	3
117	\N	LOW	He is recovering well after suffering a mild heart attack.	/hɑːt əˈtæk/	cơn đau tim	n	heart attack	3
118	\N	LOW	Always clean a wound properly to prevent infection.	/ɪnˈfɛkʃən/	nhiễm trùng	n	infection	3
119	\N	LOW	Check the label to see the list of ingredients in the product.	/ɪnˈɡriːdiənts/	thành phần (nguyên liệu)	n	ingredients	3
120	\N	LOW	Stress at work can often lead to insomnia.	/ɪnˈsəʊmniə/	mất ngủ	n	insomnia	3
121	\N	LOW	You should lower your daily intake of sugar and salt.	/ˈɪnteɪk/	lượng tiêu thụ, sự hấp thụ	n	intake	3
122	\N	LOW	Kids should be encouraged to eat fruit instead of junk food.	/dʒʌŋk fuːd/	thức ăn nhanh không tốt cho sức khỏe	n	junk food	3
123	\N	LOW	He goes to the gym to build muscle and stay fit.	/ˈmʌsl/	cơ bắp	n	muscle	3
124	\N	LOW	Vegetables are rich in essential nutrients.	/ˈnjuːtrɪənt/	dinh dưỡng	n	nutrient	3
125	\N	LOW	Good nutrition is vital for a child's development.	/njuːˈtrɪʃən/	dinh dưỡng	n	nutrition	3
126	\N	LOW	Obesity is becoming a major public health crisis worldwide.	/əʊˈbiːsɪti/	béo phì	n	obesity	3
127	\N	LOW	Early treatment can delay the onset of the disease.	/ˈɒnsɛt/	sự bắt đầu (bệnh tật)	n	onset	3
128	\N	LOW	The restaurant serves very generous portions of pasta.	/ˈpɔːʃən/	phần (lượng ăn)	n	portion	3
129	\N	LOW	A sedentary lifestyle increases the risk of heart disease.	/rɪsk/	rủi ro	n	risk	3
130	\N	LOW	The recipe makes enough for four servings.	/ˈsɜːvɪŋ/	khẩu phần ăn	n	serving	3
131	\N	LOW	He's under a lot of stress because of his exams.	/strɛs/	căng thẳng, stress	n	stress	3
132	\N	LOW	The doctor warned that high blood pressure can lead to a stroke.	/strəʊk/	đột quỵ	n	stroke	3
133	\N	LOW	She is responding well to the medical treatment.	/ˈtriːtmənt/	sự điều trị	n	treatment	3
134	\N	LOW	Physical therapy can help people regain their mobility after an injury.	/ˈθɛrəpi/	liệu pháp điều trị	n	therapy	3
135	\N	LOW	A variety of different exercises will keep your workout interesting.	/vəˈraɪəti/	sự đa dạng	n	variety	3
136	\N	LOW	He has been trying to lose weight for several months.	/weɪt/	cân nặng	n	weight	3
137	\N	LOW	She was admitted to the hospital with acute abdominal pain.	/əˈkjuːt/	cấp tính, dữ dội	adj	acute	3
138	\N	LOW	I am allergic to cat fur.	/əˈlɜːdʒɪk/	dị ứng	adj	allergic	3
139	\N	LOW	You can use honey as an alternate sweetener to sugar.	/ɔːlˈtɜːnət/	thay thế	adj	alternate	3
140	\N	LOW	Taking a brisk walk daily can improve cardiovascular health.	/brɪsk/	mạnh mẽ, nhanh chóng	adj	brisk	3
141	\N	LOW	Chronic stress can lead to various health problems.	/ˈkrɒnɪk/	mãn tính	adj	chronic	3
142	\N	LOW	Excessive sun exposure is harmful to the skin.	/ˈhɑːmfəl/	có hại	adj	harmful	3
143	\N	LOW	Staying hydrated is a healthy habit to maintain.	/ˈhɛlθi/	khỏe mạnh	adj	healthy	3
144	\N	LOW	Flu is a highly infectious disease.	/ɪnˈfɛkʃəs/	mang tính truyền nhiễm	adj	infectious	3
145	\N	LOW	Moderate exercise is recommended for people of all ages.	/ˈmɒdəreɪt/	vừa phải, điều độ	adj	moderate	3
146	\N	LOW	A person is considered obese if their BMI is over 30.	/əʊˈbiːs/	béo phì	adj	obese	3
147	\N	LOW	Being slightly overweight can increase the strain on your joints.	/ˌəʊvəˈweɪt/	thừa cân	adj	overweight	3
148	\N	LOW	If you have a persistent cough, you should see a doctor.	/pəˈsɪstənt/	dai dẳng	adj	persistent	3
149	\N	LOW	Regular check-ups are essential for early disease detection.	/ˈrɛɡjʊlə(r)/	đều đặn	adj	regular	3
150	\N	LOW	Sleep plays a vital role in physical and mental health.	/ˈvaɪtl/	quan trọng, thiết yếu	adj	vital	3
151	\N	LOW	Avoid processed foods to maintain a better diet.	/əˈvɔɪd/	tránh, né tránh	v	avoid	3
152	\N	LOW	The medicine is designed to counteract the effects of the poison.	/ˌkaʊntərˈækt/	chống lại, khắc phục	v	counteract	3
153	\N	LOW	We need to curb our consumption of fatty foods.	/kɜːb/	kiềm chế, hạn chế	v	curb	3
154	\N	LOW	Antibiotics are used to cure bacterial infections.	/kjʊə(r)/	chữa trị	v	cure	3
155	\N	LOW	The pain slowly began to diminish after he took the pill.	/dɪˈmɪnɪʃ/	giảm bớt	v	diminish	3
156	\N	LOW	Drinking coffee late at night can disrupt your sleep pattern.	/dɪsˈrʌpt/	làm gián đoạn	v	disrupt	3
157	\N	LOW	You should try to eliminate stress from your life as much as possible.	/ɪˈlɪmɪneɪt/	loại bỏ	v	eliminate	3
158	\N	LOW	It can be difficult to maintain a healthy weight without exercise.	/meɪnˈteɪn/	duy trì	v	maintain	3
159	\N	LOW	Don't overdo the exercise if you haven't been active for a while.	/ˌəʊvərˈduː/	làm quá mức	v	overdo	3
160	\N	LOW	If you overeat regularly, you will inevitably gain weight.	/ˌəʊvərˈiːt/	ăn quá mức	v	overeat	3
161	\N	LOW	Vaccination is the best way to prevent certain diseases.	/prɪˈvɛnt/	ngăn ngừa	v	prevent	3
162	\N	LOW	Doctors recommend eating at least five portions of fruit and veg a day.	/ˌrɛkəˈmɛnd/	khuyến nghị	v	recommend	3
163	\N	LOW	It took him nearly a month to fully recover from the flu.	/rɪˈkʌvə(r)/	phục hồi	v	recover	3
164	\N	LOW	Walking instead of driving helps reduce carbon emissions and keeps you fit.	/rɪˈdjuːs/	giảm bớt	v	reduce	3
165	\N	LOW	You should never skip breakfast as it's the most important meal of the day.	/skɪp/	bỏ qua	v	skip	3
166	\N	LOW	Exercise stimulates the release of endorphins, which make you feel happy.	/ˈstɪmjʊleɪt/	kích thích	v	stimulate	3
167	\N	LOW	Cold weather can sometimes trigger an asthma attack.	/ˈtrɪɡə(r)/	gây ra, kích hoạt	v	trigger	3
168	\N	LOW	Physical activity is an essential part of a healthy lifestyle.	/ækˈtɪvəti/	hoạt động	n	activity	4
169	\N	LOW	The medical team is looking at every aspect of her health.	/ˈæspekt/	khía cạnh, mặt (của vấn đề)	n	aspect	4
170	\N	LOW	He has a very positive attitude towards his work.	/ˈætɪtjuːd/	quan điểm sống, thái độ	n	attitude	4
171	\N	LOW	It can be difficult to maintain a healthy work-life balance.	/ˈbæləns/	sự cân bằng	n	balance	4
172	\N	LOW	There is a lot of competition for jobs in the creative industries.	/ˌkɒmpəˈtɪʃn/	sự cạnh tranh, cuộc thi	n	competition	4
173	\N	LOW	The job allows me to use my creativity to solve problems.	/ˌkriːeɪˈtɪvəti/	sự sáng tạo, óc sáng tạo	n	creativity	4
174	\N	LOW	I try to include some exercise in my daily routine.	/ˌdeɪli ruːˈtiːn/	nếp sinh hoạt, thói quen hằng ngày	n phr	daily routine	4
175	\N	LOW	She has a strong desire to travel the world.	/dɪˈzaɪə(r)/	sự khao khát, mong muốn	n	desire	4
176	\N	LOW	To avoid disappointment, it's best to book your tickets early.	/ˌdɪsəˈpɔɪntmənt/	sự thất vọng	n	disappointment	4
177	\N	LOW	I had a wonderful experience while trekking in the Himalayas.	/ɪkˈspɪəriəns/	kinh nghiệm, trải nghiệm	n	experience	4
178	\N	LOW	Helping others brings her a great sense of fulfillment.	/fʊlˈfɪlmənt/	sự mãn nguyện, cảm giác trọn vẹn	n	fulfillment	4
179	\N	LOW	Her ultimate goal is to become a successful entrepreneur.	/ɡəʊl/	mục tiêu	n	goal	4
180	\N	LOW	My main hobby is photography, but I also enjoy hiking.	/ˈhɒbi/	sở thích	n	hobby	4
181	\N	LOW	The book gives us a fascinating insight into life in the 19th century.	/ˈɪnsaɪt/	cái nhìn sâu sắc, sự thấu hiểu	n	insight	4
182	\N	LOW	In my leisure time, I like to read and listen to music.	/ˈleʒə(r)/	thời gian nhàn rỗi, sự thư giãn	n	leisure	4
183	\N	LOW	Many people are changing their lifestyle to be more eco-friendly.	/ˈlaɪfstaɪl/	lối sống, phong cách sống	n	lifestyle	4
184	\N	LOW	As an optimist, he always looks for the silver lining in every situation.	/ˈɒptɪmɪst/	người lạc quan	n	optimist	4
185	\N	LOW	Travelling can give you a much broader outlook on life.	/ˈaʊtlʊk/	quan điểm, cách nhìn	n	outlook	4
186	\N	LOW	Don't miss this opportunity to study abroad.	/ˌɒpəˈtjuːnəti/	cơ hội	n	opportunity	4
187	\N	LOW	She has a very outgoing and friendly personality.	/ˌpɜːsəˈnæləti/	tính cách, cá tính	n	personality	4
188	\N	LOW	You don't have to be a pessimist to see that the plan has flaws.	/ˈpesɪmɪst/	người bi quan	n	pessimist	4
189	\N	LOW	My first priority is to find a place to live.	/praɪˈɒrəti/	sự ưu tiên	n	priority	4
190	\N	LOW	He's under a lot of pressure at work lately.	/ˈpreʃə(r)/	áp lực	n	pressure	4
191	\N	LOW	I'm a realist, so I know this project will take a lot of hard work.	/ˈrɪəlɪst/	người thực tế	n	realist	4
192	\N	LOW	Successful entrepreneurs are often natural risk-takers.	/ˈrɪsk teɪkə(r)/	người ưa mạo hiểm	n	risk-taker	4
193	\N	LOW	Art is a powerful form of self-expression.	/ˌself ɪkˈspreʃn/	sự tự thể hiện bản thân	n	self-expression	4
194	\N	LOW	Having a good sense of humor helps you deal with stress.	/sens/	ý thức, cảm giác	n	sense	4
195	\N	LOW	She remains active in the local community even after retirement.	/ˈæktɪv/	năng động, tích cực	adj	active	4
196	\N	LOW	I'm bored with doing the same thing every day.	/bɔːd/	chán nản	adj	bored	4
197	\N	LOW	I'm a bit confused about the new office rules.	/kənˈfjuːzd/	bối rối, hoang mang	adj	confused	4
198	\N	LOW	If you are dissatisfied with the service, you should complain.	/dɪˈsætɪsfaɪd/	không hài lòng, bất mãn	adj	dissatisfied	4
199	\N	LOW	The competition between the two athletes was very intense.	/ɪnˈtens/	cường độ cao, mãnh liệt	adj	intense	4
200	\N	LOW	Our society is often criticized for being too materialistic.	/məˌtɪəriəˈlɪstɪk/	thực dụng, chủ nghĩa vật chất	adj	materialistic	4
201	\N	LOW	Try to stay away from people who have a negative influence on you.	/ˈneɡətɪv/	tiêu cực	adj	negative	4
202	\N	LOW	If you love nature, you'll enjoy these outdoor activities.	/ˈaʊtdɔː(r)/	(thuộc) ngoài trời	adj	outdoor	4
203	\N	LOW	Having a positive mindset is key to achieving success.	/ˈpɒzətɪv/	tích cực	adj	positive	4
204	\N	LOW	The park provides various recreational facilities for families.	/ˌrekriˈeɪʃənl/	giải trí, tiêu khiển	adj	recreational	4
205	\N	LOW	He is a very successful businessman with a global reputation.	/səkˈsesfl/	thành công	adj	successful	4
206	\N	LOW	With hard work, you can achieve anything you set your mind to.	/əˈtʃiːv/	đạt được, gặt hái	v	achieve	4
207	\N	LOW	The idea of working from home really appeals to me.	/əˈpiːl/	hấp dẫn	v	appeal	4
208	\N	LOW	The beautiful scenery attracts thousands of tourists every year.	/əˈtrækt/	thu hút	v	attract	4
209	\N	LOW	It's important to choose a career that you are passionate about.	/tʃuːz/	lựa chọn	v	choose	4
210	\N	LOW	Music is a great way to express your emotions.	/ɪkˈspres/	bày tỏ, thể hiện	v	express	4
211	\N	LOW	I really enjoy spending time with my family at the weekend.	/ɪnˈdʒɔɪ/	tận hưởng, thích thú	v	enjoy	4
212	\N	LOW	He finally managed to fulfil his dream of becoming a pilot.	/fʊlˈfɪl/	hoàn thành, đáp ứng	v	fulfil	4
213	\N	LOW	I'm taking an English course to improve my speaking skills.	/ɪmˈpruːv/	cải thiện, nâng cao	v	improve	4
214	\N	LOW	A good teacher knows how to motivate their students.	/ˈməʊtɪveɪt/	thúc đẩy, tạo động lực	v	motivate	4
215	\N	LOW	Everyone is encouraged to participate in the discussion.	/pɑːˈtɪsɪpeɪt/	tham gia	v	participate	4
216	\N	LOW	I regret not studying harder when I was at school.	/rɪˈɡret/	hối tiếc	v	regret	4
217	\N	LOW	Listening to soft music helps me relax after a long day.	/rɪˈlæks/	thư giãn	v	relax	4
218	\N	LOW	We aim to satisfy all our customers' needs.	/ˈsætɪsfaɪ/	làm hài lòng, thỏa mãn	v	satisfy	4
219	\N	LOW	The students were given a week to complete their writing assignment.	/əˈsaɪnmənt/	nhiệm vụ, bài tập được giao	n	assignment	5
220	\N	LOW	After finishing high school, she plans to go to a local college.	/ˈkɒlɪdʒ/	trường đại học, cao đẳng	n	college	5
221	\N	LOW	There is a lot of controversy surrounding the new tuition fee policy.	/kənˈtrɒvəsi/	cuộc tranh cãi, sự phản đối	n	controversy	5
222	\N	LOW	The school is adding more coding classes to its curriculum.	/kəˈrɪkjʊləm/	chương trình học (tổng thể)	n	curriculum	5
223	\N	LOW	He is currently writing his dissertation on renewable energy sources.	/ˌdɪsəˈteɪʃn/	luận văn, luận án (thường là bậc Master/PhD)	n	dissertation	5
224	\N	LOW	Every child should have access to a quality primary education.	/ˌedʒʊˈkeɪʃn/	giáo dục	n	education	5
225	\N	LOW	Students are feeling stressed about their final exams next week.	/ɪɡˈzæm/	kỳ thi	n	exam	5
226	\N	LOW	She is an expert in the field of molecular biology.	/fiːld/	lĩnh vực (học tập)	n	field (of study)	5
227	\N	LOW	The findings of the study suggest that sleep affects academic performance.	/ˈfaɪndɪŋz/	kết quả nghiên cứu	n	findings	5
228	\N	LOW	The research project was cancelled due to a lack of funding.	/ˈfʌndɪŋ/	tài trợ, sự cấp vốn	n	funding	5
229	\N	LOW	He was very happy to receive an 'A' grade on his math test.	/ɡreɪd/	điểm số, loại	n	grade	5
230	\N	LOW	My whole family attended my university graduation ceremony.	/ˌɡrædʒuˈeɪʃn/	lễ tốt nghiệp, sự tốt nghiệp	n	graduation	5
231	\N	LOW	They received a government grant to continue their scientific research.	/ɡrænt/	khoản trợ cấp, sự tài trợ	n	grant	5
232	\N	LOW	In many countries, high school covers students aged 15 to 18.	/ˈhaɪ skuːl/	trường cấp 3	n	high school	5
233	\N	LOW	The teacher told us to do our homework before coming to class.	/ˈhəʊm.wɜːk/	bài tập về nhà	n	homework	5
234	\N	LOW	My younger brother is still at junior school.	/ˈdʒuːnɪə skuːl/	trường tiểu học (7-11 tuổi tại Anh)	n	junior school	5
235	\N	LOW	Children often learn basic social skills in kindergarten.	/ˈkɪndəɡɑːtn/	mẫu giáo	n	kindergarten	5
236	\N	LOW	Dyslexia is one of the most common learning disorders.	/ˈlɜːnɪŋ dɪsˈɔːdə(r)/	rối loạn học tập	n	learning disorder	5
237	\N	LOW	The lecturer explained the complex theory very clearly.	/ˈlektʃərər/	giảng viên	n	lecturer	5
238	\N	LOW	I often spend my afternoons studying at the university library.	/ˈlaɪbrəri/	thư viện	n	library	5
239	\N	LOW	There are strict limits on how many words your essay can have.	/ˈlɪmɪts/	giới hạn	n	limits	5
240	\N	LOW	He is planning to get a Masters in Business Administration (MBA).	/ˈmɑːstərz/	bằng thạc sĩ	n	Masters	5
241	\N	LOW	They send their daughter to a nursery while they are at work.	/ˈnɜːsəri/	nhà trẻ, mẫu giáo (2-4 tuổi)	n	nursery	5
242	\N	LOW	She spent four years researching for her PhD in history.	/ˌpiː eɪtʃ ˈdiː/	tiến sĩ	n	PhD	5
243	\N	LOW	Primary school is the first stage of formal education.	/ˈpraɪməri skuːl/	trường tiểu học	n	primary school	5
244	\N	LOW	Our university offers an excellent exchange program with Japan.	/ˈprəʊɡræm/	chương trình	n	program	5
245	\N	LOW	The group project required us to interview local business owners.	/ˈprɒdʒekt/	dự án, kế hoạch	n	project	5
246	\N	LOW	Scientific research often takes years to yield significant results.	/rɪˈsɜːtʃ/	nghiên cứu	n	research	5
247	\N	LOW	The internet is a vast resource for students and teachers.	/rɪˈsɔːsɪz/	tài nguyên, nguồn lực	n	resources	5
248	\N	LOW	Students are nervously waiting for their test results.	/rɪˈzʌlts/	kết quả	n	results	5
249	\N	LOW	She won a full scholarship to study at Oxford University.	/ˈskɒləʃɪp/	học bổng (dựa trên thành tích)	n	scholarship	5
250	\N	LOW	That topic is outside the scope of this particular course.	/skəʊp/	phạm vi	n	scope	5
251	\N	LOW	Students move to secondary school after finishing primary school.	/ˈsekəndri skuːl/	trường cấp 2	n	secondary school	5
252	\N	LOW	You must cite all your sources in the bibliography.	/ˈsɔːsɪz/	nguồn tài liệu	n	sources	5
253	\N	LOW	The lecturer handed out the syllabus on the first day of class.	/ˈsɪləbəs/	đề cương môn học	n	syllabus	5
254	\N	LOW	The first task was to identify the main problem in the case study.	/tɑːsk/	nhiệm vụ, công việc	n	task	5
255	\N	LOW	We studied Einstein's theory of relativity in physics today.	/ˈθɪəri/	lý thuyết	n	theory	5
256	\N	LOW	She submitted her final thesis on urban planning last week.	/ˈθiːsɪs/	luận văn (thường bậc Bachelor/Master)	n	thesis	5
257	\N	LOW	A private tutor can help students who are struggling with math.	/ˈtjuːtə(r)/	gia sư, người hướng dẫn	n	tutor	5
258	\N	LOW	Choosing a narrow topic makes it easier to write a good essay.	/ˈtɒpɪk/	chủ đề	n	topic	5
259	\N	LOW	Going to university is a great way to meet people from different backgrounds.	/ˌjuːnɪˈvɜːsɪti/	trường đại học	n	university	5
260	\N	LOW	The school year is divided into two academic semesters.	/ˌækəˈdɛmɪk/	thuộc về học thuật	adj	academic	5
261	\N	LOW	Only students with a GPA of 3.5 are eligible for the scholarship.	/ˈelɪdʒəbl/	đủ điều kiện	adj	eligible	5
262	\N	LOW	She attended a mixed school with both boys and girls.	/mɪkst/	hỗn hợp, kết hợp	adj	mixed	5
263	\N	LOW	The university offers a variety of postgraduate degrees.	/ˌpəʊstˈɡrædʒuət/	sau đại học	adj	postgraduate	5
264	\N	LOW	Please make sure your essay only includes relevant information.	/ˈreləvənt/	liên quan, thích hợp	adj	relevant	5
265	\N	LOW	As a senior student, she was expected to mentor the freshmen.	/ˈsiːnɪə(r)/	cao cấp, lão luyện	adj	senior	5
266	\N	LOW	Some parents prefer to send their children to single-sex schools.	/ˈsɪŋɡl seks/	trường dành cho một giới tính	adj	single-sex	5
267	\N	LOW	He was a very studious child who always had his nose in a book.	/ˈstjuːdiəs/	chăm chỉ, cần cù	adj	studious	5
268	\N	LOW	Many students take part-time jobs for work-related experience.	/wɜːk rɪˈleɪtɪd/	liên quan đến công việc	adj	work-related	5
269	\N	LOW	We decided to adopt a more hands-on approach to learning.	/əˈdɒpt/	áp dụng (phương pháp)	v	adopt (an approach)	5
270	\N	LOW	Researchers need to analyse the data carefully before publishing.	/ˈænəlaɪz/	phân tích	v	analyse	5
271	\N	LOW	The scientist conducted a series of experiments in the lab.	/kənˈdʌkt/	tiến hành, tổ chức	v	conduct	5
272	\N	LOW	It's hard to concentrate on your studies if the room is noisy.	/ˈkɒnsəntreɪt/	tập trung	v	concentrate	5
273	\N	LOW	You should consider studying abroad to broaden your horizons.	/kənˈsɪdə(r)/	cân nhắc, xem xét	v	consider	5
274	\N	LOW	I need to find out when the deadline for the application is.	/faɪnd aʊt/	tìm ra, khám phá	v	find out	5
275	\N	LOW	He graduated from university with honors last year.	/ˈɡrædʒueɪt/	tốt nghiệp	v	graduate	5
276	\N	LOW	Students learn about ancient civilizations in history class.	/lɜːn/	học hỏi	v	learn (about)	5
277	\N	LOW	The school organised a trip to the local science museum.	/ˈɔːɡənaɪz/	tổ chức	v	organise	5
278	\N	LOW	She had to overcome many obstacles to complete her degree.	/ˌəʊvərˈkʌm/	vượt qua	v	overcome	5
279	\N	LOW	It's a good idea to review your notes every evening.	/rɪˈvjuː/	xem lại, ôn tập	v	review	5
280	\N	LOW	I spent the entire weekend revising for my biology exam.	/rɪˈvaɪz/	sửa đổi, ôn tập (chuẩn bị thi)	v	revise	5
281	\N	LOW	Many international students struggle with the language barrier at first.	/ˈstrʌɡl/	vật lộn, gặp khó khăn	v	struggle	5
282	\N	LOW	I'm going to take an online course on digital marketing.	/teɪk/	tham gia (một khóa học)	v	take (a course)	5
283	\N	LOW	Language learners should focus on both fluency and accuracy.	/ˈækjʊrəsi/	độ chính xác	n	accuracy	6
284	\N	LOW	Effective communication is essential for a successful marriage.	/kəˌmjuːnɪˈkeɪʃn/	sự giao tiếp	n	communication	6
285	\N	LOW	He found it difficult to grasp the abstract concept of linguistics.	/ˈkɒnsept/	khái niệm	n	concept	6
286	\N	LOW	What you are saying is mere conjecture; there is no evidence.	/kənˈdʒektʃə(r)/	sự phỏng đoán	n	conjecture	6
287	\N	LOW	They speak a local dialect that is quite hard for outsiders to understand.	/ˈdaɪəlekt/	phương ngữ	n	dialect	6
288	\N	LOW	Daily practice is the only way to achieve native-like fluency.	/ˈfluːənsi/	sự trôi chảy	n	fluency	6
289	\N	LOW	She made a rude gesture with her hand.	/ˈdʒestʃə(r)/	cử chỉ	n	gesture	6
290	\N	LOW	After a slight hesitation, she agreed to help me.	/ˌhezɪˈteɪʃn/	sự do dự	n	hesitation	6
291	\N	LOW	English is a global language used in science and aviation.	/ˈlæŋɡwɪdʒ/	ngôn ngữ	n	language	6
292	\N	LOW	The language barrier made it difficult for the tourists to order food.	/ˈlæŋɡwɪdʒ ˈbæriə(r)/	rào cản ngôn ngữ	n	language barrier	6
293	\N	LOW	As a linguist, she studies the structure and evolution of human speech.	/ˈlɪŋɡwɪst/	nhà ngôn ngữ học	n	linguist	6
294	\N	LOW	Linguistics is the scientific study of language and its structure.	/lɪŋˈɡwɪstɪks/	ngôn ngữ học	n	linguistics	6
295	\N	LOW	Social media has become a primary means of communication for young people.	/miːnz əv kəˌmjuːnɪˈkeɪʃn/	phương tiện giao tiếp	n	means of communication	6
296	\N	LOW	Even though she lives abroad, she still speaks her mother tongue at home.	/ˈmʌðə tʌŋ/	tiếng mẹ đẻ	n	mother tongue	6
297	\N	LOW	It is helpful to practice speaking with a native speaker.	/ˈneɪtɪv ˈspiːkə(r)/	người bản ngữ	n	native speaker	6
298	\N	LOW	I'm working on my English pronunciation to be more easily understood.	/prəˌnʌnsiˈeɪʃn/	cách phát âm	n	pronunciation	6
299	\N	LOW	Sign language is used by people who are deaf or hard of hearing.	/ˈsaɪn ˈlæŋɡwɪdʒ/	ngôn ngữ ký hiệu	n	sign language	6
300	\N	LOW	Reading books is a great way to expand your vocabulary.	/vəˈkæbjʊləri/	từ vựng	n	vocabulary	6
301	\N	LOW	The witness was so nervous that her testimony was incoherent.	/ˌɪnkəʊˈhɪərənt/	không mạch lạc	adj	incoherent	6
302	\N	LOW	There are inherent risks in any investment.	/ɪnˈhɪərənt/	vốn có	adj	inherent	6
303	\N	LOW	Modern communication systems use highly sophisticated technology.	/səˈfɪstɪkeɪtɪd/	tinh vi, phức tạp	adj	sophisticated	6
304	\N	LOW	The crowd broke into spontaneous applause after the speech.	/spɒnˈteɪniəs/	tự phát	adj	spontaneous	6
305	\N	LOW	Could you clarify what you mean by that statement?	/ˈklærɪfaɪ/	làm rõ	v	clarify	6
306	\N	LOW	He uses his phone to communicate with his family back home.	/kəˈmjuːnɪkeɪt/	giao tiếp	v	communicate	6
307	\N	LOW	I fail to comprehend why he would make such a decision.	/ˌkɒmprɪˈhend/	hiểu	v	comprehend	6
308	\N	LOW	The jury concluded that the defendant was not guilty.	/kənˈkluːd/	kết luận	v	conclude	6
309	\N	LOW	Please click the link in your email to confirm your registration.	/kənˈfɜːm/	xác nhận	v	confirm	6
310	\N	LOW	They sat on the bench and conversed for hours.	/kənˈvɜːs/	trò chuyện	v	converse	6
311	\N	LOW	How would you define the word 'success'?	/dɪˈfaɪn/	định nghĩa	v	define	6
312	\N	LOW	He demonstrated how to use the new software to the team.	/ˈdemənstreɪt/	minh họa, chứng minh	v	demonstrate	6
313	\N	LOW	It's difficult to distinguish between the two identical twins.	/dɪˈstɪŋɡwɪʃ/	phân biệt	v	distinguish	6
314	\N	LOW	New evidence has emerged that could change the trial's outcome.	/ɪˈmɜːdʒ/	xuất hiện	v	emerge	6
315	\N	LOW	Languages evolve over time as new words are created.	/ɪˈvɒlv/	phát triển, tiến hóa	v	evolve	6
316	\N	LOW	Can you explain the rules of the game to me?	/ɪkˈspleɪn/	giải thích	v	explain	6
317	\N	LOW	Children often use art to express their feelings.	/ɪkˈspres/	thể hiện	v	express	6
318	\N	LOW	The lecturer used examples to illustrate his point.	/ˈɪləstreɪt/	minh họa	v	illustrate	6
319	\N	LOW	Are you implying that I am lying?	/ɪmˈplaɪ/	ngụ ý	v	imply	6
320	\N	LOW	The map indicates that the station is two blocks away.	/ˈɪndɪkeɪt/	chỉ ra	v	indicate	6
321	\N	LOW	I'm not sure how to pronounce this name correctly.	/prəˈnaʊns/	phát âm	v	pronounce	6
322	\N	LOW	I can't recall exactly what she said during the meeting.	/rɪˈvjuː/	nhớ lại	v	recall	6
323	\N	LOW	The doctor referred to the latest research in his report.	/rɪˈfɜː(r)/	đề cập đến	v	refer (to)	6
324	\N	LOW	A red light signifies that you must stop.	/ˈsɪɡnɪfaɪ/	biểu thị	v	signify	6
325	\N	LOW	The witness stated that he saw the accident clearly.	/steɪt/	tuyên bố	v	state	6
326	\N	LOW	He tends to stutter when he's feeling nervous.	/ˈstʌtə(r)/	nói lắp	v	stutter	6
327	\N	LOW	I suggest that we leave early to avoid the traffic.	/səˈdʒest/	đề xuất	v	suggest	6
328	\N	LOW	Can you translate this document into Vietnamese for me?	/trænzˈleɪt/	dịch	v	translate	6
329	\N	LOW	The cost of the tour includes flights and hotel accommodation.	/əˌkʌməˈdeɪʃn/	chỗ ở	n	accommodation	7
330	\N	LOW	The Grand Canyon is one of the biggest tourist attractions in the US.	/əˈtrækʃn/	điểm tham quan	n	attraction	7
331	\N	LOW	Eco-tourism should benefit the local community.	/kəˈmjuːnəti/	cộng đồng	n	community	7
332	\N	LOW	We decided to spend the weekend walking in the countryside.	/ˈkʌntrisaɪd/	vùng nông thôn	n	countryside	7
333	\N	LOW	After a long flight, we finally reached our destination.	/ˌdestɪˈneɪʃn/	điểm đến	n	destination	7
334	\N	LOW	Eco-tourism helps protect the environment while supporting local people.	/ˈiːkəʊ ˌtʊərɪzəm/	du lịch sinh thái	n	eco-tourism	7
335	\N	LOW	The long-term effects of tourism on the island are being studied.	/ɪˈfekt/	ảnh hưởng, tác động	n	effect	7
336	\N	LOW	The hotel offers excellent sports facilities, including a gym and a pool.	/fəˈsɪlətiz/	cơ sở vật chất	n	facilities	7
337	\N	LOW	Please show your identification when checking in at the airport.	/aɪˌdentɪfɪˈkeɪʃn/	giấy tờ tùy thân	n	identification	7
338	\N	LOW	The city has over five million inhabitants.	/ɪnˈhæbɪtənt/	cư dân	n	inhabitant	7
339	\N	LOW	Our travel agent provided us with a detailed itinerary for the trip.	/aɪˈtɪnərəri/	lịch trình	n	itinerary	7
340	\N	LOW	The train journey across the country takes about three days.	/ˈdʒɜːni/	hành trình (thường là dài)	n	journey	7
341	\N	LOW	The desert landscape was beautiful but harsh.	/ˈlændskeɪp/	phong cảnh	n	landscape	7
342	\N	LOW	You are allowed one piece of carry-on luggage.	/ˈlʌɡɪdʒ/	hành lý	n	luggage	7
343	\N	LOW	They reached the mountain peak just before sunset.	/piːk/	đỉnh núi	n	peak	7
344	\N	LOW	The local economy depends heavily on tourism.	/ˈtʊərɪzəm/	ngành du lịch	n	tourism	7
345	\N	LOW	The city center is always crowded with tourists.	/ˈtʊərɪst/	khách du lịch	n	tourist	7
346	\N	LOW	Public transport is the most efficient way to get around the city.	/ˈtrænspɔːt/	phương tiện giao thông	n	transport	7
347	\N	LOW	Air travel has become much cheaper in recent years.	/ˈtrævl/	sự đi lại (nói chung)	n	travel	7
348	\N	LOW	There is a growing trend towards solo travel among young people.	/trend/	xu hướng	n	trend	7
349	\N	LOW	We took a day trip to the coast last Sunday.	/trɪp/	chuyến đi (ngắn)	n	trip	7
350	\N	LOW	It's a quiet village far away from the hustle and bustle of the city.	/ˈvɪlɪdʒ/	ngôi làng	n	village	7
351	\N	LOW	She is an adventurous traveler who loves exploring remote areas.	/ədˈventʃərəs/	thích phiêu lưu	adj	adventurous	7
352	\N	LOW	We stayed in a budget hotel to save money for activities.	/ˈbʌdʒɪt/	giá rẻ	adj	budget	7
353	\N	LOW	The view from the top of the mountain was absolutely breathtaking.	/ˈbreθteɪkɪŋ/	ngoạn mục (đẹp đến nín thở)	adj	breathtaking	7
354	\N	LOW	The coastal road offers stunning views of the ocean.	/ˈkəʊstl/	thuộc vùng biển	adj	coastal	7
355	\N	LOW	London is a very cosmopolitan city with people from all over the world.	/ˌkɒzməˈpɒlɪtən/	mang tính quốc tế, đa văn hóa	adj	cosmopolitan	7
356	\N	LOW	The country has a diverse range of wildlife and habitats.	/daɪˈvɜːs/	đa dạng	adj	diverse	7
357	\N	LOW	My travel dates are flexible, so I can fly whenever it's cheapest.	/ˈfleksəbl/	linh hoạt	adj	flexible	7
358	\N	LOW	Learning a foreign language is helpful when traveling abroad.	/ˈfɒrən/	nước ngoài	adj	foreign	7
359	\N	LOW	We enjoyed tasting the local cuisine at the night market.	/ˈləʊkl/	địa phương	adj	local	7
360	\N	LOW	They spent their honeymoon in a luxurious resort in Maldives.	/lʌɡˈʒʊəriəs/	sang trọng	adj	luxurious	7
361	\N	LOW	The northern part of the country is very mountainous.	/ˈmaʊntənəs/	nhiều núi	adj	mountainous	7
362	\N	LOW	I love the peaceful atmosphere of the countryside.	/ˈpiːsfl/	yên bình	adj	peaceful	7
363	\N	LOW	The town is famous for its picturesque harbor and narrow streets.	/ˌpɪktʃəˈresk/	đẹp như tranh vẽ	adj	picturesque	7
364	\N	LOW	The river is too polluted for swimming.	/pəˈluːtɪd/	ô nhiễm	adj	polluted	7
365	\N	LOW	We stayed in a quaint little cottage in an old village.	/kweɪnt/	cổ kính, độc đáo	adj	quaint	7
366	\N	LOW	They live in a remote area, far from the nearest town.	/rɪˈməʊt/	hẻo lánh	adj	remote	7
367	\N	LOW	The road was very rough, making the journey uncomfortable.	/rʌf/	gồ ghề (đường), động (biển)	adj	rough	7
368	\N	LOW	Rural life is often much slower and quieter than city life.	/ˈrʊərəl/	thuộc nông thôn	adj	rural	7
369	\N	LOW	We took the scenic route through the mountains.	/ˈsiːnɪk/	có phong cảnh đẹp	adj	scenic	7
370	\N	LOW	She looked absolutely stunning in her traditional dress.	/ˈstʌnɪŋ/	tuyệt đẹp (gây ấn tượng mạnh)	adj	stunning	7
371	\N	LOW	The trek was tough, but the views made it worthwhile.	/tʌf/	khó khăn, khắc nghiệt	adj	tough	7
372	\N	LOW	The village is known for its traditional crafts and festivals.	/trəˈdɪʃənl/	truyền thống	adj	traditional	7
373	\N	LOW	This island is one of the few places with truly unspoilt beaches.	/ˌʌnˈspɔɪlt/	chưa bị tàn phá (còn nguyên sơ)	adj	unspoilt	7
374	\N	LOW	Urban planning is crucial for the sustainable growth of cities.	/ˈɜːbən/	thuộc đô thị	adj	urban	7
375	\N	LOW	The bad weather might affect our travel plans.	/əˈfekt/	ảnh hưởng	v	affect	7
376	\N	LOW	Airfares tend to fluctuate depending on the season.	/ˈflʌktʃueɪt/	dao động, biến động	v	fluctuate	7
406	\N	LOW	Modern agriculture relies heavily on technology and irrigation.	/ˈæɡrɪkʌltʃə(r)/	nông nghiệp	n	agriculture	9
407	\N	LOW	Lions are often called the kings of the animal kingdom.	/ˈænɪml ˈkɪŋdəm/	vương quốc động vật	n	animal kingdom	9
408	\N	LOW	Rabbits spend a lot of their time underground in a burrow.	/ˈbʌrəʊ/	hang (thỏ, chuột đào để ở)	n	burrow	9
409	\N	LOW	The global climate is changing at an alarming rate.	/ˈklaɪmət/	khí hậu	n	climate	9
410	\N	LOW	Rice is the main crop grown in this region.	/krɒp/	mùa màng, cây trồng	n	crop(s)	9
411	\N	LOW	There has been a sharp decline in the bee population.	/dɪˈklaɪn/	sự suy giảm	n	decline	9
412	\N	LOW	The mother bear stayed in her den with the cubs all winter.	/den/	hang, sào huyệt (thú dữ như hổ, gấu)	n	den	9
413	\N	LOW	The earthquake was a major natural disaster for the country.	/dɪˈzɑːstə(r)/	thảm họa	n	disaster	9
414	\N	LOW	Killing off top predators can upset the entire ecological balance.	/ˌiːkəˈlɒdʒɪkl ˈbæləns/	cân bằng sinh thái	n	ecological balance	9
415	\N	LOW	She is studying the ecology of tropical rainforests.	/iˈkɒlədʒi/	sinh thái học	n	ecology	9
416	\N	LOW	Darwin's theory of evolution changed how we see the natural world.	/ˌiːvəˈluːʃn/	sự tiến hóa	n	evolution	9
417	\N	LOW	Many species are currently facing the threat of extinction.	/ɪkˈstɪŋkʃn/	sự tuyệt chủng	n	extinction	9
418	\N	LOW	The local fauna includes several species of rare birds.	/ˈfɔːnə/	hệ động vật	n	fauna	9
419	\N	LOW	Desert flora must be able to survive with very little water.	/ˈflɔːrə/	hệ thực vật	n	flora	9
420	\N	LOW	Genetics plays a huge role in determining an animal's traits.	/dʒəˈnetɪks/	di truyền học	n	genetics	9
421	\N	LOW	Polar bears are losing their natural habitat due to melting ice.	/ˈhæbɪtæt/	môi trường sống	n	habitat	9
422	\N	LOW	It is human nature to be curious about the world around us.	/ˈhjuːmən ˈneɪtʃə/	bản tính con người	n	human nature	9
423	\N	LOW	Ants and bees are examples of social insects.	/ˈɪnsekt/	côn trùng	n	insect	9
424	\N	LOW	You cannot argue with Mother Nature when a storm hits.	/ˈmʌðə ˈneɪtʃə/	Mẹ Thiên Nhiên	n	Mother Nature	9
425	\N	LOW	The excessive use of pesticides can harm beneficial insects.	/ˈpestɪsaɪdz/	thuốc trừ sâu	n	pesticides	9
426	\N	LOW	Whales have very few natural predators in the ocean.	/ˈpredətə(r)/	động vật ăn thịt, kẻ săn mồi	n	predator	9
427	\N	LOW	Small rodents are common prey for owls.	/preɪ/	con mồi	n	prey	9
428	\N	LOW	The loss of forests has serious repercussions for the climate.	/ˌriːpəˈkʌʃnz/	hậu quả, tác động ngược lại	n	repercussions	9
429	\N	LOW	Dogs use their sense of smell to track the scent of animals.	/sent/	mùi hương	n	scent	9
430	\N	LOW	There are thousands of species of butterflies in the world.	/ˈspiːʃiːz/	loài	n	species	9
431	\N	LOW	The soil here is very rich and perfect for farming.	/sɔɪl/	đất	n	soil	9
432	\N	LOW	The hills are covered in thick tropical vegetation.	/ˌvedʒəˈteɪʃn/	thảm thực vật	n	vegetation	9
433	\N	LOW	The farmhouse was infested with vermin like rats and mice.	/ˈvɜːmɪn/	động vật gây hại (chuột, gián...)	n	vermin	9
434	\N	LOW	My garden is full of weeds that need to be pulled out.	/wiːd/	cỏ dại	n	weed	9
435	\N	LOW	The Sahara Desert is one of the most arid regions on Earth.	/ˈærɪd/	khô cằn	adj	arid	9
436	\N	LOW	A massive oil spill would be catastrophic for the marine life.	/ˌkætəˈstrɒfɪk/	thảm khốc	adj	catastrophic	9
437	\N	LOW	The flood had a disastrous effect on the local economy.	/dɪˈzɑːstrəs/	tai hại, thảm khốc	adj	disastrous	9
438	\N	LOW	Dogs were among the first animals to be domesticated by humans.	/dəˈmestɪkeɪtɪd/	đã được thuần hóa	adj	domesticated	9
439	\N	LOW	Pandas are an endangered species that need protection.	/ɪnˈdeɪndʒəd/	có nguy cơ tuyệt chủng	adj	endangered	9
440	\N	LOW	Dinosaurs became extinct millions of years ago.	/ɪkˈstɪŋkt/	tuyệt chủng	adj	extinct	9
441	\N	LOW	Some people are concerned about the safety of genetically-modified crops.	/dʒəˈnetɪkli ˈmɒdɪfaɪd/	biến đổi gen	adj	genetically-modified	9
442	\N	LOW	Introduced species can often outcompete native wildlife.	/ˌɪntrəˈdjuːst/	được đưa vào (loài ngoại lai)	adj	introduced	9
443	\N	LOW	The kangaroo is native to Australia.	/ˈneɪtɪv/	bản địa	adj	native	9
444	\N	LOW	It is natural for animals to protect their young.	/ˈnætʃrəl/	tự nhiên	adj	natural	9
445	\N	LOW	Scientists are developing crops that are resistant to drought.	/rɪˈzɪstənt/	có sức chịu đựng, kháng lại	adj	resistant	9
446	\N	LOW	The region has a semi-arid climate with long dry summers.	/ˌsemi ˈærɪd/	bán khô hạn	adj	semi-arid	9
447	\N	LOW	Many exotic fruits grow in tropical countries.	/ˈtrɒpɪkl/	nhiệt đới	adj	tropical	9
448	\N	LOW	Young birds are very vulnerable to predators before they can fly.	/ˈvʌlnərəbl/	dễ bị tổn thương	adj	vulnerable	9
449	\N	LOW	It is dangerous to approach wild animals in the forest.	/waɪld/	hoang dã	adj	wild	9
450	\N	LOW	Animals must adapt to their environment to survive.	/əˈdæpt/	thích nghi	v	adapt	9
451	\N	LOW	New measures are needed to combat climate change.	/ˈkɒmbæt/	chống lại, ngăn chặn	v	combat	9
452	\N	LOW	Farmers cultivate the land to grow vegetables.	/ˈkʌltɪveɪt/	trồng trọt, canh tác	v	cultivate	9
453	\N	LOW	The government is trying to eradicate the invasive weed.	/ɪˈrædɪkeɪt/	diệt trừ, xóa sổ	v	eradicate	9
454	\N	LOW	Human beings evolved from ape-like ancestors.	/ɪˈvɒlv/	tiến hóa	v	evolve	9
455	\N	LOW	Bears hibernate during the coldest months of the year.	/ˈhaɪbəneɪt/	ngủ đông	v	hibernate	9
456	\N	LOW	Some plants can tolerate saltier soils than others.	/ˈtɒləreɪt/	chịu đựng được	v	tolerate	9
457	\N	LOW	Scientists are tracking an asteroid that will pass close to Earth.	/ˈæstərɔɪd/	tiểu hành tinh	n	asteroid	10
458	\N	LOW	Neil Armstrong was the first astronaut to walk on the moon.	/ˈæstrənɔːt/	phi hành gia	n	astronaut	10
459	\N	LOW	The Earth's atmosphere protects us from harmful solar radiation.	/ˈætməsfɪə(r)/	khí quyển	n	atmosphere	10
460	\N	LOW	Humanity has always been fascinated by the mysteries of the cosmos.	/ˈkɒzmɒs/	vũ trụ (nhấn mạnh tính trật tự)	n	cosmos	10
461	\N	LOW	The surface of the moon is covered in deep craters.	/ˈkreɪtə(r)/	hố, miệng núi lửa (hoặc hố do thiên thạch tạo ra)	n	crater	10
462	\N	LOW	Space debris poses a significant threat to functioning satellites.	/ˈdebriː/	mảnh vỡ, rác vũ trụ	n	debris	10
463	\N	LOW	Earth is the only planet known to support life.	/ɜːθ/	Trái Đất	n	Earth	10
464	\N	LOW	Deep-space exploration requires advanced propulsion systems.	/ˌekspləˈreɪʃn/	sự thám hiểm	n	exploration	10
465	\N	LOW	Early explorers used the stars to navigate across the oceans.	/ɪkˈsplɔːrə(r)/	nhà thám hiểm	n	explorer	10
466	\N	LOW	Our solar system is located in the Milky Way galaxy.	/ˈɡæləksi/	thiên hà	n	galaxy	10
467	\N	LOW	Jupiter is a giant planet made mostly of gas.	/ɡæs/	khí, thể khí	n	gas	10
468	\N	LOW	The moon has much weaker gravity than the Earth.	/ˈɡrævəti/	trọng lực	n	gravity	10
469	\N	LOW	The sun gradually disappeared below the western horizon.	/həˈraɪzn/	chân trời	n	horizon	10
470	\N	LOW	The rocket launch was delayed due to bad weather.	/lɔːntʃ/	sự phóng (tên lửa), hạ thủy (tàu)	n/v	launch	10
471	\N	LOW	We saw a bright meteor streak across the sky last night.	/ˈmiːtiə(r)/	sao băng, thiên thạch (khi đi vào khí quyển)	n	meteor	10
472	\N	LOW	Many planets in our solar system have more than one moon.	/muːn/	mặt trăng/vệ tinh tự nhiên	n	moon	10
473	\N	LOW	Scientists believe there may be liquid oceans beneath the ice of Europa.	/ˈəʊʃn/	đại dương	n	ocean	10
474	\N	LOW	The satellite is currently in orbit around the Earth.	/ˈɔːbɪt/	quỹ đạo / đi theo quỹ đạo	n/v	orbit	10
475	\N	LOW	In outer space, there is no air to breathe and no sound.	/ˌaʊtə ˈspeɪs/	không gian ngoài vũ trụ	n	outer space	10
476	\N	LOW	Mars is often called the 'Red Planet'.	/ˈplænɪt/	hành tinh	n	planet	10
477	\N	LOW	Space suits are designed to protect astronauts from radiation.	/ˌreɪdiˈeɪʃn/	bức xạ, phóng xạ	n	radiation	10
478	\N	LOW	The rocket carried the satellite into upper atmosphere.	/ˈrɒkɪt/	tên lửa	n	rocket	10
479	\N	LOW	GPS works by using a network of satellites orbiting the Earth.	/ˈsætəlaɪt/	vệ tinh (nhân tạo hoặc tự nhiên)	n	satellite	10
480	\N	LOW	Astronauts train in a flight simulator before going into space.	/ˈsɪmjuleɪtə(r)/	thiết bị mô phỏng	n	simulator	10
481	\N	LOW	There are eight recognized planets in our solar system.	/ˈsəʊlə sɪstəm/	hệ mặt trời	n	solar system	10
482	\N	LOW	The spacecraft successfully landed on the surface of Mars.	/ˈspeɪskrɑːft/	tàu vũ trụ	n	spacecraft	10
483	\N	LOW	The space shuttle was designed to be reused for multiple missions.	/ˈspeɪs ʃʌtl/	tàu thoi	n	space shuttle	10
484	\N	LOW	The International Space Station (ISS) is a hub for scientific research.	/ˈspeɪs steɪʃn/	trạm vũ trụ	n	space station	10
485	\N	LOW	The surface of Venus is hot enough to melt lead.	/ˈsɜːfɪs/	bề mặt	n	surface	10
486	\N	LOW	The universe is constantly expanding.	/ˈjuːnɪvɜːs/	vũ trụ (toàn bộ vạn vật)	n	universe	10
487	\N	LOW	Astronauts enjoy the feeling of weightlessness in space.	/ˈweɪtləsnəs/	tình trạng không trọng lượng	n	weightlessness	10
488	\N	LOW	Commercial space travel may become common in the next century.	/kəˈmɜːʃl/	thuộc về thương mại	adj	commercial	10
489	\N	LOW	Cosmic rays are high-energy particles from outer space.	/ˈkɒzmɪk/	thuộc về vũ trụ	adj	cosmic	10
490	\N	LOW	Space is an environment of extreme temperatures.	/ɪkˈstriːm/	khắc nghiệt, cực hạn	adj	extreme	10
491	\N	LOW	The moon is held in orbit by Earth's gravitational pull.	/ˌɡrævɪˈteɪʃənl/	thuộc về trọng lực	adj	gravitational	10
492	\N	LOW	The line where the sky meets the Earth is horizontal.	/ˌhɒrɪˈzɒntl/	nằm ngang	adj	horizontal	10
493	\N	LOW	With increasing population, the colonization of other planets seems inevitable.	/ɪnˈevɪtəbl/	không thể tránh khỏi	adj	inevitable	10
494	\N	LOW	A lunar eclipse occurs when the Earth passes between the sun and the moon.	/ˈluːnə(r)/	thuộc về mặt trăng	adj	lunar	10
495	\N	LOW	The company enjoyed a meteoric rise in profits last year.	/ˌmiːtiˈɒrɪk/	nhanh chóng (như sao băng) / thuộc thiên thạch	adj	meteoric	10
496	\N	LOW	The outer planets of our solar system are mostly gas giants.	/ˈaʊtə(r)/	bên ngoài	adj	outer	10
497	\N	LOW	Solar panels convert sunlight into electricity.	/ˈsəʊlə(r)/	thuộc về mặt trời	adj	solar	10
498	\N	LOW	Scientists are searching for terrestrial planets that might support life.	/təˈrestriəl/	thuộc về trái đất/trên cạn	adj	terrestrial	10
499	\N	LOW	The atmosphere of many planets is toxic to humans.	/ˈtɒksɪk/	độc hại	adj	toxic	10
500	\N	LOW	Without air and water, the planet remains uninhabitable.	/ˌʌnɪnˈhæbɪtəbl/	không thể cư trú được	adj	uninhabitable	10
501	\N	LOW	The law of gravity is a universal principle.	/ˌjuːnɪˈvɜːsl/	phổ quát, toàn vũ trụ	adj	universal	10
502	\N	LOW	Unmanned space probes have sent back photos from the edge of the solar system.	/ˌʌnˈmænd/	không người lái	adj	unmanned	10
503	\N	LOW	Astronauts need time to acclimatise to the lack of gravity.	/əˈklaɪmətaɪz/	thích nghi với môi trường/khí hậu	v	acclimatise	10
504	\N	LOW	Some experts believe humans will colonise Mars by 2050.	/ˈkɒlənaɪz/	chiếm làm thuộc địa/định cư	v	colonise	10
505	\N	LOW	We sent a robot to explore the cave system.	/ɪkˈsplɔː(r)/	thám hiểm	v	explore	10
506	\N	LOW	Objects float in the cabin due to zero gravity.	/fləʊt/	trôi nổi	v	float	10
507	\N	LOW	The rocket is propelled by burning liquid fuel.	/prəˈpel/	đẩy đi	v	propel	10
508	\N	LOW	The Earth rotates on its axis, creating day and night.	/rəʊˈteɪt/	quay quanh trục	v	rotate	10
509	\N	LOW	Mars does not have enough oxygen to sustain human life without help.	/səˈsteɪn/	duy trì sự sống/chống đỡ	v	sustain	10
510	\N	LOW	Computers can simulate what happens during a supernova.	/ˈsɪmjuleɪt/	mô phỏng	v	simulate	10
511	\N	LOW	The spacecraft will undergo rigorous testing before the mission.	/ˌʌndəˈɡəʊ/	trải qua	v	undergo	10
377	\N	LOW	We are currently living in the digital age.	/eɪdʒ/	thời đại, kỷ nguyên; tuổi	n	age	8
378	\N	LOW	Archaeologists have discovered ancient ruins deep in the jungle.	/ˌɑːkiˈɒlədʒɪst/	nhà khảo cổ học	n	archaeologist	8
379	\N	LOW	The castle was built in the 14th century.	/ˈsentʃəri/	thế kỷ (100 năm)	n	century	8
380	\N	LOW	The fashion of the last decade has changed significantly.	/ˈdekeɪd/	thập kỷ (10 năm)	n	decade	8
381	\N	LOW	The end of the war marked the beginning of a new era of peace.	/ˈɪərə/	kỷ nguyên, thời đại	n	era	8
382	\N	LOW	There is no scientific evidence to support that theory.	/ˈevɪdəns/	bằng chứng	n	evidence	8
383	\N	LOW	The excavation of the site revealed several Roman coins.	/ˌekskəˈveɪʃn/	cuộc khai quật	n	excavation	8
384	\N	LOW	This traditions has been passed down through many generations.	/ˌdʒenəˈreɪʃn/	thế hệ	n	generation	8
385	\N	LOW	Life in the Middle Ages was very difficult for most people.	/ðə ˌmɪdl ˈeɪdʒɪz/	thời Trung Cổ	n	the Middle Ages	8
386	\N	LOW	Pyramids have stood in the desert for several millennia.	/mɪˈleniə/	thiên niên kỷ (số nhiều của millennium - 1000 năm)	n (plural)	millennia	8
387	\N	LOW	The Victorian period was a time of great industrial growth.	/ˈpɪəriəd/	giai đoạn, thời kỳ	n	period	8
388	\N	LOW	The project is now entering its final phase.	/feɪz/	giai đoạn (trong một quá trình)	n	phase	8
389	\N	LOW	Marie Curie was a pioneer in the study of radioactivity.	/ˌpaɪəˈnɪə(r)/	người tiên phong	n	pioneer	8
390	\N	LOW	The museum has a timeline showing the history of the city.	/ˈtaɪmlaɪn/	dòng thời gian	n	timeline	8
391	\N	LOW	Ancient civilizations like Egypt and Mesopotamia were very advanced.	/ˈeɪnʃənt/	cổ đại	adj	ancient	8
392	\N	LOW	The books are arranged in chronological order.	/ˌkrɒnəˈlɒdʒɪkl/	theo trình tự thời gian	adj	chronological	8
393	\N	LOW	It rained for three consecutive days.	/kənˈsekjətɪv/	liên tiếp	adj	consecutive	8
394	\N	LOW	She loves reading historical novels set in the 18th century.	/hɪˈstɒrɪkl/	thuộc về lịch sử	adj	historical	8
395	\N	LOW	The dark clouds suggest that a storm is imminent.	/ˈɪmɪnənt/	sắp xảy ra (thường là điều không hay)	adj	imminent	8
396	\N	LOW	He is a middle-aged man in his late 40s.	/ˌmɪdl ˈeɪdʒd/	trung niên	adj	middle-aged	8
397	\N	LOW	Seeing those old photos made me feel very nostalgic.	/nɒˈstældʒɪk/	hoài niệm	adj	nostalgic	8
398	\N	LOW	Prehistoric people lived in caves and used stone tools.	/ˌpriːhɪˈstɒrɪk/	tiền sử	adj	prehistoric	8
399	\N	LOW	Please arrive at the airport two hours prior to departure.	/ˈpraɪə(r)/	trước (khi)	adj	prior (to)	8
400	\N	LOW	It's important to be punctual for a job interview.	/ˈpʌŋktʃuəl/	đúng giờ	adj	punctual	8
401	\N	LOW	Collecting data for the research was a very time-consuming process.	/ˈtaɪm kənˌsjuːmɪŋ/	tốn thời gian	adj	time-consuming	8
402	\N	LOW	The wind and rain have eroded the statues over centuries.	/ɪˈrəʊd/	xói mòn, ăn mòn	v	erode	8
403	\N	LOW	From the evidence, we can infer that the site was a marketplace.	/ɪnˈfɜː(r)/	suy ra	v	infer	8
404	\N	LOW	These artifacts predate the arrival of Europeans by centuries.	/ˌpriːˈdeɪt/	có trước, xuất hiện trước	v	predate	8
405	\N	LOW	His career as an actor spanned over five decades.	/spæn/	kéo dài, bao trùm	v	span	8
512	\N	MEDIUM	The manager praised her ability to handle difficult customers.	/əˈbɪl.ə.t̬i/	năng lực, khả năng	n	ability	11
513	\N	MEDIUM	Only authorized personnel have access to the server room.	/ˈæk.ses/	quyền truy cập, sự tiếp cận	n	access	11
514	\N	MEDIUM	The report concluded that the fire was a complete accident.	/ˈæk.sə.dənt/	tai nạn, sự tình cờ	n	accident	11
515	\N	MEDIUM	The company will provide accommodation for all overseas employees.	/əˌkɑː.məˈdeɪ.ʃən/	chỗ ở, nơi ở	n	accommodation	11
516	\N	MEDIUM	He decided to pursue a career in accounting after graduation.	/əˈkaʊ.t̬ɪŋ/	kế toán	n	accounting	11
517	\N	MEDIUM	Helping a colleague is a kind act that improves teamwork.	/ækt/	hành động	n	act	11
518	\N	MEDIUM	I need a power adapter to use my laptop in this country.	/əˈdæp.tɚ/	thiết bị chuyển đổi	n	adapter	11
519	\N	MEDIUM	The technician made a slight adjustment to the machine's settings.	/əˈdʒʌst.mənt/	sự điều chỉnh, sự thay đổi	n	adjustment	11
520	\N	MEDIUM	The new administration is focusing on reducing operational costs.	/ədˌmɪn.əˈstreɪ.ʃən/	sự quản lý, quản trị	n	administration	11
521	\N	MEDIUM	The sign stated 'No Admittance' to unauthorized visitors.	/ədˈmɪt̬.əns/	sự thu nạp, đón nhận	n	admittance	11
522	\N	MEDIUM	The building is fully accessible to people in wheelchairs.	/əkˈses.ə.bəl/	khả năng tiếp cận được	adj	accessible	11
523	\N	MEDIUM	We need an accurate estimate of the project's total cost.	/ˈæk.jɚ.ət/	đúng đắn, chính xác	adj	accurate	11
524	\N	MEDIUM	There will be an additional charge for express delivery.	/əˈdɪʃ.ən.əl/	thêm vào, phụ thêm	adj	additional	11
525	\N	MEDIUM	The book provides supplementary materials for further study.	/ˌsʌp.ləˈmen.tər.i/	bổ sung, thêm vào (=additional)	adj	supplementary	11
526	\N	MEDIUM	Please let us know if you accept the terms of the contract.	/əkˈsept/	chấp nhận, chấp thuận	v	accept	11
527	\N	MEDIUM	The hotel can accommodate up to 500 guests for the conference.	/əˈkɑː.mə.deɪt/	đáp ứng (đủ không gian/chỗ)	v	accommodate	11
528	\N	MEDIUM	We can accomplish more when we work together as a team.	/əˈkɑːm.plɪʃ/	hoàn thành, thực hiện	v	accomplish	11
529	\N	MEDIUM	The company hopes to achieve its sales targets by the end of the year.	/əˈtʃiːv/	đạt được, giành được	v	achieve	11
530	\N	MEDIUM	Our firm plans to acquire a smaller competitor next month.	/əˈkwaɪɚ/	có được, thu mua	v	acquire	11
531	\N	MEDIUM	Successful businesses are those that can adapt to changing markets.	/əˈdæpt/	thích nghi, thích ứng	v	adapt	11
532	\N	MEDIUM	You may need to adjust your expectations regarding the timeline.	/əˈdʒʌst/	điều chỉnh	v	adjust	11
533	\N	MEDIUM	Many employees admire the CEO for her visionary leadership.	/ədˈmaɪr/	ngưỡng mộ, thán phục	v	admire	11
534	\N	MEDIUM	The director had to admit that the marketing campaign was a failure.	/ədˈmɪt/	thừa nhận; tiếp nhận	v	admit	11
535	\N	MEDIUM	The company decided to adopt a new flexible working policy.	/əˈdɑːpt/	làm theo, áp dụng	v	adopt	11
536	\N	MEDIUM	According to the latest report, profits have increased by 10%.	/əˈkɔːr.dɪŋ ˌtuː/	theo như, dựa vào	prep	according to	11
537	\N	MEDIUM	Recent advances in technology have made remote work much easier.	/ədˈvæns/	sự tiến lên, tiền ứng trước	n	advance	12
538	\N	MEDIUM	Being bilingual is a great advantage in the international job market.	/ədˈvæn.t̬ɪdʒ/	lợi thế	n	advantage	12
539	\N	MEDIUM	The company placed an advertisement in the local newspaper to recruit new staff.	/æd.vɝːˈtaɪz.mənt/	bản tin quảng cáo	n	advertisement	12
540	\N	MEDIUM	The consultant provided some useful advice on how to improve efficiency.	/ədˈvaɪs/	lời khuyên, lời chỉ bảo	n	advice	12
541	\N	MEDIUM	We hired an advertising agency to handle our new product launch.	/ˈeɪ.dʒən.si/	đại lý, bên môi giới trung gian	n	agency	12
542	\N	MEDIUM	The most important item on the agenda today is the budget review.	/əˈdʒen.də/	chương trình nghị sự, kế hoạch chương trình	n	agenda	12
543	\N	MEDIUM	Both parties finally signed the lease agreement after weeks of negotiation.	/əˈɡriː.mənt/	hợp đồng, giao kèo, sự đồng ý	n	agreement	12
544	\N	MEDIUM	The government provided financial aid to small businesses during the crisis.	/eɪd/	sự giúp đỡ, cứu trợ	n	aid	12
545	\N	MEDIUM	Our primary aim is to increase customer satisfaction by 20%.	/eɪm/	mục tiêu	n	aim	12
546	\N	MEDIUM	Several airlines have announced ticket discounts for the holiday season.	/ˈer.laɪn/	công ty hàng không	n	airline	12
547	\N	MEDIUM	The flight attendant walked down the aisle to check everyone's seatbelts.	/aɪl/	gian hàng, lối đi giữa các dãy ghế	n	aisle	12
548	\N	MEDIUM	The security alarm went off when someone tried to enter the building.	/əˈlɑːrm/	sự báo động, thiết bị báo động	n	alarm	12
549	\N	MEDIUM	A large amount of work still needs to be finished before Friday.	/əˈmaʊnt/	số lượng	n	amount	12
550	\N	MEDIUM	A detailed analysis of the market trends will be presented tomorrow.	/əˈnæl.ə.sɪs/	sự phân tích, bản phân tích	n	analysis	12
551	\N	MEDIUM	The lab uses advanced techniques to test the quality of the materials.	/ədˈvænst/	tiến bộ, cấp tiến	adj	advanced	12
552	\N	MEDIUM	The merger would be advantageous for both companies involved.	/ˌæd.vænˈteɪ.dʒəs/	có lợi, thuận lợi	adj	advantageous	12
553	\N	MEDIUM	They are looking for an affordable office space in the city center.	/əˈfɔːr.də.bəl/	có khả năng chi trả, vừa túi tiền	adj	affordable	12
554	\N	MEDIUM	The two managers reached an agreeable solution to the scheduling conflict.	/əˈɡriː.ə.bəl/	dễ chịu, thích hợp	adj	agreeable	12
555	\N	MEDIUM	The country’s economy is heavily dependent on agricultural exports.	/ˌæɡ.rəˈkʌl.tʃɚ.əl/	(thuộc) nông nghiệp	adj	agricultural	12
556	\N	MEDIUM	If the main road is closed, we will have to find an alternative route.	/ɑːlˈtɝː.nə.t̬ɪv/	thay thế, xen kẽ	adj	alternative	12
557	\N	MEDIUM	The company has set an ambitious goal to expand into five new countries.	/æmˈbɪʃ.əs/	tham vọng	adj	ambitious	12
558	\N	MEDIUM	We plan to advertise our new services on social media platforms.	/ˈæd.vɚ.taɪz/	quảng cáo, thông báo	v	advertise	12
559	\N	MEDIUM	The legal department will advise us on how to proceed with the lawsuit.	/ədˈvaɪz/	đưa ra lời khuyên	v	advise	12
560	\N	MEDIUM	The new regulations will affect how we process customer data.	/əˈfekt/	ảnh hưởng, tác động	v	affect	12
561	\N	MEDIUM	We cannot afford to lose any more valuable clients.	/əˈfɔːrd/	có đủ khả năng chi trả	v	afford	12
562	\N	MEDIUM	The committee did not agree with the proposed changes to the policy.	/əˈɡriː/	đồng ý, tán thành	v	agree	12
563	\N	MEDIUM	The manager decided to allow the team to work from home on Fridays.	/əˈlaʊ/	cho phép, để cho	v	allow	12
564	\N	MEDIUM	We need to analyze the feedback from our customers more thoroughly.	/ˈæn.əl.aɪz/	phân tích	v	analyze	12
565	\N	MEDIUM	The design of the new smartphone has a broad appeal among young users.	/əˈpiːl/	lời thỉnh cầu, sức lôi cuốn	n	appeal	13
566	\N	MEDIUM	We ordered a plate of spring rolls as an appetizer before the main course.	/ˈæp.ə.taɪ.zɚ/	món khai vị	n	appetizer	13
567	\N	MEDIUM	The store sells a wide range of household appliances like blenders and toasters.	/əˈplaɪ.əns/	thiết bị, dụng cụ	n	appliance	13
568	\N	MEDIUM	Each applicant is required to submit a resume and a cover letter.	/ˈæp.lə.kənt/	người ứng tuyển	n	applicant	13
569	\N	MEDIUM	Please complete the online application form by the end of the month.	/ˌæp.ləˈkeɪ.ʃən/	đơn ứng tuyển, sự áp dụng	n	application	13
570	\N	MEDIUM	I would like to make an appointment to see the marketing director.	/əˈpɔɪnt.mənt/	sự bổ nhiệm, cuộc hẹn	n	appointment	13
571	\N	MEDIUM	The company gave him a bonus as a token of appreciation for his hard work.	/əˌpriː.ʃiˈeɪ.ʃən/	sự đánh giá cao, sự cảm kích	n	appreciation	13
572	\N	MEDIUM	He started his career as an apprentice in a local engineering firm.	/əˈpren.t̬ɪs/	người học việc	n	apprentice	13
573	\N	MEDIUM	She is an expert in the area of international trade law.	/ˈer.i.ə/	khu vực, lĩnh vực	n	area	13
574	\N	MEDIUM	There was a long argument during the meeting about the new budget.	/ˈɑːrɡ.jə.mənt/	cuộc tranh luận	n	argument	13
575	\N	MEDIUM	We have made a special arrangement to host the seminar in the main hall.	/əˈreɪndʒ.mənt/	sự sắp đặt, sự dàn xếp	n	arrangement	13
576	\N	MEDIUM	The company's greatest asset is its highly skilled workforce.	/ˈæs.et/	của cải, tài sản, vốn quý	n	asset	13
577	\N	MEDIUM	All employees are expected to attend the annual general meeting.	/ˈæn.ju.əl/	hằng năm	adj	annual	13
578	\N	MEDIUM	The staff was anxious about the news of the upcoming merger.	/ˈæŋk.ʃəs/	bồn chồn, lo lắng	adj	anxious	13
579	\N	MEDIUM	There has been an appreciable increase in sales over the last quarter.	/əˈpriː.ʃə.bəl/	đáng kể	adj	appreciable	13
580	\N	MEDIUM	The team was appreciative of the support they received from the manager.	/əˈpriː.ʃə.t̬ɪv/	biết ơn, đánh giá cao	adj	appreciative	13
581	\N	MEDIUM	The approximate cost of the renovation is around ten thousand dollars.	/əˈprɑːk.sə.mət/	xấp xỉ, gần đúng	adj	approximate	13
582	\N	MEDIUM	We anticipate that the new product will be a huge success.	/ænˈtɪs.ə.peɪt/	phỏng đoán, dự đoán	v	anticipate	13
583	\N	MEDIUM	I apologize for the delay in responding to your email.	/əˈpɑː.lə.dʒaɪz/	xin lỗi	v	apologize	13
584	\N	MEDIUM	You can apply for the position through our website.	/əˈplaɪ/	áp dụng, ứng tuyển	v	apply	13
585	\N	MEDIUM	The board decided to appoint Mr. Smith as the new CEO.	/əˈpɔɪnt/	bổ nhiệm, chỉ định	v	appoint	13
586	\N	MEDIUM	I really appreciate your help with the presentation.	/əˈpriː.ʃi.eɪt/	đánh giá cao, cảm kích	v	appreciate	13
587	\N	MEDIUM	The manager needs to approve all travel expenses in advance.	/əˈpruːv/	tán thành, phê chuẩn	v	approve	13
588	\N	MEDIUM	The lawyers will argue the case in court tomorrow morning.	/ˈɑːrɡ.juː/	tranh luận	v	argue	13
589	\N	MEDIUM	Can you arrange a meeting with the suppliers for next Tuesday?	/əˈreɪndʒ/	dàn xếp, sắp đặt	v	arrange	13
590	\N	MEDIUM	It took the workers three hours to assemble the new office desks.	/əˈsem.bəl/	lắp ráp, thu thập	v	assemble	13
591	\N	MEDIUM	The experts were hired to assess the market value of the property.	/əˈses/	đánh giá, định giá	v	assess	13
592	\N	MEDIUM	The supervisor will assign tasks to each team member.	/əˈsaɪn/	phân công, chia việc	v	assign	13
593	\N	MEDIUM	His first assignment was to reorganize the filing system.	/əˈsaɪn.mənt/	sự phân việc, nhiệm vụ được giao	n	assignment	14
594	\N	MEDIUM	Technical assistance is available 24 hours a day.	/əˈsɪs.təns/	sự giúp đỡ, hỗ trợ	n	assistance	14
595	\N	MEDIUM	Please check the email attachment for the full itinerary.	/əˈtætʃ.mənt/	sự gắn thêm, tệp đính kèm	n	attachment	14
596	\N	MEDIUM	Attendance at the monthly safety meeting is mandatory.	/əˈten.dəns/	sự tham gia, số người có mặt	n	attendance	14
597	\N	MEDIUM	The speaker captivated the audience with her presentation.	/ˈɑː.di.əns/	khán thính giả	n	audience	14
598	\N	MEDIUM	The company undergoes an external audit every year.	/ˈɑː.dɪt/	việc kiểm toán	n	audit	14
599	\N	MEDIUM	You need to get permission from the local authority before building.	/əˈθɔːr.ə.t̬i/	quyền thế, nhà chức trách	n	authority	14
600	\N	MEDIUM	Please confirm your availability for an interview next week.	/əˌveɪ.ləˈbɪl.ə.t̬i/	tính sẵn có	n	availability	14
601	\N	MEDIUM	The campaign aims to raise public awareness of environmental issues.	/əˈwer.nəs/	sự nhận thức, ý thức	n	awareness	14
602	\N	MEDIUM	She has a strong background in financial management.	/ˈbæk.ɡraʊnd/	phông nền, nền tảng kinh nghiệm	n	background	14
603	\N	MEDIUM	He put his laptop and notebooks into his backpack.	/ˈbæk.pæk/	ba lô	n	backpack	14
604	\N	MEDIUM	We waited at the baggage claim for over thirty minutes.	/ˈbæɡ.ɪdʒ kleɪm/	chỗ nhận hành lý	n	baggage claim	14
605	\N	MEDIUM	You can check your account balance at any ATM.	/ˈbæl.əns/	số dư tài khoản, sự cân bằng	n	balance	14
606	\N	MEDIUM	The bank is closed on national holidays.	/bæŋk/	ngân hàng	n	bank	14
607	\N	MEDIUM	The court declared the investor a bankrupt.	/ˈbæŋ.krʌpt/	người phá sản	n	bankrupt	14
608	\N	MEDIUM	The cashier scanned the bar code on the product label.	/ˈbɑːr ˌkoʊd/	mã vạch	n	bar code	14
609	\N	MEDIUM	This second-hand printer is a real bargain at only $50.	/ˈbɑːr.ɡɪn/	món hời, sự mặc cả	n	bargain	14
610	\N	MEDIUM	Is this model available in any other colors?	/əˈvəɪ.lə.bəl/	có sẵn, rảnh	adj	available	14
611	\N	MEDIUM	He is an avid reader of business journals.	/ˈæv.ɪd/	khao khát, say mê	adj	avid	14
612	\N	MEDIUM	There was an awkward silence when no one answered the question.	/ˈɑː.kwɚd/	khó xử, bất tiện	adj	awkward	14
613	\N	MEDIUM	The city has many beautiful parks and gardens.	/ˈbjuː.t̬ə.fəl/	xinh đẹp, tốt đẹp	adj	beautiful	14
614	\N	MEDIUM	A team of researchers will assist the lead scientist.	/əˈsɪst/	hỗ trợ, giúp đỡ	v	assist	14
615	\N	MEDIUM	You shouldn't assume that the project will be finished on time.	/əˈsuːm/	cho rằng, đảm đương	v	assume	14
616	\N	MEDIUM	Please remember to attach your photo to the application.	/əˈtætʃ/	đính kèm	v	attach	14
617	\N	MEDIUM	Many experts will attend the international conference.	/əˈtend/	tham dự	v	attend	14
618	\N	MEDIUM	The new marketing strategy is designed to attract more customers.	/əˈtrækt/	thu hút	v	attract	14
619	\N	MEDIUM	The manager must authorize any expenditure over $500.	/ˈɑː.θɚ.aɪz/	ủy quyền, cấp quyền	v	authorize	14
620	\N	MEDIUM	You should avoid making any major changes until the situation is clear.	/əˈvɔɪd/	tránh xa, ngăn ngừa	v	avoid	14
621	\N	MEDIUM	Please make sure you take all your personal belongings with you when you leave the plane.	/bɪˈlɑːŋ.ɪŋz/	tài sản, đồ dùng cá nhân	n	belongings	15
622	\N	MEDIUM	The new health insurance plan is a great benefit for all employees.	/ˈben.ə.fɪt/	ích lợi, phúc lợi	n	benefit	15
623	\N	MEDIUM	Complimentary beverages will be served during the flight.	/ˈbev.ɚ.ɪdʒ/	đồ uống, đồ giải khát	n	beverage	15
624	\N	MEDIUM	If you don't pay the electricity bill on time, the service may be disconnected.	/bɪl/	hóa đơn	n	bill	15
625	\N	MEDIUM	I kept all the project reports organized in a large blue binder.	/ˈbaɪn.dɚ/	bìa ôm, bìa rời	n	binder	15
626	\N	MEDIUM	The hotel provides extra blankets in the closet if you get cold at night.	/ˈblæŋ.kɪt/	chăn, mền	n	blanket	15
627	\N	MEDIUM	The fallen tree created a block on the main road to the airport.	/blɑːk/	khối, vật cản	n	block	15
628	\N	MEDIUM	The board of directors will meet tomorrow to discuss the new budget.	/bɔːrd/	ban giám đốc, cái bảng	n	board	15
629	\N	MEDIUM	The negotiations are taking place in the boardroom on the top floor.	/ˈbɔːrd.ruːm/	phòng họp ban giám đốc	n	boardroom	15
630	\N	MEDIUM	It wasn't a boast when he said the company was the best in the industry.	/boʊst/	sự khoe khoang	n	boast	15
631	\N	MEDIUM	She wrote a book about effective management strategies.	/bʊk/	cuốn sách	n	book	15
632	\N	MEDIUM	The tax cuts provided a much-needed boost to the economy.	/buːst/	sự tăng lên, sự thúc đẩy	n	boost	15
633	\N	MEDIUM	I'm sorry to be a bother, but could you help me with this printer?	/ˈbɑː.ðɚ/	điều gây khó chịu	n	bother	15
634	\N	MEDIUM	The bottom line is that we need to reduce costs to remain competitive.	/ˌbɑː.t̬əm ˈlaɪn/	điểm mấu chốt, lợi nhuận ròng	n	bottom line	15
635	\N	MEDIUM	Our bank is opening a new branch in the downtown area next month.	/bræntʃ/	chi nhánh	n	branch	15
636	\N	MEDIUM	The company is working hard to build a strong global brand.	/brænd/	thương hiệu	n	brand	15
637	\N	MEDIUM	He forgot his briefcase in the taxi on his way to the meeting.	/ˈbriːf.keɪs/	cặp tài liệu	n	briefcase	15
638	\N	MEDIUM	The manager gave a short briefing before the start of the shift.	/ˈbriː.fɪŋ/	buổi chỉ dẫn, hướng dẫn	n	briefing	15
639	\N	MEDIUM	The news broadcast mentioned the changes in the stock market.	/ˈbrɑːd.kæst/	chương trình phát thanh/truyền hình	n	broadcast	15
640	\N	MEDIUM	Please make sure your web browser is updated to the latest version.	/ˈbraʊ.zɚ/	trình duyệt	n	browser	15
641	\N	MEDIUM	You can find a small brush in the cleaning kit.	/brʌʃ/	bàn chải, lược	n	brush	15
642	\N	MEDIUM	We have to stay within the budget for the annual holiday party.	/ˈbʌdʒ.ɪt/	ngân sách	n	budget	15
643	\N	MEDIUM	The latest company news is posted on the bulletin board.	/ˈbʊl.ə.t̬ɪn/	bảng thông báo, tập san	n	bulletin	15
644	\N	MEDIUM	The cabin crew is responsible for the safety and comfort of the passengers.	/ˈkæb.ɪn ˌkruː/	đội bay, tiếp viên hàng không	n	cabin crew	15
645	\N	MEDIUM	Regular training sessions are beneficial for professional development.	/ˌben.əˈfɪʃ.əl/	có ích, có lợi	adj	beneficial	15
646	\N	MEDIUM	Some employees felt bored during the long, repetitive presentation.	/bɔːrd/	buồn chán, tẻ nhạt	adj	bored	15
647	\N	MEDIUM	We expect all our staff to behave professionally at all times.	/bɪˈheɪv/	hành xử, cư xử	v	behave	15
648	\N	MEDIUM	The internship is a great way to broaden your knowledge of the industry.	/ˈbrɑː.dən/	mở rộng	v	broaden	15
649	\N	MEDIUM	Most employees have lunch in the company cafeteria to save time.	/ˌkæf.əˈtɪr.i.ə/	quán ăn tự phục vụ, nhà ăn	n	cafeteria	16
650	\N	MEDIUM	According to our calculations, the project will be profitable by next year.	/ˌkæl.kjəˈleɪ.ʃən/	sự tính toán	n	calculation	16
651	\N	MEDIUM	You are allowed to use a basic calculator during the accounting exam.	/ˈkæl.kjə.leɪ.t̬ɚ/	máy tính bỏ túi	n	calculator	16
652	\N	MEDIUM	The marketing campaign resulted in a 15% increase in brand awareness.	/kæmˈpeɪn/	chiến dịch, cuộc vận động	n	campaign	16
653	\N	MEDIUM	The hotel has a 24-hour cancellation policy for all reservations.	/ˌkæn.səlˈeɪ.ʃən/	sự xóa bỏ, sự hủy bỏ	n	cancellation	16
654	\N	MEDIUM	The board is currently reviewing his candidacy for the position of Vice President.	/ˈkæn.dɪ.də.si/	sự ứng cử	n	candidacy	16
655	\N	MEDIUM	We are looking for a candidate with at least five years of experience in sales.	/ˈkæn.dɪ.dət/	ứng cử viên	n	candidate	16
656	\N	MEDIUM	The conference hall has a seating capacity of 500 people.	/kəˈpæs.ə.t̬i/	năng lực, sức chứa	n	capacity	16
657	\N	MEDIUM	The startup is looking for extra capital to expand its operations overseas.	/ˈkæp.ə.t̬əl/	nguồn vốn, thủ đô	n	capital	16
658	\N	MEDIUM	He spent most of his career working for international non-profit organizations.	/kəˈrɪr/	sự nghiệp	n	career	16
659	\N	MEDIUM	Customers receive a 5% discount if they pay in cash.	/kæʃ/	tiền mặt	n	cash	16
660	\N	MEDIUM	The cashier handed me the receipt and wished me a nice day.	/kæʃˈɪr/	nhân viên thu ngân	n	cashier	16
661	\N	MEDIUM	The heavy rain was the main cause of the flight delays.	/kɑːz/	nguyên nhân, lý do	n	cause	16
662	\N	MEDIUM	The company held a celebration to mark its 20th anniversary.	/ˌsel.əˈbreɪ.ʃən/	lễ kỉ niệm	n	celebration	16
663	\N	MEDIUM	You will receive a certificate of completion after finishing the training course.	/sɚˈtɪf.ə.kət/	giấy chứng nhận	n	certificate	16
664	\N	MEDIUM	Professional certification can help improve your chances of getting promoted.	/ˌsɜ˞ː.t̬ə.fɪˈkeɪ.ʃən/	sự cấp giấy chứng nhận	n	certification	16
665	\N	MEDIUM	They are planning to open a new chain of coffee shops across the city.	/tʃeɪn/	chuỗi	n	chain	16
666	\N	MEDIUM	Shopping at a chain store ensures consistent quality and pricing.	/ˈtʃeɪn ˌstɔːr/	cửa hàng theo chuỗi	n	chain store	16
667	\N	MEDIUM	Please take a chair and wait for the manager in the lobby.	/tʃer/	ghế ngồi	n	chair	16
668	\N	MEDIUM	The chairperson called the meeting to order at 9:00 AM.	/ˈtʃerˌpɝː.sən/	chủ tịch	n	chairperson	16
669	\N	MEDIUM	Reliability is a key characteristic we look for in our suppliers.	/ˌker.ək.təˈrɪs.tɪk/	đặc điểm	n	characteristic	16
670	\N	MEDIUM	There is no extra charge for using the hotel's fitness center.	/tʃɑːrdʒ/	chi phí, tiền công	n	charge	16
671	\N	MEDIUM	A careless mistake in the financial report caused a lot of confusion.	/ˈker.ləs/	bất cẩn, cẩu thảo	adj	careless	16
672	\N	MEDIUM	Investors are very cautious about putting money into the new tech startup.	/ˈkɑː.ʃəs/	thận trọng, cẩn thận	adj	cautious	16
673	\N	MEDIUM	We need to calculate the total shipping costs before sending the invoice.	/ˈkæl.kjə.leɪt/	tính toán	v	calculate	16
674	\N	MEDIUM	The meeting was canceled because the director had an urgent matter to attend to.	/ˈkæn.səl/	hủy bỏ	v	cancel	16
675	\N	MEDIUM	The team went out to dinner to celebrate winning the new contract.	/ˈsel.ə.breɪt/	kỉ niệm, tán dương	v	celebrate	16
676	\N	MEDIUM	High quality and durability characterize all products from this brand.	/ˈker.ək.tɚ.aɪz/	biểu thị đặc điểm	v	characterize	16
677	\N	MEDIUM	The company donates a percentage of its profits to a local charity every year.	/ˈtʃer.ə.t̬i/	lòng từ bi, tổ chức từ thiện	n	charity	17
678	\N	MEDIUM	The executive chef is responsible for creating the seasonal menu.	/ʃef/	đầu bếp	n	chef	17
679	\N	MEDIUM	Due to unforeseen circumstances, the outdoor concert has been rescheduled.	/ˈsɝː.kəm.stæns/	hoàn cảnh, tình huống	n	circumstances	17
680	\N	MEDIUM	Please submit your insurance claim within thirty days of the accident.	/kleɪm/	quyền đòi sở hữu, sự yêu cầu bồi thường	n	claim	17
681	\N	MEDIUM	The claimant must provide proof of identity to receive the payment.	/ˈkleɪ.mənt/	người thỉnh cầu, người đòi quyền lợi	n	claimant	17
682	\N	MEDIUM	Our law firm represents a wide range of corporate clients.	/ˈklaɪ.ənt/	khách hàng (đối tác chuyên môn)	n	client	17
683	\N	MEDIUM	The current economic climate makes it difficult for small businesses to thrive.	/ˈklaɪ.mət/	khí hậu, môi trường	n	climate	17
684	\N	MEDIUM	Sales agents earn a 10% commission on every product they sell.	/kəˈmɪʃ.ən/	hội đồng, tiền hoa hồng	n	commission	17
685	\N	MEDIUM	The organizing committee is meeting to plan the annual gala.	/kəˈmɪt̬.i/	ủy ban	n	committee	17
686	\N	MEDIUM	The new express train service will greatly benefit daily commuters.	/kəˈmjuː.t̬ɚ/	người đi lại thường xuyên (bằng vé tháng)	n	commuter	17
687	\N	MEDIUM	He recently joined a tech company specializing in artificial intelligence.	/ˈkʌm.pə.ni/	공 ty, sự cùng đi	n	company	17
688	\N	MEDIUM	The workers are demanding fair compensation for their overtime hours.	/ˌkɑːm.penˈseɪ.ʃən/	sự đền bù, vật bồi thường	n	compensation	17
689	\N	MEDIUM	To stay ahead of our competitors, we must focus on innovation.	/kə mˈpet̬.ə.t̬ɚ/	người cạnh tranh, đối thủ	n	competitor	17
690	\N	MEDIUM	The customer service department handled a formal complaint regarding the faulty item.	/kəmˈpleɪnt/	lời than phiền, đơn khiếu nại	n	complaint	17
691	\N	MEDIUM	Although the materials were cheap, the finished product looks very professional.	/tʃiːp/	rẻ tiền, chất lượng thấp	adj	cheap	17
692	\N	MEDIUM	Ensure that the new software is compatible with your existing operating system.	/kəmˈpæt̬.ə.bəl/	tương thích, phù hợp	adj	compatible	17
693	\N	MEDIUM	The company is looking for a competent manager to lead the new branch.	/ˈɑːm.pə.t̬ənt/	có khả năng, đủ trình độ	adj	competent	17
694	\N	MEDIUM	We offer high-quality services at very competitive prices.	/kəmˈpet̬.ə.t̬ɪv/	có tính cạnh tranh, giá cả phải chăng	adj	competitive	17
695	\N	MEDIUM	A complete list of participants will be available on the website tomorrow.	/kəmˈpliːt/	đầy đủ, hoàn thiện	adj	complete	17
696	\N	MEDIUM	Passengers are advised to check in at least two hours before departure.	/tʃek ɪn/	đăng ký phòng, làm thủ tục vé	v	check in	17
697	\N	MEDIUM	Guests must check out of their rooms by 11:00 AM.	/tʃek aʊt/	trả phòng, thanh toán	v	check out	17
698	\N	MEDIUM	We need to classify these documents according to their importance.	/ˈklæs.ə.faɪ/	phân loại	v	classify	17
699	\N	MEDIUM	The construction of the new office building is scheduled to commence in July.	/kəˈmens/	bắt đầu, khởi đầu	v	commence	17
700	\N	MEDIUM	He has to commute for over an hour each day to get to the office.	/kəˈmjuːt/	di chuyển đều đặn (đi làm/đi học)	v	commute	17
701	\N	MEDIUM	It is always wise to compare prices before making a major purchase.	/kəmˈper/	so sánh, đối chiếu	v	compare	17
702	\N	MEDIUM	The airline will compensate passengers for the long delay.	/ˈkɑːm.pən.seɪt/	đền bù, bồi thường	v	compensate	17
703	\N	MEDIUM	Residents often complain about the noise from the nearby construction site.	/kəmˈpleɪn/	kêu ca, phàn nàn	v	complain	17
704	\N	MEDIUM	The company’s headquarters is located in a large industrial complex.	/ˈkɑːm.pleks/	khu phức hợp	n	complex	18
705	\N	MEDIUM	We need to simplify the process to reduce its complexity.	/kəˈmplek.sə.t̬i/	sự phức tạp	n	complexity	18
706	\N	MEDIUM	It is a great compliment to be asked to speak at the conference.	/ˈkɑːm.plə.mənt/	lời khen	n	compliment	18
707	\N	MEDIUM	After hours of negotiation, both sides reached a compromise.	/ˈkɑːm.prə.maɪz/	sự thỏa hiệp	n	compromise	18
708	\N	MEDIUM	The main concern of the board is the drop in quarterly profits.	/kənˈsɝːn/	mối bận tâm, lo lắng	n	concern	18
709	\N	MEDIUM	The report reached the conclusion that more investment is needed.	/kənˈkluː.ʒən/	kết luận, sự kết thúc	n	conclusion	18
710	\N	MEDIUM	Meet me in the main concourse of the station at noon.	/ˈkɑːn.kɔːrs/	đám đông, sảnh chờ lớn (nhà ga/sân bay)	n	concourse	18
711	\N	MEDIUM	The second-hand machinery was still in excellent condition.	/kənˈdɪʃ.ən/	điều kiện, tình trạng	n	condition	18
712	\N	MEDIUM	The company has a strict code of conduct for all employees.	/ˈkɑːn.dʌkt/	hạnh kiểm, cách cư xử	n	conduct	18
713	\N	MEDIUM	You will receive a confirmation email once your booking is complete.	/ˌkɑːn.fɚˈmeɪ.ʃən/	sự xác nhận	n	confirmation	18
714	\N	MEDIUM	The change in the schedule caused a lot of confusion among the staff.	/kənˈfjuː.ʒən/	sự bối rối, xáo trộn	n	confusion	18
715	\N	MEDIUM	The decision to cut the budget had serious consequences for the project.	/ˈkɑːn.sə.kwəns/	hậu quả, kết quả	n	consequence	18
716	\N	MEDIUM	We hired a management consultant to help us restructure the department.	/kənˈsʌl.tənt/	tư vấn viên, cố vấn	n	consultant	18
717	\N	MEDIUM	Consumer confidence has increased since the interest rates dropped.	/kənˈsuː.mɚ/	người tiêu dùng	n	consumer	18
718	\N	MEDIUM	The hotel offers a complimentary breakfast to all guests.	/ˌkɑːm.pləˈmen.t̬ɚ.i/	miễn phí, ca ngợi	adj	complimentary	18
719	\N	MEDIUM	The manual provides a comprehensive guide to using the software.	/ˌkɑːm.prəˈhen.sɪv/	toàn diện	adj	comprehensive	18
720	\N	MEDIUM	Safety training is compulsory for all new factory workers.	/kəmˈpʌl.sɚ.i/	bắt buộc	adj	compulsory	18
721	\N	MEDIUM	The project will require a considerable amount of time and money.	/kənˈsɪd.ɚ.ə.bəl/	đáng kể, lớn lao	adj	considerable	18
722	\N	MEDIUM	The machine needs constant maintenance to operate efficiently.	/ˈkɑːn.stənt/	liên tục, không đổi	adj	constant	18
723	\N	MEDIUM	The project faced continual delays due to bad weather.	/kənˈtɪn.ju.əl/	liên tục, liên miên	adj	continual	18
724	\N	MEDIUM	All businesses must comply with the new environmental regulations.	/kəmˈplaɪ/	tuân theo	v	comply	18
725	\N	MEDIUM	The official finally conceded that there had been a mistake.	/kənˈsiːd/	thừa nhận, nhượng bộ	v	concede	18
726	\N	MEDIUM	She concluded her speech by thanking the organizers.	/kənˈkluːd/	kết luận, kết thúc	v	conclude	18
727	\N	MEDIUM	The technician is here to connect the office to the high-speed network.	/kəˈnekt/	kết nối	v	connect	18
728	\N	MEDIUM	Modern appliances are designed to consume less energy.	/kənˈsuːm/	tiêu thụ	v	consume	18
729	\N	MEDIUM	The team will continue to work on the project through the weekend.	/kənˈtɪn.juː/	tiếp tục	v	continue	18
730	\N	MEDIUM	Every member is expected to contribute ideas during the meeting.	/kənˈtrɪb.juːt/	đóng góp	v	contribute	18
731	\N	MEDIUM	The manager has full control over the project's budget.	/kənˈtroʊl/	sự điều khiển, kiểm soát	n	control	19
732	\N	MEDIUM	The technician checked the control panel to identify the system error.	/kənˈtroʊl ˌpæn.əl/	bảng điều khiển	n	control panel	19
733	\N	MEDIUM	Corporate culture plays a significant role in employee retention.	/ˈkɔːr.pɚ.ət/	đoàn thể, tập đoàn	n	corporate	19
734	\N	MEDIUM	He works for a multinational corporation with offices in twenty countries.	/ˌkɔːr.pəˈreɪ.ʃən/	tập đoàn	n	corporation	19
735	\N	MEDIUM	The cost of raw materials has risen sharply this month.	/kɑːst/	giá, chi phí	n	cost	19
736	\N	MEDIUM	Please proceed to the customer service counter for your refund.	/ˈkaʊ.t̬ɚ/	quầy hàng, quầy thu ngân	n	counter	19
737	\N	MEDIUM	The documents were sent via courier to ensure they arrived by noon.	/ˈkʊr.i.ɚ/	người đưa thư, chuyển phát nhanh	n	courier	19
738	\N	MEDIUM	A well-written cover letter can help you stand out from other applicants.	/ˈkʌv.ə ˌlet.ər/	thư xin việc, thư ngỏ	n	cover letter	19
739	\N	MEDIUM	The news provided extensive coverage of the international trade summit.	/ˈkʌv.ɚ.ɪdʒ/	mức độ bảo hiểm, bản tin sự kiện	n	coverage	19
740	\N	MEDIUM	She is going to have lunch with her coworkers from the marketing team.	/ˌkoʊˈwɝː.kɚ/	đồng nghiệp	n	coworker	19
741	\N	MEDIUM	The computer crash caused us to lose several hours of work.	/kræʃ/	sự va chạm, sụp đổ hệ thống	n	crash	19
742	\N	MEDIUM	The store will give you a store credit if you return the item without a receipt.	/ˈkred.ɪt/	tín dụng, sự tin tưởng	n	credit	19
743	\N	MEDIUM	Experience is the main criterion for choosing the new supervisor.	/kraɪˈtɪr.i.ən/	tiêu chí đánh giá	n	criterion	19
744	\N	MEDIUM	A large crowd gathered outside the store for the grand opening sale.	/kraʊd/	đám đông	n	crowd	19
745	\N	MEDIUM	They are planning to take a Mediterranean cruise next summer.	/kruːz/	chuyến du lịch biển	n	cruise	19
746	\N	MEDIUM	You can exchange your currency at the airport or at most banks.	/ˈkɝː.ən.si/	tiền tệ	n	currency	19
747	\N	MEDIUM	The strong current made it difficult for the boat to stay on course.	/ˈkɝː.ənt/	dòng, luồng	n	current	19
748	\N	MEDIUM	It is the custom in this office to have a small party for everyone's birthday.	/ˈkʌs.təm/	phong tục, tục lệ	n	custom	19
749	\N	MEDIUM	Our priority is to provide excellent service to every customer.	/ˈkʌs.tə.mɚ/	khách hàng	n	customer	19
750	\N	MEDIUM	The economic cycle often fluctuates between growth and recession.	/ˈsaɪ.kəl/	chu kỳ, chu trình	n	cycle	19
751	\N	MEDIUM	The storm caused significant damage to the warehouse roof.	/ˈdæm.ɪdʒ/	mối gây hại, sự thiệt hại	n	damage	19
752	\N	MEDIUM	The CEO's decision will be critical to the future of the company.	/ˈkrɪt̬.ɪ.kəl/	nguy kịch, phê bình	adj	critical	19
753	\N	MEDIUM	The train was so crowded that I had to stand for the entire trip.	/ˈlraʊ.dɪd/	đông đúc	adj	crowded	19
754	\N	MEDIUM	Accurate data is crucial for making an informed business decision.	/ˈkruː.ʃəl/	trọng yếu, cốt yếu	adj	crucial	19
755	\N	MEDIUM	We have a daily meeting at 9 AM to discuss our tasks.	/ˈdeɪ.li/	hằng ngày	adj	daily	19
756	\N	MEDIUM	It was hard to convince the board to invest in the new technology.	/kənˈvɪns/	thuyết phục	v	convince	19
757	\N	MEDIUM	The manager was careful not to criticize the team in front of the clients.	/ˈkrɪt̬.ɪ.saɪz/	phê bình, chỉ trích	v	criticize	19
758	\N	MEDIUM	The team worked overtime to ensure they met the project deadline.	/ˈded.laɪn/	hạn cuối, hạn hoàn thành	n	deadline	20
759	\N	MEDIUM	The sales representative managed to close a major deal with a new client.	/diːl/	thỏa thuận mua bán, sự giao dịch	n	deal	20
760	\N	MEDIUM	A debit of $500 was recorded in the company's ledger today.	/ˈdeb.ɪt/	món nợ, khoản ghi nợ	n	debit	20
761	\N	MEDIUM	The startup is struggling to pay off its initial debts to investors.	/det/	khoản nợ	n	debt	20
762	\N	MEDIUM	The management's decision to expand overseas was based on thorough research.	/dɪˈsɪʒ.ən/	quyết định	n	decision	20
763	\N	MEDIUM	There has been a significant decrease in the number of customer complaints.	/ˈdiː.kriːs/	sự sụt giảm	n	decrease	20
764	\N	MEDIUM	Applicants for this position must have a university degree in marketing.	/dɪˈɡriː/	mức độ, bằng cấp, nhiệt độ	n	degree	20
765	\N	MEDIUM	We apologize for the delay in processing your application.	/dɪˈlêɪ/	sự chậm trễ, trì hoãn	n	delay	20
766	\N	MEDIUM	The store offers free delivery on all orders over fifty dollars.	/dɪˈlɪv.ɚ.i/	sự giao hàng, sự phát biểu	n	delivery	20
767	\N	MEDIUM	The demand for eco-friendly products is growing rapidly.	/dɪˈmænd/	sự đòi hỏi, nhu cầu	n	demand	20
768	\N	MEDIUM	Please contact the human resources department if you have any questions.	/dɪˈpɑːrt.mənt/	bộ phận, phòng ban	n	department	20
769	\N	MEDIUM	Our heavy dependence on one supplier has become a risk factor.	/dɪˈpen.dəns/	sự phụ thuộc	n	dependence	20
770	\N	MEDIUM	You need to pay a one-month deposit before moving into the apartment.	/dɪˈpɑː.zɪt/	tiền cọc, tiền gửi ngân hàng	n	deposit	20
771	\N	MEDIUM	Read the job description carefully before submitting your resume.	/dɪˈskrɪp.ʃən/	bản mô tả	n	description	20
772	\N	MEDIUM	The restaurant is famous for its delicious chocolate cake dessert.	/dɪˈzɝːt/	món tráng miệng	n	dessert	20
773	\N	MEDIUM	The flight was forced to land before reaching its final destination.	/ˌdes.təˈneɪ.ʃən/	đích đến, điểm đến	n	destination	20
774	\N	MEDIUM	We need a definite answer by Friday to proceed with the plan.	/ˈdef.ən.ət/	xác định rõ, rõ ràng	adj	definite	20
775	\N	MEDIUM	We are delighted to announce that you have been selected for the role.	/dɪˈlaɪ.t̬ɪd/	hài lòng, vui mừng	adj	delighted	20
776	\N	MEDIUM	Software development can be a very demanding profession.	/dɪˈmæn.dɪŋ/	yêu cầu cao, khắt khe	adj	demanding	20
777	\N	MEDIUM	The staff stayed late to decorate the office for the holiday party.	/ˈdek.ər.eɪt/	trang trí	v	decorate	20
778	\N	MEDIUM	He decided to dedicate his career to medical research.	/ˈded.ə.keɪt/	cống hiến, dành riêng cho	v	dedicate	20
779	\N	MEDIUM	The company will deduct tax directly from your monthly salary.	/dɪˈdʌkt/	khấu trừ, trừ đi	v	deduct	20
780	\N	MEDIUM	The courier is scheduled to deliver the package tomorrow morning.	/dɪˈlɪv.ɚ/	giao hàng, phát biểu	v	deliver	20
781	\N	MEDIUM	The salesperson will demonstrate how to use the new coffee machine.	/ˈdem.ən.streɪt/	làm mẫu, giải thích, minh họa	v	demonstrate	20
782	\N	MEDIUM	The train is scheduled to depart from platform 4 at 10:30.	/dɪˈpɑːrt/	rời đi, khởi hành	v	depart	20
783	\N	MEDIUM	Our success depends on the hard work of all our employees.	/dɪˈpend/	phụ thuộc, tùy thuộc vào	v	depend	20
784	\N	MEDIUM	The manager will designate a team leader for the new project.	/ˈdez.ɪɡ.neɪt/	chỉ định, bổ nhiệm	v	designate	20
785	\N	MEDIUM	We need to dispose of the waste properly.	/dɪˈspoʊz/	vứt bỏ, giải quyết	v	dispose	21
786	\N	MEDIUM	The labor dispute was finally settled after a week of negotiations.	/dɪˈspjuːt/	cuộc bàn cãi, tranh chấp	n	dispute	21
787	\N	MEDIUM	The storm caused a major disruption to the local train services.	/dɪsˈrʌp.ʃən/	sự phá vỡ, gián đoạn	n	disruption	21
788	\N	MEDIUM	The company is looking for a new partner to handle the distribution of its products.	/ˌdɪs.trɪˈbjuː.ʃən/	sự phân phát, phân phối	n	distribution	21
789	\N	MEDIUM	Shareholders will receive a higher dividend this year due to increased profits.	/ˈdɪv.ə.dend/	cổ tức, số bị chia	n	dividend	21
790	\N	MEDIUM	Please make sure you save the document before closing the program.	/ˈdɑː.kjə.mənt/	văn kiện, tài liệu	n	document	21
791	\N	MEDIUM	The museum received a generous donation from a local businessman.	/doʊˈneɪ.ʃən/	sự quyên góp, hiến tặng	n	donation	21
792	\N	MEDIUM	I'll have a double of whatever she's having.	/ˈdʌb.əl/	số lượng gấp đôi	n	double	21
793	\N	MEDIUM	The economic downturn has led to a decrease in consumer spending.	/ˈdaʊn.tɝːn/	sự suy thoái, sụt giảm	n	downturn	21
794	\N	MEDIUM	The files you are looking for are in the bottom drawer of the desk.	/drɑːr/	ngăn kéo	n	drawer	21
795	\N	MEDIUM	The annual recruitment drive will start early next month.	/draɪv/	cuộc đua, chiến dịch	n	drive	21
796	\N	MEDIUM	The duration of the training course is three weeks.	/djʊəˈreɪ.ʃən/	khoảng thời gian, thời hạn	n	duration	21
797	\N	MEDIUM	The company's quarterly earnings exceeded market expectations.	/ˈɝː.nɪŋz/	thu nhập, tiền kiếm được	n	earnings	21
798	\N	MEDIUM	Tourism plays a vital role in the national economy.	/iˈkɑː.nə.mi/	nền kinh tế	n	economy	21
799	\N	MEDIUM	The brand is known for its distinctive logo and packaging.	/dɪˈstɪŋ.kɪv/	đặc biệt, độc đáo	adj	distinctive	21
800	\N	MEDIUM	The presentation was quite dull and hard to follow.	/dʌl/	buồn tẻ, chậm hiểu	adj	dull	21
801	\N	MEDIUM	You can buy perfume and alcohol at the duty-free shop in the airport.	/ˌduː.t̬iˈfriː/	miễn thuế	adj	duty-free	21
802	\N	MEDIUM	It is more economical to buy office supplies in bulk.	/ˌiː.kəˈnɑː.mɪ.kəl/	tiết kiệm, kinh tế	adj	economical	21
803	\N	MEDIUM	It is sometimes difficult to distinguish between the two models.	/dɪˈstɪŋ.ɡwɪʃ/	phân biệt, nhận ra	v	distinguish	21
804	\N	MEDIUM	The assistant will distribute the meeting agenda to all participants.	/dɪˈstrɪb.juːt/	phân phát, phân bổ	v	distribute	21
805	\N	MEDIUM	Many employees choose to donate a portion of their salary to charity.	\N	quyên góp	/ˈdoʊ.neɪt/	donate	21
806	\N	MEDIUM	You can download the full report from our website.	/ˈdaʊn.loʊd/	tải xuống	v	download	21
807	\N	MEDIUM	The firm had to downsize its workforce to stay afloat during the crisis.	/ˈdaʊn.saɪz/	cắt giảm nhân sự/quy mô	v	downsize	21
808	\N	MEDIUM	The trade fair is expected to draw thousands of visitors.	/drɑː/	vẽ, thu hút	v	draw	21
809	\N	MEDIUM	The company hopes to earn a profit by the end of the second year.	/ɝːn/	kiếm tiền, giành được	v	earn	21
810	\N	MEDIUM	We need to economize on electricity and paper usage.	/iˈkɑː.nə.maɪz/	tiết kiệm chi phí	v	economize	21
811	\N	MEDIUM	The effectiveness of the new marketing campaign will be measured by sales growth.	/əˈfek.tɪv.nəs/	sự hiệu quả	n	effectiveness	22
812	\N	MEDIUM	We are looking for ways to improve the energy efficiency of our manufacturing plant.	/ɪˈfɪʃ.ən.si/	hiệu suất, năng suất	n	efficiency	22
813	\N	MEDIUM	The freight elevator is currently out of service for maintenance.	/ˈel.ə.veɪ.t̬ɚ/	thang máy	n	elevator	22
814	\N	MEDIUM	In case of an emergency, please use the stairs instead of the lift.	/ɪˈmɝː.dʒən.si/	trường hợp khẩn cấp	n	emergency	22
815	\N	MEDIUM	As an employer, the company is responsible for providing a safe working environment.	/ɪmˈplɔɪ.ɚ/	người làm chủ, chủ lao động	n	employer	22
816	\N	MEDIUM	The terms of your employment are clearly stated in the contract.	/ɪmˈplɔɪ.mənt/	việc làm, sự thuê mướn	n	employment	22
817	\N	MEDIUM	The software engineer fixed the bug in the system within an hour.	/ˌen.dʒɪˈnɪr/	kỹ sư	n	engineer	22
818	\N	MEDIUM	The firm specializes in civil engineering and urban planning.	/ˌen.dʒɪˈnɪr.ɪŋ/	công việc kỹ sư, ngành kỹ thuật	n	engineering	22
819	\N	MEDIUM	This small enterprise has grown into a global leader in just five years.	/ˈen.t̬ɚ.praɪz/	doanh nghiệp, xí nghiệp	n	enterprise	22
820	\N	MEDIUM	Your holiday entitlement increases after two years of service with the company.	/ɪnˈtaɪ.t̬əl.mənt/	quyền hạn, sự được phép hưởng	n	entitlement	22
821	\N	MEDIUM	The waiter recommended the grilled salmon as the best entrée on the menu.	/ˈɑːn.treɪ/	món chính, sự gia nhập	n	entrée	22
822	\N	MEDIUM	The new safety regulations will be effective starting from next Monday.	/əˈfek.tɪv/	hiệu quả, có hiệu lực	adj	effective	22
823	\N	MEDIUM	An efficient filing system can save a lot of time in the office.	/ɪˈfɪʃ.ənt/	năng suất cao, hiệu quả tốt	adj	efficient	22
824	\N	MEDIUM	The community center offers various programs for elderly residents.	/ˈel.dɚ.li/	lớn tuổi, có tuổi	adj	elderly	22
825	\N	MEDIUM	The manager was very enthusiastic about the new project proposal.	/ɪnˌθuː.ziˈæs.tɪk/	nhiệt tình, hứng khởi	adj	enthusiastic	22
826	\N	MEDIUM	The company is about to embark on a major restructuring plan.	/ɪmˈbɑːrk/	bắt đầu, dấn thân, lên tàu/máy bay	v	embark	22
827	\N	MEDIUM	I must emphasize that all data in this report is strictly confidential.	/ˈem.fə.saɪz/	nhấn mạnh	v	emphasize	22
828	\N	MEDIUM	This software update will enable users to share files more easily.	/ɪˈneɪ.bəl/	cho phép, làm cho có thể	v	enable	22
829	\N	MEDIUM	Please find the invoice and the shipping label enclosed with this letter.	/ɪnˈkloʊz/	gửi kèm, vây quanh	v	enclose	22
830	\N	MEDIUM	Managers are encouraged to provide regular feedback to their teams.	/ɪnˈkɝː.ɪʒ/	động viên, cổ vũ	v	encourage	22
831	\N	MEDIUM	The company has managed to endure several economic recessions.	/ɪnˈdʊr/	chịu đựng, tồn tại lâu dài	v	endure	22
832	\N	MEDIUM	We need to enhance our customer service to compete in the current market.	/ɪnˈhæns/	làm tăng thêm, đẩy mạnh	v	enhance	22
833	\N	MEDIUM	The seminar aims to enlighten participants on new financial regulations.	/ɪnˈlaɪ.t̬ən/	làm sáng tỏ, khai sáng	v	enlighten	22
834	\N	MEDIUM	Employees can enroll in the company’s retirement plan after six months.	/ɪnˈroʊl/	đăng ký, ghi danh	v	enroll	22
835	\N	MEDIUM	Please double-check the figures to ensure accuracy in the final report.	/ɪnˈʃʊr/	bảo đảm, chắc chắn	v	ensure	22
836	\N	MEDIUM	The project manager went over every detail of the contract before signing.	/ˈdiː.teɪl/	chi tiết, tiểu tiết	n	detail	23
837	\N	MEDIUM	The deterioration of the building's structure required immediate renovation.	/dɪˌtɪr.i.əˈreɪ.ʃən/	sự hư hại, xuống cấp	n	deterioration	23
838	\N	MEDIUM	Our lead developer is working on a new feature for the mobile app.	/dɪˈvel.ə.pɚ/	người phát triển, lập trình viên	n	developer	23
839	\N	MEDIUM	The development of the new software took over six months to complete.	/dɪˈvel.əp.mənt/	sự phát triển	n	development	23
840	\N	MEDIUM	Please turn off all electronic devices before the flight takes off.	/dɪˈvaɪs/	thiết bị, máy móc	n	device	23
841	\N	MEDIUM	The board of directors will meet next week to discuss the annual report.	/daɪˈrek.tɚ/	giám đốc, người điều hành	n	director	23
842	\N	MEDIUM	There was a slight disagreement between the two departments regarding the budget.	/ˌdɪs.əˈɡriː.mənt/	sự bất đồng, mâu thuẫn	n	disagreement	23
843	\N	MEDIUM	Employees are entitled to a 20% discount on all company products.	/ˈdɪs.kaʊnt/	sự giảm giá, chiết khấu	n	discount	23
844	\N	MEDIUM	The auditor found a discrepancy between the receipts and the bank statement.	/dɪˈskrep.ən.si/	sự khác biệt, chênh lệch (số liệu)	n	discrepancy	23
845	\N	MEDIUM	The company has strict policies against any form of workplace discrimination.	/dɪˌskrɪm.əˈneɪ.ʃən/	sự phân biệt đối xử	n	discrimination	23
846	\N	MEDIUM	We had a productive discussion about the upcoming marketing strategy.	/dɪˈskʌʃ.ən/	cuộc thảo luận	n	discussion	23
847	\N	MEDIUM	The signature dish at this restaurant is grilled salmon with asparagus.	/dɪʃ/	món ăn, đĩa đựng	n	dish	23
848	\N	MEDIUM	The latest products are currently on display in the main lobby.	/dɪˈspleɪ/	sự trưng bày, màn hình	n	display	23
849	\N	MEDIUM	The technician provided a detailed explanation of how the system works.	/ˈdiː.teɪld/	chi tiết, cụ thể	adj	detailed	23
850	\N	MEDIUM	She is determined to finish the report before the end of the day.	/dɪˈtɝː.mɪnd/	quyết tâm, kiên quyết	adj	determined	23
851	\N	MEDIUM	Differential pricing is used to target different segments of the market.	/ˌdɪf.əˈren.ʃəl/	khác biệt, chênh lệch	adj	differential	23
852	\N	MEDIUM	He is a diligent worker who always pays attention to small details.	/ˈdɪl.ə.dʒənt/	chăm chỉ, cần cù	adj	diligent	23
853	\N	MEDIUM	The quarterly sales results were quite disappointing for the investors.	/ˌdɪs.əˈpɔɪn.t̬ɪŋ/	đáng thất vọng	adj	disappointing	23
854	\N	MEDIUM	The manager was dismissive of the employee's concerns about safety.	/dɪˈsmɪs.ɪv/	thô bạo, tùy tiện, gạt bỏ	adj	dismissive	23
855	\N	MEDIUM	The cafeteria replaced plastic plates with biodegradable disposable ones.	/dɪˈspoʊ.zə.bəl/	dùng một lần, sẵn có	adj	disposable	23
856	\N	MEDIUM	The security system is designed to detect any unauthorized entry.	/dɪˈtekt/	dò ra, phát hiện	v	detect	23
857	\N	MEDIUM	The committee will determine which candidate is best suited for the job.	/dɪˈtɝː.mɪn/	xác định rõ, quyết định	v	determine	23
858	\N	MEDIUM	The company plans to develop a new line of organic skincare products.	/dɪˈvel.əp/	phát triển	v	develop	23
859	\N	MEDIUM	The IT team is trying to diagnose the cause of the network failure.	/ˌdaɪ.əɡˈnoʊz/	chẩn đoán	v	diagnose	23
860	\N	MEDIUM	I'm afraid I disagree with the proposed changes to the policy.	/ˌdɪs.əˈɡriː/	bất đồng, không đồng ý	v	disagree	23
861	\N	MEDIUM	Remember to disconnect the power supply before repairing the machine.	/ˌdɪs.kəˈnekt/	ngắt kết nối	v	disconnect	23
862	\N	MEDIUM	We need to discuss the feedback from our latest customer survey.	/dɪˈskʌs/	thảo luận	v	discuss	23
863	\N	MEDIUM	The judge decided to dismiss the case due to a lack of evidence.	/dɪˈsmɪs/	giải tán, sa thải, gạt bỏ	v	dismiss	23
864	\N	MEDIUM	We strive to create a working environment that fosters creativity and collaboration.	/ɪnˈvaɪ.rən.mənt/	môi trường	n	environment	24
865	\N	MEDIUM	The cost of the repair is the equivalent of a new machine.	/ɪˈkwɪv.əl.ənt/	vật tương đương, sự tương đương	n	equivalent	24
866	\N	MEDIUM	The networking event is a great opportunity to meet industry leaders.	/ɪˈvent/	sự kiện	n	event	24
867	\N	MEDIUM	There is clear evidence that the new marketing strategy is working.	/ˈev.ə.dəns/	bằng chứng, chứng cớ	n	evidence	24
868	\N	MEDIUM	A thorough examination of the financial records revealed some errors.	/ɪɡˌzæm.əˈneɪ.ʃən/	sự khám xét, kiểm tra, kỳ thi	n	examination	24
869	\N	MEDIUM	The chief executive decided to delay the product launch by two weeks.	/ɪɡˈzek.jə.t̬ɪv/	người điều hành, ủy viên ban quản trị	n	executive	24
870	\N	MEDIUM	The company’s rapid expansion into Asian markets has been very successful.	/ɪkˈspæn.ʃən/	sự mở rộng	n	expansion	24
871	\N	MEDIUM	The final sales figures exceeded our highest expectations.	/ˌek.spekˈteɪ.ʃən/	sự mong chờ, kỳ vọng	n	expectation	24
872	\N	MEDIUM	The government is planning to increase its expenditure on infrastructure.	/ɪkˈspen.də.tʃɚ/	sự tiêu dùng, phí tổn (ngân sách)	n	expenditure	24
873	\N	MEDIUM	Travel expenses will be reimbursed by the company upon submission of receipts.	/ɪkˈspens/	chi phí	n	expense	24
874	\N	MEDIUM	Applicants must have at least three years of experience in accounting.	/ɪkˈspɪr.i.əns/	trải nghiệm, kinh nghiệm	n	experience	24
875	\N	MEDIUM	The laboratory is conducting an experiment to test the new drug's safety.	/ɪkˈsper.ə.mənt/	thí nghiệm, cuộc thử nghiệm	n	experiment	24
876	\N	MEDIUM	The company is involved in the exploration of new oil fields in the North Sea.	/ˌek.spləˈreɪ.ʃən/	cuộc thăm dò, thám hiểm	n	exploration	24
877	\N	MEDIUM	If you send it by express, it should arrive by tomorrow morning.	/ɪkˈspres/	công văn hỏa tốc, dịch vụ chuyển phát nhanh	n	express	24
878	\N	MEDIUM	The firm was fined for violating several environmental regulations.	/ɪnˌvaɪ.rənˈmen.t̬əl/	(thuộc) môi trường	adj	environmental	24
879	\N	MEDIUM	Good communication skills are essential for this customer-facing role.	/ɪˈsen.ʃəl/	cốt lõi, thiết yếu	adj	essential	24
880	\N	MEDIUM	We need the exact measurements before we can start the installation.	/ɪɡˈzækt/	chính xác	adj	exact	24
881	\N	MEDIUM	The hotel is famous for its excellent service and luxurious rooms.	/ˈek.səl.ənt/	xuất sắc, ưu tú	adj	excellent	24
882	\N	MEDIUM	Maintaining the old equipment has become too expensive for the factory.	/ɪkˈspen.sɪv/	đắt tiền	adj	expensive	24
883	\N	MEDIUM	Our team consists of highly experienced professionals in the tech industry.	/ɪkˈspɪə.ri.ənst/	có kinh nghiệm	adj	experienced	24
884	\N	MEDIUM	Experts estimate that the global economy will grow by 3% this year.	/ˈes.tə.meɪt/	ước tính, dự đoán	v	estimate	24
885	\N	MEDIUM	We need to evaluate the performance of our suppliers every quarter.	/ɪˈvæl.ju.eɪt/	đánh giá, định giá	v	evaluate	24
886	\N	MEDIUM	The small family business has evolved into a major international firm.	/ɪˈvɑːlv/	tiến hóa, phát triển dần	v	evolve	24
887	\N	MEDIUM	The safety inspector will examine the machinery for any potential risks.	/ɪɡˈzæm.ɪn/	khảo sát, kiểm tra kỹ	v	examine	24
888	\N	MEDIUM	She has always managed to excel in competitive environments.	/ɪkˈsel/	vượt trội, xuất sắc ở lĩnh vực nào đó	v	excel	24
889	\N	MEDIUM	Local artists will exhibit their work at the gallery next month.	/ɪɡˈzɪb.ɪt/	trưng bày, triển lãm	v	exhibit	24
890	\N	MEDIUM	The retail chain plans to expand its operations to three more cities.	/ɪkˈspænd/	mở rộng	v	expand	24
891	\N	MEDIUM	We expect the new software to be available for download by Friday.	/ɪkˈspekt/	chờ đợi, hy vọng, liệu rằng	v	expect	24
892	\N	MEDIUM	If you need more time to finish the report, you can request a two-day extension.	/ɪkˈsten.ʃən/	sự mở rộng, sự gia hạn, số máy nhánh	n	extension	25
893	\N	MEDIUM	The research facility is equipped with the latest technology in the field.	/fəˈsɪl.ə.t̬i/	cơ sở vật chất, điều kiện thuận lợi	n	facility	25
894	\N	MEDIUM	Location is a key factor to consider when opening a new retail store.	/ˈfæk.tɚ/	nhân tố	n	factor	25
895	\N	MEDIUM	The company plans to build a new factory to increase production capacity.	/ˈfæk.tɚ.i/	nhà máy, xí nghiệp	n	factory	25
896	\N	MEDIUM	The power failure resulted in the loss of unsaved data on many computers.	/ˈfeɪ.ljɚ/	sự thất bại, sự hỏng hóc (máy móc)	n	failure	25
897	\N	MEDIUM	Many local businesses will participate in the annual job fair this weekend.	/fer/	hội chợ, phiên chợ	n	fair	25
898	\N	MEDIUM	Bus fares are expected to increase by ten percent next month.	/fer/	tiền xe, tiền vé (tàu, xe, máy bay)	n	fare	25
899	\N	MEDIUM	The technician identified a minor fault in the wiring system.	/fɑːlt/	lỗi, sai lầm, khuyết điểm	n	fault	25
900	\N	MEDIUM	Could you do me a favor and drop these documents off at the post office?	/ˈfeɪ.vɚ/	thiện ý, sự giúp đỡ	n	favor	25
901	\N	MEDIUM	Please send the signed agreement via fax to our headquarters.	/fæks/	bản fax, máy fax	n	fax	25
902	\N	MEDIUM	The most impressive feature of the new smartphone is its long battery life.	/ˈfiː.tʃɚ/	đặc điểm, tính năng	n	feature	25
903	\N	MEDIUM	There is a small processing fee for all credit card transactions.	/fiː/	lệ phí, phí dịch vụ	n	fee	25
904	\N	MEDIUM	Positive feedback from customers has boosted the team's morale.	/ˈfiːd.bæk/	phản hồi, góp ý	n	feedback	25
905	\N	MEDIUM	The latest sales figures show a steady increase in revenue.	/ˈfɪɡ.jɚ/	con số, số liệu, nhân vật	n	figure	25
906	\N	MEDIUM	I need to organize these files before the meeting starts.	/faɪl/	hồ sơ, tập tin	n	file	25
907	\N	MEDIUM	She has a background in international finance and investment.	/ˈfaɪ.næns/	tài chính	n	finance	25
908	\N	MEDIUM	My flight was delayed due to heavy fog at the airport.	/flaɪt/	chuyến bay	n	flight	25
909	\N	MEDIUM	The flight attendant helped the passengers locate their seats.	/ˈflaɪt əˌten.dənt/	tiếp viên hàng không	n	flight attendant	25
910	\N	MEDIUM	The company hired an external consultant to review its safety procedures.	/ɪkˈstɝː.nəl/	bên ngoài, đối ngoại	adj	external	25
911	\N	MEDIUM	The city is famed for its historic architecture and vibrant culture.	/feɪmd/	nổi tiếng, lừng danh	adj	famed	25
912	\N	MEDIUM	You can return the faulty goods and ask for a full refund.	/ˈfɑːl.t̬i/	có lỗi, bị hỏng	adj	faulty	25
913	\N	MEDIUM	The final decision regarding the budget will be made by the CEO.	/ˈfaɪ.nəl/	cuối cùng	adj	final	25
914	\N	MEDIUM	The company is in a strong financial position following the merger.	/faɪˈnæn.ʃəl/	(thuộc) tài chính	adj	financial	25
915	\N	MEDIUM	We offer flexible working hours to help employees balance work and life.	/ˈflek.sə.bəl/	linh hoạt	adj	flexible	25
916	\N	MEDIUM	The deadline for the scholarship application has been extended to next Friday.	/ɪkˈstend/	gia hạn, kéo dài, gửi tới	v	extend	25
917	\N	MEDIUM	If the negotiations fail, the company will have to look for a different partner.	/feɪl/	thất bại, trượt	v	fail	25
918	\N	MEDIUM	Please fill out the application form and sign it at the bottom.	/fɪl/	làm đầy, điền vào (fill out/in)	v	fill	25
919	\N	MEDIUM	The IT department is working to fix the server issue as quickly as possible.	/fɪks/	sửa chữa, cố định	v	fix	25
920	\N	MEDIUM	Investors are concerned about the constant fluctuation in oil prices.	/ˌflʌk.tʃuˈeɪ.ʃən/	sự dao động, biến động	n	fluctuation	26
921	\N	MEDIUM	The main focus of today's meeting is the upcoming product launch.	/ˈfoʊ.kəs/	sự tập trung, tiêu điểm	n	focus	26
922	\N	MEDIUM	Make a sharp fold at the top of the page to mark your place.	/foʊld/	nếp gấp	n	fold	26
923	\N	MEDIUM	Please organize these invoices into the blue folder on my desk.	/ˈfoʊl.dɚ/	bìa đựng hồ sơ, kẹp tài liệu	n	folder	26
924	\N	MEDIUM	The sales force has been doubled to reach more potential customers.	/fɔːrs/	lực lượng, sức mạnh	n	force	26
925	\N	MEDIUM	The weather forecast predicts heavy rain for the weekend.	/ˈfɔːr.kæst/	sự dự báo	n	forecast	26
926	\N	MEDIUM	Applicants are required to fill out an application form online.	/fɔːrm/	mẫu đơn, hình dáng	n	form	26
927	\N	MEDIUM	Rising fuel costs have impacted the shipping industry significantly.	/ˈfjuː.əl/	nhiên liệu, chất đốt	n	fuel	26
928	\N	MEDIUM	The main function of this software is to track inventory in real-time.	/ˈfʌŋk.ʃən/	chức năng, buổi lễ/tiệc	n	function	26
929	\N	MEDIUM	The charity organized a fundraising event to build a new community center.	/ˈfʌndˌreɪ.zɪŋ/	sự huy động vốn, gây quỹ	n	fundraising	26
930	\N	MEDIUM	The office furniture was replaced to create a more ergonomic workspace.	/ˈfɝː.nɪ.tʃɚ/	đồ nội thất	n	furniture	26
931	\N	MEDIUM	Sending a thank-you note is a nice gesture after a job interview.	/ˈdʒes.tʃɚ/	cử chỉ, điệu bộ	n	gesture	26
932	\N	MEDIUM	Our primary goal is to achieve a 15% increase in sales this quarter.	/ɡoʊl/	mục tiêu	n	goal	26
933	\N	MEDIUM	The warehouse is used to store finished goods before they are shipped.	/ɡʊdz/	hàng hóa	n	goods	26
934	\N	MEDIUM	The employee filed a formal grievance regarding unfair treatment.	/ˈɡriː.vəns/	lời than phiền, khiếu nại (trong công việc)	n	grievance	26
935	\N	MEDIUM	The restaurant is famous for its mixed grill platter.	/ɡrɪl/	vỉ nướng, món nướng	n	grill	26
936	\N	MEDIUM	She remained focused on her work despite the noise in the office.	/ˈfoʊ.kəst/	tập trung, chú ý	adj	focused	26
937	\N	MEDIUM	Learning a foreign language is beneficial for international business.	/ˈfɔːr.ən/	nước ngoài, ngoại quốc	adj	foreign	26
938	\N	MEDIUM	He has become quite forgetful lately, often losing his keys.	/fɚˈɡet.fəl/	hay quên	adj	forgetful	26
939	\N	MEDIUM	To be frank, I don't think the new design will be popular with customers.	/fræŋk/	thẳng thắn, bộc trực	adj	frank	26
940	\N	MEDIUM	The new office layout is both stylish and highly functional.	/ˈfʌŋk.ʃən.əl/	(thuộc) chức năng, hữu dụng	adj	functional	26
941	\N	MEDIUM	For further information, please visit our official website.	/ˈfɝː.ðɚ/	xa hơn, thêm nữa	adj	further	26
942	\N	MEDIUM	Exchange rates fluctuate daily based on market conditions.	/ˈflʌk.tʃu.eɪt/	dao động, thay đổi thất thường	v	fluctuate	26
943	\N	MEDIUM	Don't forget to back up your files before the system update.	/fɚˈɡet/	quên	v	forget	26
944	\N	MEDIUM	The company worked hard to fulfill all customer orders on time.	/fʊlˈfɪl/	hoàn thành, đáp ứng	v	fulfill	26
945	\N	MEDIUM	The company has seen a significant growth in international sales this year.	/ɡroʊθ/	sự tăng trưởng, phát triển	n	growth	27
946	\N	MEDIUM	The electronic equipment comes with a two-year guarantee against defects.	/ˌɡer.ənˈtiː/	sự đảm bảo, giấy bảo hành	n	guarantee	27
947	\N	MEDIUM	Please follow the guidelines provided in the employee handbook.	/ˈɡaɪd.laɪn/	quy tắc, nguyên tắc chỉ đạo	n	guideline	27
948	\N	MEDIUM	It's common to haggle over prices at local street markets.	/ˈhæɡ.əl/	sự mặc cả	n	haggle	27
949	\N	MEDIUM	The handle of the suitcase was damaged during the flight.	/ˈhæn.dəl/	tay cầm, cán	n	handle	27
950	\N	MEDIUM	The ship is docked in the harbor for repairs.	/ˈhɑː.bər/	bến cảng	n	harbor	27
951	\N	MEDIUM	Our head office is located in the financial district of New York.	/ˌhed ˈɑː.fɪs/	trụ sở chính, văn phòng chính	n	head office	27
952	\N	MEDIUM	The global headquarters of the firm moved to London last summer.	/ˈhedˌkwɔːr.t̬ɚz/	sở chỉ huy, trụ sở chính	n	headquarters	27
953	\N	MEDIUM	After a brief hesitation, the candidate signed the job offer.	/ˌhez.əˈteɪ.ʃən/	sự do dự, ngập ngừng	n	hesitation	27
954	\N	MEDIUM	The highlight of the conference was the keynote speech by the CEO.	/ˈhaɪ.laɪt/	điểm nổi bật	n	highlight	27
955	\N	MEDIUM	The recent price hike has caused concern among regular customers.	/haɪk/	cuộc đi bộ đường dài, sự tăng vọt (giá)	n	hike	27
956	\N	MEDIUM	The new hires are required to attend an orientation session tomorrow.	/haɪr/	sự thuê, người mới được thuê	n	hire	27
957	\N	MEDIUM	All large luggage must be stored in the aircraft's hold.	/hoʊld/	sự cầm nắm, khoang hàng (tàu)	n	hold	27
958	\N	MEDIUM	The city is proud to be the host of the international trade fair.	/hoʊst/	chủ nhà, người chủ trì	n	host	27
959	\N	MEDIUM	Please show your identification at the security desk upon arrival.	/aɪˌden.t̬ə.fəˈkeɪ.ʃən/	sự nhận diện, giấy tờ tùy thân	n	identification	27
960	\N	MEDIUM	The new tax policy will have a major impact on small businesses.	/ˈɪm.pækt/	tác động, ảnh hưởng	n	impact	27
961	\N	MEDIUM	It's always handy to have a backup of your files on a portable drive.	/ˈhæn.di/	thuận tiện, có sẵn	adj	handy	27
962	\N	MEDIUM	The report warns that high levels of stress can be harmful to health.	/ˈhɑːrm.fəl/	gây hại	adj	harmful	27
963	\N	MEDIUM	The workers wear protective gear when handling hazardous chemicals.	/ˈhæz.ɚ.dəs/	nguy hiểm, mạo hiểm	adj	hazardous	27
964	\N	MEDIUM	The marketing team came up with an imaginative solution for the ad campaign.	/ɪˈmædʒ.ə.nə.t̬ɪv/	giàu tưởng tượng, sáng tạo	adj	imaginative	27
965	\N	MEDIUM	The new software update requires an immediate restart of the system.	/ɪˈmiː.di.ət/	ngay lập tức, trực tiếp	adj	immediate	27
966	\N	MEDIUM	The customer became impatient after waiting for thirty minutes.	/ɪmˈpeɪ.ʃənt/	thiếu kiên nhẫn	adj	impatient	27
967	\N	MEDIUM	Please do not hesitate to contact us if you have any questions.	/ˈhez.ə.teɪt/	do dự	v	hesitate	27
968	\N	MEDIUM	The company was accused of trying to hide its financial losses.	/haɪd/	che giấu	v	hide	27
969	\N	MEDIUM	The investigation aims to identify the cause of the system failure.	/aɪˈden.t̬ə.faɪ/	nhận diện, xác định	v	identify	27
970	\N	MEDIUM	He was arrested for trying to impersonate a police officer.	/ɪmˈpɝː.sən.eɪt/	mạo danh, đóng vai	v	impersonate	27
\.


--
-- Name: achievements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.achievements_id_seq', 1, false);


--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_attempts_id_seq', 5, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topics_id_seq', 27, true);


--
-- Name: user_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_progress_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: vocabularies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vocabularies_id_seq', 970, true);


--
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- Name: attempt_answers attempt_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_answers
    ADD CONSTRAINT attempt_answers_pkey PRIMARY KEY (attempt_id, question_id);


--
-- Name: exam_attempts exam_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_attempts
    ADD CONSTRAINT exam_attempts_pkey PRIMARY KEY (id);


--
-- Name: exam_templates exam_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_templates
    ADD CONSTRAINT exam_templates_pkey PRIMARY KEY (id);


--
-- Name: ipa_confusing_pairs ipa_confusing_pairs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ipa_confusing_pairs
    ADD CONSTRAINT ipa_confusing_pairs_pkey PRIMARY KEY (id);


--
-- Name: ipa_phonemes ipa_phonemes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ipa_phonemes
    ADD CONSTRAINT ipa_phonemes_pkey PRIMARY KEY (id);


--
-- Name: ipa_words ipa_words_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ipa_words
    ADD CONSTRAINT ipa_words_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: users uk_6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- Name: topics uk_7tuhnscjpohbffmp7btit1uff; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT uk_7tuhnscjpohbffmp7btit1uff UNIQUE (name);


--
-- Name: ipa_phonemes uk_cxse2xrhatnoyhn5837owmr7m; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ipa_phonemes
    ADD CONSTRAINT uk_cxse2xrhatnoyhn5837owmr7m UNIQUE (symbol);


--
-- Name: achievements uk_ktpif54u9a3ssn6rpxxqx6jvp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT uk_ktpif54u9a3ssn6rpxxqx6jvp UNIQUE (name);


--
-- Name: user_progress user_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_progress
    ADD CONSTRAINT user_progress_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vocabularies vocabularies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vocabularies
    ADD CONSTRAINT vocabularies_pkey PRIMARY KEY (id);


--
-- Name: exam_attempts fk1fg44fp83p3itmga7jnje9xc8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_attempts
    ADD CONSTRAINT fk1fg44fp83p3itmga7jnje9xc8 FOREIGN KEY (template_id) REFERENCES public.exam_templates(id);


--
-- Name: attempt_answers fk25c079ncy1idc9r4fj4ug6t6f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_answers
    ADD CONSTRAINT fk25c079ncy1idc9r4fj4ug6t6f FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: ipa_words fk73sys2iim0pf369bbvy4s4hdn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ipa_words
    ADD CONSTRAINT fk73sys2iim0pf369bbvy4s4hdn FOREIGN KEY (primary_phoneme_id) REFERENCES public.ipa_phonemes(id);


--
-- Name: ipa_confusing_pairs fkcy9cehpn6qmp1udni0snyn9lw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ipa_confusing_pairs
    ADD CONSTRAINT fkcy9cehpn6qmp1udni0snyn9lw FOREIGN KEY (phoneme_id_2) REFERENCES public.ipa_phonemes(id);


--
-- Name: user_progress fkda4ew6uxvxv60yu9b1sbnhntv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_progress
    ADD CONSTRAINT fkda4ew6uxvxv60yu9b1sbnhntv FOREIGN KEY (vocab_id) REFERENCES public.vocabularies(id);


--
-- Name: attempt_answers fko5l8lds50jeasb0ko4m15bsti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attempt_answers
    ADD CONSTRAINT fko5l8lds50jeasb0ko4m15bsti FOREIGN KEY (attempt_id) REFERENCES public.exam_attempts(id);


--
-- Name: vocabularies fkp6fiqnekqeiwugsb9cpmc0ced; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vocabularies
    ADD CONSTRAINT fkp6fiqnekqeiwugsb9cpmc0ced FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: quiz_attempts fkp8rw7e04f3qra2uii437cal15; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT fkp8rw7e04f3qra2uii437cal15 FOREIGN KEY (vocab_id) REFERENCES public.vocabularies(id);


--
-- Name: questions fksxwgrf7v7r900o7rc49gjj4me; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fksxwgrf7v7r900o7rc49gjj4me FOREIGN KEY (template_id) REFERENCES public.exam_templates(id);


--
-- Name: ipa_confusing_pairs fkt61g8fwi3afn8u26bad5fieog; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ipa_confusing_pairs
    ADD CONSTRAINT fkt61g8fwi3afn8u26bad5fieog FOREIGN KEY (phoneme_id_1) REFERENCES public.ipa_phonemes(id);


--
-- PostgreSQL database dump complete
--

\unrestrict cWAOOd9OC4bRvVysQZYUDg9EFMz7V5pJ7eOq8vDhBUd0nXsHCQubKc8xfvIRLir

