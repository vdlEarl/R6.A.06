--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Debian 12.17-1.pgdg120+1)
-- Dumped by pg_dump version 12.17 (Debian 12.17-1.pgdg120+1)

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
-- Name: exo_state; Type: TYPE; Schema: public; Owner: plagedba
--

CREATE TYPE exo_state AS ENUM (
    'Draft in progress',
    'Need to be tested',
    'Available',
    'Require correction'
);


ALTER TYPE exo_state OWNER TO plagedba;

--
-- Name: loc; Type: TYPE; Schema: public; Owner: plagedba
--

CREATE TYPE loc AS ENUM (
    'en',
    'fr'
);


ALTER TYPE loc OWNER TO plagedba;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: acquiredskill; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE acquiredskill (
    user_id integer NOT NULL,
    skill_code character varying(40) NOT NULL
);


ALTER TABLE acquiredskill OWNER TO plagedba;

--
-- Name: acquiredskill_user_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE acquiredskill_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acquiredskill_user_id_seq OWNER TO plagedba;

--
-- Name: acquiredskill_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE acquiredskill_user_id_seq OWNED BY acquiredskill.user_id;


--
-- Name: exercise; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE exercise (
    ex_id integer NOT NULL,
    template_statement text,
    template_archive bytea,
    state exo_state NOT NULL,
    author integer NOT NULL,
    name character varying(40) NOT NULL,
    statement_creation_script bytea,
    marking_script bytea,
    locale loc NOT NULL,
    ref_id integer
);


ALTER TABLE exercise OWNER TO plagedba;

--
-- Name: exercise_ex_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE exercise_ex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exercise_ex_id_seq OWNER TO plagedba;

--
-- Name: exercise_ex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE exercise_ex_id_seq OWNED BY exercise.ex_id;


--
-- Name: exerciselevel; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE exerciselevel (
    skill_code character varying(40) NOT NULL,
    ex_id integer NOT NULL,
    nam_id integer NOT NULL
);


ALTER TABLE exerciselevel OWNER TO plagedba;

--
-- Name: exerciseproduction; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE exerciseproduction (
    ep_id integer NOT NULL,
    ex_id integer NOT NULL,
    user_id integer NOT NULL,
    comment text,
    is_final boolean NOT NULL,
    score numeric(5,2) NOT NULL,
    processing_log text NOT NULL,
    working_time character varying(40) NOT NULL,
    production_data bytea NOT NULL,
    submissiont_date date NOT NULL
);


ALTER TABLE exerciseproduction OWNER TO plagedba;

--
-- Name: exerciseproduction_ep_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE exerciseproduction_ep_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exerciseproduction_ep_id_seq OWNER TO plagedba;

--
-- Name: exerciseproduction_ep_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE exerciseproduction_ep_id_seq OWNED BY exerciseproduction.ep_id;


--
-- Name: lms_activity_to_soy_ex; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE lms_activity_to_soy_ex (
    link_id integer NOT NULL,
    lms_instance_id integer NOT NULL,
    lms_course_id integer NOT NULL,
    lms_activity_id integer NOT NULL,
    soy_ex_id integer NOT NULL
);


ALTER TABLE lms_activity_to_soy_ex OWNER TO plagedba;

--
-- Name: lms_act_to_soy_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE lms_act_to_soy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lms_act_to_soy_id_seq OWNER TO plagedba;

--
-- Name: lms_act_to_soy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE lms_act_to_soy_id_seq OWNED BY lms_activity_to_soy_ex.link_id;


--
-- Name: lms_user_info; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE lms_user_info (
    email character varying(40) NOT NULL,
    first_name character varying(40),
    last_name character varying(40),
    lms_role character varying(40)
);


ALTER TABLE lms_user_info OWNER TO plagedba;

--
-- Name: nam; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE nam (
    nam_id integer NOT NULL,
    name character varying(40) NOT NULL,
    locale loc NOT NULL,
    ref_id integer
);


ALTER TABLE nam OWNER TO plagedba;

--
-- Name: nam_nam_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE nam_nam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nam_nam_id_seq OWNER TO plagedba;

--
-- Name: nam_nam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE nam_nam_id_seq OWNED BY nam.nam_id;


--
-- Name: plagesession; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE plagesession (
    ps_id integer NOT NULL,
    p_id integer NOT NULL,
    name character varying(40) NOT NULL,
    secret_key character varying(40),
    start_date date,
    end_date date,
    author integer NOT NULL,
    description text,
    universe character varying(40),
    seq_id integer,
    is_timed boolean DEFAULT true NOT NULL
);


ALTER TABLE plagesession OWNER TO plagedba;

--
-- Name: plagesession_ps_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE plagesession_ps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE plagesession_ps_id_seq OWNER TO plagedba;

--
-- Name: plagesession_ps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE plagesession_ps_id_seq OWNED BY plagesession.ps_id;


--
-- Name: profile; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE profile (
    p_id integer NOT NULL,
    job character varying(40) NOT NULL,
    level character varying(40),
    sector character varying(40) NOT NULL,
    description text,
    ref_id integer,
    locale loc NOT NULL
);


ALTER TABLE profile OWNER TO plagedba;

--
-- Name: profile_p_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE profile_p_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE profile_p_id_seq OWNER TO plagedba;

--
-- Name: profile_p_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE profile_p_id_seq OWNED BY profile.p_id;


--
-- Name: profilelevel; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE profilelevel (
    p_id integer NOT NULL,
    skill_code character varying(40) NOT NULL,
    nam_id integer NOT NULL,
    description character varying(40)
);


ALTER TABLE profilelevel OWNER TO plagedba;

--
-- Name: profilelevel_p_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE profilelevel_p_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE profilelevel_p_id_seq OWNER TO plagedba;

--
-- Name: profilelevel_p_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE profilelevel_p_id_seq OWNED BY profilelevel.p_id;


--
-- Name: sequencelist; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE sequencelist (
    seq_id integer NOT NULL,
    ex_id integer NOT NULL,
    rank integer NOT NULL,
    min_rating numeric(5,2) NOT NULL,
    p_id integer NOT NULL,
    description text
);


ALTER TABLE sequencelist OWNER TO plagedba;

--
-- Name: sequencelist_seq_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE sequencelist_seq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sequencelist_seq_id_seq OWNER TO plagedba;

--
-- Name: sequencelist_seq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE sequencelist_seq_id_seq OWNED BY sequencelist.seq_id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE session OWNER TO plagedba;

--
-- Name: skill; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE skill (
    skill_code character varying(40) NOT NULL,
    name character varying(100) NOT NULL,
    th_id integer NOT NULL,
    description text,
    locale loc NOT NULL,
    ref_code character varying(40)
);


ALTER TABLE skill OWNER TO plagedba;

--
-- Name: studentstatement; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE studentstatement (
    ps_id integer NOT NULL,
    user_id integer NOT NULL,
    ex_id integer NOT NULL,
    availability_date date,
    deadline_date date NOT NULL,
    is_sended boolean DEFAULT false NOT NULL,
    statement text,
    file bytea
);


ALTER TABLE studentstatement OWNER TO plagedba;

--
-- Name: theme; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE theme (
    th_id integer NOT NULL,
    name character varying(40) NOT NULL,
    locale loc NOT NULL,
    ref_id integer
);


ALTER TABLE theme OWNER TO plagedba;

--
-- Name: theme_th_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE theme_th_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE theme_th_id_seq OWNER TO plagedba;

--
-- Name: theme_th_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE theme_th_id_seq OWNED BY theme.th_id;


--
-- Name: userplage; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE userplage (
    user_id integer NOT NULL,
    lastname character varying(40) NOT NULL,
    firstname character varying(40) NOT NULL,
    tdgroup character varying(40),
    email character varying(40) NOT NULL,
    enabled boolean NOT NULL,
    role_id integer NOT NULL,
    avatar bytea,
    password character varying(128) NOT NULL,
    organization character varying(40),
    country character varying(40),
    locale loc NOT NULL,
    student_number character varying(40),
    nonce character varying(128),
    salt character varying(16) NOT NULL
);


ALTER TABLE userplage OWNER TO plagedba;

--
-- Name: userplage_user_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE userplage_user_id_seq
    AS integer
    START WITH 3
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userplage_user_id_seq OWNER TO plagedba;

--
-- Name: userplage_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE userplage_user_id_seq OWNED BY userplage.user_id;


--
-- Name: userrole; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE userrole (
    role_id integer NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE userrole OWNER TO plagedba;

--
-- Name: userrole_role_id_seq; Type: SEQUENCE; Schema: public; Owner: plagedba
--

CREATE SEQUENCE userrole_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userrole_role_id_seq OWNER TO plagedba;

--
-- Name: userrole_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: plagedba
--

ALTER SEQUENCE userrole_role_id_seq OWNED BY userrole.role_id;


--
-- Name: usersession; Type: TABLE; Schema: public; Owner: plagedba
--

CREATE TABLE usersession (
    user_id integer NOT NULL,
    ps_id integer NOT NULL
);


ALTER TABLE usersession OWNER TO plagedba;

--
-- Name: acquiredskill user_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY acquiredskill ALTER COLUMN user_id SET DEFAULT nextval('acquiredskill_user_id_seq'::regclass);


--
-- Name: exercise ex_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exercise ALTER COLUMN ex_id SET DEFAULT nextval('exercise_ex_id_seq'::regclass);


--
-- Name: exerciseproduction ep_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciseproduction ALTER COLUMN ep_id SET DEFAULT nextval('exerciseproduction_ep_id_seq'::regclass);


--
-- Name: lms_activity_to_soy_ex link_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY lms_activity_to_soy_ex ALTER COLUMN link_id SET DEFAULT nextval('lms_act_to_soy_id_seq'::regclass);


--
-- Name: nam nam_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY nam ALTER COLUMN nam_id SET DEFAULT nextval('nam_nam_id_seq'::regclass);


--
-- Name: plagesession ps_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY plagesession ALTER COLUMN ps_id SET DEFAULT nextval('plagesession_ps_id_seq'::regclass);


--
-- Name: profile p_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profile ALTER COLUMN p_id SET DEFAULT nextval('profile_p_id_seq'::regclass);


--
-- Name: profilelevel p_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profilelevel ALTER COLUMN p_id SET DEFAULT nextval('profilelevel_p_id_seq'::regclass);


--
-- Name: sequencelist seq_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY sequencelist ALTER COLUMN seq_id SET DEFAULT nextval('sequencelist_seq_id_seq'::regclass);


--
-- Name: theme th_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY theme ALTER COLUMN th_id SET DEFAULT nextval('theme_th_id_seq'::regclass);


--
-- Name: userplage user_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY userplage ALTER COLUMN user_id SET DEFAULT nextval('userplage_user_id_seq'::regclass);


--
-- Name: userrole role_id; Type: DEFAULT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY userrole ALTER COLUMN role_id SET DEFAULT nextval('userrole_role_id_seq'::regclass);


--
-- Name: acquiredskill acquiredskill_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY acquiredskill
    ADD CONSTRAINT acquiredskill_pkey PRIMARY KEY (user_id, skill_code);


--
-- Name: exercise exercise_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exercise
    ADD CONSTRAINT exercise_pkey PRIMARY KEY (ex_id);


--
-- Name: exerciselevel exerciselevel_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciselevel
    ADD CONSTRAINT exerciselevel_pkey PRIMARY KEY (skill_code, ex_id);


--
-- Name: exerciseproduction exerciseproduction_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciseproduction
    ADD CONSTRAINT exerciseproduction_pkey PRIMARY KEY (ep_id);


--
-- Name: lms_activity_to_soy_ex lms_activity_to_soy_ex_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY lms_activity_to_soy_ex
    ADD CONSTRAINT lms_activity_to_soy_ex_pkey PRIMARY KEY (link_id);


--
-- Name: lms_user_info lms_user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY lms_user_info
    ADD CONSTRAINT lms_user_info_pkey PRIMARY KEY (email);


--
-- Name: nam nam_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY nam
    ADD CONSTRAINT nam_pkey PRIMARY KEY (nam_id);


--
-- Name: plagesession plagesession_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY plagesession
    ADD CONSTRAINT plagesession_pkey PRIMARY KEY (ps_id);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (p_id);


--
-- Name: profilelevel profilelevel_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profilelevel
    ADD CONSTRAINT profilelevel_pkey PRIMARY KEY (p_id, skill_code);


--
-- Name: sequencelist sequencelist_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY sequencelist
    ADD CONSTRAINT sequencelist_pkey PRIMARY KEY (seq_id, ex_id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (skill_code);


--
-- Name: studentstatement studentstatement_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY studentstatement
    ADD CONSTRAINT studentstatement_pkey PRIMARY KEY (ps_id, user_id, ex_id);


--
-- Name: theme theme_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY theme
    ADD CONSTRAINT theme_pkey PRIMARY KEY (th_id);


--
-- Name: userplage uniqueemail_userplage; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY userplage
    ADD CONSTRAINT uniqueemail_userplage UNIQUE (email);


--
-- Name: exercise uniquename_exercise; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exercise
    ADD CONSTRAINT uniquename_exercise UNIQUE (name);


--
-- Name: plagesession uniquename_plagesession; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY plagesession
    ADD CONSTRAINT uniquename_plagesession UNIQUE (name);


--
-- Name: userplage userplage_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY userplage
    ADD CONSTRAINT userplage_pkey PRIMARY KEY (user_id);


--
-- Name: userrole userrole_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY userrole
    ADD CONSTRAINT userrole_pkey PRIMARY KEY (role_id);


--
-- Name: usersession usersession_pkey; Type: CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY usersession
    ADD CONSTRAINT usersession_pkey PRIMARY KEY (user_id, ps_id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: plagedba
--

CREATE INDEX "IDX_session_expire" ON session USING btree (expire);


--
-- Name: acquiredskill acquiredskill_skill_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY acquiredskill
    ADD CONSTRAINT acquiredskill_skill_code_fkey FOREIGN KEY (skill_code) REFERENCES skill(skill_code);


--
-- Name: acquiredskill acquiredskill_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY acquiredskill
    ADD CONSTRAINT acquiredskill_user_id_fkey FOREIGN KEY (user_id) REFERENCES userplage(user_id);


--
-- Name: exercise exercise_author_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exercise
    ADD CONSTRAINT exercise_author_fkey FOREIGN KEY (author) REFERENCES userplage(user_id);


--
-- Name: exercise exercise_fk; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exercise
    ADD CONSTRAINT exercise_fk FOREIGN KEY (ref_id) REFERENCES exercise(ex_id);


--
-- Name: exerciselevel exerciselevel_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciselevel
    ADD CONSTRAINT exerciselevel_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: exerciselevel exerciselevel_nam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciselevel
    ADD CONSTRAINT exerciselevel_nam_id_fkey FOREIGN KEY (nam_id) REFERENCES nam(nam_id);


--
-- Name: exerciselevel exerciselevel_skill_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciselevel
    ADD CONSTRAINT exerciselevel_skill_code_fkey FOREIGN KEY (skill_code) REFERENCES skill(skill_code);


--
-- Name: exerciseproduction exerciseproduction_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciseproduction
    ADD CONSTRAINT exerciseproduction_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: exerciseproduction exerciseproduction_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY exerciseproduction
    ADD CONSTRAINT exerciseproduction_user_id_fkey FOREIGN KEY (user_id) REFERENCES userplage(user_id);


--
-- Name: lms_activity_to_soy_ex lms_activity_to_soy_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY lms_activity_to_soy_ex
    ADD CONSTRAINT lms_activity_to_soy_ex_id_fkey FOREIGN KEY (soy_ex_id) REFERENCES exercise(ex_id);


--
-- Name: nam nam_fk; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY nam
    ADD CONSTRAINT nam_fk FOREIGN KEY (ref_id) REFERENCES nam(nam_id);


--
-- Name: plagesession plagesession_p_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY plagesession
    ADD CONSTRAINT plagesession_p_id_fkey FOREIGN KEY (p_id) REFERENCES profile(p_id);


--
-- Name: plagesession plageuser_fk; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY plagesession
    ADD CONSTRAINT plageuser_fk FOREIGN KEY (author) REFERENCES userplage(user_id);


--
-- Name: profile profile_fk; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_fk FOREIGN KEY (ref_id) REFERENCES profile(p_id);


--
-- Name: profilelevel profilelevel_nam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profilelevel
    ADD CONSTRAINT profilelevel_nam_id_fkey FOREIGN KEY (nam_id) REFERENCES nam(nam_id);


--
-- Name: profilelevel profilelevel_p_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profilelevel
    ADD CONSTRAINT profilelevel_p_id_fkey FOREIGN KEY (p_id) REFERENCES profile(p_id);


--
-- Name: profilelevel profilelevel_skill_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY profilelevel
    ADD CONSTRAINT profilelevel_skill_code_fkey FOREIGN KEY (skill_code) REFERENCES skill(skill_code);


--
-- Name: sequencelist sequencelist_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY sequencelist
    ADD CONSTRAINT sequencelist_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: sequencelist sequencelist_p_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY sequencelist
    ADD CONSTRAINT sequencelist_p_id_fkey FOREIGN KEY (p_id) REFERENCES profile(p_id);


--
-- Name: skill skill_fk; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY skill
    ADD CONSTRAINT skill_fk FOREIGN KEY (ref_code) REFERENCES skill(skill_code);


--
-- Name: skill skill_th_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY skill
    ADD CONSTRAINT skill_th_id_fkey FOREIGN KEY (th_id) REFERENCES theme(th_id);


--
-- Name: studentstatement studentstatement_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY studentstatement
    ADD CONSTRAINT studentstatement_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: studentstatement studentstatement_ps_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY studentstatement
    ADD CONSTRAINT studentstatement_ps_id_fkey FOREIGN KEY (ps_id) REFERENCES plagesession(ps_id);


--
-- Name: studentstatement studentstatement_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY studentstatement
    ADD CONSTRAINT studentstatement_user_id_fkey FOREIGN KEY (user_id) REFERENCES userplage(user_id);


--
-- Name: theme theme_fk; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY theme
    ADD CONSTRAINT theme_fk FOREIGN KEY (ref_id) REFERENCES theme(th_id);


--
-- Name: userplage userplage_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY userplage
    ADD CONSTRAINT userplage_role_id_fkey FOREIGN KEY (role_id) REFERENCES userrole(role_id);


--
-- Name: usersession usersession_ps_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY usersession
    ADD CONSTRAINT usersession_ps_id_fkey FOREIGN KEY (ps_id) REFERENCES plagesession(ps_id);


--
-- Name: usersession usersession_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: plagedba
--

ALTER TABLE ONLY usersession
    ADD CONSTRAINT usersession_user_id_fkey FOREIGN KEY (user_id) REFERENCES userplage(user_id);


--
-- PostgreSQL database dump complete
--

