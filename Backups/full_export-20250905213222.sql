--
-- PostgreSQL database dump
--

\restrict EDvn0lX04mLCSSQtxDsAfXJ56B6bP6LHvvg7bNqgUOKXTaiUpInQyoQMZBcYF54

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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


--
-- Name: adjudications; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: adjudications_adjudicationid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: aliases; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: aliases_aliasid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: assignments; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: assignments_assignmentid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.assignments_assignmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assignments_assignmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.assignments_assignmentid_seq OWNED BY public.assignments.assignmentid;


--
-- Name: assignmentstatuses; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: assignmentstatuses_assignmentstatusid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: assignmenttypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: assignmenttypes_assignmenttypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: callsandorders; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: callsandorders_callsandordersid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: contacttypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contacttypes_contacttypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: contracts; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: contracts_contractid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contracts_contractid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contracts_contractid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contracts_contractid_seq OWNED BY public.contracts.contractid;


--
-- Name: contracttypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contracttypes_contracttypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: coreidentity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coreidentity (
    coreidentityid integer NOT NULL,
    humanreadableid character varying(20),
    prefixid integer,
    firstname character varying(50) NOT NULL,
    middlename character varying(50),
    lastname character varying(50) NOT NULL,
    suffixid integer,
    ssn bytea NOT NULL,
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


--
-- Name: coreidentity_coreidentityid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: coreidentityadjudications; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: coreidentityadjudications_coreidentityadjudicationid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: coreidentityemails; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: coreidentityemails_coreidentityemailid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coreidentityemails_coreidentityemailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coreidentityemails_coreidentityemailid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coreidentityemails_coreidentityemailid_seq OWNED BY public.coreidentityemails.coreidentityemailid;


--
-- Name: coreidentityinvestigationrequests; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq OWNED BY public.coreidentityinvestigationrequests.coreidentityinvestigationrequestid;


--
-- Name: coreidentityphones; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: coreidentityphones_coreidentityphoneid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coreidentityphones_coreidentityphoneid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coreidentityphones_coreidentityphoneid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coreidentityphones_coreidentityphoneid_seq OWNED BY public.coreidentityphones.coreidentityphoneid;


--
-- Name: coreidentitypostaladdresses; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: coreidentitypostaladdresses_coreidentitypostaladdressid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coreidentitypostaladdresses_coreidentitypostaladdressid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq OWNED BY public.coreidentitypostaladdresses.coreidentitypostaladdressid;


--
-- Name: coreidentitysocialmedia; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: coreidentitysocialmedia_coreidentitysocialmediaid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coreidentitysocialmedia_coreidentitysocialmediaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coreidentitysocialmedia_coreidentitysocialmediaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coreidentitysocialmedia_coreidentitysocialmediaid_seq OWNED BY public.coreidentitysocialmedia.coreidentitysocialmediaid;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: countries_countryid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: countrycodes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: countrycodes_countrycodeid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: defaultitems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.defaultitems (
    defaultitemid integer NOT NULL,
    defaultitempage character varying(100) NOT NULL,
    defaultitemtab character varying(100),
    cancellink character varying(100),
    cancellinktext character varying(100),
    previouslink character varying(100),
    previouslinktext character varying(100),
    nextlink character varying(100),
    nextlinktext character varying(100),
    recordstatusid integer NOT NULL
);


--
-- Name: defaultitems_defaultitemid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.defaultitems_defaultitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: defaultitems_defaultitemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.defaultitems_defaultitemid_seq OWNED BY public.defaultitems.defaultitemid;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.emails (
    emailid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    emailaddress character varying(320) NOT NULL,
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


--
-- Name: emails_emailid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.emails_emailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emails_emailid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.emails_emailid_seq OWNED BY public.emails.emailid;


--
-- Name: emergencycontacts; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: emergencycontacts_emergencycontactid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.emergencycontacts_emergencycontactid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emergencycontacts_emergencycontactid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.emergencycontacts_emergencycontactid_seq OWNED BY public.emergencycontacts.emergencycontactid;


--
-- Name: formtypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: formtypes_formtypesid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: geography; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: geography_geographyid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: geographytypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: geographytypes_geographytypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: investigationrequest; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: investigationrequest_investigationrequestid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.investigationrequest_investigationrequestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: investigationrequest_investigationrequestid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.investigationrequest_investigationrequestid_seq OWNED BY public.investigationrequest.investigationrequestid;


--
-- Name: menuitems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menuitems (
    menuitemid integer NOT NULL,
    menuitemname character varying(40) NOT NULL,
    immediatelink character varying(100),
    nextlink character varying(100),
    cancellink character varying(100),
    previouslink character varying(100),
    nextlinktext character varying(100),
    cancellinktext character varying(100),
    previouslinktext character varying(100),
    menuitemtypeid integer NOT NULL,
    parentid integer,
    sequenceid integer NOT NULL,
    recordstatusid integer NOT NULL
);


--
-- Name: menuitems_menuitemid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.menuitems_menuitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menuitems_menuitemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.menuitems_menuitemid_seq OWNED BY public.menuitems.menuitemid;


--
-- Name: menuitemtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menuitemtypes (
    menuitemtypeid integer NOT NULL,
    menuitemtypename character varying(20) NOT NULL,
    recordstatusid integer NOT NULL
);


--
-- Name: menuitemtypes_menuitemtypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.menuitemtypes_menuitemtypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menuitemtypes_menuitemtypeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.menuitemtypes_menuitemtypeid_seq OWNED BY public.menuitemtypes.menuitemtypeid;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: organizations_organizationid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizations_organizationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_organizationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizations_organizationid_seq OWNED BY public.organizations.organizationid;


--
-- Name: organizationshistory; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: organizationshistory_organizationshistoryid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizationshistory_organizationshistoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizationshistory_organizationshistoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizationshistory_organizationshistoryid_seq OWNED BY public.organizationshistory.organizationshistoryid;


--
-- Name: organizationtypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: organizationtypes_organizationtypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: organizationwebsites; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: organizationwebsites_organizationwebsiteid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: packageformevents; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: packageformevents_packageformeventsid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: packages; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: packages_packagesid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: packagetypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: packagetypes_packagetypesid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: phones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phones (
    phoneid integer NOT NULL,
    humanreadableid character varying(20),
    recordstatusid integer NOT NULL,
    phonenumber character varying(320) NOT NULL,
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


--
-- Name: phones_phoneid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.phones_phoneid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phones_phoneid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.phones_phoneid_seq OWNED BY public.phones.phoneid;


--
-- Name: pointsofcontact; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: pointsofcontact_pointofcontactid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: pointsofcontactemails; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: pointsofcontactemails_pointsofcontactemailid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pointsofcontactemails_pointsofcontactemailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pointsofcontactemails_pointsofcontactemailid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pointsofcontactemails_pointsofcontactemailid_seq OWNED BY public.pointsofcontactemails.pointsofcontactemailid;


--
-- Name: pointsofcontactphones; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: pointsofcontactphones_pointsofcontactphoneid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pointsofcontactphones_pointsofcontactphoneid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pointsofcontactphones_pointsofcontactphoneid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pointsofcontactphones_pointsofcontactphoneid_seq OWNED BY public.pointsofcontactphones.pointsofcontactphoneid;


--
-- Name: postaladdresses; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: postaladdresses_postaladdressid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.postaladdresses_postaladdressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: postaladdresses_postaladdressid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.postaladdresses_postaladdressid_seq OWNED BY public.postaladdresses.postaladdressid;


--
-- Name: prefixsuffix; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: prefixsuffix_prefixsuffixid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: recordstatuses; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: recordstatuses_recordstatusid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recordstatuses_recordstatusid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recordstatuses_recordstatusid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recordstatuses_recordstatusid_seq OWNED BY public.recordstatuses.recordstatusid;


--
-- Name: relationshiptypes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: relationshiptypes_relationshiptypeid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: serviceproviders; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: serviceproviders_serviceproviderid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.serviceproviders_serviceproviderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: serviceproviders_serviceproviderid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.serviceproviders_serviceproviderid_seq OWNED BY public.serviceproviders.serviceproviderid;


--
-- Name: sexes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: sexes_sexid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: socialmedia; Type: TABLE; Schema: public; Owner: -
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
    createdip character varying(45) DEFAULT '::0'::character varying NOT NULL,
    modifiedby integer,
    modifieddate timestamp without time zone,
    modifiedip character varying(45),
    deletedby integer,
    deleteddate timestamp without time zone,
    deletedip character varying(45)
);


--
-- Name: socialmedia_socialmediaid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.socialmedia_socialmediaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: socialmedia_socialmediaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.socialmedia_socialmediaid_seq OWNED BY public.socialmedia.socialmediaid;


--
-- Name: ssn_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ssn_tokens (
    token uuid NOT NULL,
    encrypted_ssn bytea,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    expires_at timestamp without time zone NOT NULL
);


--
-- Name: tableprefixes; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: tableprefixes_prefixid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tableprefixes_prefixid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tableprefixes_prefixid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tableprefixes_prefixid_seq OWNED BY public.tableprefixes.prefixid;


--
-- Name: vendors; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vendors_vendorid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: vendorwebsites; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: vendorwebsites_vendorwebsiteid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: websites; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: websites_websiteid_seq; Type: SEQUENCE; Schema: public; Owner: -
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
-- Name: assignments assignmentid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignments ALTER COLUMN assignmentid SET DEFAULT nextval('public.assignments_assignmentid_seq'::regclass);


--
-- Name: contracts contractid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contracts ALTER COLUMN contractid SET DEFAULT nextval('public.contracts_contractid_seq'::regclass);


--
-- Name: coreidentityemails coreidentityemailid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentityemails ALTER COLUMN coreidentityemailid SET DEFAULT nextval('public.coreidentityemails_coreidentityemailid_seq'::regclass);


--
-- Name: coreidentityinvestigationrequests coreidentityinvestigationrequestid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentityinvestigationrequests ALTER COLUMN coreidentityinvestigationrequestid SET DEFAULT nextval('public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq'::regclass);


--
-- Name: coreidentityphones coreidentityphoneid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentityphones ALTER COLUMN coreidentityphoneid SET DEFAULT nextval('public.coreidentityphones_coreidentityphoneid_seq'::regclass);


--
-- Name: coreidentitypostaladdresses coreidentitypostaladdressid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentitypostaladdresses ALTER COLUMN coreidentitypostaladdressid SET DEFAULT nextval('public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq'::regclass);


--
-- Name: coreidentitysocialmedia coreidentitysocialmediaid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentitysocialmedia ALTER COLUMN coreidentitysocialmediaid SET DEFAULT nextval('public.coreidentitysocialmedia_coreidentitysocialmediaid_seq'::regclass);


--
-- Name: defaultitems defaultitemid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.defaultitems ALTER COLUMN defaultitemid SET DEFAULT nextval('public.defaultitems_defaultitemid_seq'::regclass);


--
-- Name: emails emailid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emails ALTER COLUMN emailid SET DEFAULT nextval('public.emails_emailid_seq'::regclass);


--
-- Name: emergencycontacts emergencycontactid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emergencycontacts ALTER COLUMN emergencycontactid SET DEFAULT nextval('public.emergencycontacts_emergencycontactid_seq'::regclass);


--
-- Name: investigationrequest investigationrequestid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investigationrequest ALTER COLUMN investigationrequestid SET DEFAULT nextval('public.investigationrequest_investigationrequestid_seq'::regclass);


--
-- Name: menuitems menuitemid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitems ALTER COLUMN menuitemid SET DEFAULT nextval('public.menuitems_menuitemid_seq'::regclass);


--
-- Name: menuitemtypes menuitemtypeid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitemtypes ALTER COLUMN menuitemtypeid SET DEFAULT nextval('public.menuitemtypes_menuitemtypeid_seq'::regclass);


--
-- Name: organizations organizationid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN organizationid SET DEFAULT nextval('public.organizations_organizationid_seq'::regclass);


--
-- Name: organizationshistory organizationshistoryid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizationshistory ALTER COLUMN organizationshistoryid SET DEFAULT nextval('public.organizationshistory_organizationshistoryid_seq'::regclass);


--
-- Name: phones phoneid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phones ALTER COLUMN phoneid SET DEFAULT nextval('public.phones_phoneid_seq'::regclass);


--
-- Name: pointsofcontactemails pointsofcontactemailid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointsofcontactemails ALTER COLUMN pointsofcontactemailid SET DEFAULT nextval('public.pointsofcontactemails_pointsofcontactemailid_seq'::regclass);


--
-- Name: pointsofcontactphones pointsofcontactphoneid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointsofcontactphones ALTER COLUMN pointsofcontactphoneid SET DEFAULT nextval('public.pointsofcontactphones_pointsofcontactphoneid_seq'::regclass);


--
-- Name: postaladdresses postaladdressid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postaladdresses ALTER COLUMN postaladdressid SET DEFAULT nextval('public.postaladdresses_postaladdressid_seq'::regclass);


--
-- Name: recordstatuses recordstatusid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recordstatuses ALTER COLUMN recordstatusid SET DEFAULT nextval('public.recordstatuses_recordstatusid_seq'::regclass);


--
-- Name: serviceproviders serviceproviderid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.serviceproviders ALTER COLUMN serviceproviderid SET DEFAULT nextval('public.serviceproviders_serviceproviderid_seq'::regclass);


--
-- Name: socialmedia socialmediaid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.socialmedia ALTER COLUMN socialmediaid SET DEFAULT nextval('public.socialmedia_socialmediaid_seq'::regclass);


--
-- Name: tableprefixes prefixid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tableprefixes ALTER COLUMN prefixid SET DEFAULT nextval('public.tableprefixes_prefixid_seq'::regclass);


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20250905184349_Baseline	9.0.8
\.


--
-- Data for Name: adjudications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.adjudications (adjudicationid, humanreadableid, recordstatusid, firstadjudicatorid, firstdecisiondate, firstdecisionid, secondadjudicatorid, seconddecisiondate, seconddecisionid, thirdadjudicatorid, thirddecisiondate, thirddecisionid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: aliases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.aliases (aliasid, humanreadableid, recordstatusid, coreidentityid, alias, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: assignments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.assignments (assignmentid, humanreadableid, recordstatusid, workerid, organizationid, contractid, assignmenttypeid, assignmentstatusid, startdate, enddate, hoursperweek, hourlyrate, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: assignmentstatuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.assignmentstatuses (assignmentstatusid, humanreadableid, recordstatusid, assignmentstatusname, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: assignmenttypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.assignmenttypes (assignmenttypeid, humanreadableid, recordstatusid, assignmenttypename, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: callsandorders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.callsandorders (callsandordersid, humanreadableid, contractid, callorordernumber, popstartdate, popenddate, cor, acor, co, cs, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: contacttypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contacttypes (contacttypeid, humanreadableid, contacttypename, appliestoemail, appliestophone, appliestosocialmedia, appliestopostaladdress, appliestowebsite, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	\N	Home	t	t	f	t	f	1	1	2025-09-05 03:01:42.211693	::0	\N	\N	\N	\N	\N	\N
2	\N	Work	t	t	f	t	f	1	1	2025-09-05 03:01:42.211693	::0	\N	\N	\N	\N	\N	\N
3	\N	School	t	t	f	t	f	1	1	2025-09-05 03:01:42.211693	::0	\N	\N	\N	\N	\N	\N
4	\N	Mobile	f	t	f	f	f	1	1	2025-09-05 03:01:42.211693	::0	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contracts (contractid, humanreadableid, recordstatusid, contractnumber, contractname, contracttypeid, organizationid, vendorid, startdate, enddate, contractvalue, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: contracttypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contracttypes (contracttypeid, humanreadableid, contracttypename, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coreidentity (coreidentityid, humanreadableid, prefixid, firstname, middlename, lastname, suffixid, ssn, dob, placeofbirthid, sexid, legacyid, preferredname, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
2	\N	\N	System	\N	User	\N	\\xc30d040703021f2057a15cb9570b7dd23a01093342757bb7b3d6151d96832f9281f2fdf420b08104af788d198d7a812a89af9c002eeaf8b2f2af7972322f07fbaa1b6158671f401f1147d6	2025-08-30 00:00:00	1	3	\N	\N	1	0	2025-09-05 19:29:49.670603	::0	0	2025-09-05 19:29:49.670603	::0	\N	\N	\N
\.


--
-- Data for Name: coreidentityadjudications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coreidentityadjudications (coreidentityadjudicationid, adjudicationid, coreidentityid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentityemails; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coreidentityemails (coreidentityemailid, humanreadableid, recordstatusid, coreidentityid, emailid, contacttypeid, contactsequence, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentityinvestigationrequests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coreidentityinvestigationrequests (coreidentityinvestigationrequestid, humanreadableid, recordstatusid, investigationrequestid, coreidentityid, assignmentdate, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentityphones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coreidentityphones (coreidentityphoneid, humanreadableid, recordstatusid, coreidentityid, phoneid, contacttypeid, contactsequence, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentitypostaladdresses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coreidentitypostaladdresses (coreidentitypostaladdressid, humanreadableid, recordstatusid, coreidentityid, postaladdressid, contacttypeid, contactsequence, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: coreidentitysocialmedia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coreidentitysocialmedia (coreidentitysocialmediaid, humanreadableid, recordstatusid, coreidentityid, socialmediaid, contacttypeid, contactsequence, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.countries (countryid, name, isocode, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: countrycodes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.countrycodes (countrycodeid, humanreadableid, countrycode, countryid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: defaultitems; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.defaultitems (defaultitemid, defaultitempage, defaultitemtab, cancellink, cancellinktext, previouslink, previouslinktext, nextlink, nextlinktext, recordstatusid) FROM stdin;
1	check-ssn		check-ssn	No			create-identity.Basic Information	Yes	1
2	create-identity	Basic Information	check-ssn	Cancel			create-identity.Contact Information	Next	1
3	create-identity	Contact Information	check-ssn	Cancel	create-identity.Basic Information	Back	create-alignment.Organization	Next	1
\.


--
-- Data for Name: emails; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.emails (emailid, humanreadableid, recordstatusid, emailaddress, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: emergencycontacts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.emergencycontacts (emergencycontactid, humanreadableid, recordstatusid, coreidentityid, pointofcontactid, relationshiptypeid, contactsequence, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: formtypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.formtypes (formtypesid, humanreadableid, formtypename, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: geography; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.geography (geographyid, humanreadableid, geographyname, geographytypeid, parentid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	\N	Afghanistan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
2	\N	Albania	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
3	\N	Algeria	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
4	\N	Andorra	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
5	\N	Angola	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
6	\N	Antigua and Barbuda	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
7	\N	Argentina	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
8	\N	Armenia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
9	\N	Australia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
10	\N	Austria	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
11	\N	Azerbaijan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
12	\N	Bahamas	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
13	\N	Bahrain	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
14	\N	Bangladesh	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
15	\N	Barbados	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
16	\N	Belarus	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
17	\N	Belgium	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
18	\N	Belize	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
19	\N	Benin	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
20	\N	Bhutan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
21	\N	Bolivia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
22	\N	Bosnia and Herzegovina	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
23	\N	Botswana	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
24	\N	Brazil	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
25	\N	Brunei	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
26	\N	Bulgaria	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
27	\N	Burkina Faso	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
28	\N	Burundi	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
29	\N	Cabo Verde	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
30	\N	Cambodia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
31	\N	Cameroon	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
32	\N	Canada	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
33	\N	Central African Republic	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
34	\N	Chad	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
35	\N	Chile	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
36	\N	China	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
37	\N	Colombia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
38	\N	Comoros	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
39	\N	Congo (Congo-Brazzaville)	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
40	\N	Congo (Congo-Kinshasa)	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
41	\N	Costa Rica	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
42	\N	Côte d’Ivoire	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
43	\N	Croatia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
44	\N	Cuba	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
45	\N	Cyprus	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
46	\N	Czechia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
47	\N	Denmark	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
48	\N	Djibouti	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
49	\N	Dominica	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
50	\N	Dominican Republic	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
51	\N	Ecuador	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
52	\N	Egypt	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
53	\N	El Salvador	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
54	\N	Equatorial Guinea	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
55	\N	Eritrea	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
56	\N	Estonia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
57	\N	Eswatini	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
58	\N	Ethiopia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
59	\N	Fiji	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
60	\N	Finland	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
61	\N	France	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
62	\N	Gabon	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
63	\N	Gambia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
64	\N	Georgia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
65	\N	Germany	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
66	\N	Ghana	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
67	\N	Greece	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
68	\N	Grenada	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
69	\N	Guatemala	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
70	\N	Guinea	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
71	\N	Guinea-Bissau	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
72	\N	Guyana	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
73	\N	Haiti	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
74	\N	Holy See	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
75	\N	Honduras	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
76	\N	Hungary	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
77	\N	Iceland	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
78	\N	India	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
79	\N	Indonesia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
80	\N	Iran	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
81	\N	Iraq	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
82	\N	Ireland	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
83	\N	Israel	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
84	\N	Italy	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
85	\N	Jamaica	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
86	\N	Japan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
87	\N	Jordan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
88	\N	Kazakhstan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
89	\N	Kenya	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
90	\N	Kiribati	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
91	\N	Kuwait	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
92	\N	Kyrgyzstan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
93	\N	Laos	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
94	\N	Latvia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
95	\N	Lebanon	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
96	\N	Lesotho	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
97	\N	Liberia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
98	\N	Libya	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
99	\N	Liechtenstein	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
100	\N	Lithuania	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
101	\N	Luxembourg	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
102	\N	Madagascar	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
103	\N	Malawi	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
104	\N	Malaysia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
105	\N	Maldives	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
106	\N	Mali	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
107	\N	Malta	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
108	\N	Marshall Islands	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
109	\N	Mauritania	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
110	\N	Mauritius	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
111	\N	Mexico	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
112	\N	Micronesia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
113	\N	Moldova	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
114	\N	Monaco	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
115	\N	Mongolia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
116	\N	Montenegro	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
117	\N	Morocco	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
118	\N	Mozambique	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
119	\N	Myanmar	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
120	\N	Namibia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
121	\N	Nauru	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
122	\N	Nepal	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
123	\N	Netherlands	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
124	\N	New Zealand	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
125	\N	Nicaragua	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
126	\N	Niger	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
127	\N	Nigeria	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
128	\N	North Korea	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
129	\N	North Macedonia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
130	\N	Norway	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
131	\N	Oman	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
132	\N	Pakistan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
133	\N	Palau	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
134	\N	Palestine	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
135	\N	Panama	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
136	\N	Papua New Guinea	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
137	\N	Paraguay	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
138	\N	Peru	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
139	\N	Philippines	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
140	\N	Poland	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
141	\N	Portugal	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
142	\N	Qatar	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
143	\N	Romania	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
144	\N	Russia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
145	\N	Rwanda	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
146	\N	Saint Kitts and Nevis	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
147	\N	Saint Lucia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
148	\N	Saint Vincent and the Grenadines	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
149	\N	Samoa	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
150	\N	San Marino	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
151	\N	Sao Tome and Principe	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
152	\N	Saudi Arabia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
153	\N	Senegal	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
154	\N	Serbia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
155	\N	Seychelles	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
156	\N	Sierra Leone	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
157	\N	Singapore	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
158	\N	Slovakia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
159	\N	Slovenia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
160	\N	Solomon Islands	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
161	\N	Somalia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
162	\N	South Africa	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
163	\N	South Korea	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
164	\N	South Sudan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
165	\N	Spain	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
166	\N	Sri Lanka	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
167	\N	Sudan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
168	\N	Suriname	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
169	\N	Sweden	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
170	\N	Switzerland	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
171	\N	Syria	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
172	\N	Taiwan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
173	\N	Tajikistan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
174	\N	Tanzania	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
175	\N	Thailand	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
176	\N	Timor-Leste	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
177	\N	Togo	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
178	\N	Tonga	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
179	\N	Trinidad and Tobago	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
180	\N	Tunisia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
181	\N	Turkey	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
182	\N	Turkmenistan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
183	\N	Tuvalu	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
184	\N	Uganda	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
185	\N	Ukraine	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
186	\N	United Arab Emirates	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
187	\N	United Kingdom	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
188	\N	United States	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
189	\N	Uruguay	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
190	\N	Uzbekistan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
191	\N	Vanuatu	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
192	\N	Venezuela	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
193	\N	Vietnam	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
194	\N	Yemen	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
195	\N	Zambia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
196	\N	Zimbabwe	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
197	\N	Abkhazia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
198	\N	Artsakh	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
199	\N	Cook Islands	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
200	\N	Kosovo	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
201	\N	Niue	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
202	\N	Northern Cyprus	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
203	\N	Palestine	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
204	\N	Sahrawi Arab Democratic Republic	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
205	\N	Somaliland	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
206	\N	South Ossetia	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
207	\N	Transnistria	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
208	\N	Taiwan	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
209	\N	Vatican City	1	\N	1	1	2025-09-05 02:05:32.33076	::0	\N	\N	\N	\N	\N	\N
210	\N	Alabama	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
211	\N	Alaska	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
212	\N	Arizona	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
213	\N	Arkansas	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
214	\N	California	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
215	\N	Colorado	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
216	\N	Connecticut	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
217	\N	Delaware	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
218	\N	District of Columbia	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
219	\N	Florida	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
220	\N	Georgia	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
221	\N	Hawaii	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
222	\N	Idaho	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
223	\N	Illinois	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
224	\N	Indiana	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
225	\N	Iowa	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
226	\N	Kansas	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
227	\N	Kentucky	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
228	\N	Louisiana	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
229	\N	Maine	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
230	\N	Maryland	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
231	\N	Massachusetts	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
232	\N	Michigan	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
233	\N	Minnesota	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
234	\N	Mississippi	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
235	\N	Missouri	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
236	\N	Montana	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
237	\N	Nebraska	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
238	\N	Nevada	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
239	\N	New Hampshire	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
240	\N	New Jersey	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
241	\N	New Mexico	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
242	\N	New York	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
243	\N	North Carolina	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
244	\N	North Dakota	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
245	\N	Ohio	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
246	\N	Oklahoma	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
247	\N	Oregon	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
248	\N	Pennsylvania	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
249	\N	Rhode Island	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
250	\N	South Carolina	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
251	\N	South Dakota	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
252	\N	Tennessee	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
253	\N	Texas	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
254	\N	Utah	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
255	\N	Vermont	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
256	\N	Virginia	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
257	\N	Washington	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
258	\N	West Virginia	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
259	\N	Wisconsin	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
260	\N	Wyoming	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
261	\N	American Samoa	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
262	\N	Guam	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
263	\N	Northern Mariana Islands	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
264	\N	Puerto Rico	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
265	\N	U.S. Virgin Islands	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
266	\N	Minor Outlying Islands	2	188	1	1	2025-09-05 02:08:56.715971	::0	\N	\N	\N	\N	\N	\N
267	\N	Alberta	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
268	\N	British Columbia	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
269	\N	Manitoba	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
270	\N	New Brunswick	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
271	\N	Newfoundland and Labrador	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
272	\N	Northwest Territories	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
273	\N	Nova Scotia	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
274	\N	Nunavut	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
275	\N	Ontario	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
276	\N	Prince Edward Island	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
277	\N	Quebec	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
278	\N	Saskatchewan	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
279	\N	Yukon	2	32	1	1	2025-09-05 02:08:56.718061	::0	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: geographytypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.geographytypes (geographytypeid, humanreadableid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	\N	Country	1	0	2025-09-04 17:09:07.76446	::0	0	2025-09-04 17:09:07.76446	::0	\N	\N	\N
2	\N	State	1	0	2025-09-04 17:09:07.76446	::0	0	2025-09-04 17:09:07.76446	::0	\N	\N	\N
3	\N	City	1	0	2025-09-04 17:09:07.76446	::0	0	2025-09-04 17:09:07.76446	::0	\N	\N	\N
4	\N	Country	1	0	2025-09-05 19:29:49.680168	::0	0	2025-09-05 19:29:49.680168	::0	\N	\N	\N
5	\N	State	1	0	2025-09-05 19:29:49.680168	::0	0	2025-09-05 19:29:49.680168	::0	\N	\N	\N
6	\N	City	1	0	2025-09-05 19:29:49.680168	::0	0	2025-09-05 19:29:49.680168	::0	\N	\N	\N
\.


--
-- Data for Name: investigationrequest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.investigationrequest (investigationrequestid, humanreadableid, recordstatusid, specialistassignedid, serviceproviderid, investigationtypeid, sentdate, completiondate, receiveddate, coreidentityid, assignmentdate, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: menuitems; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menuitems (menuitemid, menuitemname, immediatelink, nextlink, cancellink, previouslink, nextlinktext, cancellinktext, previouslinktext, menuitemtypeid, parentid, sequenceid, recordstatusid) FROM stdin;
7	Align Person	check-ssn	security-profile	home	check-ssn	Next	Cancel	Previous	2	1	2	1
8	Security Profile	check-ssn	hire-done	home	check-ssn	Next	Cancel	Previous	2	1	3	1
9	Options	config	config	home		Next	Cancel	\N	2	5	1	1
6	Create Person	check-ssn	create-identity	check-ssn		Yes	No	\N	2	1	1	1
1	Hire Personnel	\N	\N	\N	\N	\N	\N	\N	1	\N	2	1
2	Move Personnel	\N	\N	\N	\N	\N	\N	\N	1	\N	3	1
3	Separate Personnel	\N	\N	\N	\N	\N	\N	\N	1	\N	4	1
4	Reports	\N	\N	\N	\N	\N	\N	\N	1	\N	5	1
5	Configuration	\N	\N	\N	\N	\N	\N	\N	1	\N	6	1
10	Home	home	\N	\N	\N	\N	\N	\N	1	\N	1	1
\.


--
-- Data for Name: menuitemtypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menuitemtypes (menuitemtypeid, menuitemtypename, recordstatusid) FROM stdin;
1	Header	1
2	Item	1
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organizations (organizationid, humanreadableid, recordstatusid, organizationname, organizationtypeid, address1, address2, city, state, zipcode, phone, email, website, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: organizationshistory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organizationshistory (organizationshistoryid, humanreadableid, recordstatusid, organizationid, organizationname, organizationtypeid, address1, address2, city, state, zipcode, phone, email, website, operation, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: organizationtypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organizationtypes (organizationtypeid, humanreadableid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: organizationwebsites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organizationwebsites (organizationwebsiteid, organizationid, websiteid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: packageformevents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.packageformevents (packageformeventsid, humanreadableid, packageid, formtypeid, eventtype, eventdate, comments, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.packages (packagesid, humanreadableid, specialistid, packagetypeid, packagecomments, sf86required, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: packagetypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.packagetypes (packagetypesid, humanreadableid, packagetypename, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: phones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.phones (phoneid, humanreadableid, recordstatusid, phonenumber, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: pointsofcontact; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pointsofcontact (pointofcontactid, humanreadableid, prefixid, firstname, lastname, suffixid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: pointsofcontactemails; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pointsofcontactemails (pointsofcontactemailid, humanreadableid, recordstatusid, pointofcontactid, emailid, contacttypeid, contactsequence, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: pointsofcontactphones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pointsofcontactphones (pointsofcontactphoneid, humanreadableid, recordstatusid, pointofcontactid, phoneid, contacttypeid, contactsequence, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: postaladdresses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.postaladdresses (postaladdressid, humanreadableid, recordstatusid, address1, address2, city, state, zipcode, countryid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: prefixsuffix; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.prefixsuffix (prefixsuffixid, humanreadableid, description, category, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	\N	Mr.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
2	\N	Ms.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
3	\N	Mrs.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
4	\N	Sir	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
5	\N	Lady	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
6	\N	Miss	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
7	\N	Dr.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
8	\N	Gen.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
9	\N	Adm.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
10	\N	Col.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
11	\N	Lt. Col.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
12	\N	Maj.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
13	\N	Cpt.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
14	\N	Lt.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
15	\N	Ens.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
16	\N	Sgt.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
17	\N	Cpl.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
18	\N	Pvt.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
19	\N	Hon.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
20	\N	Sen.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
21	\N	Rep.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
22	\N	Mayor	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
23	\N	Gov.	Prefix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
24	\N	Sr.	Suffix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
25	\N	Jr.	Suffix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
26	\N	III	Suffix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
27	\N	IV	Suffix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
28	\N	V	Suffix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
29	\N	MD	Suffix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
30	\N	Esq.	Suffix	1	0	2025-09-04 17:09:07.760063	::0	0	2025-09-04 17:09:07.760063	::0	\N	\N	\N
\.


--
-- Data for Name: recordstatuses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recordstatuses (recordstatusid, humanreadableid, statusabbreviation, statusname, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	\N	A	Active	0	2025-09-04 17:09:07.758894	::0	0	2025-09-04 17:09:07.758894	::0	\N	\N	\N
2	\N	I	Inactive	0	2025-09-04 17:09:07.758894	::0	0	2025-09-04 17:09:07.758894	::0	\N	\N	\N
3	\N	D	Deleted	0	2025-09-04 17:09:07.758894	::0	0	2025-09-04 17:09:07.758894	::0	\N	\N	\N
4	\N	R	Archived	0	2025-09-04 17:09:07.758894	::0	0	2025-09-04 17:09:07.758894	::0	\N	\N	\N
\.


--
-- Data for Name: relationshiptypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.relationshiptypes (relationshiptypeid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: serviceproviders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.serviceproviders (serviceproviderid, humanreadableid, recordstatusid, providername, description, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: sexes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sexes (sexid, humanreadableid, description, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
1	\N	Female	1	0	2025-09-05 19:29:49.669709	::0	0	2025-09-05 19:29:49.669709	::0	\N	\N	\N
2	\N	Male	1	0	2025-09-05 19:29:49.669709	::0	0	2025-09-05 19:29:49.669709	::0	\N	\N	\N
3	\N	Unspecified	1	0	2025-09-05 19:29:49.669709	::0	0	2025-09-05 19:29:49.669709	::0	\N	\N	\N
\.


--
-- Data for Name: socialmedia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.socialmedia (socialmediaid, humanreadableid, recordstatusid, platform, handle, url, isprimary, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: ssn_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ssn_tokens (token, encrypted_ssn, created_at, expires_at) FROM stdin;
dd38c052-f471-422b-a075-781d38804c2f	\\xc30d04070302be88ab0a29af6b066bd23a01ed5bf15858ee27c4b24bdbe138e13bd3bd3da10cb9574760e93e7a9fc7fbb5dac916383f7f10bcb4d41caa4ee1e40555be880c73818d823cec	2025-09-04 17:09:32.444051	2025-09-04 17:19:32.444051
60605356-2a05-4852-a5a7-4cab6ac98028	\\xc30d040703026056bccdcf8d8c5673d23a01c8387c743dafa5e4c8ac955012f0106d09dea7d6d1a4b2f033ab9c49e7bb9949af3a4144c923ed34d977ee65a12492460337261259b265b1ee	2025-09-04 17:10:42.146252	2025-09-04 17:20:42.146252
bcf6a251-e682-4ad6-bdff-d202e865c0f1	\\xc30d04070302bc3e0e699809f47370d23a017efae20043568afe93121203de4d01eb254b4e4529e721d576cda4b12b1c8c0f6cf3f8c8a7a7d8917724fffce52cafbd1b5fbb4f331825c981	2025-09-04 17:11:54.112945	2025-09-04 17:21:54.112945
b6e69d40-e605-4881-b1f3-926437ee7867	\\xc30d04070302ac8a613ff80c9fe375d23a01c33e86cb649f87b3638201acf89ef0e515702b290b1f7f391673f8858097a0c332d9853ba6be7b17d9052f510f47d0067eed1d8fb6ea53972e	2025-09-04 17:15:44.198364	2025-09-04 17:25:44.198364
cdecd0f6-fcd5-456d-8234-b2d2d46ef26d	\\xc30d0407030298ff9bbbbb52e07e7dd23a014876d07f691a9e456e4d21a4f1f0ac30f879dcd2c476991da61a704b698c14e389bb41028cd04409b547c513e58fa61132b548a7490f4d24a7	2025-09-04 17:16:17.506284	2025-09-04 17:26:17.506284
21001578-bfe2-42cb-b77c-cd77dc3ff210	\\xc30d04070302e4365a04560c0c3b6ad23a019e2968fdf6a6e5fedfbe1376abb4f9c01c8bf098d984fbb88028ae2a059f5a6fa4e216f2566a395188a8908d7803b25b1612f8b14af031b2bf	2025-09-04 17:17:59.772875	2025-09-04 17:27:59.772875
b582c639-684a-4044-8415-7724f93fbbf3	\\xc30d040703023f5c673917eea91d69d23a015f217aaf15b5222ca01f7147044bdc0b4168a4ef9b151f647e100f4a963b5199dfa04401a3945d1da580a70dd82ef9f4312e0bee449a795f9f	2025-09-04 17:19:21.565634	2025-09-04 17:29:21.565634
d0cf3818-41ac-4bb1-900b-abf3ada92d23	\\xc30d04070302d94f173e337aa58473d23a018765090eb756aa8e14c134e1f0a95ed077f6a0eff11c134be140f3ace8fc778a90c7a9b540bcce16fb153ad88f5768688196ea3be3feb55a40	2025-09-04 17:21:10.499955	2025-09-04 17:31:10.499955
3d58fc15-1f70-4c22-b5ab-8f44cf2d5462	\\xc30d040703029627cc94e2b04c267ed23a01511df3929b43d18e098ed7b596973654db4ecc7a457f58daff635632282e706cd5aa975c237aa5aa3c9f0a48ea19948bd0f0848438fd7f04c5	2025-09-04 17:28:16.570807	2025-09-04 17:38:16.570807
0fa876db-0a59-4c86-a5d1-58279c5ce9a9	\\xc30d04070302caa32b70a89c83fa7ed23a01b348699fc609e792020ef8f3a6b692cf72838a4cac29a595618e751da036eb4a620ec88f2255c86d62346b30f04b923fefd0b30c1428552e34	2025-09-04 21:05:25.273622	2025-09-04 21:15:25.273622
f099e811-b666-4043-8b0a-8c16ead87054	\\xc30d0407030231edcab562fa38aa60d23a01522a4072ba5b8f4f4c3cb12d9d873297bf4a68a09ba9c0cb4c7b9d04a537a85b07f50deebe7a13b0a2d65015523e1b7510e6bfdbdc81d6b827	2025-09-04 21:38:17.010091	2025-09-04 21:48:17.010091
57123d95-765a-4cce-9cf0-f7faaeef86f0	\\xc30d04070302bf936b2c26f8cfd277d23a01a3c913a6eab24a1723713f7d18de0d31057f06b55d50bc591675e9d7161e37cc740f2ff360064a4735bdb476aa5b01ccb9a3f1d521c6f20d88	2025-09-04 21:39:19.348931	2025-09-04 21:49:19.348931
eeecc1eb-7c76-4d06-9fed-11ddcd9c9a30	\\xc30d04070302dbce2de8710aac0e7bd23a011e7db3d6c517966b8a9e2f8c0d12af5253d41bf377576fde39caef5762bb4f59a6aebe6f1a6971dbc752f55f34130f1698953cb0724a92a470	2025-09-04 21:41:41.462844	2025-09-04 21:51:41.462844
79175c39-8791-414e-a97b-40e6aef8309f	\\xc30d040703022fae7d1103be24877ed23a010b08ab3431db50103c4715269ee3ad3bfcb2dcc901810627a47e0521d8c5728a5470920af601eeb53885fdf3abc573b92edf4b02f3b1ce56b4	2025-09-04 21:41:49.952352	2025-09-04 21:51:49.952352
8b550d35-c8aa-4f0f-a767-b8d15ad5ee01	\\xc30d0407030266458c7fc46df38074d23a01986c9ed55f3c034bb31b3818563da08b605899ab4c46c8921d089cce88f4d7c579ab80c570b95c549c2dabad9baab31d9927152d863d704f72	2025-09-04 21:44:48.261367	2025-09-04 21:54:48.261367
a45305d9-dfb5-4df4-a22b-6d2a59d2a920	\\xc30d04070302600ac12f86385d076ad23a012edea71328c570d1ec258d3473b970d957704b85d45af405b0084691e9bd6ba04edd0be047259e7a0664585250bae863847ab88f9a0d6f0e71	2025-09-04 21:56:38.4787	2025-09-04 22:06:38.4787
56074597-eccc-4463-8dbe-a4ff4a094a19	\\xc30d04070302af80cb7fa32ec3e16ad23a01482dffa11531b847bb19afc6ff0e6de963ed2bade047780c3639bc3e084db90c7b84a9837ba683fb3f4ccdbacde9ab2b0d90908933b84f957a	2025-09-04 21:56:48.677985	2025-09-04 22:06:48.677985
381f4e9b-25d5-41c0-9cf6-0b07541eba12	\\xc30d04070302becb3f57c65e9ccc6bd23a01eea333fbee4a96166c78ca00ebf47c7fbfb85a641cfb4840fbd71408f458a1f2baecdc467f3390d971ff163955e77c2575b607e6d2afd48cd9	2025-09-04 21:59:30.544324	2025-09-04 22:09:30.544324
8ff4535b-99f9-4333-8da7-42a38e1842b1	\\xc30d04070302d3f89143d390365f69d23a013f8bfc7ffefbfb4e0ca0eecd61c6976f76f689b3a1828cd54278f7919187bc7e3498e784097a324eadb057d26d16a283638cc9fe77748bda53	2025-09-04 22:04:21.317396	2025-09-04 22:14:21.317396
1c2dc1f3-05cb-4694-a24e-71e4c4e57217	\\xc30d04070302c8ca718939b43c6f60d23a01b6073350b90df57509e0805b6ab7e22b11efb365ba3d4e0953bf4c36292a8186b103f15de3b336eb31ff7be835e3033b55438ed71e919b6fa7	2025-09-04 22:06:38.802741	2025-09-04 22:16:38.802741
67c87ed1-e1bc-477e-8141-40276aeab604	\\xc30d04070302c1159f8de587bc8276d23a01ef8db05cae8f01f08fd3ccfb9dd116bb743dfd23f52de2d0d2a758d50298e63306a23d22de96fd658a9ef928847b6394b50f30ae0e737128a2	2025-09-05 01:59:19.177503	2025-09-05 02:09:19.177503
dec5c3bc-9727-4f0f-b2ed-48b8a1c45021	\\xc30d04070302082c8a6f571e0b2b78d23a014f314d2f0d75a809cea9073cbfd6b9bcfe95aa7833a4b39374221c96faad0ab8b42edfbc91eebfd68bc9635f42357b727a481d26866d877cb7	2025-09-05 02:12:35.714897	2025-09-05 02:22:35.714897
4ee06620-2b76-4724-b878-d399abec68e6	\\xc30d040703029012d0b54ffaef057dd23a0107d09cad8b9cca39202b8c5fa4c98848056b4d6db6a464b0abdef1aa0e387fbe04d812a8fbf741464417e72f065a8c12a7854c27e3d5f629cc	2025-09-05 02:13:10.182376	2025-09-05 02:23:10.182376
0d509d0f-68bc-428c-b75f-76a446f4447b	\\xc30d04070302a929f5f71c24141774d23a01a77a3fd600f4fbf71d2f14df30fe8070c35a85f1d618214990d9cbc2a49e98beea8fed6554e6159fc130fc23b5123996bc72bc507f3f9d8f6c	2025-09-05 02:15:55.04849	2025-09-05 02:25:55.04849
b99d42a9-6905-48fd-87de-49c9593a660d	\\xc30d04070302d949002c8ff0de8862d23a01af0d72cd29d1a042094c8f012e57a72f3a97b2e3f0522c1be3831f0b8c9b7c1b90d09aba12d2c7195912ab1a81c671c110069cd88bb108e6d0	2025-09-05 02:20:32.596256	2025-09-05 02:30:32.596256
eb181ff0-4eb9-4f9d-b827-c0a0a95f46a6	\\xc30d04070302b2c4d3c1c66ac2f773d23a017045609c761409f70959585f30a1be290122de23bb4288f846592f53e83926aa014cf5ff2d6cb15e520eb953eb6b33c04ccc129e01fa28aa15	2025-09-05 02:21:00.653231	2025-09-05 02:31:00.653231
7b8f5b13-1fb5-4c53-9438-4c90f3595b80	\\xc30d04070302ee62858b55fd279f7fd23a017c340ca45b9eb6f8ea913ed3064a3da6b5b4ce5f428e7997585374406b188a3b987a07e67c0510a80ed941efcba27f1e7a02a7cf366e56fc99	2025-09-05 02:25:26.957993	2025-09-05 02:35:26.957993
c3cfaef9-7d1d-4131-80d8-1bb8e1f902b8	\\xc30d04070302d2ed078938eb388f73d23a019fa9a288d83c615f7da9017f57c6e7d58d0f8c951bea4f0ff141541ab38d83ca9ff1f5af0eb1dbae09d67c5e2e3b27d77e783fc73f9c1a2d68	2025-09-05 02:28:47.190648	2025-09-05 02:38:47.190648
23fac0fc-c30a-4647-8c69-0b2439ef5aff	\\xc30d0407030292a72a3b70252ffc71d23a0144a7eb9e4bb1f947538bfc96d591a95d13f525a5a0bedc4d44ecab3bb8db05252f33e052d34be0d3e0d6435a1ff5db2d7cca8aa0985d868c70	2025-09-05 02:32:48.526438	2025-09-05 02:42:48.526438
f85946e5-1892-443f-9791-95258f18187f	\\xc30d0407030217e1b749123ad3667dd23a0192904f89874f979541bbe402c9ea025c247cf7cb143096c9f206229906235dc95449b06e8cd9aaabe26d1fac846b9312c2f277afc2f7df412e	2025-09-05 02:35:14.066633	2025-09-05 02:45:14.066633
c43ec5b1-ae8f-4c65-be7c-f6a9c7de4ad7	\\xc30d040703026d543f74d766ccfd65d23a016de48ef7c2960e889876f17eea1ef1a592dc305de35884725363b5a1859e8f19b3eef8a510e7dccf0d7060c69a1491ea9a1176e45aaf2e45bf	2025-09-05 02:37:35.180988	2025-09-05 02:47:35.180988
a22fd46a-70f8-498e-b61f-8525bd425b6f	\\xc30d0407030200bb98d5fb07310461d23a01ca5c27611379f23bb3b3b7aabb540425e8081d6f51bc8ee7292966935104f7a80404d2b54329fbad08c2cc214dcc2cd1ba605c3019e4954689	2025-09-05 02:40:41.749237	2025-09-05 02:50:41.749237
438f9fdd-b9fa-46ec-b6f6-5b8d18ff0c02	\\xc30d04070302360dfe2d12e6cc7f77d23a01504cb71acea5698649e96ce0f417d46f83a19bdbdb4050df05988cb98e4e0c9aeeca51ee7a493ac7f1b5a07f20ee587ab7a986da7f824dc460	2025-09-05 02:48:23.743123	2025-09-05 02:58:23.743123
53ce29b5-ca2f-4a39-a6a9-37da7b0fc965	\\xc30d040703027f4005ce80a1dc5871d23a01c3e32295a92bde08f0f5210f8d6f672dea02cbded62327b196e03a55e543c1000b16ba4fa75cf44730916770efdbf88f28b5d1d5dfeb32d2f4	2025-09-05 02:50:32.302406	2025-09-05 03:00:32.302406
e7ee1e6d-029f-4839-8383-1a97fbb2bc69	\\xc30d04070302202ad6db617eb88968d23a0109e0c8e7f527b3405c06ad7bbbff2085f62608318262d4e19c232e8ea3139fff115f468626defcdb984f66f4fc86ca6c91a86c226b38eb8855	2025-09-05 03:01:58.472703	2025-09-05 03:11:58.472703
f16989a1-3cf1-4285-a4a1-2888ad9af3bb	\\xc30d0407030257da3218941e291162d23a01a742146f70414f025f8ed83ef0470d017d4ae9e3fd8668c51413e11d89c8ac7ddc08f7fb356795ed146b33f3d6718ae0c67c3dba8b1223913a	2025-09-05 03:02:12.069442	2025-09-05 03:12:12.069442
78d78fe6-1410-4901-8568-087b3439b852	\\xc30d040703020f9606cef6e0eae672d23a0114af0edd4b10c2e0db2a60e377700dc1818d90e1e5ff046276ba40625575b0af81c29e1787f804781c1a841d552ea46eb99fbc12551c48aff9	2025-09-05 03:04:45.629525	2025-09-05 03:14:45.629525
19769c1d-4504-44b1-bc23-46e8c048e4d3	\\xc30d0407030233290b22761bbf387bd23a015d32e658e614a5c4a8118088e62ea60c8cfae8a39a4e0432106940427a4520b371d7e59fdf6ce5b485456d9545da217794ef23a27adaff6622	2025-09-05 03:05:56.687874	2025-09-05 03:15:56.687874
40ea973e-aeb2-4813-aced-2c30ea6c707b	\\xc30d04070302729ad12815ada84a73d23a01d65e300a00b6f5dfee345a2b470fcbec2cbbdab41f3c574ccdc7788602ea0a8eb62071008a5fd12d2dfea7760932f21a6fbd14a0d65fd1a5af	2025-09-05 03:08:04.28756	2025-09-05 03:18:04.28756
ad08b5dd-c2ef-4dc9-8ea8-53b8dc012d61	\\xc30d04070302078313307fc82f506dd23a01a348e14aa57093be6a6c391327c33d3a726cb1829d01e8c4705dea1fca3138b343102f11b82a7d5f40a0b708b03979d993623ec73fa9aaf94c	2025-09-05 03:08:56.978364	2025-09-05 03:18:56.978364
ada64875-7291-4046-8be4-bcc4fb2ab3e1	\\xc30d040703029a42c979e8f77b7961d23a012ecbf51c8be7df6ac3a0db8dea121bc586402185b27dcfeb0f60c9ed9bea158bcb8ffe7cf02c505ce8f265dfdc084edb303da66c602de4c1ce	2025-09-05 03:10:41.133104	2025-09-05 03:20:41.133104
25a495c0-a067-449b-8a9f-626f0115a427	\\xc30d04070302d082b1a752cbae5f67d23a011d106cdf571263b47454143f4956dec16011b17c18d88ef176e5910e664c7637e3021b3c30770b7a451ab4d3f6a9ba86f3103d9b8b174a58b5	2025-09-05 03:16:20.775417	2025-09-05 03:26:20.775417
2a001eb0-b76f-4982-8f13-6c568751307a	\\xc30d04070302f2da89f58333607b7dd23a01597dfe349e5da5b2ee1dd5cbb725b99be21dd576405bdc140d58601ad203901622e9df44f960db50211d83fc7723ae60a0f15219b2f7bf2f4b	2025-09-05 03:17:41.16192	2025-09-05 03:27:41.16192
37523a6e-7223-41c0-ac2f-ae49a63e2000	\\xc30d04070302c9b49781e9a32f2879d23a0163ee6d8b0da8d3fe25f2b840e7aa73546351a179f027026262792a391f8182eaf44d485e862fdb7ab36fd7473bb24f38cd492efdcfa607cab0	2025-09-05 03:26:39.243971	2025-09-05 03:36:39.243971
894e2392-9d16-4d9e-9161-569b9b21a598	\\xc30d040703022cb718d4f358001478d23a01b371f05c9009a53b92729ab80f03832ac9047818609f5b13578885d6a5b6034567b24c075c6aa32d11a5d2b2d8e6a58196b1d0289c4b9bc581	2025-09-05 03:44:45.625947	2025-09-05 03:54:45.625947
0a609027-8f62-49c4-8c69-606f500ca03e	\\xc30d040703020edd2920080f674a7ed23a01b4cc5f491ab2ecada5bb8366a079ae0b95d2423b1bddbb8c8c20105c45fb7b889d6ceedc7614e30725fa9ba47c88e7e9d964f8cdfcf37819cd	2025-09-05 03:44:51.707732	2025-09-05 03:54:51.707732
abcc5017-a00c-4745-8d6f-865c62f822e4	\\xc30d040703023fa0b17d7323ac6071d23a0184edf8682f41e647f3c247c50466e2cd39c0a571c02ec941f9ac9dfb774573441aca068a6e0058470ea274a9a703adbbaaf4c3420773493c90	2025-09-05 03:44:59.491895	2025-09-05 03:54:59.491895
759411d1-7860-4714-bc5c-a3d0000dfbf4	\\xc30d04070302949060865ede3a9b7fd23a0184b9996765f702f857cd30712797f0eddd2b2b363a414fa5fcd3031db8ea0c3198e0ec10044538d6139d745ebb389bd647de828687b1165569	2025-09-05 03:59:01.684159	2025-09-05 04:09:01.684159
7a7f46be-9ff8-4d66-a952-c6f30f3c0275	\\xc30d0407030209032a52a9a9a3c361d23a012d8efb4870a42d55310231026161f3eabea1894a5dcb5cec9ab4256b2fa1b70c5f2ccf8329915849452e84b22b4ad4e93a66788c344dd70eb9	2025-09-05 17:26:57.52403	2025-09-05 17:36:57.52403
dafd7b6b-51ed-4ef5-8507-9e44f2ece2be	\\xc30d04070302ed1489bfc0a4e53a72d23a01a0a600b3a138459f3cf96e54e88efbafbc33b009edefaf38e31d2ec193d51842cd3093c0b0bf6f473eb325d95cc33d6388b265d0112596bbf7	2025-09-05 17:32:33.719164	2025-09-05 17:42:33.719164
d9aa90e9-fe79-424a-b447-008cd8807813	\\xc30d04070302b1de0aa15058f34b73d23a0198173da8b5b096274c01835784c3724856f07b05a677fb7c5bd16d1d5cfa36b330b7be79cb4abb3e50242231e47423709c5f16f5b968800a4c	2025-09-05 17:32:48.007792	2025-09-05 17:42:48.007792
1912b31a-df4f-4f09-a2d9-b34387610179	\\xc30d0407030226b2b7174e59152174d23a01af1e19aa643bb8af769da1a33df3611bbb970448006b5eb1e6e1d9ef85355a237b07dcd36264b2c2fbcd0871e74d48053a7c53bdd83caadf07	2025-09-05 17:38:43.202387	2025-09-05 17:48:43.202387
251359c4-398f-44f2-88a2-184d00624458	\\xc30d040703029a225fde0243aa9f64d23a0177b98785bf19f061a9ec096ef30d575aa364ab9b0f9e899235c704590f0146ba354cc3ed4e097949a38921ee40ba2dffc04ed5dee1ffbeccdc	2025-09-05 17:42:22.870036	2025-09-05 17:52:22.870036
1e8e9308-328b-4270-b03b-e52a462a12e3	\\xc30d0407030291094e456650c7f87ad23a01638a2b01827430f0da6d1592da65dc763d2561cd5a77b8db9836b818f93f135d2d293e5a43de342dee45267e5c0714474fd57bac31a2be297d	2025-09-05 17:45:51.930583	2025-09-05 17:55:51.930583
21d959af-ef1c-4893-bb26-7327892786ee	\\xc30d040703023075c1036e9e5b9474d23a0173f3d8f11cadded41185eb676015e0d49b8b7f059ed6ace31faacc71f58edd650c7909b8fb1bbc4baeaf707298afe01b551a8841f6585ed0be	2025-09-05 17:47:38.933767	2025-09-05 17:57:38.933767
889b826d-021a-47af-9ab3-2f30c6d2ea68	\\xc30d0407030273ad483a7161b4db70d23a018072eedf316856b3c371d35f9ae5a675ecad49cb3f3972827efe29c10368f8e2d7111a8ea74b3e363269119aa7ad27cc32149b7bf03cac2cbf	2025-09-05 17:48:38.843387	2025-09-05 17:58:38.843387
e3ce2e99-8b1a-4f32-b47b-dc2a58953339	\\xc30d0407030294d2085c6d374ef777d23a0126672c078ded1a6b7ebdcfa7de3bd6181d6a7abd9d327b9df0f1025bc130d439cf3f15039b6296f32d14b3f553bda8d812811f5e158c85a95e	2025-09-05 17:51:49.039835	2025-09-05 18:01:49.039835
4ce676d9-3d6f-44a3-990e-948c8db8ec11	\\xc30d0407030296e75c5d0b88d2c062d23a01161cb6bb6b210d65bab330a938630d103e0036fc3400b45bdd621c031db1263ccd9ba4666f94532de86957929d11c73d883ff34399e80dd7f7	2025-09-05 17:49:51.386164	2025-09-05 17:59:51.386164
b04933bc-ad14-4053-8e60-5aa2e4964b64	\\xc30d040703029e57b44cbdc2eae974d23a01d5032e60bae22e4925ef7cbcd6622f1113d017792970d4ea9b7499090aa6c552b3e64024e8e3b592ffc553966e299a8223f948590cce921da1	2025-09-05 17:49:58.223009	2025-09-05 17:59:58.223009
3a4a6e48-ac6f-42c5-90aa-5a3d5283240d	\\xc30d0407030270fe1dbd7e48bc3c62d23a01ab44c6faf4173e970bb66e022a1112ca272209ccaa4d8bb18b997a217be910980ff7437d1a1b965620c3034f2f3b3941b8680974e75e61a943	2025-09-05 17:50:16.366842	2025-09-05 18:00:16.366842
3dea51c4-9754-4773-a359-806ea33725b9	\\xc30d04070302e2661bf651740d6270d23a016a4457ce6bdd2c31eb7ae66245b33a8d6e68276f5899840ad9e00cdf6aaeb1ce132f3d98ed55479a23f4449ba2dc126f0b4f587c31d4ab99e5	2025-09-05 21:00:58.031064	2025-09-05 21:10:58.031064
1012cb54-596d-466b-8a83-5cf1131bf48f	\\xc30d040703023c2d7874344bc71e64d23a0109d78082af69cdd39e974a2f3eee94f52165f8e1649b79887514b20361190fc29c7e36e6ac6cbfb4024a9ae07050e22bb6de0cacbf894751ec	2025-09-05 17:54:59.800088	2025-09-05 18:04:59.800088
490b8064-628c-4baa-a005-947ffc86ab81	\\xc30d040703021d10135ff9a212186cd23a0196ab87fdfd4373eb9d8f0cbb29637189a68379f61e8bcf30b010a5d14d6b6c66a29168531646add34e14f3596242a268062eacbb879b48a427	2025-09-05 17:59:13.483405	2025-09-05 18:09:13.483405
01c0d0f2-f5de-4440-8dd0-6dd8d7816a61	\\xc30d040703028e512acb8189aaf066d23a01bd1b5cc330c68990e7a914bf7cb1939c3ac57ad9a7334748f3359d80b700365ff3046025610f8cd839e936b7797854f3d4b513fe8b3b20c582	2025-09-05 18:00:49.438997	2025-09-05 18:10:49.438997
71ce417c-b383-4f22-9d02-615bd075b1fe	\\xc30d040703029a1db995e202c8af72d23a01dd9014741aa5d3a31c43c633733e0a28a338be0ec0468b5de17f3fa528290c404b3434e58e53f3ae6dbfe02f621590a6416938786a2116235e	2025-09-05 19:23:35.031029	2025-09-05 19:33:35.031029
12b7f600-b6f4-454d-ba77-8940337f2398	\\xc30d040703022f25c2682dfc777166d23a015a3a17168d68268b27841638cd7a185f8a16386fc9a8225f8712d1bd33815975850c1d563cb8bb6553cabb48beeaebe8e0f9b6a441838e7f6e	2025-09-05 21:06:50.110623	2025-09-05 21:16:50.110623
b965ec36-353e-4787-ba3d-ff9359356901	\\xc30d040703025246d711c2b09aec73d23a01c90580f02ccd792555282889ccb80e2d257b96412ac6073ef8806abc950811706d5558b492d16ee0ba526b8e47a44286d62585d1606dd43a0b	2025-09-05 19:32:40.211245	2025-09-05 19:42:40.211245
5c7ffd4f-8ccc-41e1-b06b-545faaa224fd	\\xc30d0407030235a5e67f6f07b16c7ad23a01fd89ce40d6abbe51a37e0a94ae5ac774f9121fdd8e69470432f169e6ccf42d7be7b2e12595edd4964fd8b1b1651c65ce3d165f6e950c65613f	2025-09-05 19:34:15.892035	2025-09-05 19:44:15.892035
a1c369f6-b26f-4b7f-a22a-06200ea31600	\\xc30d0407030229377fee0ec675e277d23a014a14ea56e88619a122132c57e605604f75bc1230eef5d74ff91b1729cc7a7102a66bc71b1383f6a59ff33725a1dc69dbb49637931ad5948f07	2025-09-05 21:09:00.383051	2025-09-05 21:19:00.383051
2f177975-0767-4408-a47f-91085b51295a	\\xc30d040703020e62aa84604e067776d23a011c4552f2d7429f0152a6b8bd9d466f8d37c9bae8dda008204fa19e3e07ea5da43dcd1f9b16572a37f67eac5d183aec2bac69a27277ec21cc58	2025-09-05 19:35:39.698447	2025-09-05 19:45:39.698447
0ce333e9-b4e8-4c6f-ad8e-77bec4988cb0	\\xc30d040703027a59f0900523e8e177d23a0133522b2395121eb2b80932687d7ef4981dd487a8d69b61faccaec7a7236f489ce33987c1e723da160815eec779a3becb85577bbb78a9b49c36	2025-09-05 19:36:22.065638	2025-09-05 19:46:22.065638
fe74c587-b6be-4073-a5f4-56c74378ae6e	\\xc30d0407030278f1f2efab849eef7ad23a01a60b5b5d5b0ba80ac181837492519e8957455fce5c72d1dc75325b958d6ac8bceec48fd17fa03a7a3df788efe92fe81a1f9753dbdb698c5f2c	2025-09-05 21:12:24.110083	2025-09-05 21:22:24.110083
fca5abab-0d6c-4378-9e1e-8d933444a89f	\\xc30d0407030212d96e0baf8f8c7978d23a01c92de2788a93523db5a6f15be0acbfb9c76b62d7cbd015cbf4b07bad1108132df169417541bde9bfdb7ce95a1ea8c0babfcf7e6768a914656b	2025-09-05 19:37:45.663185	2025-09-05 19:47:45.663185
03c76e89-769c-4b9b-8b67-fa89b0617c68	\\xc30d040703025171d7a21770c91678d23a017a7c4e4b31063b904d311d0498a57398a39f031f696f839d1f095827eb255324a79529c3c5c7a75cbd87eeb49f5190be0d69f1f5834911f22f	2025-09-05 19:38:01.465829	2025-09-05 19:48:01.465829
a800e9cb-db30-42f4-b052-8d496871f43c	\\xc30d04070302fb8cd4b995eeb4e466d23a01f4eea394962554b3adf2bf69bde7ce98a6fd7d52ec5cf13d8843200a2cbf6284f387d1aa0c08323cfc1b5335e5d96c6d075b11773a16dbbdf3	2025-09-05 19:39:07.335955	2025-09-05 19:49:07.335955
4daa34b3-4a8c-43b3-bb05-d6071208a3b4	\\xc30d04070302acb49f063e891cfe64d23a015a3219f6b4035fac9e8e11f1b2a52108661a24987d06668efb82c4ccc1613278bddf2b1e608d845d2416d484fe9b716194b4f9580578782930	2025-09-05 19:41:57.298284	2025-09-05 19:51:57.298284
d6576351-bcd3-444c-9310-5de7a74824c8	\\xc30d040703020014d59703a2768978d23a0134bb837514df0e58cb91f6ff6fee8142f11da80f985ab67be0c0e2b27afff5904562901b3accbb04b7a336fb35475ecea286d9bc8bd3909c1e	2025-09-05 19:46:54.787968	2025-09-05 19:56:54.787968
cd31fb74-60d9-4722-8811-15f56ad82a5d	\\xc30d040703029f04d3040fcab43e6ed23a01b22abf3f01dc32e90604f420cf0a874227df3f7eb739075b2adfbaae9a20152f271f54fc513fe3b009b0801558ba56f3147581029c40393fc1	2025-09-05 19:51:00.590204	2025-09-05 20:01:00.590204
38f12be0-0ab0-44da-8a16-0b63c1baa5b3	\\xc30d040703024c98cee0a7656be772d23a019a8a4f5fa9d051526d5bcfc54153658040d2ac855a04d71a4f8db4b6651c388e2f6ba34fdfe29526e263314846c72b8c2a7444c986a7cdda1c	2025-09-05 19:57:31.002055	2025-09-05 20:07:31.002055
c9ac42aa-7e1c-48de-a2c9-477c60a98567	\\xc30d04070302c6a3cd49f74343d467d23a017a2f4d8119557e7812e949b3833866c348b0be02493cc91af0f1ea4d309337568c28bce47563c220a1dff5622a634b1b3c4c298ba3b0d13051	2025-09-05 20:14:55.060643	2025-09-05 20:24:55.060643
596d2335-14aa-4240-87d6-325077f72be6	\\xc30d04070302b8f1ab762a86573d6cd23a018ed6b5b20dd84d9cfe6440e2ba8c21b40cc11e762f8c1bd1cb8804fa09913b978bc2adcddf2ce0eb03a7030910ff5b150c578f71b11334f693	2025-09-05 20:16:06.066243	2025-09-05 20:26:06.066243
e02b54b1-1a26-44f5-82d8-9ad21ab30a00	\\xc30d04070302886f806eec94389867d23a01c756bbae06a0eed40f00c5689a0079ffc265f3c338103c647d70dbe91baca70c7480b77b35fdeb591e6d257c71771fb8543b754470b3ffe698	2025-09-05 20:16:20.528288	2025-09-05 20:26:20.528288
001c3d09-85fe-4a21-8e7c-baaee2f831ba	\\xc30d040703022cae9e20d6d0a69376d23a01b6dd6db7c1d86358dccbd381733728ccab5d1fb5989061002ca46988da3cbf90d14ce858ca5209fae4a7772b6d525a99cc2f8e6d610b71ca39	2025-09-05 20:16:44.41059	2025-09-05 20:26:44.41059
70fc4856-3757-41d5-a52f-fae2e72dad59	\\xc30d04070302098d7e95e6dc372b73d23a0133d36551ff472f3e2cdb19f39ee5ac07a6a5eee29bc552154e101286d643a411430dde54d8e051ea088852f02cbeb4cbb492828e0911b779f5	2025-09-05 20:21:00.869836	2025-09-05 20:31:00.869836
57a682a8-1810-49e8-8783-07ccadfef2a5	\\xc30d040703026e178f287ee589a964d23a019e522dcbfeac1e0508d75dc874dcc7529248f9f8fcddf14c3b993d7cd14e1d77f28d1232644170a73234353e8ad232a2874b4a2e974466b791	2025-09-05 20:22:08.618109	2025-09-05 20:32:08.618109
a29d9584-edfc-4761-b94b-9aa793709515	\\xc30d04070302c885868c2a3ef72d6dd23a01d11618237266f5ee3d32453466d106dadf27ea4098e601e7621d968cb95a192145dcdee4c5b597f3f0948aa5cb263755dd268131ab7e129012	2025-09-05 20:26:33.643188	2025-09-05 20:36:33.643188
4d9c479f-59c2-4a54-a8d4-0ef5987446f4	\\xc30d04070302218dfb256edf15f46cd23a017ad77b480e86527ba289f4f8667a6a5347e78b26013547141b405a93f5c630476cc4109a489011ed88fe016058279a9f3ebded35fee52767ea	2025-09-05 20:29:44.960907	2025-09-05 20:39:44.960907
b5c6cb2b-6570-443f-9d41-9526a0f56229	\\xc30d04070302e2ddd4e1d578e5bb73d23a01453e7f725d053b8ccd108affb4c7a6daacecb6c34aa1b02d18d11d1df05417a14c3ba9a859d6c0e0e5f2c626353b93a1f4df382dcf42fc6bcb	2025-09-05 20:34:09.450494	2025-09-05 20:44:09.450494
8788bb9c-3151-4f60-b845-a3cd15745846	\\xc30d04070302db71f874f3d7df596ed23a01e81c425dd2eb6d2ca3ce7a03b478a8ace72a463d38cbd0c11424a0145b2fb2246ab0c0a17b76b6fb6f54b2fe073ba5cec3eba6ff5adacd5952	2025-09-05 20:40:03.462501	2025-09-05 20:50:03.462501
53f28a3a-b72b-4766-8631-93846eca8a33	\\xc30d0407030228c7777ed5f2b4c77bd23a01c674ea29a9e4dd015f71d960fdbcec0873abb12e4dd62f9adc0073b5c50db5c1afba0f2b218ba57e783978b82059f9ecbb7a8c3c322820f385	2025-09-05 20:45:01.034196	2025-09-05 20:55:01.034196
77dc8c84-8703-40c7-baab-f0b6271dc186	\\xc30d04070302a2d879321ad81d5375d23a01950867f0f38faf9d9eb339bae1bc33de119cb9ad28b8da225f1bc0f2d79ff443073663a2759a666e7daba5ececd5660c40f0c9e2ecf14c8836	2025-09-05 20:46:35.321161	2025-09-05 20:56:35.321161
48268efc-f297-4161-a215-ca1717557241	\\xc30d0407030228c7c9b32e408b8864d23a01a327303ce9200d41a673866adf281d9646b4726351ceea227829d8033b47e6340012ae070a85737045d14d4c40aefc489ecf96f1e665c6b40d	2025-09-05 20:51:45.957955	2025-09-05 21:01:45.957955
9c17915d-fa55-4c60-aff6-ab20648ae676	\\xc30d04070302e1ace3f0c5ffe4246ed23a0115576a75aa50b2e1655711880865cc961d90db12bedc547d432cef280efd72faec1210a95cbffe530cc5ac363e49fdd2c03d64579397552baf	2025-09-05 20:54:19.750633	2025-09-05 21:04:19.750633
6bd2ed82-d21a-484c-b272-f91341153980	\\xc30d040703026516a10d1e0b46c974d23a01774252497d0d9b5325c666b9b4b830094cdf834794bc0caf771fe511b1d13b81254bcec2f3d3fb21ba17b89fc6c13e31571a53b7819931ea5e	2025-09-05 20:55:11.217974	2025-09-05 21:05:11.217974
0c106102-d2c8-450e-af0c-1c680a79e82f	\\xc30d0407030278accbf885347de26dd23a01fef006fb757e646fabd4496ad59622f22dea04ac80878d4f5b95826ef63c227184e8666db9e3b4920abd14d9dea3b29fe2de722156bda6f906	2025-09-05 20:56:44.449097	2025-09-05 21:06:44.449097
\.


--
-- Data for Name: tableprefixes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tableprefixes (prefixid, humanreadableid, tablename, tableprefix, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
23	\N	tableprefixes	TP	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
24	\N	recordstatuses	REC	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
25	\N	sexes	SX	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
26	\N	prefixsuffix	PS	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
27	\N	vendors	VEN	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
28	\N	phones	PHN	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
29	\N	coreidentity	CI	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
30	\N	adjudications	ADJ	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
31	\N	aliases	AL	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
32	\N	assignments	ASN	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
33	\N	assignmenttypes	AST	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
34	\N	contacts	CON	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
35	\N	contacttypes	CT	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
36	\N	contracts	CTR	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
37	\N	contracttypes	CTT	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
38	\N	geography	GEO	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
39	\N	geographytypes	GET	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
40	\N	pointsofcontact	POC	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
41	\N	emailaddresses	EML	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
42	\N	postaladdresses	PAD	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
43	\N	organizations	ORG	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
44	\N	organizationtypes	ORT	0	2025-09-05 19:29:49.656271	::0	0	2025-09-05 19:29:49.656271	::0	\N	\N	\N
\.


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vendors (vendorid, humanreadableid, vendorname, contactpersonname, address1, address2, city, state, zipcode, phone, email, website, taxid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: vendorwebsites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vendorwebsites (vendorwebsiteid, vendorid, websiteid, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Data for Name: websites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.websites (websiteid, humanreadableid, websiteurl, recordstatusid, createdby, createddate, createdip, modifiedby, modifieddate, modifiedip, deletedby, deleteddate, deletedip) FROM stdin;
\.


--
-- Name: adjudications_adjudicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.adjudications_adjudicationid_seq', 1, false);


--
-- Name: aliases_aliasid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.aliases_aliasid_seq', 1, false);


--
-- Name: assignments_assignmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.assignments_assignmentid_seq', 1, false);


--
-- Name: assignmentstatuses_assignmentstatusid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.assignmentstatuses_assignmentstatusid_seq', 1, false);


--
-- Name: assignmenttypes_assignmenttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.assignmenttypes_assignmenttypeid_seq', 1, false);


--
-- Name: callsandorders_callsandordersid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.callsandorders_callsandordersid_seq', 1, false);


--
-- Name: contacttypes_contacttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contacttypes_contacttypeid_seq', 8, true);


--
-- Name: contracts_contractid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contracts_contractid_seq', 1, false);


--
-- Name: contracttypes_contracttypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contracttypes_contracttypeid_seq', 1, false);


--
-- Name: coreidentity_coreidentityid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coreidentity_coreidentityid_seq', 2, true);


--
-- Name: coreidentityadjudications_coreidentityadjudicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coreidentityadjudications_coreidentityadjudicationid_seq', 1, false);


--
-- Name: coreidentityemails_coreidentityemailid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coreidentityemails_coreidentityemailid_seq', 1, false);


--
-- Name: coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coreidentityinvestigationrequ_coreidentityinvestigationrequ_seq', 1, false);


--
-- Name: coreidentityphones_coreidentityphoneid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coreidentityphones_coreidentityphoneid_seq', 1, false);


--
-- Name: coreidentitypostaladdresses_coreidentitypostaladdressid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coreidentitypostaladdresses_coreidentitypostaladdressid_seq', 1, false);


--
-- Name: coreidentitysocialmedia_coreidentitysocialmediaid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coreidentitysocialmedia_coreidentitysocialmediaid_seq', 1, false);


--
-- Name: countries_countryid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.countries_countryid_seq', 1, false);


--
-- Name: countrycodes_countrycodeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.countrycodes_countrycodeid_seq', 1, false);


--
-- Name: defaultitems_defaultitemid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.defaultitems_defaultitemid_seq', 3, true);


--
-- Name: emails_emailid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.emails_emailid_seq', 1, false);


--
-- Name: emergencycontacts_emergencycontactid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.emergencycontacts_emergencycontactid_seq', 1, false);


--
-- Name: formtypes_formtypesid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.formtypes_formtypesid_seq', 1, false);


--
-- Name: geography_geographyid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.geography_geographyid_seq', 571, true);


--
-- Name: geographytypes_geographytypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.geographytypes_geographytypeid_seq', 6, true);


--
-- Name: investigationrequest_investigationrequestid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.investigationrequest_investigationrequestid_seq', 1, false);


--
-- Name: menuitems_menuitemid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menuitems_menuitemid_seq', 10, true);


--
-- Name: menuitemtypes_menuitemtypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menuitemtypes_menuitemtypeid_seq', 2, true);


--
-- Name: organizations_organizationid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organizations_organizationid_seq', 1, false);


--
-- Name: organizationshistory_organizationshistoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organizationshistory_organizationshistoryid_seq', 1, false);


--
-- Name: organizationtypes_organizationtypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organizationtypes_organizationtypeid_seq', 1, false);


--
-- Name: organizationwebsites_organizationwebsiteid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organizationwebsites_organizationwebsiteid_seq', 1, false);


--
-- Name: packageformevents_packageformeventsid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.packageformevents_packageformeventsid_seq', 1, false);


--
-- Name: packages_packagesid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.packages_packagesid_seq', 1, false);


--
-- Name: packagetypes_packagetypesid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.packagetypes_packagetypesid_seq', 1, false);


--
-- Name: phones_phoneid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.phones_phoneid_seq', 1, false);


--
-- Name: pointsofcontact_pointofcontactid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pointsofcontact_pointofcontactid_seq', 1, false);


--
-- Name: pointsofcontactemails_pointsofcontactemailid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pointsofcontactemails_pointsofcontactemailid_seq', 1, false);


--
-- Name: pointsofcontactphones_pointsofcontactphoneid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pointsofcontactphones_pointsofcontactphoneid_seq', 1, false);


--
-- Name: postaladdresses_postaladdressid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.postaladdresses_postaladdressid_seq', 1, false);


--
-- Name: prefixsuffix_prefixsuffixid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.prefixsuffix_prefixsuffixid_seq', 60, true);


--
-- Name: recordstatuses_recordstatusid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recordstatuses_recordstatusid_seq', 1, false);


--
-- Name: relationshiptypes_relationshiptypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.relationshiptypes_relationshiptypeid_seq', 1, false);


--
-- Name: serviceproviders_serviceproviderid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.serviceproviders_serviceproviderid_seq', 1, false);


--
-- Name: sexes_sexid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sexes_sexid_seq', 1, false);


--
-- Name: socialmedia_socialmediaid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.socialmedia_socialmediaid_seq', 1, false);


--
-- Name: tableprefixes_prefixid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tableprefixes_prefixid_seq', 44, true);


--
-- Name: vendors_vendorid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendors_vendorid_seq', 1, false);


--
-- Name: vendorwebsites_vendorwebsiteid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.vendorwebsites_vendorwebsiteid_seq', 1, false);


--
-- Name: websites_websiteid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.websites_websiteid_seq', 1, false);


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: adjudications adjudications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjudications
    ADD CONSTRAINT adjudications_pkey PRIMARY KEY (adjudicationid);


--
-- Name: aliases aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aliases
    ADD CONSTRAINT aliases_pkey PRIMARY KEY (aliasid);


--
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (assignmentid);


--
-- Name: assignmentstatuses assignmentstatuses_assignmentstatusname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignmentstatuses
    ADD CONSTRAINT assignmentstatuses_assignmentstatusname_key UNIQUE (assignmentstatusname);


--
-- Name: assignmentstatuses assignmentstatuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignmentstatuses
    ADD CONSTRAINT assignmentstatuses_pkey PRIMARY KEY (assignmentstatusid);


--
-- Name: assignmenttypes assignmenttypes_assignmenttypename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignmenttypes
    ADD CONSTRAINT assignmenttypes_assignmenttypename_key UNIQUE (assignmenttypename);


--
-- Name: assignmenttypes assignmenttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignmenttypes
    ADD CONSTRAINT assignmenttypes_pkey PRIMARY KEY (assignmenttypeid);


--
-- Name: callsandorders callsandorders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.callsandorders
    ADD CONSTRAINT callsandorders_pkey PRIMARY KEY (callsandordersid);


--
-- Name: contacttypes contacttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacttypes
    ADD CONSTRAINT contacttypes_pkey PRIMARY KEY (contacttypeid);


--
-- Name: contracts contracts_contractnumber_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_contractnumber_key UNIQUE (contractnumber);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (contractid);


--
-- Name: contracttypes contracttypes_contracttypename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contracttypes
    ADD CONSTRAINT contracttypes_contracttypename_key UNIQUE (contracttypename);


--
-- Name: contracttypes contracttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contracttypes
    ADD CONSTRAINT contracttypes_pkey PRIMARY KEY (contracttypeid);


--
-- Name: coreidentity coreidentity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentity
    ADD CONSTRAINT coreidentity_pkey PRIMARY KEY (coreidentityid);


--
-- Name: coreidentityadjudications coreidentityadjudications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentityadjudications
    ADD CONSTRAINT coreidentityadjudications_pkey PRIMARY KEY (coreidentityadjudicationid);


--
-- Name: coreidentityemails coreidentityemails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentityemails
    ADD CONSTRAINT coreidentityemails_pkey PRIMARY KEY (coreidentityemailid);


--
-- Name: coreidentityinvestigationrequests coreidentityinvestigationrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentityinvestigationrequests
    ADD CONSTRAINT coreidentityinvestigationrequests_pkey PRIMARY KEY (coreidentityinvestigationrequestid);


--
-- Name: coreidentityphones coreidentityphones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentityphones
    ADD CONSTRAINT coreidentityphones_pkey PRIMARY KEY (coreidentityphoneid);


--
-- Name: coreidentitypostaladdresses coreidentitypostaladdresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentitypostaladdresses
    ADD CONSTRAINT coreidentitypostaladdresses_pkey PRIMARY KEY (coreidentitypostaladdressid);


--
-- Name: coreidentitysocialmedia coreidentitysocialmedia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coreidentitysocialmedia
    ADD CONSTRAINT coreidentitysocialmedia_pkey PRIMARY KEY (coreidentitysocialmediaid);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (countryid);


--
-- Name: countrycodes countrycodes_countrycode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countrycodes
    ADD CONSTRAINT countrycodes_countrycode_key UNIQUE (countrycode);


--
-- Name: countrycodes countrycodes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countrycodes
    ADD CONSTRAINT countrycodes_pkey PRIMARY KEY (countrycodeid);


--
-- Name: defaultitems defaultitems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.defaultitems
    ADD CONSTRAINT defaultitems_pkey PRIMARY KEY (defaultitemid);


--
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (emailid);


--
-- Name: emergencycontacts emergencycontacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.emergencycontacts
    ADD CONSTRAINT emergencycontacts_pkey PRIMARY KEY (emergencycontactid);


--
-- Name: formtypes formtypes_formtypename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formtypes
    ADD CONSTRAINT formtypes_formtypename_key UNIQUE (formtypename);


--
-- Name: formtypes formtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.formtypes
    ADD CONSTRAINT formtypes_pkey PRIMARY KEY (formtypesid);


--
-- Name: geography geography_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geography
    ADD CONSTRAINT geography_pkey PRIMARY KEY (geographyid);


--
-- Name: geographytypes geographytypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geographytypes
    ADD CONSTRAINT geographytypes_pkey PRIMARY KEY (geographytypeid);


--
-- Name: investigationrequest investigationrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.investigationrequest
    ADD CONSTRAINT investigationrequest_pkey PRIMARY KEY (investigationrequestid);


--
-- Name: menuitems menuitems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitems
    ADD CONSTRAINT menuitems_pkey PRIMARY KEY (menuitemid);


--
-- Name: menuitemtypes menuitemtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitemtypes
    ADD CONSTRAINT menuitemtypes_pkey PRIMARY KEY (menuitemtypeid);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (organizationid);


--
-- Name: organizationshistory organizationshistory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizationshistory
    ADD CONSTRAINT organizationshistory_pkey PRIMARY KEY (organizationshistoryid);


--
-- Name: organizationtypes organizationtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizationtypes
    ADD CONSTRAINT organizationtypes_pkey PRIMARY KEY (organizationtypeid);


--
-- Name: organizationwebsites organizationwebsites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizationwebsites
    ADD CONSTRAINT organizationwebsites_pkey PRIMARY KEY (organizationwebsiteid);


--
-- Name: packageformevents packageformevents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packageformevents
    ADD CONSTRAINT packageformevents_pkey PRIMARY KEY (packageformeventsid);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (packagesid);


--
-- Name: packagetypes packagetypes_packagetypename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packagetypes
    ADD CONSTRAINT packagetypes_packagetypename_key UNIQUE (packagetypename);


--
-- Name: packagetypes packagetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packagetypes
    ADD CONSTRAINT packagetypes_pkey PRIMARY KEY (packagetypesid);


--
-- Name: phones phones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (phoneid);


--
-- Name: pointsofcontact pointsofcontact_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointsofcontact
    ADD CONSTRAINT pointsofcontact_pkey PRIMARY KEY (pointofcontactid);


--
-- Name: pointsofcontactemails pointsofcontactemails_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointsofcontactemails
    ADD CONSTRAINT pointsofcontactemails_pkey PRIMARY KEY (pointsofcontactemailid);


--
-- Name: pointsofcontactphones pointsofcontactphones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pointsofcontactphones
    ADD CONSTRAINT pointsofcontactphones_pkey PRIMARY KEY (pointsofcontactphoneid);


--
-- Name: postaladdresses postaladdresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.postaladdresses
    ADD CONSTRAINT postaladdresses_pkey PRIMARY KEY (postaladdressid);


--
-- Name: prefixsuffix prefixsuffix_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prefixsuffix
    ADD CONSTRAINT prefixsuffix_pkey PRIMARY KEY (prefixsuffixid);


--
-- Name: recordstatuses recordstatuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recordstatuses
    ADD CONSTRAINT recordstatuses_pkey PRIMARY KEY (recordstatusid);


--
-- Name: recordstatuses recordstatuses_statusabbreviation_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recordstatuses
    ADD CONSTRAINT recordstatuses_statusabbreviation_key UNIQUE (statusabbreviation);


--
-- Name: relationshiptypes relationshiptypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.relationshiptypes
    ADD CONSTRAINT relationshiptypes_pkey PRIMARY KEY (relationshiptypeid);


--
-- Name: serviceproviders serviceproviders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.serviceproviders
    ADD CONSTRAINT serviceproviders_pkey PRIMARY KEY (serviceproviderid);


--
-- Name: serviceproviders serviceproviders_providername_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.serviceproviders
    ADD CONSTRAINT serviceproviders_providername_key UNIQUE (providername);


--
-- Name: sexes sexes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sexes
    ADD CONSTRAINT sexes_pkey PRIMARY KEY (sexid);


--
-- Name: socialmedia socialmedia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.socialmedia
    ADD CONSTRAINT socialmedia_pkey PRIMARY KEY (socialmediaid);


--
-- Name: ssn_tokens ssn_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ssn_tokens
    ADD CONSTRAINT ssn_tokens_pkey PRIMARY KEY (token);


--
-- Name: tableprefixes tableprefixes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tableprefixes
    ADD CONSTRAINT tableprefixes_pkey PRIMARY KEY (prefixid);


--
-- Name: tableprefixes tableprefixes_tablename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tableprefixes
    ADD CONSTRAINT tableprefixes_tablename_key UNIQUE (tablename);


--
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (vendorid);


--
-- Name: vendorwebsites vendorwebsites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vendorwebsites
    ADD CONSTRAINT vendorwebsites_pkey PRIMARY KEY (vendorwebsiteid);


--
-- Name: websites websites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.websites
    ADD CONSTRAINT websites_pkey PRIMARY KEY (websiteid);


--
-- Name: defaultitems fk_defaultitems_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.defaultitems
    ADD CONSTRAINT fk_defaultitems_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: menuitems fk_menuitems_menuitemtypeid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitems
    ADD CONSTRAINT fk_menuitems_menuitemtypeid FOREIGN KEY (menuitemtypeid) REFERENCES public.menuitemtypes(menuitemtypeid);


--
-- Name: menuitems fk_menuitems_parentid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitems
    ADD CONSTRAINT fk_menuitems_parentid FOREIGN KEY (parentid) REFERENCES public.menuitems(menuitemid);


--
-- Name: menuitems fk_menuitems_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitems
    ADD CONSTRAINT fk_menuitems_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- Name: menuitemtypes fk_menuitemtypes_recordstatusid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menuitemtypes
    ADD CONSTRAINT fk_menuitemtypes_recordstatusid FOREIGN KEY (recordstatusid) REFERENCES public.recordstatuses(recordstatusid);


--
-- PostgreSQL database dump complete
--

\unrestrict EDvn0lX04mLCSSQtxDsAfXJ56B6bP6LHvvg7bNqgUOKXTaiUpInQyoQMZBcYF54

