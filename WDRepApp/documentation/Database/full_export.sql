--
-- PostgreSQL database dump
--

\restrict 7fzebkEmaqDPviiWdOK4PbxBuA9r1oQ7PASD6TDuqeRMTbvb7VkVAfPGVR2kHBt

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Debian 16.10-1.pgdg13+1)

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
-- Name: set_modified_on_insert(); Type: FUNCTION; Schema: public; Owner: wdrep
--

CREATE FUNCTION public.set_modified_on_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.modifiedby := NEW.createdby;
    NEW.modifieddate := NEW.createddate;
    NEW.modifiedip := NEW.createdip;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_modified_on_insert() OWNER TO wdrep;

--
-- Name: update_human_readable_id(); Type: FUNCTION; Schema: public; Owner: wdrep
--

CREATE FUNCTION public.update_human_readable_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    prefix TEXT;
    pk_col TEXT;
    pk_value TEXT;
    padded_pk TEXT;
BEGIN
    -- Get table prefix
    SELECT COALESCE(TablePrefix, 'UNK') INTO prefix
    FROM TablePrefixes
    WHERE UPPER(TableName) = UPPER(TG_TABLE_NAME);

    -- Dynamically find PK column for the current table
    SELECT a.attname INTO pk_col
    FROM pg_index i
    JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = ANY(i.indkey)
    WHERE i.indrelid = TG_RELID AND i.indisprimary
    LIMIT 1;

    -- Get PK value from NEW
    EXECUTE format('SELECT ($1).%I', pk_col) USING NEW INTO pk_value;
    padded_pk := LPAD(pk_value::TEXT, 8, '0');

    -- Always recalculate humanreadableid, ignore user input
    NEW.humanreadableid := prefix || '-' || padded_pk;
    RETURN NEW;
END;
$_$;


ALTER FUNCTION public.update_human_readable_id() OWNER TO wdrep;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adjudications; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.adjudications (
    adjudicationid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    firstadjudicatorid integer,
    firstdecisiondate timestamp without time zone,
    firstdecisionid integer,
    secondadjudicatorid integer,
    seconddecisiondate timestamp without time zone,
    seconddecisionid integer,
    thirdadjudicatorid integer,
    thirddecisiondate timestamp without time zone,
    thirddecisionid integer,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.adjudications OWNER TO wdrep;

--
-- Name: adjudications_adjudicationid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.adjudications ALTER COLUMN adjudicationid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.adjudications_adjudicationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: aliases; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.aliases (
    aliasid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    coreidentityid integer NOT NULL,
    alias character varying(2000) NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.aliases OWNER TO wdrep;

--
-- Name: aliases_aliasid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.aliases ALTER COLUMN aliasid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.aliases_aliasid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: assignments; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.assignments (
    assignmentid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    workerid integer NOT NULL,
    organizationid integer NOT NULL,
    contractid integer,
    assignmenttypeid integer NOT NULL,
    assignmentstatusid integer NOT NULL,
    startdate date NOT NULL,
    enddate date,
    hoursperweek numeric(5,2),
    hourlyrate numeric(10,2),
    description text,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.assignments OWNER TO wdrep;

--
-- Name: assignments_assignmentid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.assignments_assignmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assignments_assignmentid_seq OWNER TO wdrep;

--
-- Name: assignments_assignmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.assignments_assignmentid_seq OWNED BY public.assignments.assignmentid;


--
-- Name: assignmentstatuses; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.assignmentstatuses (
    assignmentstatusid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    assignmentstatusname character varying(50) NOT NULL,
    description text,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.assignmentstatuses OWNER TO wdrep;

--
-- Name: assignmentstatuses_assignmentstatusid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.assignmentstatuses ALTER COLUMN assignmentstatusid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.assignmentstatuses_assignmentstatusid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: assignmenttypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.assignmenttypes (
    assignmenttypeid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    assignmenttypename character varying(100) NOT NULL,
    description text,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.assignmenttypes OWNER TO wdrep;

--
-- Name: assignmenttypes_assignmenttypeid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.assignmenttypes ALTER COLUMN assignmenttypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.assignmenttypes_assignmenttypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: callsandorders; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.callsandorders (
    callsandordersid integer NOT NULL,
    humanreadableid character varying(20),
    contractid integer NOT NULL,
    callorordernumber character varying(50) NOT NULL,
    popstartdate timestamp without time zone NOT NULL,
    popenddate timestamp without time zone NOT NULL,
    cor integer NOT NULL,
    acor integer,
    co integer,
    cs integer,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.callsandorders OWNER TO wdrep;

--
-- Name: callsandorders_callsandordersid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.callsandorders ALTER COLUMN callsandordersid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.callsandorders_callsandordersid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contacttypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.contacttypes (
    contacttypeid integer NOT NULL,
    humanreadableid character varying(20),
    contacttypename character varying(20) NOT NULL,
    appliestoemail boolean DEFAULT false NOT NULL,
    appliestophone boolean DEFAULT false NOT NULL,
    appliestosocialmedia boolean DEFAULT false NOT NULL,
    appliestopostaladdress boolean DEFAULT false NOT NULL,
    appliestowebsite boolean DEFAULT false NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.contacttypes OWNER TO wdrep;

--
-- Name: contacttypes_contacttypeid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.contacttypes ALTER COLUMN contacttypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contacttypes_contacttypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.contracts (
    contractid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    contractnumber character varying(100) NOT NULL,
    contractname character varying(255) NOT NULL,
    contracttypeid integer NOT NULL,
    organizationid integer NOT NULL,
    vendorid integer,
    startdate date NOT NULL,
    enddate date,
    contractvalue numeric(15,2),
    description text,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.contracts OWNER TO wdrep;

--
-- Name: contracts_contractid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.contracts_contractid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contracts_contractid_seq OWNER TO wdrep;

--
-- Name: contracts_contractid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.contracts_contractid_seq OWNED BY public.contracts.contractid;


--
-- Name: contracttypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.contracttypes (
    contracttypeid integer NOT NULL,
    humanreadableid character varying(20),
    contracttypename character varying(100) NOT NULL,
    description text,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.contracttypes OWNER TO wdrep;

--
-- Name: contracttypes_contracttypeid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.contracttypes ALTER COLUMN contracttypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.contracttypes_contracttypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: coreidentity; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.coreidentity (
    coreidentityid integer NOT NULL,
    humanreadableid character varying(20),
    prefixid integer,
    firstname character varying(50) NOT NULL,
    middlename character varying(50),
    lastname character varying(50) NOT NULL,
    suffixid integer,
    ssn character(9) NOT NULL,
    dob timestamp without time zone NOT NULL,
    placeofbirthid integer NOT NULL,
    sexid integer NOT NULL,
    legacyid character varying(11),
    preferredname character varying(50),
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.coreidentity OWNER TO wdrep;

--
-- Name: coreidentity_coreidentityid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.coreidentity ALTER COLUMN coreidentityid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.coreidentity_coreidentityid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: coreidentityadjudications; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.coreidentityadjudications (
    coreidentityadjudicationid integer NOT NULL,
    adjudicationid integer NOT NULL,
    coreidentityid integer NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.coreidentityadjudications OWNER TO wdrep;

--
-- Name: coreidentityadjudications_coreidentityadjudicationid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.coreidentityadjudications ALTER COLUMN coreidentityadjudicationid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.coreidentityadjudications_coreidentityadjudicationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: coreidentityemails; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.coreidentityemails (
    coreidentityemailid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    coreidentityid integer NOT NULL,
    emailid integer NOT NULL,
    contacttypeid integer NOT NULL,
    contactsequence integer DEFAULT 1 NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.coreidentityemails OWNER TO wdrep;

--
-- Name: coreidentityemails_coreidentityemailid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.coreidentityemails_coreidentityemailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coreidentityemails_coreidentityemailid_seq OWNER TO wdrep;

--
-- Name: coreidentityemails_coreidentityemailid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.coreidentityemails_coreidentityemailid_seq OWNED BY public.coreidentityemails.coreidentityemailid;


--
-- Name: coreidentityinvestigationrequests; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.coreidentityinvestigationrequests (
    coreidentityinvestigationrequestid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    investigationrequestid integer NOT NULL,
    coreidentityid integer NOT NULL,
    assignmentdate timestamp without time zone NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.coreidentityinvestigationrequests OWNER TO wdrep;

--
-- Name: coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq OWNER TO wdrep;

--
-- Name: coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq OWNED BY public.coreidentityinvestigationrequests.coreidentityinvestigationrequestid;


--
-- Name: coreidentityphones; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.coreidentityphones (
    coreidentityphoneid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    coreidentityid integer NOT NULL,
    phoneid integer NOT NULL,
    contacttypeid integer NOT NULL,
    contactsequence integer DEFAULT 1 NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.coreidentityphones OWNER TO wdrep;

--
-- Name: coreidentityphones_coreidentityphoneid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.coreidentityphones_coreidentityphoneid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coreidentityphones_coreidentityphoneid_seq OWNER TO wdrep;

--
-- Name: coreidentityphones_coreidentityphoneid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.coreidentityphones_coreidentityphoneid_seq OWNED BY public.coreidentityphones.coreidentityphoneid;


--
-- Name: coreidentitypostaladdresses; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.coreidentitypostaladdresses (
    coreidentitypostaladdressid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    coreidentityid integer NOT NULL,
    postaladdressid integer NOT NULL,
    contacttypeid integer NOT NULL,
    contactsequence integer DEFAULT 1 NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.coreidentitypostaladdresses OWNER TO wdrep;

--
-- Name: coreidentitypostaladdresses_coreidentitypostaladdressid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq OWNER TO wdrep;

--
-- Name: coreidentitypostaladdresses_coreidentitypostaladdressid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq OWNED BY public.coreidentitypostaladdresses.coreidentitypostaladdressid;


--
-- Name: coreidentitysocialmedia; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.coreidentitysocialmedia (
    coreidentitysocialmediaid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    coreidentityid integer NOT NULL,
    socialmediaid integer NOT NULL,
    contacttypeid integer NOT NULL,
    contactsequence integer DEFAULT 1 NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.coreidentitysocialmedia OWNER TO wdrep;

--
-- Name: coreidentitysocialmedia_coreidentitysocialmediaid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.coreidentitysocialmedia_coreidentitysocialmediaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coreidentitysocialmedia_coreidentitysocialmediaid_seq OWNER TO wdrep;

--
-- Name: coreidentitysocialmedia_coreidentitysocialmediaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.coreidentitysocialmedia_coreidentitysocialmediaid_seq OWNED BY public.coreidentitysocialmedia.coreidentitysocialmediaid;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.countries (
    countryid integer NOT NULL,
    name character varying(100) NOT NULL,
    isocode character(3) NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.countries OWNER TO wdrep;

--
-- Name: countries_countryid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.countries ALTER COLUMN countryid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.countries_countryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: countrycodes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.countrycodes (
    countrycodeid integer NOT NULL,
    humanreadableid character varying(20),
    countrycode character varying(10) NOT NULL,
    countryid integer NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.countrycodes OWNER TO wdrep;

--
-- Name: countrycodes_countrycodeid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.countrycodes ALTER COLUMN countrycodeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.countrycodes_countrycodeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: emails; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.emails (
    emailid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    emailaddress character varying(320) NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.emails OWNER TO wdrep;

--
-- Name: emails_emailid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.emails_emailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emails_emailid_seq OWNER TO wdrep;

--
-- Name: emails_emailid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.emails_emailid_seq OWNED BY public.emails.emailid;


--
-- Name: emergencycontacts; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.emergencycontacts (
    emergencycontactid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    coreidentityid integer NOT NULL,
    pointofcontactid integer NOT NULL,
    relationshiptypeid integer NOT NULL,
    contactsequence integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.emergencycontacts OWNER TO wdrep;

--
-- Name: emergencycontacts_emergencycontactid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.emergencycontacts_emergencycontactid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.emergencycontacts_emergencycontactid_seq OWNER TO wdrep;

--
-- Name: emergencycontacts_emergencycontactid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.emergencycontacts_emergencycontactid_seq OWNED BY public.emergencycontacts.emergencycontactid;


--
-- Name: formtypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.formtypes (
    formtypesid integer NOT NULL,
    humanreadableid character varying(20),
    formtypename character varying(100) NOT NULL,
    description character varying(255),
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.formtypes OWNER TO wdrep;

--
-- Name: formtypes_formtypesid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.formtypes ALTER COLUMN formtypesid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.formtypes_formtypesid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: geography; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.geography (
    geographyid integer NOT NULL,
    humanreadableid character varying(20),
    geographyname character varying(50) NOT NULL,
    geographytypeid integer NOT NULL,
    parentid integer,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.geography OWNER TO wdrep;

--
-- Name: geography_geographyid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.geography ALTER COLUMN geographyid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.geography_geographyid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: geographytypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.geographytypes (
    geographytypeid integer NOT NULL,
    humanreadableid character varying(20),
    description text,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.geographytypes OWNER TO wdrep;

--
-- Name: geographytypes_geographytypeid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.geographytypes ALTER COLUMN geographytypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.geographytypes_geographytypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: investigationrequest; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.investigationrequest (
    investigationrequestid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    specialistassignedid integer,
    serviceproviderid integer,
    investigationtypeid integer,
    sentdate timestamp without time zone,
    completiondate timestamp without time zone,
    receiveddate timestamp without time zone,
    coreidentityid integer NOT NULL,
    assignmentdate timestamp without time zone NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.investigationrequest OWNER TO wdrep;

--
-- Name: investigationrequest_investigationrequestid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.investigationrequest_investigationrequestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investigationrequest_investigationrequestid_seq OWNER TO wdrep;

--
-- Name: investigationrequest_investigationrequestid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.investigationrequest_investigationrequestid_seq OWNED BY public.investigationrequest.investigationrequestid;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.organizations (
    organizationid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    organizationname character varying(255) NOT NULL,
    organizationtypeid integer NOT NULL,
    address1 character varying(255),
    address2 character varying(255),
    city character varying(100),
    state character varying(50),
    zipcode character varying(20),
    phone character varying(20),
    email character varying(255),
    website character varying(255),
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.organizations OWNER TO wdrep;

--
-- Name: organizations_organizationid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.organizations_organizationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organizations_organizationid_seq OWNER TO wdrep;

--
-- Name: organizations_organizationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.organizations_organizationid_seq OWNED BY public.organizations.organizationid;


--
-- Name: organizationshistory; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.organizationshistory (
    organizationshistoryid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    organizationid integer NOT NULL,
    organizationname character varying(255) NOT NULL,
    organizationtypeid integer NOT NULL,
    address1 character varying(255),
    address2 character varying(255),
    city character varying(100),
    state character varying(50),
    zipcode character varying(20),
    phone character varying(20),
    email character varying(255),
    website character varying(255),
    operation character varying(10) NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.organizationshistory OWNER TO wdrep;

--
-- Name: organizationshistory_organizationshistoryid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.organizationshistory_organizationshistoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organizationshistory_organizationshistoryid_seq OWNER TO wdrep;

--
-- Name: organizationshistory_organizationshistoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.organizationshistory_organizationshistoryid_seq OWNED BY public.organizationshistory.organizationshistoryid;


--
-- Name: organizationtypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.organizationtypes (
    organizationtypeid integer NOT NULL,
    humanreadableid character varying(20),
    description text,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.organizationtypes OWNER TO wdrep;

--
-- Name: organizationtypes_organizationtypeid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.organizationtypes ALTER COLUMN organizationtypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.organizationtypes_organizationtypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: organizationwebsites; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.organizationwebsites (
    organizationwebsiteid integer NOT NULL,
    organizationid integer NOT NULL,
    websiteid integer NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.organizationwebsites OWNER TO wdrep;

--
-- Name: organizationwebsites_organizationwebsiteid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.organizationwebsites ALTER COLUMN organizationwebsiteid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.organizationwebsites_organizationwebsiteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: packageformevents; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.packageformevents (
    packageformeventsid integer NOT NULL,
    humanreadableid character varying(20),
    packageid integer NOT NULL,
    formtypeid integer NOT NULL,
    eventtype character varying(20) NOT NULL,
    eventdate timestamp without time zone NOT NULL,
    comments character varying(255),
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.packageformevents OWNER TO wdrep;

--
-- Name: packageformevents_packageformeventsid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.packageformevents ALTER COLUMN packageformeventsid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.packageformevents_packageformeventsid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: packages; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.packages (
    packagesid integer NOT NULL,
    humanreadableid character varying(20),
    specialistid integer NOT NULL,
    packagetypeid integer NOT NULL,
    packagecomments text,
    sf86required boolean NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.packages OWNER TO wdrep;

--
-- Name: packages_packagesid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.packages ALTER COLUMN packagesid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.packages_packagesid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: packagetypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.packagetypes (
    packagetypesid integer NOT NULL,
    humanreadableid character varying(20),
    packagetypename character varying(100) NOT NULL,
    description character varying(255),
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.packagetypes OWNER TO wdrep;

--
-- Name: packagetypes_packagetypesid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.packagetypes ALTER COLUMN packagetypesid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.packagetypes_packagetypesid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pointsofcontact; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.pointsofcontact (
    pointofcontactid integer NOT NULL,
    humanreadableid character varying(20),
    prefixid integer,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    suffixid integer,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.pointsofcontact OWNER TO wdrep;

--
-- Name: pointsofcontact_pointofcontactid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.pointsofcontact ALTER COLUMN pointofcontactid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pointsofcontact_pointofcontactid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: pointsofcontactemails; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.pointsofcontactemails (
    pointsofcontactemailid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    pointofcontactid integer NOT NULL,
    emailid integer NOT NULL,
    contacttypeid integer NOT NULL,
    contactsequence integer DEFAULT 1 NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.pointsofcontactemails OWNER TO wdrep;

--
-- Name: pointsofcontactemails_pointsofcontactemailid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.pointsofcontactemails_pointsofcontactemailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pointsofcontactemails_pointsofcontactemailid_seq OWNER TO wdrep;

--
-- Name: pointsofcontactemails_pointsofcontactemailid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.pointsofcontactemails_pointsofcontactemailid_seq OWNED BY public.pointsofcontactemails.pointsofcontactemailid;


--
-- Name: pointsofcontactphones; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.pointsofcontactphones (
    pointsofcontactphoneid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    pointofcontactid integer NOT NULL,
    phoneid integer NOT NULL,
    contacttypeid integer NOT NULL,
    contactsequence integer DEFAULT 1 NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.pointsofcontactphones OWNER TO wdrep;

--
-- Name: pointsofcontactphones_pointsofcontactphoneid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.pointsofcontactphones_pointsofcontactphoneid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pointsofcontactphones_pointsofcontactphoneid_seq OWNER TO wdrep;

--
-- Name: pointsofcontactphones_pointsofcontactphoneid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.pointsofcontactphones_pointsofcontactphoneid_seq OWNED BY public.pointsofcontactphones.pointsofcontactphoneid;


--
-- Name: postaladdresses; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.postaladdresses (
    postaladdressid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    address1 character varying(255) NOT NULL,
    address2 character varying(255),
    city character varying(100) NOT NULL,
    state character varying(50) NOT NULL,
    zipcode character varying(20) NOT NULL,
    countryid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.postaladdresses OWNER TO wdrep;

--
-- Name: postaladdresses_postaladdressid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.postaladdresses_postaladdressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.postaladdresses_postaladdressid_seq OWNER TO wdrep;

--
-- Name: postaladdresses_postaladdressid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.postaladdresses_postaladdressid_seq OWNED BY public.postaladdresses.postaladdressid;


--
-- Name: prefixsuffix; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.prefixsuffix (
    prefixsuffixid integer NOT NULL,
    humanreadableid character varying(20),
    description character varying(255) NOT NULL,
    category character(6) NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.prefixsuffix OWNER TO wdrep;

--
-- Name: prefixsuffix_prefixsuffixid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.prefixsuffix ALTER COLUMN prefixsuffixid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.prefixsuffix_prefixsuffixid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: recordstatuses; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.recordstatuses (
    recordstatusid integer NOT NULL,
    humanreadableid character varying(20),
    statusabbreviation character varying(50) NOT NULL,
    statusname character varying(255),
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.recordstatuses OWNER TO wdrep;

--
-- Name: recordstatuses_recordstatusid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.recordstatuses_recordstatusid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recordstatuses_recordstatusid_seq OWNER TO wdrep;

--
-- Name: recordstatuses_recordstatusid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.recordstatuses_recordstatusid_seq OWNED BY public.recordstatuses.recordstatusid;


--
-- Name: relationshiptypes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.relationshiptypes (
    relationshiptypeid integer NOT NULL,
    description character varying(100) NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.relationshiptypes OWNER TO wdrep;

--
-- Name: relationshiptypes_relationshiptypeid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.relationshiptypes ALTER COLUMN relationshiptypeid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.relationshiptypes_relationshiptypeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: serviceproviders; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.serviceproviders (
    serviceproviderid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    providername character varying(100) NOT NULL,
    description character varying(255),
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.serviceproviders OWNER TO wdrep;

--
-- Name: serviceproviders_serviceproviderid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.serviceproviders_serviceproviderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.serviceproviders_serviceproviderid_seq OWNER TO wdrep;

--
-- Name: serviceproviders_serviceproviderid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.serviceproviders_serviceproviderid_seq OWNED BY public.serviceproviders.serviceproviderid;


--
-- Name: sexes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.sexes (
    sexid integer NOT NULL,
    humanreadableid character varying(20),
    description text,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.sexes OWNER TO wdrep;

--
-- Name: sexes_sexid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.sexes ALTER COLUMN sexid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sexes_sexid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: socialmedia; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.socialmedia (
    socialmediaid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    platform character varying(50) NOT NULL,
    handle character varying(100) NOT NULL,
    url character varying(255),
    isprimary boolean DEFAULT false NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdipaddress character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedipaddress character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedipaddress character varying(45)
);


ALTER TABLE public.socialmedia OWNER TO wdrep;

--
-- Name: socialmedia_socialmediaid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.socialmedia_socialmediaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.socialmedia_socialmediaid_seq OWNER TO wdrep;

--
-- Name: socialmedia_socialmediaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.socialmedia_socialmediaid_seq OWNED BY public.socialmedia.socialmediaid;


--
-- Name: tableprefixes; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.tableprefixes (
    prefixid integer NOT NULL,
    humanreadableid character varying(20),
    tablename character varying(50) NOT NULL,
    tableprefix character varying(255),
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.tableprefixes OWNER TO wdrep;

--
-- Name: tableprefixes_prefixid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

CREATE SEQUENCE public.tableprefixes_prefixid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tableprefixes_prefixid_seq OWNER TO wdrep;

--
-- Name: tableprefixes_prefixid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wdrep
--

ALTER SEQUENCE public.tableprefixes_prefixid_seq OWNED BY public.tableprefixes.prefixid;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.vendors (
    vendorid integer NOT NULL,
    humanreadableid character varying(20),
    vendorname character varying(255) NOT NULL,
    contactpersonname character varying(255),
    address1 character varying(255),
    address2 character varying(255),
    city character varying(100),
    state character varying(50),
    zipcode character varying(20),
    phone character varying(20),
    email character varying(255),
    website character varying(255),
    taxid character varying(50),
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.vendors OWNER TO wdrep;

--
-- Name: vendors_vendorid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.vendors ALTER COLUMN vendorid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vendors_vendorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vendorwebsites; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.vendorwebsites (
    vendorwebsiteid integer NOT NULL,
    vendorid integer NOT NULL,
    websiteid integer NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.vendorwebsites OWNER TO wdrep;

--
-- Name: vendorwebsites_vendorwebsiteid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.vendorwebsites ALTER COLUMN vendorwebsiteid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vendorwebsites_vendorwebsiteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: websites; Type: TABLE; Schema: public; Owner: wdrep
--

CREATE TABLE public.websites (
    websiteid integer NOT NULL,
    humanreadableid character varying(20),
    websiteurl character varying(255) NOT NULL,
    recordstatusid integer NOT NULL,
    createdby integer NOT NULL,
    createddate timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


ALTER TABLE public.websites OWNER TO wdrep;

--
-- Name: websites_websiteid_seq; Type: SEQUENCE; Schema: public; Owner: wdrep
--

ALTER TABLE public.websites ALTER COLUMN websiteid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.websites_websiteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: assignments assignmentid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments ALTER COLUMN assignmentid SET DEFAULT nextval('public.assignments_assignmentid_seq'::regclass);


--
-- Name: contracts contractid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracts ALTER COLUMN contractid SET DEFAULT nextval('public.contracts_contractid_seq'::regclass);


--
-- Name: coreidentityemails coreidentityemailid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityemails ALTER COLUMN coreidentityemailid SET DEFAULT nextval('public.coreidentityemails_coreidentityemailid_seq'::regclass);


--
-- Name: coreidentityinvestigationrequests coreidentityinvestigationrequestid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityinvestigationrequests ALTER COLUMN coreidentityinvestigationrequestid SET DEFAULT nextval('public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq'::regclass);


--
-- Name: coreidentityphones coreidentityphoneid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityphones ALTER COLUMN coreidentityphoneid SET DEFAULT nextval('public.coreidentityphones_coreidentityphoneid_seq'::regclass);


--
-- Name: coreidentitypostaladdresses coreidentitypostaladdressid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitypostaladdresses ALTER COLUMN coreidentitypostaladdressid SET DEFAULT nextval('public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq'::regclass);


--
-- Name: coreidentitysocialmedia coreidentitysocialmediaid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitysocialmedia ALTER COLUMN coreidentitysocialmediaid SET DEFAULT nextval('public.coreidentitysocialmedia_coreidentitysocialmediaid_seq'::regclass);


--
-- Name: emails emailid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emails ALTER COLUMN emailid SET DEFAULT nextval('public.emails_emailid_seq'::regclass);


--
-- Name: emergencycontacts emergencycontactid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emergencycontacts ALTER COLUMN emergencycontactid SET DEFAULT nextval('public.emergencycontacts_emergencycontactid_seq'::regclass);


--
-- Name: investigationrequest investigationrequestid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.investigationrequest ALTER COLUMN investigationrequestid SET DEFAULT nextval('public.investigationrequest_investigationrequestid_seq'::regclass);


--
-- Name: organizations organizationid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizations ALTER COLUMN organizationid SET DEFAULT nextval('public.organizations_organizationid_seq'::regclass);


--
-- Name: organizationshistory organizationshistoryid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory ALTER COLUMN organizationshistoryid SET DEFAULT nextval('public.organizationshistory_organizationshistoryid_seq'::regclass);


--
-- Name: pointsofcontactemails pointsofcontactemailid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactemails ALTER COLUMN pointsofcontactemailid SET DEFAULT nextval('public.pointsofcontactemails_pointsofcontactemailid_seq'::regclass);


--
-- Name: pointsofcontactphones pointsofcontactphoneid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactphones ALTER COLUMN pointsofcontactphoneid SET DEFAULT nextval('public.pointsofcontactphones_pointsofcontactphoneid_seq'::regclass);


--
-- Name: postaladdresses postaladdressid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.postaladdresses ALTER COLUMN postaladdressid SET DEFAULT nextval('public.postaladdresses_postaladdressid_seq'::regclass);


--
-- Name: recordstatuses recordstatusid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.recordstatuses ALTER COLUMN recordstatusid SET DEFAULT nextval('public.recordstatuses_recordstatusid_seq'::regclass);


--
-- Name: serviceproviders serviceproviderid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.serviceproviders ALTER COLUMN serviceproviderid SET DEFAULT nextval('public.serviceproviders_serviceproviderid_seq'::regclass);


--
-- Name: socialmedia socialmediaid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.socialmedia ALTER COLUMN socialmediaid SET DEFAULT nextval('public.socialmedia_socialmediaid_seq'::regclass);


--
-- Name: tableprefixes prefixid; Type: DEFAULT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.tableprefixes ALTER COLUMN prefixid SET DEFAULT nextval('public.tableprefixes_prefixid_seq'::regclass);


--
-- Data for Name: adjudications; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.adjudications (adjudicationid, humanreadableid, recordstatusid, firstadjudicatorid, firstdecisiondate, firstdecisionid, secondadjudicatorid, seconddecisiondate, seconddecisionid, thirdadjudicatorid, thirddecisiondate, thirddecisionid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: aliases; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.aliases (aliasid, humanreadableid, recordstatusid, coreidentityid, alias, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: assignments; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.assignments (assignmentid, humanreadableid, recordstatusid, workerid, organizationid, contractid, assignmenttypeid, assignmentstatusid, startdate, enddate, hoursperweek, hourlyrate, description, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: assignmentstatuses; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.assignmentstatuses (assignmentstatusid, humanreadableid, recordstatusid, assignmentstatusname, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: assignmenttypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.assignmenttypes (assignmenttypeid, humanreadableid, recordstatusid, assignmenttypename, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: callsandorders; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.callsandorders (callsandordersid, humanreadableid, contractid, callorordernumber, popstartdate, popenddate, cor, acor, co, cs, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: contacttypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.contacttypes (contacttypeid, humanreadableid, contacttypename, appliestoemail, appliestophone, appliestosocialmedia, appliestopostaladdress, appliestowebsite, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
5	CT-00000005	Home	t	t	t	t	t	1	1	2025-08-31 22:32:55.64758	::0	1	2025-08-31 22:32:55.64758	::0	\N	\N	\N
6	CT-00000006	Work	t	t	t	t	t	1	1	2025-08-31 22:32:55.64758	::0	1	2025-08-31 22:32:55.64758	::0	\N	\N	\N
7	CT-00000007	School	t	t	f	t	f	1	1	2025-08-31 22:32:55.64758	::0	1	2025-08-31 22:32:55.64758	::0	\N	\N	\N
8	CT-00000008	Mobile	f	t	f	f	f	1	1	2025-08-31 22:32:55.64758	::0	1	2025-08-31 22:32:55.64758	::0	\N	\N	\N
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.contracts (contractid, humanreadableid, recordstatusid, contractnumber, contractname, contracttypeid, organizationid, vendorid, startdate, enddate, contractvalue, description, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: contracttypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.contracttypes (contracttypeid, humanreadableid, contracttypename, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentity; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.coreidentity (coreidentityid, humanreadableid, prefixid, firstname, middlename, lastname, suffixid, ssn, dob, placeofbirthid, sexid, legacyid, preferredname, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	CI-00000001	\N	System	\N	User	\N	000112222	2025-08-30 00:00:00	1	3	\N	\N	1	0	2025-08-31 21:06:01.143926	::0	0	2025-08-31 21:06:01.143926	::0	\N	\N	\N
\.


--
-- Data for Name: coreidentityadjudications; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.coreidentityadjudications (coreidentityadjudicationid, adjudicationid, coreidentityid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentityemails; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.coreidentityemails (coreidentityemailid, humanreadableid, recordstatusid, coreidentityid, emailid, contacttypeid, contactsequence, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: coreidentityinvestigationrequests; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.coreidentityinvestigationrequests (coreidentityinvestigationrequestid, humanreadableid, recordstatusid, investigationrequestid, coreidentityid, assignmentdate, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentityphones; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.coreidentityphones (coreidentityphoneid, humanreadableid, recordstatusid, coreidentityid, phoneid, contacttypeid, contactsequence, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: coreidentitypostaladdresses; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.coreidentitypostaladdresses (coreidentitypostaladdressid, humanreadableid, recordstatusid, coreidentityid, postaladdressid, contacttypeid, contactsequence, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: coreidentitysocialmedia; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.coreidentitysocialmedia (coreidentitysocialmediaid, humanreadableid, recordstatusid, coreidentityid, socialmediaid, contacttypeid, contactsequence, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.countries (countryid, name, isocode, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: countrycodes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.countrycodes (countrycodeid, humanreadableid, countrycode, countryid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: emails; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.emails (emailid, humanreadableid, recordstatusid, emailaddress, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: emergencycontacts; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.emergencycontacts (emergencycontactid, humanreadableid, recordstatusid, coreidentityid, pointofcontactid, relationshiptypeid, contactsequence, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: formtypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.formtypes (formtypesid, humanreadableid, formtypename, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: geography; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.geography (geographyid, humanreadableid, geographyname, geographytypeid, parentid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	GEO-00000001	United States	1	\N	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
2	GEO-00000002	Canada	1	\N	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
11	GEO-00000011	Quebec	2	2	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
10	GEO-00000010	Ontario	2	2	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
12	GEO-00000012	Saskatchewan	2	2	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
13	GEO-00000013	British Columbia	2	2	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
3	GEO-00000003	New York	2	1	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
4	GEO-00000004	Florida	2	1	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
5	GEO-00000005	California	2	1	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
6	GEO-00000006	Arizona	2	1	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
7	GEO-00000007	Wisconsin	2	1	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
8	GEO-00000008	Kansas	2	1	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
9	GEO-00000009	Kentucky	2	1	1	0	2025-09-01 00:25:29.430025	::0	0	2025-09-01 00:25:29.430025	::0	\N	\N	\N
\.


--
-- Data for Name: geographytypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.geographytypes (geographytypeid, humanreadableid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	GET-00000001	Country	1	0	2025-08-31 21:06:01.145521	::0	0	2025-08-31 21:06:01.145521	::0	\N	\N	\N
2	GET-00000002	State	1	0	2025-08-31 21:06:01.145521	::0	0	2025-08-31 21:06:01.145521	::0	\N	\N	\N
3	GET-00000003	City	1	0	2025-08-31 21:06:01.145521	::0	0	2025-08-31 21:06:01.145521	::0	\N	\N	\N
\.


--
-- Data for Name: investigationrequest; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.investigationrequest (investigationrequestid, humanreadableid, recordstatusid, specialistassignedid, serviceproviderid, investigationtypeid, sentdate, completiondate, receiveddate, coreidentityid, assignmentdate, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.organizations (organizationid, humanreadableid, recordstatusid, organizationname, organizationtypeid, address1, address2, city, state, zipcode, phone, email, website, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: organizationshistory; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.organizationshistory (organizationshistoryid, humanreadableid, recordstatusid, organizationid, organizationname, organizationtypeid, address1, address2, city, state, zipcode, phone, email, website, operation, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: organizationtypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.organizationtypes (organizationtypeid, humanreadableid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: organizationwebsites; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.organizationwebsites (organizationwebsiteid, organizationid, websiteid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: packageformevents; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.packageformevents (packageformeventsid, humanreadableid, packageid, formtypeid, eventtype, eventdate, comments, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.packages (packagesid, humanreadableid, specialistid, packagetypeid, packagecomments, sf86required, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: packagetypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.packagetypes (packagetypesid, humanreadableid, packagetypename, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: pointsofcontact; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.pointsofcontact (pointofcontactid, humanreadableid, prefixid, firstname, lastname, suffixid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: pointsofcontactemails; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.pointsofcontactemails (pointsofcontactemailid, humanreadableid, recordstatusid, pointofcontactid, emailid, contacttypeid, contactsequence, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: pointsofcontactphones; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.pointsofcontactphones (pointsofcontactphoneid, humanreadableid, recordstatusid, pointofcontactid, phoneid, contacttypeid, contactsequence, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: postaladdresses; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.postaladdresses (postaladdressid, humanreadableid, recordstatusid, address1, address2, city, state, zipcode, countryid, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: prefixsuffix; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.prefixsuffix (prefixsuffixid, humanreadableid, description, category, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	PS-00000001	Mr.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
2	PS-00000002	Ms.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
3	PS-00000003	Mrs.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
4	PS-00000004	Sir	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
5	PS-00000005	Lady	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
6	PS-00000006	Miss	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
7	PS-00000007	Dr.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
8	PS-00000008	Gen.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
9	PS-00000009	Adm.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
10	PS-00000010	Col.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
11	PS-00000011	Lt. Col.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
12	PS-00000012	Maj.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
13	PS-00000013	Cpt.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
14	PS-00000014	Lt.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
15	PS-00000015	Ens.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
16	PS-00000016	Sgt.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
17	PS-00000017	Cpl.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
18	PS-00000018	Pvt.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
19	PS-00000019	Hon.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
20	PS-00000020	Sen.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
21	PS-00000021	Rep.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
22	PS-00000022	Mayor	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
23	PS-00000023	Gov.	Prefix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
24	PS-00000024	Sr.	Suffix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
25	PS-00000025	Jr.	Suffix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
26	PS-00000026	III	Suffix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
27	PS-00000027	IV	Suffix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
28	PS-00000028	V	Suffix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
29	PS-00000029	MD	Suffix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
30	PS-00000030	Esq.	Suffix	1	0	2025-08-31 21:06:01.140359	::0	0	2025-08-31 21:06:01.140359	::0	\N	\N	\N
\.


--
-- Data for Name: recordstatuses; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.recordstatuses (recordstatusid, humanreadableid, statusabbreviation, statusname, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	REC-00000001	A	Active	0	2025-08-31 21:06:01.139191	::0	0	2025-08-31 21:06:01.139191	::0	\N	\N	\N
2	REC-00000002	I	Inactive	0	2025-08-31 21:06:01.139191	::0	0	2025-08-31 21:06:01.139191	::0	\N	\N	\N
3	REC-00000003	D	Deleted	0	2025-08-31 21:06:01.139191	::0	0	2025-08-31 21:06:01.139191	::0	\N	\N	\N
4	REC-00000004	R	Archived	0	2025-08-31 21:06:01.139191	::0	0	2025-08-31 21:06:01.139191	::0	\N	\N	\N
\.


--
-- Data for Name: relationshiptypes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.relationshiptypes (relationshiptypeid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: serviceproviders; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.serviceproviders (serviceproviderid, humanreadableid, recordstatusid, providername, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: sexes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.sexes (sexid, humanreadableid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	SX-00000001	Female	1	0	2025-08-31 21:06:01.142539	::0	0	2025-08-31 21:06:01.142539	::0	\N	\N	\N
2	SX-00000002	Male	1	0	2025-08-31 21:06:01.142539	::0	0	2025-08-31 21:06:01.142539	::0	\N	\N	\N
3	SX-00000003	Unspecified	1	0	2025-08-31 21:06:01.142539	::0	0	2025-08-31 21:06:01.142539	::0	\N	\N	\N
\.


--
-- Data for Name: socialmedia; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.socialmedia (socialmediaid, humanreadableid, recordstatusid, platform, handle, url, isprimary, createdby, createddate, createdipaddress, modifiedby, modifieddate, modifiedipaddress, deletedby, deleteddate, deletedipaddress) FROM stdin;
\.


--
-- Data for Name: tableprefixes; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.tableprefixes (prefixid, humanreadableid, tablename, tableprefix, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	TP-00000001	tableprefixes	TP	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
2	TP-00000002	recordstatuses	REC	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
3	TP-00000003	sexes	SX	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
4	TP-00000004	prefixsuffix	PS	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
5	TP-00000005	vendors	VEN	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
6	TP-00000006	phones	PHN	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
7	TP-00000007	coreidentity	CI	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
8	TP-00000008	adjudications	ADJ	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
9	TP-00000009	aliases	AL	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
10	TP-00000010	assignments	ASN	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
11	TP-00000011	assignmenttypes	AST	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
12	TP-00000012	contacts	CON	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
13	TP-00000013	contacttypes	CT	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
14	TP-00000014	contracts	CTR	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
15	TP-00000015	contracttypes	CTT	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
16	TP-00000016	geography	GEO	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
17	TP-00000017	geographytypes	GET	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
18	TP-00000018	pointsofcontact	POC	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
19	TP-00000019	emailaddresses	EML	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
20	TP-00000020	postaladdresses	PAD	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
21	TP-00000021	organizations	ORG	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
22	TP-00000022	organizationtypes	ORT	0	2025-08-31 21:06:01.082803	::0	0	2025-08-31 21:06:01.082803	::0	\N	\N	\N
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.vendors (vendorid, humanreadableid, vendorname, contactpersonname, address1, address2, city, state, zipcode, phone, email, website, taxid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: vendorwebsites; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.vendorwebsites (vendorwebsiteid, vendorid, websiteid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: websites; Type: TABLE DATA; Schema: public; Owner: wdrep
--

COPY public.websites (websiteid, humanreadableid, websiteurl, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Name: adjudications_adjudicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.adjudications_adjudicationid_seq', 1, false);


--
-- Name: aliases_aliasid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.aliases_aliasid_seq', 1, false);


--
-- Name: assignments_assignmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.assignments_assignmentid_seq', 1, false);


--
-- Name: assignmentstatuses_assignmentstatusid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.assignmentstatuses_assignmentstatusid_seq', 1, false);


--
-- Name: assignmenttypes_assignmenttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.assignmenttypes_assignmenttypeid_seq', 1, false);


--
-- Name: callsandorders_callsandordersid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.callsandorders_callsandordersid_seq', 1, false);


--
-- Name: contacttypes_contacttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.contacttypes_contacttypeid_seq', 8, true);


--
-- Name: contracts_contractid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.contracts_contractid_seq', 1, false);


--
-- Name: contracttypes_contracttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.contracttypes_contracttypeid_seq', 1, false);


--
-- Name: coreidentity_coreidentityid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.coreidentity_coreidentityid_seq', 1, true);


--
-- Name: coreidentityadjudications_coreidentityadjudicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.coreidentityadjudications_coreidentityadjudicationid_seq', 1, false);


--
-- Name: coreidentityemails_coreidentityemailid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.coreidentityemails_coreidentityemailid_seq', 1, false);


--
-- Name: coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq', 1, false);


--
-- Name: coreidentityphones_coreidentityphoneid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.coreidentityphones_coreidentityphoneid_seq', 1, false);


--
-- Name: coreidentitypostaladdresses_coreidentitypostaladdressid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq', 1, false);


--
-- Name: coreidentitysocialmedia_coreidentitysocialmediaid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.coreidentitysocialmedia_coreidentitysocialmediaid_seq', 1, false);


--
-- Name: countries_countryid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.countries_countryid_seq', 1, false);


--
-- Name: countrycodes_countrycodeid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.countrycodes_countrycodeid_seq', 1, false);


--
-- Name: emails_emailid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.emails_emailid_seq', 1, false);


--
-- Name: emergencycontacts_emergencycontactid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.emergencycontacts_emergencycontactid_seq', 1, false);


--
-- Name: formtypes_formtypesid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.formtypes_formtypesid_seq', 1, false);


--
-- Name: geography_geographyid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.geography_geographyid_seq', 13, true);


--
-- Name: geographytypes_geographytypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.geographytypes_geographytypeid_seq', 3, true);


--
-- Name: investigationrequest_investigationrequestid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.investigationrequest_investigationrequestid_seq', 1, false);


--
-- Name: organizations_organizationid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.organizations_organizationid_seq', 1, false);


--
-- Name: organizationshistory_organizationshistoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.organizationshistory_organizationshistoryid_seq', 1, false);


--
-- Name: organizationtypes_organizationtypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.organizationtypes_organizationtypeid_seq', 1, false);


--
-- Name: organizationwebsites_organizationwebsiteid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.organizationwebsites_organizationwebsiteid_seq', 1, false);


--
-- Name: packageformevents_packageformeventsid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.packageformevents_packageformeventsid_seq', 1, false);


--
-- Name: packages_packagesid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.packages_packagesid_seq', 1, false);


--
-- Name: packagetypes_packagetypesid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.packagetypes_packagetypesid_seq', 1, false);


--
-- Name: pointsofcontact_pointofcontactid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.pointsofcontact_pointofcontactid_seq', 1, false);


--
-- Name: pointsofcontactemails_pointsofcontactemailid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.pointsofcontactemails_pointsofcontactemailid_seq', 1, false);


--
-- Name: pointsofcontactphones_pointsofcontactphoneid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.pointsofcontactphones_pointsofcontactphoneid_seq', 1, false);


--
-- Name: postaladdresses_postaladdressid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.postaladdresses_postaladdressid_seq', 1, false);


--
-- Name: prefixsuffix_prefixsuffixid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.prefixsuffix_prefixsuffixid_seq', 30, true);


--
-- Name: recordstatuses_recordstatusid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.recordstatuses_recordstatusid_seq', 1, false);


--
-- Name: relationshiptypes_relationshiptypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.relationshiptypes_relationshiptypeid_seq', 1, false);


--
-- Name: serviceproviders_serviceproviderid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.serviceproviders_serviceproviderid_seq', 1, false);


--
-- Name: sexes_sexid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.sexes_sexid_seq', 1, false);


--
-- Name: socialmedia_socialmediaid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.socialmedia_socialmediaid_seq', 1, false);


--
-- Name: tableprefixes_prefixid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.tableprefixes_prefixid_seq', 22, true);


--
-- Name: vendors_vendorid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.vendors_vendorid_seq', 1, false);


--
-- Name: vendorwebsites_vendorwebsiteid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.vendorwebsites_vendorwebsiteid_seq', 1, false);


--
-- Name: websites_websiteid_seq; Type: SEQUENCE SET; Schema: public; Owner: wdrep
--

SELECT pg_catalog.setval('public.websites_websiteid_seq', 1, false);


--
-- Name: adjudications adjudications_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.adjudications
    ADD CONSTRAINT adjudications_pkey PRIMARY KEY (adjudicationid);


--
-- Name: aliases aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.aliases
    ADD CONSTRAINT aliases_pkey PRIMARY KEY (aliasid);


--
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (assignmentid);


--
-- Name: assignmentstatuses assignmentstatuses_assignmentstatusname_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignmentstatuses
    ADD CONSTRAINT assignmentstatuses_assignmentstatusname_key UNIQUE (assignmentstatusname);


--
-- Name: assignmentstatuses assignmentstatuses_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignmentstatuses
    ADD CONSTRAINT assignmentstatuses_pkey PRIMARY KEY (assignmentstatusid);


--
-- Name: assignmenttypes assignmenttypes_assignmenttypename_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignmenttypes
    ADD CONSTRAINT assignmenttypes_assignmenttypename_key UNIQUE (assignmenttypename);


--
-- Name: assignmenttypes assignmenttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignmenttypes
    ADD CONSTRAINT assignmenttypes_pkey PRIMARY KEY (assignmenttypeid);


--
-- Name: callsandorders callsandorders_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.callsandorders
    ADD CONSTRAINT callsandorders_pkey PRIMARY KEY (callsandordersid);


--
-- Name: contacttypes contacttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contacttypes
    ADD CONSTRAINT contacttypes_pkey PRIMARY KEY (contacttypeid);


--
-- Name: contracts contracts_contractnumber_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_contractnumber_key UNIQUE (contractnumber);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (contractid);


--
-- Name: contracttypes contracttypes_contracttypename_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracttypes
    ADD CONSTRAINT contracttypes_contracttypename_key UNIQUE (contracttypename);


--
-- Name: contracttypes contracttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracttypes
    ADD CONSTRAINT contracttypes_pkey PRIMARY KEY (contracttypeid);


--
-- Name: coreidentity coreidentity_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentity
    ADD CONSTRAINT coreidentity_pkey PRIMARY KEY (coreidentityid);


--
-- Name: coreidentityadjudications coreidentityadjudications_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityadjudications
    ADD CONSTRAINT coreidentityadjudications_pkey PRIMARY KEY (coreidentityadjudicationid);


--
-- Name: coreidentityemails coreidentityemails_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityemails
    ADD CONSTRAINT coreidentityemails_pkey PRIMARY KEY (coreidentityemailid);


--
-- Name: coreidentityinvestigationrequests coreidentityinvestigationrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityinvestigationrequests
    ADD CONSTRAINT coreidentityinvestigationrequests_pkey PRIMARY KEY (coreidentityinvestigationrequestid);


--
-- Name: coreidentityphones coreidentityphones_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityphones
    ADD CONSTRAINT coreidentityphones_pkey PRIMARY KEY (coreidentityphoneid);


--
-- Name: coreidentitypostaladdresses coreidentitypostaladdresses_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitypostaladdresses
    ADD CONSTRAINT coreidentitypostaladdresses_pkey PRIMARY KEY (coreidentitypostaladdressid);


--
-- Name: coreidentitysocialmedia coreidentitysocialmedia_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitysocialmedia
    ADD CONSTRAINT coreidentitysocialmedia_pkey PRIMARY KEY (coreidentitysocialmediaid);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (countryid);


--
-- Name: countrycodes countrycodes_countrycode_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.countrycodes
    ADD CONSTRAINT countrycodes_countrycode_key UNIQUE (countrycode);


--
-- Name: countrycodes countrycodes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.countrycodes
    ADD CONSTRAINT countrycodes_pkey PRIMARY KEY (countrycodeid);


--
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (emailid);


--
-- Name: emergencycontacts emergencycontacts_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emergencycontacts
    ADD CONSTRAINT emergencycontacts_pkey PRIMARY KEY (emergencycontactid);


--
-- Name: formtypes formtypes_formtypename_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.formtypes
    ADD CONSTRAINT formtypes_formtypename_key UNIQUE (formtypename);


--
-- Name: formtypes formtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.formtypes
    ADD CONSTRAINT formtypes_pkey PRIMARY KEY (formtypesid);


--
-- Name: geography geography_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.geography
    ADD CONSTRAINT geography_pkey PRIMARY KEY (geographyid);


--
-- Name: geographytypes geographytypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.geographytypes
    ADD CONSTRAINT geographytypes_pkey PRIMARY KEY (geographytypeid);


--
-- Name: investigationrequest investigationrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.investigationrequest
    ADD CONSTRAINT investigationrequest_pkey PRIMARY KEY (investigationrequestid);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (organizationid);


--
-- Name: organizationshistory organizationshistory_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT organizationshistory_pkey PRIMARY KEY (organizationshistoryid);


--
-- Name: organizationtypes organizationtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationtypes
    ADD CONSTRAINT organizationtypes_pkey PRIMARY KEY (organizationtypeid);


--
-- Name: organizationwebsites organizationwebsites_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationwebsites
    ADD CONSTRAINT organizationwebsites_pkey PRIMARY KEY (organizationwebsiteid);


--
-- Name: packageformevents packageformevents_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packageformevents
    ADD CONSTRAINT packageformevents_pkey PRIMARY KEY (packageformeventsid);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (packagesid);


--
-- Name: packagetypes packagetypes_packagetypename_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packagetypes
    ADD CONSTRAINT packagetypes_packagetypename_key UNIQUE (packagetypename);


--
-- Name: packagetypes packagetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packagetypes
    ADD CONSTRAINT packagetypes_pkey PRIMARY KEY (packagetypesid);


--
-- Name: pointsofcontact pointsofcontact_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT pointsofcontact_pkey PRIMARY KEY (pointofcontactid);


--
-- Name: pointsofcontactemails pointsofcontactemails_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactemails
    ADD CONSTRAINT pointsofcontactemails_pkey PRIMARY KEY (pointsofcontactemailid);


--
-- Name: pointsofcontactphones pointsofcontactphones_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactphones
    ADD CONSTRAINT pointsofcontactphones_pkey PRIMARY KEY (pointsofcontactphoneid);


--
-- Name: postaladdresses postaladdresses_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.postaladdresses
    ADD CONSTRAINT postaladdresses_pkey PRIMARY KEY (postaladdressid);


--
-- Name: prefixsuffix prefixsuffix_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.prefixsuffix
    ADD CONSTRAINT prefixsuffix_pkey PRIMARY KEY (prefixsuffixid);


--
-- Name: recordstatuses recordstatuses_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.recordstatuses
    ADD CONSTRAINT recordstatuses_pkey PRIMARY KEY (recordstatusid);


--
-- Name: recordstatuses recordstatuses_statusabbreviation_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.recordstatuses
    ADD CONSTRAINT recordstatuses_statusabbreviation_key UNIQUE (statusabbreviation);


--
-- Name: relationshiptypes relationshiptypes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.relationshiptypes
    ADD CONSTRAINT relationshiptypes_pkey PRIMARY KEY (relationshiptypeid);


--
-- Name: serviceproviders serviceproviders_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.serviceproviders
    ADD CONSTRAINT serviceproviders_pkey PRIMARY KEY (serviceproviderid);


--
-- Name: serviceproviders serviceproviders_providername_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.serviceproviders
    ADD CONSTRAINT serviceproviders_providername_key UNIQUE (providername);


--
-- Name: sexes sexes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.sexes
    ADD CONSTRAINT sexes_pkey PRIMARY KEY (sexid);


--
-- Name: socialmedia socialmedia_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.socialmedia
    ADD CONSTRAINT socialmedia_pkey PRIMARY KEY (socialmediaid);


--
-- Name: tableprefixes tableprefixes_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.tableprefixes
    ADD CONSTRAINT tableprefixes_pkey PRIMARY KEY (prefixid);


--
-- Name: tableprefixes tableprefixes_tablename_key; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.tableprefixes
    ADD CONSTRAINT tableprefixes_tablename_key UNIQUE (tablename);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (vendorid);


--
-- Name: vendorwebsites vendorwebsites_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.vendorwebsites
    ADD CONSTRAINT vendorwebsites_pkey PRIMARY KEY (vendorwebsiteid);


--
-- Name: websites websites_pkey; Type: CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.websites
    ADD CONSTRAINT websites_pkey PRIMARY KEY (websiteid);


--
-- Name: adjudications trg_set_modified_on_insert_adjudications; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_adjudications BEFORE INSERT ON public.adjudications FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: aliases trg_set_modified_on_insert_aliases; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_aliases BEFORE INSERT ON public.aliases FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: assignments trg_set_modified_on_insert_assignments; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_assignments BEFORE INSERT ON public.assignments FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: assignmentstatuses trg_set_modified_on_insert_assignmentstatuses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_assignmentstatuses BEFORE INSERT ON public.assignmentstatuses FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: assignmenttypes trg_set_modified_on_insert_assignmenttypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_assignmenttypes BEFORE INSERT ON public.assignmenttypes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: callsandorders trg_set_modified_on_insert_callsandorders; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_callsandorders BEFORE INSERT ON public.callsandorders FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: contacttypes trg_set_modified_on_insert_contacttypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_contacttypes BEFORE INSERT ON public.contacttypes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: contracts trg_set_modified_on_insert_contracts; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_contracts BEFORE INSERT ON public.contracts FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: contracttypes trg_set_modified_on_insert_contracttypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_contracttypes BEFORE INSERT ON public.contracttypes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: coreidentity trg_set_modified_on_insert_coreidentity; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_coreidentity BEFORE INSERT ON public.coreidentity FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: coreidentityemails trg_set_modified_on_insert_coreidentityemails; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_coreidentityemails BEFORE INSERT ON public.coreidentityemails FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: coreidentityinvestigationrequests trg_set_modified_on_insert_coreidentityinvestigationrequests; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_coreidentityinvestigationrequests BEFORE INSERT ON public.coreidentityinvestigationrequests FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: coreidentityphones trg_set_modified_on_insert_coreidentityphones; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_coreidentityphones BEFORE INSERT ON public.coreidentityphones FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: coreidentitypostaladdresses trg_set_modified_on_insert_coreidentitypostaladdresses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_coreidentitypostaladdresses BEFORE INSERT ON public.coreidentitypostaladdresses FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: coreidentitysocialmedia trg_set_modified_on_insert_coreidentitysocialmedia; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_coreidentitysocialmedia BEFORE INSERT ON public.coreidentitysocialmedia FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: countrycodes trg_set_modified_on_insert_countrycodes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_countrycodes BEFORE INSERT ON public.countrycodes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: emails trg_set_modified_on_insert_emails; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_emails BEFORE INSERT ON public.emails FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: emergencycontacts trg_set_modified_on_insert_emergencycontacts; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_emergencycontacts BEFORE INSERT ON public.emergencycontacts FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: formtypes trg_set_modified_on_insert_formtypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_formtypes BEFORE INSERT ON public.formtypes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: geography trg_set_modified_on_insert_geography; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_geography BEFORE INSERT ON public.geography FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: geographytypes trg_set_modified_on_insert_geographytypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_geographytypes BEFORE INSERT ON public.geographytypes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: investigationrequest trg_set_modified_on_insert_investigationrequest; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_investigationrequest BEFORE INSERT ON public.investigationrequest FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: organizations trg_set_modified_on_insert_organizations; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_organizations BEFORE INSERT ON public.organizations FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: organizationshistory trg_set_modified_on_insert_organizationshistory; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_organizationshistory BEFORE INSERT ON public.organizationshistory FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: organizationtypes trg_set_modified_on_insert_organizationtypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_organizationtypes BEFORE INSERT ON public.organizationtypes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: packageformevents trg_set_modified_on_insert_packageformevents; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_packageformevents BEFORE INSERT ON public.packageformevents FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: packages trg_set_modified_on_insert_packages; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_packages BEFORE INSERT ON public.packages FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: packagetypes trg_set_modified_on_insert_packagetypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_packagetypes BEFORE INSERT ON public.packagetypes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: pointsofcontact trg_set_modified_on_insert_pointsofcontact; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_pointsofcontact BEFORE INSERT ON public.pointsofcontact FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: pointsofcontactemails trg_set_modified_on_insert_pointsofcontactemails; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_pointsofcontactemails BEFORE INSERT ON public.pointsofcontactemails FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: pointsofcontactphones trg_set_modified_on_insert_pointsofcontactphones; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_pointsofcontactphones BEFORE INSERT ON public.pointsofcontactphones FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: postaladdresses trg_set_modified_on_insert_postaladdresses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_postaladdresses BEFORE INSERT ON public.postaladdresses FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: prefixsuffix trg_set_modified_on_insert_prefixsuffix; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_prefixsuffix BEFORE INSERT ON public.prefixsuffix FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: recordstatuses trg_set_modified_on_insert_recordstatuses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_recordstatuses BEFORE INSERT ON public.recordstatuses FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: serviceproviders trg_set_modified_on_insert_serviceproviders; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_serviceproviders BEFORE INSERT ON public.serviceproviders FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: sexes trg_set_modified_on_insert_sexes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_sexes BEFORE INSERT ON public.sexes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: socialmedia trg_set_modified_on_insert_socialmedia; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_socialmedia BEFORE INSERT ON public.socialmedia FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: tableprefixes trg_set_modified_on_insert_tableprefixes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_tableprefixes BEFORE INSERT ON public.tableprefixes FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: vendors trg_set_modified_on_insert_vendors; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_vendors BEFORE INSERT ON public.vendors FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: websites trg_set_modified_on_insert_websites; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_set_modified_on_insert_websites BEFORE INSERT ON public.websites FOR EACH ROW EXECUTE FUNCTION public.set_modified_on_insert();


--
-- Name: adjudications trg_update_human_readable_id_adjudications; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_adjudications BEFORE INSERT OR UPDATE ON public.adjudications FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: aliases trg_update_human_readable_id_aliases; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_aliases BEFORE INSERT OR UPDATE ON public.aliases FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: assignments trg_update_human_readable_id_assignments; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_assignments BEFORE INSERT OR UPDATE ON public.assignments FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: assignmentstatuses trg_update_human_readable_id_assignmentstatuses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_assignmentstatuses BEFORE INSERT OR UPDATE ON public.assignmentstatuses FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: assignmenttypes trg_update_human_readable_id_assignmenttypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_assignmenttypes BEFORE INSERT OR UPDATE ON public.assignmenttypes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: callsandorders trg_update_human_readable_id_callsandorders; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_callsandorders BEFORE INSERT OR UPDATE ON public.callsandorders FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: contacttypes trg_update_human_readable_id_contacttypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_contacttypes BEFORE INSERT OR UPDATE ON public.contacttypes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: contracts trg_update_human_readable_id_contracts; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_contracts BEFORE INSERT OR UPDATE ON public.contracts FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: contracttypes trg_update_human_readable_id_contracttypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_contracttypes BEFORE INSERT OR UPDATE ON public.contracttypes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: coreidentity trg_update_human_readable_id_coreidentity; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_coreidentity BEFORE INSERT OR UPDATE ON public.coreidentity FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: coreidentityemails trg_update_human_readable_id_coreidentityemails; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_coreidentityemails BEFORE INSERT OR UPDATE ON public.coreidentityemails FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: coreidentityinvestigationrequests trg_update_human_readable_id_coreidentityinvestigationrequests; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_coreidentityinvestigationrequests BEFORE INSERT OR UPDATE ON public.coreidentityinvestigationrequests FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: coreidentityphones trg_update_human_readable_id_coreidentityphones; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_coreidentityphones BEFORE INSERT OR UPDATE ON public.coreidentityphones FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: coreidentitypostaladdresses trg_update_human_readable_id_coreidentitypostaladdresses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_coreidentitypostaladdresses BEFORE INSERT OR UPDATE ON public.coreidentitypostaladdresses FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: coreidentitysocialmedia trg_update_human_readable_id_coreidentitysocialmedia; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_coreidentitysocialmedia BEFORE INSERT OR UPDATE ON public.coreidentitysocialmedia FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: countrycodes trg_update_human_readable_id_countrycodes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_countrycodes BEFORE INSERT OR UPDATE ON public.countrycodes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: emails trg_update_human_readable_id_emails; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_emails BEFORE INSERT OR UPDATE ON public.emails FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: emergencycontacts trg_update_human_readable_id_emergencycontacts; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_emergencycontacts BEFORE INSERT OR UPDATE ON public.emergencycontacts FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: formtypes trg_update_human_readable_id_formtypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_formtypes BEFORE INSERT OR UPDATE ON public.formtypes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: geography trg_update_human_readable_id_geography; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_geography BEFORE INSERT OR UPDATE ON public.geography FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: geographytypes trg_update_human_readable_id_geographytypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_geographytypes BEFORE INSERT OR UPDATE ON public.geographytypes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: investigationrequest trg_update_human_readable_id_investigationrequest; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_investigationrequest BEFORE INSERT OR UPDATE ON public.investigationrequest FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: organizations trg_update_human_readable_id_organizations; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_organizations BEFORE INSERT OR UPDATE ON public.organizations FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: organizationshistory trg_update_human_readable_id_organizationshistory; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_organizationshistory BEFORE INSERT OR UPDATE ON public.organizationshistory FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: organizationtypes trg_update_human_readable_id_organizationtypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_organizationtypes BEFORE INSERT OR UPDATE ON public.organizationtypes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: packageformevents trg_update_human_readable_id_packageformevents; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_packageformevents BEFORE INSERT OR UPDATE ON public.packageformevents FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: packages trg_update_human_readable_id_packages; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_packages BEFORE INSERT OR UPDATE ON public.packages FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: packagetypes trg_update_human_readable_id_packagetypes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_packagetypes BEFORE INSERT OR UPDATE ON public.packagetypes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: pointsofcontact trg_update_human_readable_id_pointsofcontact; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_pointsofcontact BEFORE INSERT OR UPDATE ON public.pointsofcontact FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: pointsofcontactemails trg_update_human_readable_id_pointsofcontactemails; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_pointsofcontactemails BEFORE INSERT OR UPDATE ON public.pointsofcontactemails FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: pointsofcontactphones trg_update_human_readable_id_pointsofcontactphones; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_pointsofcontactphones BEFORE INSERT OR UPDATE ON public.pointsofcontactphones FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: postaladdresses trg_update_human_readable_id_postaladdresses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_postaladdresses BEFORE INSERT OR UPDATE ON public.postaladdresses FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: prefixsuffix trg_update_human_readable_id_prefixsuffix; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_prefixsuffix BEFORE INSERT OR UPDATE ON public.prefixsuffix FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: recordstatuses trg_update_human_readable_id_recordstatuses; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_recordstatuses BEFORE INSERT OR UPDATE ON public.recordstatuses FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: serviceproviders trg_update_human_readable_id_serviceproviders; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_serviceproviders BEFORE INSERT OR UPDATE ON public.serviceproviders FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: sexes trg_update_human_readable_id_sexes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_sexes BEFORE INSERT OR UPDATE ON public.sexes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: socialmedia trg_update_human_readable_id_socialmedia; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_socialmedia BEFORE INSERT OR UPDATE ON public.socialmedia FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: tableprefixes trg_update_human_readable_id_tableprefixes; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_tableprefixes BEFORE INSERT OR UPDATE ON public.tableprefixes FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: vendors trg_update_human_readable_id_vendors; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_vendors BEFORE INSERT OR UPDATE ON public.vendors FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: websites trg_update_human_readable_id_websites; Type: TRIGGER; Schema: public; Owner: wdrep
--

CREATE TRIGGER trg_update_human_readable_id_websites BEFORE INSERT OR UPDATE ON public.websites FOR EACH ROW EXECUTE FUNCTION public.update_human_readable_id();


--
-- Name: adjudications fk_adjudications_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.adjudications
    ADD CONSTRAINT fk_adjudications_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: aliases fk_aliases_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.aliases
    ADD CONSTRAINT fk_aliases_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: aliases fk_aliases_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.aliases
    ADD CONSTRAINT fk_aliases_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: assignments fk_assignments_assignmentstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_assignments_assignmentstatusid FOREIGN KEY (assignmentstatusid) REFERENCES public.assignmentstatuses(assignmentstatusid);


--
-- Name: assignments fk_assignments_assignmenttypeid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_assignments_assignmenttypeid FOREIGN KEY (assignmenttypeid) REFERENCES public.assignmenttypes(assignmenttypeid);


--
-- Name: assignments fk_assignments_contractid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_assignments_contractid FOREIGN KEY (contractid) REFERENCES public.contracts(contractid);


--
-- Name: assignments fk_assignments_organizationid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_assignments_organizationid FOREIGN KEY (organizationid) REFERENCES public.organizations(organizationid);


--
-- Name: assignments fk_assignments_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_assignments_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: assignments fk_assignments_workerid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_assignments_workerid FOREIGN KEY (workerid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: assignmentstatuses fk_assignmentstatuses_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignmentstatuses
    ADD CONSTRAINT fk_assignmentstatuses_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: assignmenttypes fk_assignmenttypes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.assignmenttypes
    ADD CONSTRAINT fk_assignmenttypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentityadjudications fk_cia_adjudicationid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityadjudications
    ADD CONSTRAINT fk_cia_adjudicationid FOREIGN KEY (adjudicationid) REFERENCES public.adjudications(adjudicationid);


--
-- Name: coreidentityadjudications fk_cia_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityadjudications
    ADD CONSTRAINT fk_cia_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: coreidentityadjudications fk_cia_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityadjudications
    ADD CONSTRAINT fk_cia_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentityemails fk_cie_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityemails
    ADD CONSTRAINT fk_cie_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: coreidentityemails fk_cie_emailid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityemails
    ADD CONSTRAINT fk_cie_emailid FOREIGN KEY (emailid) REFERENCES public.emails(emailid);


--
-- Name: coreidentityemails fk_cie_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityemails
    ADD CONSTRAINT fk_cie_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentityinvestigationrequests fk_ciir_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityinvestigationrequests
    ADD CONSTRAINT fk_ciir_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: coreidentityinvestigationrequests fk_ciir_investigationrequestid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityinvestigationrequests
    ADD CONSTRAINT fk_ciir_investigationrequestid FOREIGN KEY (investigationrequestid) REFERENCES public.investigationrequest(investigationrequestid);


--
-- Name: coreidentityinvestigationrequests fk_ciir_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityinvestigationrequests
    ADD CONSTRAINT fk_ciir_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentityphones fk_cip_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityphones
    ADD CONSTRAINT fk_cip_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: coreidentityphones fk_cip_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentityphones
    ADD CONSTRAINT fk_cip_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentitypostaladdresses fk_cipa_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitypostaladdresses
    ADD CONSTRAINT fk_cipa_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: coreidentitypostaladdresses fk_cipa_postaladdressid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitypostaladdresses
    ADD CONSTRAINT fk_cipa_postaladdressid FOREIGN KEY (postaladdressid) REFERENCES public.postaladdresses(postaladdressid);


--
-- Name: coreidentitypostaladdresses fk_cipa_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitypostaladdresses
    ADD CONSTRAINT fk_cipa_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentitysocialmedia fk_cism_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitysocialmedia
    ADD CONSTRAINT fk_cism_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: coreidentitysocialmedia fk_cism_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitysocialmedia
    ADD CONSTRAINT fk_cism_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentitysocialmedia fk_cism_socialmediaid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentitysocialmedia
    ADD CONSTRAINT fk_cism_socialmediaid FOREIGN KEY (socialmediaid) REFERENCES public.socialmedia(socialmediaid);


--
-- Name: contacttypes fk_contacttypes_createdby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contacttypes
    ADD CONSTRAINT fk_contacttypes_createdby FOREIGN KEY (createdby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: contacttypes fk_contacttypes_deletedby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contacttypes
    ADD CONSTRAINT fk_contacttypes_deletedby FOREIGN KEY (deletedby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: contacttypes fk_contacttypes_modifiedby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contacttypes
    ADD CONSTRAINT fk_contacttypes_modifiedby FOREIGN KEY (modifiedby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: contacttypes fk_contacttypes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contacttypes
    ADD CONSTRAINT fk_contacttypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: contracts fk_contracts_contracttypeid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT fk_contracts_contracttypeid FOREIGN KEY (contracttypeid) REFERENCES public.contracttypes(contracttypeid);


--
-- Name: contracts fk_contracts_organizationid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT fk_contracts_organizationid FOREIGN KEY (organizationid) REFERENCES public.organizations(organizationid);


--
-- Name: contracts fk_contracts_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT fk_contracts_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: contracts fk_contracts_vendorid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT fk_contracts_vendorid FOREIGN KEY (vendorid) REFERENCES public.vendors(vendorid);


--
-- Name: contracttypes fk_contracttypes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.contracttypes
    ADD CONSTRAINT fk_contracttypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentity fk_coreidentity_prefixid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentity
    ADD CONSTRAINT fk_coreidentity_prefixid FOREIGN KEY (prefixid) REFERENCES public.prefixsuffix(prefixsuffixid);


--
-- Name: coreidentity fk_coreidentity_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentity
    ADD CONSTRAINT fk_coreidentity_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: coreidentity fk_coreidentity_sexid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentity
    ADD CONSTRAINT fk_coreidentity_sexid FOREIGN KEY (sexid) REFERENCES public.sexes(sexid);


--
-- Name: coreidentity fk_coreidentity_suffixid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.coreidentity
    ADD CONSTRAINT fk_coreidentity_suffixid FOREIGN KEY (suffixid) REFERENCES public.prefixsuffix(prefixsuffixid);


--
-- Name: countries fk_countries_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT fk_countries_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: countrycodes fk_countrycodes_countryid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.countrycodes
    ADD CONSTRAINT fk_countrycodes_countryid FOREIGN KEY (countryid) REFERENCES public.countries(countryid);


--
-- Name: countrycodes fk_countrycodes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.countrycodes
    ADD CONSTRAINT fk_countrycodes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: emergencycontacts fk_ec_coreidentityid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emergencycontacts
    ADD CONSTRAINT fk_ec_coreidentityid FOREIGN KEY (coreidentityid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: emergencycontacts fk_ec_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emergencycontacts
    ADD CONSTRAINT fk_ec_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: emergencycontacts fk_ec_relationshiptypeid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emergencycontacts
    ADD CONSTRAINT fk_ec_relationshiptypeid FOREIGN KEY (relationshiptypeid) REFERENCES public.relationshiptypes(relationshiptypeid);


--
-- Name: emails fk_emails_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT fk_emails_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: formtypes fk_formtypes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.formtypes
    ADD CONSTRAINT fk_formtypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: geography fk_geography_geographytypeid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.geography
    ADD CONSTRAINT fk_geography_geographytypeid FOREIGN KEY (geographytypeid) REFERENCES public.geographytypes(geographytypeid);


--
-- Name: geography fk_geography_parentid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.geography
    ADD CONSTRAINT fk_geography_parentid FOREIGN KEY (parentid) REFERENCES public.geography(geographyid);


--
-- Name: geography fk_geography_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.geography
    ADD CONSTRAINT fk_geography_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: geographytypes fk_geographytypes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.geographytypes
    ADD CONSTRAINT fk_geographytypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: organizationshistory fk_organizationshistory_createdby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT fk_organizationshistory_createdby FOREIGN KEY (createdby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: organizationshistory fk_organizationshistory_deletedby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT fk_organizationshistory_deletedby FOREIGN KEY (deletedby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: organizationshistory fk_organizationshistory_modifiedby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT fk_organizationshistory_modifiedby FOREIGN KEY (modifiedby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: organizationshistory fk_organizationshistory_organizationid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT fk_organizationshistory_organizationid FOREIGN KEY (organizationid) REFERENCES public.organizations(organizationid);


--
-- Name: organizationshistory fk_organizationshistory_organizationtypeid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT fk_organizationshistory_organizationtypeid FOREIGN KEY (organizationtypeid) REFERENCES public.organizationtypes(organizationtypeid);


--
-- Name: organizationshistory fk_organizationshistory_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT fk_organizationshistory_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: postaladdresses fk_pa_countryid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.postaladdresses
    ADD CONSTRAINT fk_pa_countryid FOREIGN KEY (countryid) REFERENCES public.countries(countryid);


--
-- Name: postaladdresses fk_pa_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.postaladdresses
    ADD CONSTRAINT fk_pa_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: packageformevents fk_packageformevents_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packageformevents
    ADD CONSTRAINT fk_packageformevents_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: packages fk_packages_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT fk_packages_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: packages fk_packages_specialistid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT fk_packages_specialistid FOREIGN KEY (specialistid) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: packagetypes fk_packagetypes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.packagetypes
    ADD CONSTRAINT fk_packagetypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: pointsofcontact fk_pointsofcontact_createdby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT fk_pointsofcontact_createdby FOREIGN KEY (createdby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: pointsofcontact fk_pointsofcontact_deletedby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT fk_pointsofcontact_deletedby FOREIGN KEY (deletedby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: pointsofcontact fk_pointsofcontact_modifiedby; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT fk_pointsofcontact_modifiedby FOREIGN KEY (modifiedby) REFERENCES public.coreidentity(coreidentityid);


--
-- Name: pointsofcontact fk_pointsofcontact_prefixid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT fk_pointsofcontact_prefixid FOREIGN KEY (prefixid) REFERENCES public.prefixsuffix(prefixsuffixid);


--
-- Name: pointsofcontact fk_pointsofcontact_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT fk_pointsofcontact_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: pointsofcontact fk_pointsofcontact_suffixid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT fk_pointsofcontact_suffixid FOREIGN KEY (suffixid) REFERENCES public.prefixsuffix(prefixsuffixid);


--
-- Name: pointsofcontactemails fk_pointsofcontactemails_emailid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactemails
    ADD CONSTRAINT fk_pointsofcontactemails_emailid FOREIGN KEY (emailid) REFERENCES public.emails(emailid);


--
-- Name: pointsofcontactemails fk_pointsofcontactemails_pointofcontactid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactemails
    ADD CONSTRAINT fk_pointsofcontactemails_pointofcontactid FOREIGN KEY (pointofcontactid) REFERENCES public.pointsofcontact(pointofcontactid);


--
-- Name: pointsofcontactemails fk_pointsofcontactemails_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactemails
    ADD CONSTRAINT fk_pointsofcontactemails_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: pointsofcontactphones fk_pointsofcontactphones_pointofcontactid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactphones
    ADD CONSTRAINT fk_pointsofcontactphones_pointofcontactid FOREIGN KEY (pointofcontactid) REFERENCES public.pointsofcontact(pointofcontactid);


--
-- Name: pointsofcontactphones fk_pointsofcontactphones_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.pointsofcontactphones
    ADD CONSTRAINT fk_pointsofcontactphones_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: prefixsuffix fk_prefixsuffix_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.prefixsuffix
    ADD CONSTRAINT fk_prefixsuffix_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: sexes fk_sexes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.sexes
    ADD CONSTRAINT fk_sexes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: socialmedia fk_sm_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.socialmedia
    ADD CONSTRAINT fk_sm_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: vendors fk_vendors_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: wdrep
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT fk_vendors_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- PostgreSQL database dump complete
--

\unrestrict 7fzebkEmaqDPviiWdOK4PbxBuA9r1oQ7PASD6TDuqeRMTbvb7VkVAfPGVR2kHBt

