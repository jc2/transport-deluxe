--
-- PostgreSQL database cluster dump
--

\restrict 7KWQvvPTKoSF90ZUZq94MfoOG5jD7rw1gA74mvydSzNgB2oOwLquKHsrCFxLkub

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE casdoor;
DROP DATABASE transport_deluxe;
DROP DATABASE transport_deluxe_test;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:fxAaZPkd2cNn61tz04af/g==$Xs4I4ix++EwL26tx3hQ2Nvzkp77Wet5shJhYdZwF5Jg=:fK151ztNvs7nfR2gReqZY1/IQr9gp9oOFicni6HuiIY=';

--
-- User Configurations
--








\unrestrict 7KWQvvPTKoSF90ZUZq94MfoOG5jD7rw1gA74mvydSzNgB2oOwLquKHsrCFxLkub

--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

\restrict hD5iN9NkIsYqnTgO70azqPGA0sJn0pol1R7v4ycT0XXikKTDf1hhtrGjtrUHB1l

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\unrestrict hD5iN9NkIsYqnTgO70azqPGA0sJn0pol1R7v4ycT0XXikKTDf1hhtrGjtrUHB1l
\connect template1
\restrict hD5iN9NkIsYqnTgO70azqPGA0sJn0pol1R7v4ycT0XXikKTDf1hhtrGjtrUHB1l

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\unrestrict hD5iN9NkIsYqnTgO70azqPGA0sJn0pol1R7v4ycT0XXikKTDf1hhtrGjtrUHB1l
\connect template1
\restrict hD5iN9NkIsYqnTgO70azqPGA0sJn0pol1R7v4ycT0XXikKTDf1hhtrGjtrUHB1l

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict hD5iN9NkIsYqnTgO70azqPGA0sJn0pol1R7v4ycT0XXikKTDf1hhtrGjtrUHB1l

--
-- Database "casdoor" dump
--

--
-- PostgreSQL database dump
--

\restrict dZoZjtIN8zYencgIlyh6eRccaf6Cl3kxv7JfswhpLy3yTC3E9rXAEkJhCIbLXdd

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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
-- Name: casdoor; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE casdoor WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE casdoor OWNER TO postgres;

\unrestrict dZoZjtIN8zYencgIlyh6eRccaf6Cl3kxv7JfswhpLy3yTC3E9rXAEkJhCIbLXdd
\connect casdoor
\restrict dZoZjtIN8zYencgIlyh6eRccaf6Cl3kxv7JfswhpLy3yTC3E9rXAEkJhCIbLXdd

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
-- Name: adapter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adapter (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    "table" character varying(100),
    use_same_db boolean,
    type character varying(100),
    database_type character varying(100),
    host character varying(100),
    port integer,
    "user" character varying(100),
    password character varying(150),
    database character varying(100)
);


ALTER TABLE public.adapter OWNER TO postgres;

--
-- Name: agent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agent (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    url character varying(500),
    token character varying(500),
    application character varying(100)
);


ALTER TABLE public.agent OWNER TO postgres;

--
-- Name: application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    category character varying(20),
    type character varying(20),
    scopes text,
    logo character varying(200),
    title character varying(100),
    favicon character varying(200),
    "order" integer,
    homepage_url character varying(100),
    description character varying(100),
    organization character varying(100),
    cert character varying(100),
    default_group character varying(100),
    header_html text,
    enable_password boolean,
    enable_sign_up boolean,
    enable_guest_signin boolean,
    disable_signin boolean,
    enable_signin_session boolean,
    enable_auto_signin boolean,
    enable_code_signin boolean,
    enable_exclusive_signin boolean,
    enable_saml_compress boolean,
    enable_saml_c14n10 boolean,
    enable_saml_post_binding boolean,
    disable_saml_attributes boolean,
    enable_saml_assertion_signature boolean,
    use_email_as_saml_name_id boolean,
    enable_web_authn boolean,
    enable_link_with_email boolean,
    org_choice_mode character varying(255),
    saml_reply_url character varying(500),
    providers text,
    signin_methods character varying(2000),
    signup_items character varying(3000),
    signin_items text,
    grant_types character varying(1000),
    tags text,
    saml_attributes character varying(1000),
    saml_hash_algorithm character varying(20),
    is_shared boolean,
    ip_restriction character varying(255),
    client_id character varying(100),
    client_secret character varying(100),
    client_cert character varying(100),
    redirect_uris character varying(1000),
    backchannel_logout_uri character varying(500),
    forced_redirect_origin character varying(100),
    token_format character varying(100),
    token_signing_method character varying(100),
    token_fields character varying(1000),
    token_attributes text,
    expire_in_hours double precision,
    refresh_expire_in_hours double precision,
    cookie_expire_in_hours bigint,
    signup_url character varying(200),
    signin_url character varying(200),
    forget_url character varying(200),
    affiliation_url character varying(100),
    ip_whitelist character varying(200),
    terms_of_use character varying(200),
    signup_html text,
    signin_html text,
    theme_data json,
    footer_html text,
    form_css text,
    form_css_mobile text,
    form_offset integer,
    form_side_html text,
    form_background_url character varying(200),
    form_background_url_mobile character varying(200),
    failed_signin_limit integer,
    failed_signin_frozen_time integer,
    code_resend_timeout integer,
    custom_scopes text,
    domain character varying(100),
    other_domains character varying(1000),
    upstream_host character varying(100),
    ssl_mode character varying(100),
    ssl_cert character varying(100)
);


ALTER TABLE public.application OWNER TO postgres;

--
-- Name: casbin_api_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casbin_api_rule (
    id bigint NOT NULL,
    ptype character varying(100) DEFAULT ''::character varying NOT NULL,
    v0 character varying(100) DEFAULT ''::character varying NOT NULL,
    v1 character varying(100) DEFAULT ''::character varying NOT NULL,
    v2 character varying(100) DEFAULT ''::character varying NOT NULL,
    v3 character varying(100) DEFAULT ''::character varying NOT NULL,
    v4 character varying(100) DEFAULT ''::character varying NOT NULL,
    v5 character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.casbin_api_rule OWNER TO postgres;

--
-- Name: casbin_api_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.casbin_api_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.casbin_api_rule_id_seq OWNER TO postgres;

--
-- Name: casbin_api_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.casbin_api_rule_id_seq OWNED BY public.casbin_api_rule.id;


--
-- Name: casbin_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casbin_rule (
    id bigint NOT NULL,
    ptype character varying(100) DEFAULT ''::character varying NOT NULL,
    v0 character varying(100) DEFAULT ''::character varying NOT NULL,
    v1 character varying(100) DEFAULT ''::character varying NOT NULL,
    v2 character varying(100) DEFAULT ''::character varying NOT NULL,
    v3 character varying(100) DEFAULT ''::character varying NOT NULL,
    v4 character varying(100) DEFAULT ''::character varying NOT NULL,
    v5 character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.casbin_rule OWNER TO postgres;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.casbin_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.casbin_rule_id_seq OWNER TO postgres;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.casbin_rule_id_seq OWNED BY public.casbin_rule.id;


--
-- Name: casbin_user_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.casbin_user_rule (
    id bigint NOT NULL,
    ptype character varying(100) DEFAULT ''::character varying NOT NULL,
    v0 character varying(100) DEFAULT ''::character varying NOT NULL,
    v1 character varying(100) DEFAULT ''::character varying NOT NULL,
    v2 character varying(100) DEFAULT ''::character varying NOT NULL,
    v3 character varying(100) DEFAULT ''::character varying NOT NULL,
    v4 character varying(100) DEFAULT ''::character varying NOT NULL,
    v5 character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.casbin_user_rule OWNER TO postgres;

--
-- Name: casbin_user_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.casbin_user_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.casbin_user_rule_id_seq OWNER TO postgres;

--
-- Name: casbin_user_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.casbin_user_rule_id_seq OWNED BY public.casbin_user_rule.id;


--
-- Name: cert; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cert (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    scope character varying(100),
    type character varying(100),
    crypto_algorithm character varying(100),
    bit_size integer,
    expire_in_years integer,
    expire_time character varying(100),
    domain_expire_time character varying(100),
    provider character varying(100),
    account character varying(100),
    access_key character varying(100),
    access_secret character varying(100),
    certificate text,
    private_key text
);


ALTER TABLE public.cert OWNER TO postgres;

--
-- Name: coupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coupon (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    description character varying(500),
    code character varying(100),
    discount_type character varying(20),
    discount double precision,
    max_discount double precision,
    scope character varying(20),
    products character varying(2000),
    users character varying(2000),
    quantity integer,
    used_count integer,
    max_usage_per_user integer,
    start_time character varying(100),
    expire_time character varying(100),
    min_order_amount double precision,
    currency character varying(100),
    state character varying(20)
);


ALTER TABLE public.coupon OWNER TO postgres;

--
-- Name: coupon_usage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coupon_usage (
    id integer NOT NULL,
    owner character varying(100),
    coupon_owner character varying(100),
    coupon_name character varying(100),
    "user" character varying(100),
    "order" character varying(100),
    created_time character varying(100),
    amount double precision
);


ALTER TABLE public.coupon_usage OWNER TO postgres;

--
-- Name: coupon_usage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coupon_usage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coupon_usage_id_seq OWNER TO postgres;

--
-- Name: coupon_usage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coupon_usage_id_seq OWNED BY public.coupon_usage.id;


--
-- Name: enforcer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enforcer (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    description character varying(100),
    model character varying(100),
    adapter character varying(100),
    enforcer text
);


ALTER TABLE public.enforcer OWNER TO postgres;

--
-- Name: entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.entry (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    provider character varying(100),
    application character varying(100),
    type character varying(100),
    client_ip character varying(100),
    user_agent character varying(500),
    message text
);


ALTER TABLE public.entry OWNER TO postgres;

--
-- Name: form; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.form (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    type character varying(100),
    tag character varying(100),
    form_items character varying(5000)
);


ALTER TABLE public.form OWNER TO postgres;

--
-- Name: group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."group" (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    manager character varying(100),
    contact_email character varying(100),
    type character varying(100),
    parent_id character varying(100),
    is_top_group boolean,
    title character varying(255),
    key character varying(255),
    children text,
    is_enabled boolean
);


ALTER TABLE public."group" OWNER TO postgres;

--
-- Name: invitation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invitation (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    code character varying(100),
    is_regexp boolean,
    quota integer,
    used_count integer,
    application character varying(100),
    username character varying(100),
    email character varying(100),
    phone character varying(100),
    signup_group character varying(100),
    default_code character varying(100),
    state character varying(100)
);


ALTER TABLE public.invitation OWNER TO postgres;

--
-- Name: key; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.key (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    type character varying(100),
    organization character varying(100),
    application character varying(100),
    "user" character varying(100),
    access_key character varying(100),
    access_secret character varying(100),
    expire_time character varying(100),
    state character varying(100)
);


ALTER TABLE public.key OWNER TO postgres;

--
-- Name: ldap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ldap (
    id character varying(100) NOT NULL,
    owner character varying(100),
    created_time character varying(100),
    server_name character varying(100),
    host character varying(100),
    port integer,
    enable_ssl boolean,
    allow_self_signed_cert boolean,
    username character varying(100),
    password character varying(100),
    base_dn character varying(500),
    filter character varying(200),
    filter_fields character varying(100),
    default_group character varying(100),
    default_groups text,
    password_type character varying(100),
    custom_attributes text,
    auto_sync integer,
    last_sync character varying(100),
    enable_groups boolean
);


ALTER TABLE public.ldap OWNER TO postgres;

--
-- Name: model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    description character varying(100),
    model_text text
);


ALTER TABLE public.model OWNER TO postgres;

--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    update_time character varying(100),
    display_name character varying(100),
    products character varying(1000),
    product_infos text,
    "user" character varying(100),
    payment character varying(100),
    price double precision,
    currency character varying(100),
    state character varying(100),
    message character varying(2000),
    coupon_name character varying(100),
    coupon_discount double precision
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: organization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organization (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    website_url character varying(100),
    logo character varying(200),
    logo_dark character varying(200),
    favicon character varying(200),
    has_privilege_consent boolean,
    password_type character varying(100),
    password_salt character varying(100),
    password_options character varying(100),
    password_obfuscator_type character varying(100),
    password_obfuscator_key character varying(100),
    password_expire_days integer,
    country_codes text,
    default_avatar character varying(200),
    use_permanent_avatar boolean,
    default_application character varying(100),
    user_types text,
    tags text,
    languages character varying(255),
    theme_data json,
    master_password character varying(200),
    default_password character varying(200),
    master_verification_code character varying(100),
    ip_whitelist character varying(200),
    init_score integer,
    enable_soft_deletion boolean,
    is_profile_public boolean,
    use_email_as_username boolean,
    enable_tour boolean,
    disable_signin boolean,
    ip_restriction character varying(255),
    nav_items text,
    user_nav_items text,
    widget_items text,
    mfa_items character varying(300),
    mfa_remember_in_hours integer,
    account_menu character varying(20),
    account_items text,
    dcr_policy character varying(100),
    ldap_attributes text,
    kerberos_realm character varying(200),
    kerberos_kdc_host character varying(200),
    kerberos_keytab text,
    kerberos_service_name character varying(100),
    org_balance double precision,
    user_balance double precision,
    balance_credit double precision,
    balance_currency character varying(100)
);


ALTER TABLE public.organization OWNER TO postgres;

--
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    provider character varying(100),
    type character varying(100),
    products character varying(1000),
    products_display_name character varying(1000),
    product_name character varying(1000),
    product_display_name character varying(1000),
    detail character varying(255),
    currency character varying(100),
    price double precision,
    "user" character varying(100),
    person_name character varying(100),
    person_id_card character varying(100),
    person_email character varying(100),
    person_phone character varying(100),
    invoice_type character varying(100),
    invoice_title character varying(100),
    invoice_tax_id character varying(100),
    invoice_remark character varying(100),
    invoice_url character varying(255),
    "order" character varying(100),
    out_order_id character varying(100),
    pay_url character varying(2000),
    success_url character varying(2000),
    state character varying(100),
    message character varying(2000)
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    description character varying(100),
    users text,
    groups text,
    roles text,
    domains text,
    model character varying(100),
    adapter character varying(100),
    resource_type character varying(100),
    resources text,
    actions text,
    effect character varying(100),
    is_enabled boolean,
    submitter character varying(100),
    approver character varying(100),
    approve_time character varying(100),
    state character varying(100)
);


ALTER TABLE public.permission OWNER TO postgres;

--
-- Name: permission_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission_rule (
    id bigint NOT NULL,
    ptype character varying(100) DEFAULT ''::character varying NOT NULL,
    v0 character varying(100) DEFAULT ''::character varying NOT NULL,
    v1 character varying(100) DEFAULT ''::character varying NOT NULL,
    v2 character varying(100) DEFAULT ''::character varying NOT NULL,
    v3 character varying(100) DEFAULT ''::character varying NOT NULL,
    v4 character varying(100) DEFAULT ''::character varying NOT NULL,
    v5 character varying(100) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.permission_rule OWNER TO postgres;

--
-- Name: permission_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permission_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permission_rule_id_seq OWNER TO postgres;

--
-- Name: permission_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permission_rule_id_seq OWNED BY public.permission_rule.id;


--
-- Name: plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plan (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    description character varying(100),
    price double precision,
    currency character varying(100),
    period character varying(100),
    product character varying(100),
    payment_providers character varying(100),
    is_enabled boolean,
    is_exclusive boolean,
    role character varying(100)
);


ALTER TABLE public.plan OWNER TO postgres;

--
-- Name: pricing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pricing (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    description character varying(100),
    plans text,
    is_enabled boolean,
    trial_duration integer,
    application character varying(100)
);


ALTER TABLE public.pricing OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    image character varying(100),
    detail character varying(1000),
    description character varying(200),
    tag character varying(100),
    currency character varying(100),
    price double precision,
    quantity integer,
    sold integer,
    is_recharge boolean,
    recharge_options character varying(500),
    disable_custom_recharge boolean,
    providers character varying(255),
    success_url character varying(1000),
    state character varying(100)
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    category character varying(100),
    type character varying(100),
    sub_type character varying(100),
    method character varying(100),
    client_id character varying(200),
    client_secret character varying(3000),
    client_id2 character varying(100),
    client_secret2 character varying(500),
    cert character varying(100),
    custom_auth_url character varying(200),
    custom_token_url character varying(200),
    custom_user_info_url character varying(200),
    custom_logout_url character varying(200),
    custom_logo character varying(200),
    scopes character varying(100),
    user_mapping character varying(500),
    http_headers character varying(500),
    host character varying(100),
    port integer,
    disable_ssl boolean,
    ssl_mode character varying(100),
    title character varying(100),
    content character varying(2000),
    receiver character varying(100),
    region_id character varying(100),
    sign_name character varying(100),
    template_code character varying(100),
    app_id character varying(100),
    endpoint character varying(1000),
    intranet_endpoint character varying(100),
    domain character varying(100),
    bucket character varying(100),
    path_prefix character varying(100),
    metadata text,
    id_p text,
    issuer_url character varying(100),
    enable_sign_authn_request boolean,
    email_regex character varying(200),
    provider_url character varying(200),
    enable_proxy boolean,
    enable_pkce boolean,
    state character varying(100)
);


ALTER TABLE public.provider OWNER TO postgres;

--
-- Name: radius_accounting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.radius_accounting (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time timestamp without time zone,
    username character varying(255),
    service_type bigint,
    nas_id character varying(255),
    nas_ip_addr character varying(255),
    nas_port_id character varying(255),
    nas_port_type bigint,
    nas_port bigint,
    framed_ip_addr character varying(255),
    framed_ip_netmask character varying(255),
    acct_session_id character varying(255),
    acct_session_time bigint,
    acct_input_total bigint,
    acct_output_total bigint,
    acct_input_packets bigint,
    acct_output_packets bigint,
    acct_terminate_cause bigint,
    last_update timestamp without time zone,
    acct_start_time timestamp without time zone,
    acct_stop_time timestamp without time zone
);


ALTER TABLE public.radius_accounting OWNER TO postgres;

--
-- Name: record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.record (
    id integer NOT NULL,
    owner character varying(100),
    name character varying(100),
    created_time character varying(100),
    organization character varying(100),
    client_ip character varying(100),
    "user" character varying(100),
    method character varying(100),
    request_uri character varying(1000),
    action character varying(1000),
    language character varying(100),
    object text,
    response text,
    status_code integer,
    is_triggered boolean
);


ALTER TABLE public.record OWNER TO postgres;

--
-- Name: record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.record_id_seq OWNER TO postgres;

--
-- Name: record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.record_id_seq OWNED BY public.record.id;


--
-- Name: resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource (
    owner character varying(100) NOT NULL,
    name character varying(180) NOT NULL,
    created_time character varying(100),
    "user" character varying(100),
    provider character varying(100),
    application character varying(100),
    tag character varying(100),
    parent character varying(100),
    file_name character varying(255),
    file_type character varying(100),
    file_format character varying(100),
    file_size integer,
    url character varying(500),
    description character varying(255)
);


ALTER TABLE public.resource OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    description character varying(100),
    users text,
    groups text,
    roles text,
    domains text,
    is_enabled boolean
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100) NOT NULL,
    updated_time character varying(100) NOT NULL,
    type character varying(100) NOT NULL,
    expressions text,
    action character varying(100) NOT NULL,
    status_code integer NOT NULL,
    reason character varying(100) NOT NULL,
    is_verbose boolean
);


ALTER TABLE public.rule OWNER TO postgres;

--
-- Name: server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.server (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    url character varying(500),
    token character varying(500),
    application character varying(100),
    tools text
);


ALTER TABLE public.server OWNER TO postgres;

--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    application character varying(100) NOT NULL,
    created_time character varying(100),
    session_id text
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    tag character varying(100),
    domain character varying(100),
    other_domains character varying(500),
    need_redirect boolean,
    disable_verbose boolean,
    rules character varying(500),
    enable_alert boolean,
    alert_interval integer,
    alert_try_times integer,
    alert_providers character varying(500),
    challenges text,
    host character varying(100),
    port integer,
    hosts character varying(1000),
    ssl_mode character varying(100),
    public_ip character varying(100),
    node character varying(100),
    is_self boolean,
    status character varying(100),
    nodes text,
    casdoor_application character varying(100)
);


ALTER TABLE public.site OWNER TO postgres;

--
-- Name: subscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    display_name character varying(100),
    created_time character varying(100),
    description character varying(100),
    "user" character varying(100),
    pricing character varying(100),
    plan character varying(100),
    payment character varying(100),
    start_time character varying(100),
    end_time character varying(100),
    period character varying(100),
    state character varying(100)
);


ALTER TABLE public.subscription OWNER TO postgres;

--
-- Name: syncer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.syncer (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    organization character varying(100),
    type character varying(100),
    database_type character varying(100),
    ssl_mode character varying(100),
    ssh_type character varying(100),
    host character varying(100),
    port integer,
    "user" character varying(100),
    password character varying(150),
    ssh_host character varying(100),
    ssh_port integer,
    ssh_user character varying(100),
    ssh_password character varying(150),
    cert character varying(100),
    database character varying(100),
    "table" character varying(100),
    table_columns text,
    affiliation_table character varying(100),
    avatar_base_url character varying(100),
    error_text text,
    sync_interval integer,
    is_read_only boolean,
    is_enabled boolean
);


ALTER TABLE public.syncer OWNER TO postgres;

--
-- Name: third_party_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.third_party_link (
    owner character varying(100) NOT NULL,
    user_name character varying(100) NOT NULL,
    provider_name character varying(100) NOT NULL,
    provider_id character varying(100) NOT NULL,
    created_time character varying(100)
);


ALTER TABLE public.third_party_link OWNER TO postgres;

--
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    display_name character varying(100),
    "user" character varying(100),
    title character varying(200),
    content text,
    state character varying(50),
    messages json
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- Name: token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    application character varying(100),
    organization character varying(100),
    "user" character varying(100),
    code character varying(100),
    access_token text,
    refresh_token text,
    access_token_hash character varying(100),
    refresh_token_hash character varying(100),
    expires_in integer,
    scope character varying(100),
    token_type character varying(100),
    code_challenge character varying(100),
    code_is_used boolean,
    code_expire_in bigint,
    resource character varying(255),
    dpop_jkt character varying(255)
);


ALTER TABLE public.token OWNER TO postgres;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    display_name character varying(100),
    application character varying(100),
    domain character varying(1000),
    category character varying(100),
    type character varying(100),
    subtype character varying(100),
    provider character varying(100),
    "user" character varying(100),
    tag character varying(100),
    amount double precision,
    currency character varying(100),
    payment character varying(100),
    state character varying(100)
);


ALTER TABLE public.transaction OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    owner character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    deleted_time character varying(100),
    id character varying(100),
    external_id character varying(100),
    type character varying(100),
    password character varying(150),
    password_salt character varying(100),
    password_type character varying(100),
    display_name character varying(100),
    first_name character varying(100),
    last_name character varying(100),
    avatar text,
    avatar_type character varying(100),
    permanent_avatar character varying(500),
    email character varying(100),
    email_verified boolean,
    phone character varying(100),
    country_code character varying(6),
    region character varying(100),
    location character varying(100),
    address text,
    addresses bytea,
    affiliation character varying(100),
    title character varying(100),
    id_card_type character varying(100),
    id_card character varying(100),
    real_name character varying(100),
    is_verified boolean,
    homepage character varying(100),
    bio character varying(100),
    tag character varying(100),
    language character varying(100),
    gender character varying(100),
    birthday character varying(100),
    education character varying(100),
    score integer,
    karma integer,
    ranking integer,
    balance double precision,
    balance_credit double precision,
    currency character varying(100),
    balance_currency character varying(100),
    is_default_avatar boolean,
    is_online boolean,
    is_admin boolean,
    is_forbidden boolean,
    is_deleted boolean,
    signup_application character varying(100),
    hash character varying(100),
    pre_hash character varying(100),
    register_type character varying(100),
    register_source character varying(100),
    access_token text,
    original_token text,
    original_refresh_token text,
    created_ip character varying(100),
    last_signin_time character varying(100),
    last_signin_ip character varying(100),
    github character varying(100),
    google character varying(100),
    qq character varying(100),
    wechat character varying(100),
    facebook character varying(100),
    dingtalk character varying(100),
    weibo character varying(100),
    gitee character varying(100),
    linkedin character varying(100),
    wecom character varying(100),
    lark character varying(100),
    gitlab character varying(100),
    adfs character varying(100),
    baidu character varying(100),
    alipay character varying(100),
    casdoor character varying(100),
    infoflow character varying(100),
    apple character varying(100),
    azuread character varying(100),
    azureadb2c character varying(100),
    slack character varying(100),
    steam character varying(100),
    bilibili character varying(100),
    okta character varying(100),
    douyin character varying(100),
    kwai character varying(100),
    line character varying(100),
    amazon character varying(100),
    auth0 character varying(100),
    battlenet character varying(100),
    bitbucket character varying(100),
    box character varying(100),
    cloudfoundry character varying(100),
    dailymotion character varying(100),
    deezer character varying(100),
    digitalocean character varying(100),
    discord character varying(100),
    dropbox character varying(100),
    eveonline character varying(100),
    fitbit character varying(100),
    gitea character varying(100),
    heroku character varying(100),
    influxcloud character varying(100),
    instagram character varying(100),
    intercom character varying(100),
    kakao character varying(100),
    lastfm character varying(100),
    mailru character varying(100),
    meetup character varying(100),
    microsoftonline character varying(100),
    naver character varying(100),
    nextcloud character varying(100),
    onedrive character varying(100),
    oura character varying(100),
    patreon character varying(100),
    paypal character varying(100),
    salesforce character varying(100),
    shopify character varying(100),
    soundcloud character varying(100),
    spotify character varying(100),
    strava character varying(100),
    stripe character varying(100),
    telegram character varying(100),
    tiktok character varying(100),
    tumblr character varying(100),
    twitch character varying(100),
    twitter character varying(100),
    typetalk character varying(100),
    uber character varying(100),
    vk character varying(100),
    wepay character varying(100),
    xero character varying(100),
    yahoo character varying(100),
    yammer character varying(100),
    yandex character varying(100),
    zoom character varying(100),
    metamask character varying(100),
    web3onboard character varying(100),
    custom character varying(100),
    custom2 text,
    custom3 text,
    custom4 text,
    custom5 text,
    custom6 text,
    custom7 text,
    custom8 text,
    custom9 text,
    custom10 text,
    "webauthnCredentials" bytea,
    preferred_mfa_type character varying(100),
    recovery_codes text,
    totp_secret character varying(100),
    mfa_phone_enabled boolean,
    mfa_email_enabled boolean,
    mfa_radius_enabled boolean,
    mfa_radius_username character varying(100),
    mfa_radius_provider character varying(100),
    mfa_push_enabled boolean,
    mfa_push_receiver character varying(100),
    mfa_push_provider character varying(100),
    invitation character varying(100),
    invitation_code character varying(100),
    face_ids text,
    cart text,
    ldap character varying(100),
    properties text,
    roles text,
    permissions text,
    groups text,
    last_change_password_time character varying(100),
    last_signin_wrong_time character varying(100),
    signin_wrong_times integer,
    "managedAccounts" bytea,
    "mfaAccounts" bytea,
    mfa_items character varying(300),
    mfa_remember_deadline character varying(100),
    need_update_password boolean,
    ip_whitelist character varying(200),
    application_scopes text
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: verification_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification_record (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    remote_addr character varying(100),
    type character varying(10),
    "user" character varying(100) NOT NULL,
    provider character varying(100) NOT NULL,
    receiver character varying(100) NOT NULL,
    code character varying(10) NOT NULL,
    "time" bigint NOT NULL,
    is_used boolean NOT NULL
);


ALTER TABLE public.verification_record OWNER TO postgres;

--
-- Name: webhook; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhook (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    organization character varying(100),
    url character varying(200),
    method character varying(100),
    content_type character varying(100),
    headers text,
    events character varying(1000),
    token_fields character varying(1000),
    object_fields character varying(1000),
    is_user_extended boolean,
    single_org_only boolean,
    is_enabled boolean,
    max_retries integer DEFAULT 3,
    retry_interval integer DEFAULT 60,
    use_exponential_backoff boolean
);


ALTER TABLE public.webhook OWNER TO postgres;

--
-- Name: webhook_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.webhook_event (
    owner character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    created_time character varying(100),
    updated_time character varying(100),
    webhook character varying(200),
    organization character varying(100),
    event_type character varying(100),
    state character varying(50),
    payload text,
    extended_user text,
    attempt_count integer DEFAULT 0,
    max_retries integer DEFAULT 3,
    next_retry_time character varying(100),
    last_status_code integer,
    last_response text,
    last_error text
);


ALTER TABLE public.webhook_event OWNER TO postgres;

--
-- Name: casbin_api_rule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casbin_api_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_api_rule_id_seq'::regclass);


--
-- Name: casbin_rule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casbin_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_rule_id_seq'::regclass);


--
-- Name: casbin_user_rule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casbin_user_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_user_rule_id_seq'::regclass);


--
-- Name: coupon_usage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupon_usage ALTER COLUMN id SET DEFAULT nextval('public.coupon_usage_id_seq'::regclass);


--
-- Name: permission_rule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_rule ALTER COLUMN id SET DEFAULT nextval('public.permission_rule_id_seq'::regclass);


--
-- Name: record id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record ALTER COLUMN id SET DEFAULT nextval('public.record_id_seq'::regclass);


--
-- Data for Name: adapter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adapter (owner, name, created_time, "table", use_same_db, type, database_type, host, port, "user", password, database) FROM stdin;
built-in	api-adapter-built-in	2026-05-10T01:14:35Z	casbin_api_rule	t				0
built-in	user-adapter-built-in	2026-05-10T01:14:35Z	casbin_user_rule	t				0
\.


--
-- Data for Name: agent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.agent (owner, name, created_time, updated_time, display_name, url, token, application) FROM stdin;
\.


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application (owner, name, created_time, display_name, category, type, scopes, logo, title, favicon, "order", homepage_url, description, organization, cert, default_group, header_html, enable_password, enable_sign_up, enable_guest_signin, disable_signin, enable_signin_session, enable_auto_signin, enable_code_signin, enable_exclusive_signin, enable_saml_compress, enable_saml_c14n10, enable_saml_post_binding, disable_saml_attributes, enable_saml_assertion_signature, use_email_as_saml_name_id, enable_web_authn, enable_link_with_email, org_choice_mode, saml_reply_url, providers, signin_methods, signup_items, signin_items, grant_types, tags, saml_attributes, saml_hash_algorithm, is_shared, ip_restriction, client_id, client_secret, client_cert, redirect_uris, backchannel_logout_uri, forced_redirect_origin, token_format, token_signing_method, token_fields, token_attributes, expire_in_hours, refresh_expire_in_hours, cookie_expire_in_hours, signup_url, signin_url, forget_url, affiliation_url, ip_whitelist, terms_of_use, signup_html, signin_html, theme_data, footer_html, form_css, form_css_mobile, form_offset, form_side_html, form_background_url, form_background_url_mobile, failed_signin_limit, failed_signin_frozen_time, code_resend_timeout, custom_scopes, domain, other_domains, upstream_host, ssl_mode, ssl_cert) FROM stdin;
admin	app-built-in	2026-05-10T01:14:34Z	Casdoor	Default	All	[]	https://cdn.casbin.org/img/casdoor-logo_1185x256.png			0	https://casdoor.org		built-in	cert-built-in			t	t	f	f	f	f	f	f	f	f	f	f	f	f	f	f			[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"None","provider":null}]	[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}]	[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"}]	[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}]	null	[]	null		f		76d934521d2fe3a09d5d	1d1c49fc2462dee5324938c0cf873a02cbbbe33d		[]			JWT		[]	null	168	0	720									\N				2				0	0	0	null		null
admin	transport-deluxe	2026-05-09T20:18:09-05:00	Transport Delux	Default	All	[]				0			transport-deluxe	cert-built-in			t	t	f	f	f	f	f	f	f	f	f	f	f	f	f	f			[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":null}]	[{"name":"Password","displayName":"Password","rule":"All"}]	[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}]	[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}]	["authorization_code","password","client_credentials","token","id_token","refresh_token"]	[]	null		f		transport-deluxe-client	transport-deluxe-secret		["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"]			JWT		[]	null	24	24	720									\N				2				5	15	0	[]		null
\.


--
-- Data for Name: casbin_api_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.casbin_api_rule (id, ptype, v0, v1, v2, v3, v4, v5) FROM stdin;
1	p	built-in	*	*	*	*	*
2	p	app	*	*	*	*	*
3	p	app-dcr	*	*	/api/login/oauth/*	*	*
4	p	app-dcr	*	*	/api/get-oauth-token	*	*
5	p	app-dcr	*	*	/api/userinfo	*	*
6	p	app-dcr	*	*	/api/get-application	*	*
7	p	*	*	POST	/api/signup	*	*
8	p	*	*	GET	/api/get-email-and-phone	*	*
9	p	*	*	POST	/api/login	*	*
10	p	*	*	GET	/api/get-app-login	*	*
11	p	*	*	POST	/api/logout	*	*
12	p	*	*	GET	/api/logout	*	*
13	p	*	*	POST	/api/sso-logout	*	*
14	p	*	*	GET	/api/sso-logout	*	*
15	p	*	*	POST	/api/callback	*	*
16	p	*	*	POST	/api/device-auth	*	*
17	p	*	*	POST	/api/cancel-device-auth	*	*
18	p	*	*	POST	/api/device-auth-complete	*	*
19	p	*	*	GET	/api/get-account	*	*
20	p	*	*	GET	/api/userinfo	*	*
21	p	*	*	GET	/api/user	*	*
22	p	*	*	GET	/api/health	*	*
23	p	*	*	*	/api/webhook	*	*
24	p	*	*	GET	/api/get-qrcode	*	*
25	p	*	*	GET	/api/get-webhook-event	*	*
26	p	*	*	GET	/api/get-captcha-status	*	*
27	p	*	*	*	/api/login/oauth	*	*
28	p	*	*	POST	/api/oauth/register	*	*
29	p	*	*	GET	/api/get-application	*	*
30	p	*	*	GET	/api/get-organization-applications	*	*
31	p	*	*	GET	/api/get-user	*	*
32	p	*	*	GET	/api/get-user-application	*	*
33	p	*	*	POST	/api/upload-users	*	*
34	p	*	*	GET	/api/get-resources	*	*
35	p	*	*	GET	/api/get-records	*	*
36	p	*	*	GET	/api/get-product	*	*
37	p	*	*	GET	/api/get-products	*	*
38	p	*	*	POST	/api/buy-product	*	*
39	p	*	*	GET	/api/get-order	*	*
40	p	*	*	GET	/api/get-orders	*	*
41	p	*	*	GET	/api/get-user-orders	*	*
42	p	*	*	GET	/api/get-payment	*	*
43	p	*	*	POST	/api/invoice-payment	*	*
44	p	*	*	POST	/api/notify-payment	*	*
45	p	*	*	POST	/api/place-order	*	*
46	p	*	*	POST	/api/cancel-order	*	*
47	p	*	*	POST	/api/pay-order	*	*
48	p	*	*	POST	/api/validate-coupon	*	*
49	p	*	*	POST	/api/unlink	*	*
50	p	*	*	POST	/api/set-password	*	*
51	p	*	*	POST	/api/send-verification-code	*	*
52	p	*	*	GET	/api/get-captcha	*	*
53	p	*	*	POST	/api/verify-captcha	*	*
54	p	*	*	POST	/api/verify-code	*	*
55	p	*	*	POST	/api/v1/traces	*	*
56	p	*	*	POST	/api/v1/metrics	*	*
57	p	*	*	POST	/api/v1/logs	*	*
58	p	*	*	POST	/api/reset-email-or-phone	*	*
59	p	*	*	POST	/api/upload-resource	*	*
60	p	*	*	GET	/.well-known/openid-configuration	*	*
61	p	*	*	GET	/.well-known/oauth-authorization-server	*	*
62	p	*	*	GET	/.well-known/oauth-protected-resource	*	*
63	p	*	*	GET	/.well-known/webfinger	*	*
64	p	*	*	*	/.well-known/jwks	*	*
65	p	*	*	GET	/.well-known/:application/openid-configuration	*	*
66	p	*	*	GET	/.well-known/:application/oauth-authorization-server	*	*
67	p	*	*	GET	/.well-known/:application/oauth-protected-resource	*	*
68	p	*	*	GET	/.well-known/:application/webfinger	*	*
69	p	*	*	*	/.well-known/:application/jwks	*	*
70	p	*	*	GET	/api/get-saml-login	*	*
71	p	*	*	POST	/api/acs	*	*
72	p	*	*	GET	/api/saml/metadata	*	*
73	p	*	*	*	/api/saml/redirect	*	*
74	p	*	*	*	/cas	*	*
75	p	*	*	*	/scim	*	*
76	p	*	*	*	/api/webauthn	*	*
77	p	*	*	GET	/api/get-release	*	*
78	p	*	*	GET	/api/get-default-application	*	*
79	p	*	*	GET	/api/get-prometheus-info	*	*
80	p	*	*	*	/api/metrics	*	*
81	p	*	*	GET	/api/get-pricing	*	*
82	p	*	*	GET	/api/get-plan	*	*
83	p	*	*	GET	/api/get-subscription	*	*
84	p	*	*	GET	/api/get-transactions	*	*
85	p	*	*	GET	/api/get-transaction	*	*
86	p	*	*	GET	/api/get-provider	*	*
87	p	*	*	GET	/api/get-organization-names	*	*
88	p	*	*	GET	/api/get-organizations	*	*
89	p	*	*	GET	/api/get-all-objects	*	*
90	p	*	*	GET	/api/get-all-actions	*	*
91	p	*	*	GET	/api/get-all-roles	*	*
92	p	*	*	GET	/api/run-casbin-command	*	*
93	p	*	*	POST	/api/refresh-engines	*	*
94	p	*	*	GET	/api/get-invitation-info	*	*
95	p	*	*	GET	/api/faceid-signin-begin	*	*
96	p	*	*	GET	/api/kerberos-login	*	*
\.


--
-- Data for Name: casbin_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.casbin_rule (id, ptype, v0, v1, v2, v3, v4, v5) FROM stdin;
\.


--
-- Data for Name: casbin_user_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.casbin_user_rule (id, ptype, v0, v1, v2, v3, v4, v5) FROM stdin;
\.


--
-- Data for Name: cert; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cert (owner, name, created_time, display_name, scope, type, crypto_algorithm, bit_size, expire_in_years, expire_time, domain_expire_time, provider, account, access_key, access_secret, certificate, private_key) FROM stdin;
admin	cert-built-in	2026-05-10T01:14:34Z	Built-in Cert	JWT	x509	RS256	4096	20							-----BEGIN CERTIFICATE-----\nMIIE3TCCAsWgAwIBAgIDAeJAMA0GCSqGSIb3DQEBCwUAMCgxDjAMBgNVBAoTBWFk\nbWluMRYwFAYDVQQDEw1jZXJ0LWJ1aWx0LWluMB4XDTI2MDUxMDAxMTQzNVoXDTQ2\nMDUxMDAxMTQzNVowKDEOMAwGA1UEChMFYWRtaW4xFjAUBgNVBAMTDWNlcnQtYnVp\nbHQtaW4wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDL5s8WLJjTpME3\n1h2fde1MoI7lTmNBk3yr6a62owXKUMzMKxf5Q29oShe8Y4SvwJkxhnG8qNGOXa5c\nm8auE8cMneWiJfmzBku9W4cIseznYX4uR51a40dGWYo/U5bdDLM68F3nuskW6RkS\naabw4/E8N2dwJqLmlgPpylI/CKsY7k+HYxBqIQ3fGc5Xgfn/JVKTknn2cnPB3Rxu\nahNo4jr6mcxMR5dvzkHylE+78augr4pDbONGf5Qav18/u60V8tiJldfEmi/Y7t8e\nO4jMeMoAK+AbuSZryoIjpqO5glvhRM5TBBsmFjqwnEw8Evvk9vNUdMHiDv5YMfH+\nw/KZrwd3oXXhTUAfkme0mL9MHlWi+SHWUWVbO7t5ZKE2LZYw5f+zpBgTfklt/PMc\nXKszyzQowr4saSyDoSjs2qpDHpNnA+g5UHtKvovCXRkhBmr+jQDB3LwlHpYZygzw\n4AK/NSfVrVRwWgBxIhX/hNblRvqhAEepTSGvS1y6Sbnl3u4zZ8pSkhsdLKv/F48G\n1OZRmyiKORQ69yMinXT8Xu1MBopQZh0wSCdXsX9IxMTCOBnCObgdszVpQYdQom+s\n55SeCCLaOm8fi/4WKQt2X/dpQ278OoeOvrAVkr3rhxdDo+T7S8kYFA68AxIywXbI\n1xi/c62AYIre3OeFiGCU0f6Mc1e/rwIDAQABoxAwDjAMBgNVHRMBAf8EAjAAMA0G\nCSqGSIb3DQEBCwUAA4ICAQAimVRFCvsPz7hwwZdGL0CCjUdrV+Q4AIfd3E5DoSpx\nZTG0JCoD1oLjdslcmn2DrtEJ2iBtGQbFnaYgJtuLhDPQnIzCNeI0g7BmA/NOPFAV\nknmp15cwM1SBqNduWylrCLSAth8jYh9pZaXLgyUc7dL5nB9M+I2aIJhQtRKB7LSM\nRlMhOLr6yv/hnG2JjjJFf7DsiBhN/MDdV5SyCmYjKI34rPl2O0uAXv4Il9szwMKc\nk5+WjS6v/3v/L7xrVisM9OYolEZ9E8cClaIQmpc66alb3QumoDRRj/V+J2bQlJoL\n1gaHUUh0qNrL7BwpF1bqYscmv+yN5ufqLiP5BXF2kXjWfzeRHTJSknhjxcHt0YaY\n8kPJEmgZddCuzPi0NXT0NnE/IVc54Ngs2MObQQcbIsg+G14D+3tpNdSn9ZXxKtUi\n5VYryqLpEo8uH+ukWV2IE4Lq1hDzZPEAWlmNNdhdBr0Dud6ygLp9VGYmiYw/E1mQ\ngvXZ7nQeNpOA5Q5crP3KTRk8ehQJmJsbFzgUG6F64WUwmyV9I3ZKIOZOMAuTbTCQ\n2jJy+Rs3jU/bhW1faRtWVUaXULuxUW504H72MpiY9wzd9ECBvHEz7nN93QMuzjaa\nMAqokb/Hg4vqkP2268iTOK0e23ZWej1KL8KucymoBEeIvfkYWww3HJBpR6iNN1d6\noQ==\n-----END CERTIFICATE-----\n	-----BEGIN RSA PRIVATE KEY-----\nMIIJKAIBAAKCAgEAy+bPFiyY06TBN9Ydn3XtTKCO5U5jQZN8q+mutqMFylDMzCsX\n+UNvaEoXvGOEr8CZMYZxvKjRjl2uXJvGrhPHDJ3loiX5swZLvVuHCLHs52F+Lked\nWuNHRlmKP1OW3QyzOvBd57rJFukZEmmm8OPxPDdncCai5pYD6cpSPwirGO5Ph2MQ\naiEN3xnOV4H5/yVSk5J59nJzwd0cbmoTaOI6+pnMTEeXb85B8pRPu/GroK+KQ2zj\nRn+UGr9fP7utFfLYiZXXxJov2O7fHjuIzHjKACvgG7kma8qCI6ajuYJb4UTOUwQb\nJhY6sJxMPBL75PbzVHTB4g7+WDHx/sPyma8Hd6F14U1AH5JntJi/TB5Vovkh1lFl\nWzu7eWShNi2WMOX/s6QYE35JbfzzHFyrM8s0KMK+LGksg6Eo7NqqQx6TZwPoOVB7\nSr6Lwl0ZIQZq/o0Awdy8JR6WGcoM8OACvzUn1a1UcFoAcSIV/4TW5Ub6oQBHqU0h\nr0tcukm55d7uM2fKUpIbHSyr/xePBtTmUZsoijkUOvcjIp10/F7tTAaKUGYdMEgn\nV7F/SMTEwjgZwjm4HbM1aUGHUKJvrOeUnggi2jpvH4v+FikLdl/3aUNu/DqHjr6w\nFZK964cXQ6Pk+0vJGBQOvAMSMsF2yNcYv3OtgGCK3tznhYhglNH+jHNXv68CAwEA\nAQKCAgADCo7FLGYdJgRxwkJP2hDvhyeKeQhW9o2x/LrL45OXCGx9kRj68UwMmKpQ\n94UHoA5I5FH29+ekQXZz0Cj++LGL2SEPMZTPXEUt7lsNwKWhb91TcGMC84fhHz3G\nIweJhYJ42xPzfGA6dMCYezXvut6iwMrMq+7bFJq7VnaylP0EUq2h/dLFWnfb/4UJ\n3hjt+s8H/3PNPrjGR/eAGBnxAwrRKREYhCrYkpF+PkMQMRMXwvaDefDL4ORDH96a\nU0DKJoSfTLpaptgW2r0+NLIeJqEQrpbZowHVMsCNKpOflTesnPuc1l9XSpaWgsZK\nURgrupk3hcRMjF+zzg7nd2G7dBZe5htZFt4dylEgAnNM6nJNf6NUhO3D9y6vvOzx\nGE3GYQS0Gn8vQ0xiLlp0AWB0z9UNtWvYc9QrQdEXNNykSxbq6PVR/fO20eISULcp\nzY5i9Dpt5MHoP8Y5DpSHPFcZKdrGyr1KtHG1rhqYUdDpez3blJQCFWIIq/+Awz1U\nPKHeUfIuHaU5X89vFqahlkMCu47br1o6QN+Hwkt0u+gnqc8A6bKuLV0hUd1UOgy8\nuAgfvodQetiTB0/LlFmVglX9E/ffI10N7JKfV8HaqlF1b/mqZnX7eP+tYCtE89aS\nq1ie1CSZfsa+ET35F2+7ZTi5KwpqyFAiNpPadqbO5a4xaGXCsQKCAQEA5Ci8ed8C\nb1XOvc++k3alSVHWOpvw1/ig2OHJZdsyHXG6cKpyKzbhufl47U5IKfVRADq5SSZh\n3KA88RMlc1Dd+h32Q3HxrXOP248QafKm2h94muOcRboZxx2WsTWM3lN5kKlcsdOQ\noIqFY/uh4oLOMlRhd0tzgWdi8Zap11rnSF8j2GulpnQlr2vpg065Bajspqw1BaIN\noh0nL4greOdzaEzwwejyJHYg0/paz5ao8QGVsBTDulc7JbSEaMJwWJXkhsaILpjQ\nA1HdEDUIbN5Ka4dAUUXUiZ2GO6EYdoOF3qfaKnxmEHtSu53cAP91t/it3EbpdREx\nOhcFSWza9i9jHwKCAQEA5MhQHMlOQmNkVF9qg9+o+uO7Z8SZJrNIvM43a7WUHcdt\nTDuKadGamosGmxvr8neprF6OUPdP/thL4cX0OrjHqb8DeH1LjcipMvoma/hnxmvt\nJy9ZqK2wcpweX/MritS22oS5X4XByFCSPunZ8MDwJzuFRxMb9ekYS6x47gNmXE8D\nS/6NpSv1q0FNAt4tc7DJpUkXmEFoTzkvDNqy1G82X/+u8re8XqRNr1OyPTXEpxwk\ntoJ/D0mEGUzOr+0tCtVYX6vrqTOJWrTntAgbD6F9AQ2uJ3NSfeSFern/M1QObvtc\nt55seXQWQiD9WQOUbzYc1XlguexRSvFKRA+CdJohcQKCAQAdqGnvkZyYalgIdmO4\neXi80iV90t14xXnrF1Z9pgOarjjlAlL66RRof1RHzKA2zAuucvO43YNlEXM6hxmc\nJsvkAlcLp1kaCeaOTMd+bitgOS0NPT8IFUvahS8cc/COyd0If+trtiubosX6HDCL\n6CLzieJthmJKVO0YqFQFiWx9DNj0/fE3dOudJPLiva3xXWb9t27g/5K0GwQH+rRj\n7/ohebbmDejD8pML2wRI7bWiNmmFzP0wULyAhzmbAINoEHv3RQFYxUZs2AxbWflx\nZWfZGGi059Xb2Z0kTSmH5krViY4jba46wD0d5EQ/4PUlZ+75rkIUlJqIiYuHYt4H\nmFtTAoIBAQDSZkH+50c4mM2ZJpL/qn5uFWexG8W5KKJZONERFlGcPV6QACXgAWrM\ne9TcawZH27LIGcGKRpdkCKlofjOImYzN2CQp+Bi20PaCMjmJjE5r1a+pHMu469tc\n26S3mxvNNqjfN7Z/WbSIM0j74PaUieuSORPt9G3/bpnwZjJkue22MNgYWIcNgusQ\nzyIy4/8q6UfY4Op5FJYIXc+eY7aY1ZpNGQhcoYr0AuiKuE8wKbWr9Z7x1ftiJLr+\nxXtDobyNvPzkJ2i4F/RW3g5ErDuu2VXr1Rf3ogAYVURIRKulGcWYXUS8fU7HN3KM\n6Gf2J+unhz1nOZQyCFoOsO8avqS79U+RAoIBAH30SLbSQGjwk014jVGB3jBB6EY/\nO9YbvfyTZMGtwTJbAa2BJXv+dPA0QoqtL++1bRIxVGzRyICEjfh0IoPsjWrAa19e\nnZp8vWYnmyRfpxkJVmEFsEWOT4MzVGsDASMLMx3vV/haAoFq9IioPvVQQwazRbwc\nS2qTaITbRHuqxHELPqSd1UN+0cd9wIjZ7bU9YNojoYmv85MCKPwW64rM7o1VZKq6\n104H+nRjMuak7P+1L2PV/ZezRpGwV+WIMQA5k9K+blKTWbijmJ0MdRBkfiN07/WB\n81O8HGx4nwU08mqzDYLbl8gcOZYkBMkB/a+kuBKIfbDHQV6/useazo2y2bs=\n-----END RSA PRIVATE KEY-----\n
\.


--
-- Data for Name: coupon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coupon (owner, name, created_time, display_name, description, code, discount_type, discount, max_discount, scope, products, users, quantity, used_count, max_usage_per_user, start_time, expire_time, min_order_amount, currency, state) FROM stdin;
\.


--
-- Data for Name: coupon_usage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coupon_usage (id, owner, coupon_owner, coupon_name, "user", "order", created_time, amount) FROM stdin;
\.


--
-- Data for Name: enforcer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enforcer (owner, name, created_time, updated_time, display_name, description, model, adapter, enforcer) FROM stdin;
built-in	api-enforcer-built-in	2026-05-10T01:14:35Z	2026-05-10 01:14:35	API Enforcer		built-in/api-model-built-in	built-in/api-adapter-built-in	\N
built-in	user-enforcer-built-in	2026-05-10T01:14:35Z	2026-05-10 01:14:35	User Enforcer		built-in/user-model-built-in	built-in/user-adapter-built-in	\N
\.


--
-- Data for Name: entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.entry (owner, name, created_time, updated_time, display_name, provider, application, type, client_ip, user_agent, message) FROM stdin;
\.


--
-- Data for Name: form; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.form (owner, name, created_time, display_name, type, tag, form_items) FROM stdin;
\.


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."group" (owner, name, created_time, updated_time, display_name, manager, contact_email, type, parent_id, is_top_group, title, key, children, is_enabled) FROM stdin;
\.


--
-- Data for Name: invitation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invitation (owner, name, created_time, updated_time, display_name, code, is_regexp, quota, used_count, application, username, email, phone, signup_group, default_code, state) FROM stdin;
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.key (owner, name, created_time, updated_time, display_name, type, organization, application, "user", access_key, access_secret, expire_time, state) FROM stdin;
\.


--
-- Data for Name: ldap; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ldap (id, owner, created_time, server_name, host, port, enable_ssl, allow_self_signed_cert, username, password, base_dn, filter, filter_fields, default_group, default_groups, password_type, custom_attributes, auto_sync, last_sync, enable_groups) FROM stdin;
ldap-built-in	built-in	2026-05-10T01:14:35Z	BuildIn LDAP Server	example.com	389	f	f	cn=buildin,dc=example,dc=com	123	ou=BuildIn,dc=example,dc=com		null		null		null	0		f
1da3428c-e3b4-44e8-ba35-d1f7afe1dc71	transport-deluxe	2026-05-11T23:47:34Z	Example LDAP Server	example.com	389	f	f	cn=admin,dc=example,dc=com	123	ou=People,dc=example,dc=com		null		null		null	0		f
\.


--
-- Data for Name: model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model (owner, name, created_time, display_name, description, model_text) FROM stdin;
built-in	api-model-built-in	2026-05-10T01:14:35Z	API Model		[request_definition]\nr = subOwner, subName, method, urlPath, objOwner, objName\n\n[policy_definition]\np = subOwner, subName, method, urlPath, objOwner, objName\n\n[role_definition]\ng = _, _\n\n[policy_effect]\ne = some(where (p.eft == allow))\n\n[matchers]\nm = (r.subOwner == p.subOwner || p.subOwner == "*") && \\\n    (r.subName == p.subName || p.subName == "*" || r.subName != "anonymous" && p.subName == "!anonymous") && \\\n    (r.method == p.method || p.method == "*") && \\\n    (keyMatch2(r.urlPath, p.urlPath) || p.urlPath == "*") && \\\n    (r.objOwner == p.objOwner || p.objOwner == "*") && \\\n    (r.objName == p.objName || p.objName == "*") || \\\n    (r.subOwner == r.objOwner && r.subName == r.objName)
built-in	user-model-built-in	2026-05-10T01:14:35Z	Built-in Model		[request_definition]\nr = sub, obj, act\n\n[policy_definition]\np = sub, obj, act\n\n[role_definition]\ng = _, _\n\n[policy_effect]\ne = some(where (p.eft == allow))\n\n[matchers]\nm = g(r.sub, p.sub) && r.obj == p.obj && r.act == p.act
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (owner, name, created_time, update_time, display_name, products, product_infos, "user", payment, price, currency, state, message, coupon_name, coupon_discount) FROM stdin;
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organization (owner, name, created_time, display_name, website_url, logo, logo_dark, favicon, has_privilege_consent, password_type, password_salt, password_options, password_obfuscator_type, password_obfuscator_key, password_expire_days, country_codes, default_avatar, use_permanent_avatar, default_application, user_types, tags, languages, theme_data, master_password, default_password, master_verification_code, ip_whitelist, init_score, enable_soft_deletion, is_profile_public, use_email_as_username, enable_tour, disable_signin, ip_restriction, nav_items, user_nav_items, widget_items, mfa_items, mfa_remember_in_hours, account_menu, account_items, dcr_policy, ldap_attributes, kerberos_realm, kerberos_kdc_host, kerberos_keytab, kerberos_service_name, org_balance, user_balance, balance_credit, balance_currency) FROM stdin;
admin	built-in	2026-05-10T01:14:34Z	Built-in Organization	https://example.com			https://cdn.casbin.org/img/casbin/favicon.ico	f	bcrypt		["AtLeast6"]			0	["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"]	https://cdn.casbin.org/img/casbin.svg	f		[]	[]	["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"]	\N					2000	f	f	f	t	f		null	null	null	null	12		[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}]	disabled	null					0	0	0	USD
admin	transport-deluxe	2026-05-10T01:14:35Z	Transport Deluxe	http://localhost:8000			https://cdn.casbin.org/img/casbin/favicon.ico	f	plain		["AtLeast6"]			0	[]	https://cdn.casbin.org/img/casbin.svg	f	transport-deluxe	null	[]	["en","es"]	\N					2000	f	f	f	t	f		null	null	null	null	12		[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}]		null					0	0	0	USD
\.


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (owner, name, created_time, display_name, provider, type, products, products_display_name, product_name, product_display_name, detail, currency, price, "user", person_name, person_id_card, person_email, person_phone, invoice_type, invoice_title, invoice_tax_id, invoice_remark, invoice_url, "order", out_order_id, pay_url, success_url, state, message) FROM stdin;
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission (owner, name, created_time, display_name, description, users, groups, roles, domains, model, adapter, resource_type, resources, actions, effect, is_enabled, submitter, approver, approve_time, state) FROM stdin;
built-in	permission-built-in	2026-05-10T01:14:34Z	Built-in Permission	Built-in Permission	["built-in/*"]	[]	[]	[]	built-in/user-model-built-in		Application	["app-built-in"]	["Read","Write","Admin"]	Allow	t	admin	admin	2026-05-10T01:14:34Z	Approved
\.


--
-- Data for Name: permission_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission_rule (id, ptype, v0, v1, v2, v3, v4, v5) FROM stdin;
1	p	built-in/*	app-built-in	Read	allow		built-in/permission-built-in
2	p	built-in/*	app-built-in	Write	allow		built-in/permission-built-in
3	p	built-in/*	app-built-in	Admin	allow		built-in/permission-built-in
\.


--
-- Data for Name: plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plan (owner, name, created_time, display_name, description, price, currency, period, product, payment_providers, is_enabled, is_exclusive, role) FROM stdin;
\.


--
-- Data for Name: pricing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pricing (owner, name, created_time, display_name, description, plans, is_enabled, trial_duration, application) FROM stdin;
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (owner, name, created_time, display_name, image, detail, description, tag, currency, price, quantity, sold, is_recharge, recharge_options, disable_custom_recharge, providers, success_url, state) FROM stdin;
\.


--
-- Data for Name: provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider (owner, name, created_time, display_name, category, type, sub_type, method, client_id, client_secret, client_id2, client_secret2, cert, custom_auth_url, custom_token_url, custom_user_info_url, custom_logout_url, custom_logo, scopes, user_mapping, http_headers, host, port, disable_ssl, ssl_mode, title, content, receiver, region_id, sign_name, template_code, app_id, endpoint, intranet_endpoint, domain, bucket, path_prefix, metadata, id_p, issuer_url, enable_sign_authn_request, email_regex, provider_url, enable_proxy, enable_pkce, state) FROM stdin;
admin	provider_captcha_default	2026-05-10T01:14:34Z	Captcha Default	Captcha	Default														null	null		0	f																	f			f	f
admin	provider_balance	2026-05-10T01:14:34Z	Balance	Payment	Balance														null	null		0	f																	f			f	f
admin	provider_payment_dummy	2026-05-10T01:14:34Z	Dummy Payment	Payment	Dummy														null	null		0	f																	f			f	f
\.


--
-- Data for Name: radius_accounting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.radius_accounting (owner, name, created_time, username, service_type, nas_id, nas_ip_addr, nas_port_id, nas_port_type, nas_port, framed_ip_addr, framed_ip_netmask, acct_session_id, acct_session_time, acct_input_total, acct_output_total, acct_input_packets, acct_output_packets, acct_terminate_cause, last_update, acct_start_time, acct_stop_time) FROM stdin;
\.


--
-- Data for Name: record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.record (id, owner, name, created_time, organization, client_ip, "user", method, request_uri, action, language, object, response, status_code, is_triggered) FROM stdin;
1	built-in	43bd9ad5-aac4-4091-b6dd-40a8cba7353b	2026-05-10T01:14:56Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-10T01:14:35Z","displayName":"Transport Deluxe","category":"","type":"","scopes":[],"logo":"https://cdn.casbin.org/img/casdoor-logo_1185x256.png","title":"","favicon":"","order":0,"homepageUrl":"https://casdoor.org","description":"Transport Deluxe Application","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Forget password link","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-10T01:14:35Z","displayName":"Transport Deluxe","websiteUrl":"http://localhost:8000","logo":"","logoDark":"","favicon":"","hasPrivilegeConsent":false,"passwordType":"plain","passwordSalt":"","passwordOptions":null,"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":[],"defaultAvatar":"","usePermanentAvatar":false,"defaultApplication":"","userTypes":null,"tags":[],"languages":null,"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":0,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":false,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":[{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.email}"},{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.name}"},{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.name}"},{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.id}"},{"name":"uid","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.id}"}],"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":[],"expireInHours":0,"refreshExpireInHours":0,"cookieExpireInHours":0,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":0,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":[],"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
2	built-in	eedf62c0-f7db-4f08-94eb-e5a11b1be52c	2026-05-10T01:15:01Z	built-in	151.101.192.223	admin	POST	/api/delete-application	delete-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-10T01:14:35Z","displayName":"Transport Deluxe","category":"","type":"","scopes":[],"logo":"https://cdn.casbin.org/img/casdoor-logo_1185x256.png","title":"","favicon":"","order":0,"homepageUrl":"https://casdoor.org","description":"Transport Deluxe Application","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Forget password link","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":null,"certPublicKey":"","tags":[],"samlAttributes":[{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.email}"},{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.name}"},{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.name}"},{"name":"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/upn","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.id}"},{"name":"uid","nameFormat":"urn:oasis:names:tc:SAML:2.0:attrname-format:uri","value":"${user.id}"}],"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":[],"expireInHours":0,"refreshExpireInHours":0,"cookieExpireInHours":0,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":0,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":[],"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
3	built-in	8df3f699-899e-4af3-b991-580b101d6bce	2026-05-10T01:15:03Z	built-in	151.101.192.223	admin	POST	/api/add-application	add-application	en	{"owner":"admin","name":"app-built-in_dnt34a","createdTime":"2026-05-09T20:15:03-05:00","displayName":"Copy Application - app-built-in_dnt34a","category":"Default","type":"All","scopes":[],"logo":"https://cdn.casbin.org/img/casdoor-logo_1185x256.png","title":"","favicon":"","order":0,"homepageUrl":"https://casdoor.org","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"None","provider":null}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":null,"organizationObj":null,"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"","clientSecret":"","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":0,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":0,"failedSigninFrozenTime":0,"codeResendTimeout":0,"customScopes":null,"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
4	built-in	74587654-63ab-40aa-9fda-479656ffe968	2026-05-10T01:15:20Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/app-built-in_dnt34a	update-application	en	{"owner":"admin","name":"app-built-in_dnt34a","createdTime":"2026-05-09T20:15:03-05:00","displayName":"Copy Application - app-built-in_dnt34a","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"https://casdoor.org","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"None","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"customCss":"","label":"","name":"Signup button","placeholder":"","visible":true}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"35b7dbb1e1cc5b398ab5","clientSecret":"0d58216029eee06007283125e8bf895ce437bce1","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":0,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
5	built-in	9e4a2680-aec9-452e-a0f5-d0ee05f9431d	2026-05-10T01:15:36Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/app-built-in_dnt34a	update-application	en	{"owner":"admin","name":"","createdTime":"2026-05-09T20:15:03-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"None","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"customCss":"","label":"","name":"Signup button","placeholder":"","visible":true}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"35b7dbb1e1cc5b398ab5","clientSecret":"0d58216029eee06007283125e8bf895ce437bce1","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":0,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"error", msg:"no columns found to be updated"}	200	t
6	built-in	2ac466bb-3815-4303-9730-c8301e49839f	2026-05-10T01:15:40Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/app-built-in_dnt34a	update-application	en	{"owner":"admin","name":"app-built-in_dnt34a","createdTime":"2026-05-09T20:15:03-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"None","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"customCss":"","label":"","name":"Signup button","placeholder":"","visible":true}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"35b7dbb1e1cc5b398ab5","clientSecret":"0d58216029eee06007283125e8bf895ce437bce1","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":0,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
7	built-in	51cd2bb1-c3d6-43b7-b5a5-8572529661ce	2026-05-10T01:15:49Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/app-built-in_dnt34a	update-application	en	{"owner":"admin","name":"app-built-in_dnt34a","createdTime":"2026-05-09T20:15:03-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":false,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"None","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"customCss":"","label":"","name":"Signup button","placeholder":"","visible":true}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"35b7dbb1e1cc5b398ab5","clientSecret":"0d58216029eee06007283125e8bf895ce437bce1","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":0,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
8	built-in	7f0f9d42-7ef4-47d8-b857-9d2f0835b49c	2026-05-10T01:15:52Z	built-in	151.101.192.223	admin	POST	/api/add-application	add-application	en	{"owner":"admin","name":"application_m65c9q","organization":"built-in","createdTime":"2026-05-09T20:15:52-05:00","displayName":"New Application - m65c9q","category":"Default","type":"All","scopes":[],"logo":"https://cdn.casbin.org/img/casdoor-logo_1185x256.png","enablePassword":true,"enableSignUp":true,"disableSignin":false,"enableSigninSession":false,"enableCodeSignin":false,"enableSamlCompress":false,"disableSamlAttributes":false,"providers":[{"name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"prompted":false,"signupGroup":"","rule":""}],"SigninMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"rule":"Random"},{"name":"Username","visible":true,"required":true,"rule":"None"},{"name":"Display name","visible":true,"required":true,"rule":"None"},{"name":"Password","visible":true,"required":true,"rule":"None"},{"name":"Confirm password","visible":true,"required":true,"rule":"None"},{"name":"Email","visible":true,"required":true,"rule":"Normal"},{"name":"Phone","visible":true,"required":true,"rule":"None"},{"name":"Agreement","visible":true,"required":true,"rule":"None"},{"name":"Signup button","visible":true,"required":true,"rule":"None"},{"name":"Providers","visible":true,"required":true,"rule":"None","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n "}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"cert":"cert-built-in","redirectUris":["http://localhost:9000/callback"],"tokenFormat":"JWT","tokenFields":[],"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"formOffset":2}	{status:"ok", msg:""}	200	t
9	built-in	c9fa0cde-6253-407e-814c-141d459443d7	2026-05-10T01:16:00Z	built-in	151.101.192.223	admin	POST	/api/delete-application	delete-application	en	{"owner":"admin","name":"app-built-in_dnt34a","createdTime":"2026-05-09T20:15:03-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":false,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"None","provider":null}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":false,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":""}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code"],"organizationObj":null,"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"35b7dbb1e1cc5b398ab5","clientSecret":"0d58216029eee06007283125e8bf895ce437bce1","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":0,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
10	built-in	43cc8af3-4976-4504-b9d3-97cc236b8211	2026-05-10T01:16:11Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/application_m65c9q	update-application	en	{"owner":"admin","name":"application_m65c9q","createdTime":"2026-05-09T20:15:52-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"4eb4f3d9bf1cb35c7248","clientSecret":"40c3f908927673ed112a14931127260130028c35","clientCert":"","redirectUris":["http://localhost:9000/callback"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
11	built-in	f60f189f-f930-4a64-9ae9-a8f19818ddd9	2026-05-10T01:16:19Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/application_m65c9q	update-application	en	{"owner":"admin","name":"application_m65c9q","createdTime":"2026-05-09T20:15:52-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"4eb4f3d9bf1cb35c7248","clientSecret":"40c3f908927673ed112a14931127260130028c35","clientCert":"","redirectUris":["http://localhost:9000/callback"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
12	built-in	8754518b-5063-424f-91ca-f1f95614f264	2026-05-10T01:16:24Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/application_m65c9q	update-application	en	{"owner":"admin","name":"application_m65c9q","createdTime":"2026-05-09T20:15:52-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":false,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"4eb4f3d9bf1cb35c7248","clientSecret":"40c3f908927673ed112a14931127260130028c35","clientCert":"","redirectUris":["http://localhost:9000/callback"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
13	built-in	56122771-f374-46ba-8a17-27aba84b6b17	2026-05-10T01:16:39Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/application_m65c9q	update-application	en	{"owner":"admin","name":"application_m65c9q","createdTime":"2026-05-09T20:15:52-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":false,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":[],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"4eb4f3d9bf1cb35c7248","clientSecret":"40c3f908927673ed112a14931127260130028c35","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
14	built-in	64c4566c-812a-4a2e-bf57-1b73a5f85ce5	2026-05-10T01:17:06Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/application_m65c9q	update-application	en	{"owner":"admin","name":"application_m65c9q","createdTime":"2026-05-09T20:15:52-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":false,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":[],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"4eb4f3d9bf1cb35c7248","clientSecret":"40c3f908927673ed112a14931127260130028c35","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
15	built-in	93f86b54-bb6a-4111-bea4-3154fdfc98e7	2026-05-10T01:17:46Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/application_m65c9q	update-application	en	{"owner":"admin","name":"application_m65c9q","createdTime":"2026-05-09T20:15:52-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":false,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":[],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"hola-mundo","clientSecret":"hola-mundo","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
16	built-in	b41e87c7-315b-4981-b205-095a1b5a4745	2026-05-10T01:18:03Z	built-in	151.101.192.223	admin	POST	/api/delete-application	delete-application	en	{"owner":"admin","name":"application_m65c9q","createdTime":"2026-05-09T20:15:52-05:00","displayName":"","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":false,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":[],"organizationObj":null,"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"hola-mundo","clientSecret":"hola-mundo","clientCert":"","redirectUris":[],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
17	built-in	cde7d403-0d62-4304-af95-131d72528d84	2026-05-10T01:18:09Z	built-in	151.101.192.223	admin	POST	/api/add-application	add-application	en	{"owner":"admin","name":"application_x7v1kn","organization":"built-in","createdTime":"2026-05-09T20:18:09-05:00","displayName":"New Application - x7v1kn","category":"Default","type":"All","scopes":[],"logo":"https://cdn.casbin.org/img/casdoor-logo_1185x256.png","enablePassword":true,"enableSignUp":true,"disableSignin":false,"enableSigninSession":false,"enableCodeSignin":false,"enableSamlCompress":false,"disableSamlAttributes":false,"providers":[{"name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"prompted":false,"signupGroup":"","rule":""}],"SigninMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"rule":"Random"},{"name":"Username","visible":true,"required":true,"rule":"None"},{"name":"Display name","visible":true,"required":true,"rule":"None"},{"name":"Password","visible":true,"required":true,"rule":"None"},{"name":"Confirm password","visible":true,"required":true,"rule":"None"},{"name":"Email","visible":true,"required":true,"rule":"Normal"},{"name":"Phone","visible":true,"required":true,"rule":"None"},{"name":"Agreement","visible":true,"required":true,"rule":"None"},{"name":"Signup button","visible":true,"required":true,"rule":"None"},{"name":"Providers","visible":true,"required":true,"rule":"None","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n "}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"cert":"cert-built-in","redirectUris":["http://localhost:9000/callback"],"tokenFormat":"JWT","tokenFields":[],"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"formOffset":2}	{status:"ok", msg:""}	200	t
18	built-in	7c86134d-aee0-4600-8d0c-6926f233f861	2026-05-10T01:18:26Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/application_x7v1kn	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"c9bcd79166b3878f6b35","clientSecret":"90e85fb684321736305c5b345861d23067f41e71","clientCert":"","redirectUris":["http://localhost:9000/callback"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
19	built-in	04de18fb-7aa6-4bd7-9cf8-09f274345d7e	2026-05-10T01:19:09Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:9000/callback"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
20	built-in	00e2a419-fa9b-49ab-ae6b-cd940539a249	2026-05-10T01:19:37Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
21	built-in	512ffe88-feae-4fef-938c-a5cc5c4157ef	2026-05-10T01:19:37Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":168,"refreshExpireInHours":168,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
22	built-in	f361ae4e-8acf-4281-9ff1-2b4be833cf27	2026-05-10T01:19:53Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"},{"name":"Verification code","displayName":"Verification code","rule":"All"},{"name":"WebAuthn","displayName":"WebAuthn","rule":"None"},{"name":"Face ID","displayName":"Face ID","rule":"None"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"None"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"None","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":24,"refreshExpireInHours":24,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
23	built-in	7cd32ebe-eedf-4d3e-acbe-0ef599164ce8	2026-05-10T01:20:04Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":24,"refreshExpireInHours":24,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
52		5d783b2f-0fd7-492e-985d-1ec5850e096e	2026-05-11T23:52:27Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
24		f0f9c48f-a810-4465-83fa-e6a1bd677107	2026-05-11T23:38:33Z		151.101.192.223		POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8003/auth/callback&responseType=code&scope=openid+profile&state=eIowK_NATsU7f5jmVZNZ4Okig0teM_TGXIH9w6UJ1t4&type=code	login	en	{"application":"transport-deluxe","organization":"built-in","username":"test-margin-configurator","password":"***","autoSignin":true,"language":"","signinMethod":"Password","type":"code"}	{status:"error", msg:"The user: built-in/test-margin-configurator doesn't exist"}	200	t
25	built-in	668b44f8-53a4-4973-8f21-6c666f1a8758	2026-05-11T23:38:39Z	built-in	151.101.192.223	admin	POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8003/auth/callback&responseType=code&scope=openid+profile&state=eIowK_NATsU7f5jmVZNZ4Okig0teM_TGXIH9w6UJ1t4&type=code	login	en	{"application":"transport-deluxe","language":"","organization":"built-in","signinMethod":"Password","type":"code"}	{status:"ok", msg:""}	200	t
26		962aafc4-77b1-49f8-81db-940e427a91d8	2026-05-11T23:38:39Z		172.18.0.8		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=authorization_code&redirect_uri=http%3A%2F%2Flocalhost%3A8003%2Fauth%2Fcallback&code=cfa4d4d781564f4a40c7&scope=openid+profile&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret	{status:"", msg:""}	200	t
28	built-in	e3d1e398-358b-4179-a4da-81f1f10bbe4c	2026-05-11T23:41:37Z	built-in	151.101.192.223	admin	POST	/api/add-user	add-user	en	{"owner":"built-in","name":"user_n34jaq","createdTime":"2026-05-11T18:41:37-05:00","type":"normal-user","password":"***","passwordSalt":"","displayName":"New User - n34jaq","avatar":"https://cdn.casbin.org/img/casbin.svg","email":"n34jaq@example.com","phone":"37279129294","countryCode":"US","address":[],"groups":[],"affiliation":"Example Inc.","tag":"staff","region":"","realName":"","isVerified":false,"isAdmin":true,"IsForbidden":false,"score":2000,"isDeleted":false,"properties":{},"signupApplication":"","registerType":"Add User","registerSource":"built-in/admin","balanceCurrency":"USD"}	{status:"error", msg:"adding a new user to the 'built-in' organization is currently disabled. Please note: all users in the 'built-in' organization are global administrators in Casdoor. Refer to the docs: https://casdoor.org/docs/basic/core-concepts#how-does-casdoor-manage-itself. If you still wish to create a user for the 'built-in' organization, go to the organization's settings page and enable the 'Has privilege consent' option."}	200	t
30	built-in	b8b69685-f015-4aa8-8b4f-e9cec710536c	2026-05-11T23:42:07Z	built-in	151.101.192.223	admin	POST	/api/add-organization	add-organization	en	{"owner":"admin","name":"organization_xkvo8c","createdTime":"2026-05-11T18:42:07-05:00","displayName":"New Organization - xkvo8c","websiteUrl":"https://door.casdoor.com","favicon":"https://cdn.casbin.org/img/favicon.png","passwordType":"bcrypt","PasswordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"Plain","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","defaultApplication":"","tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"masterPassword":"","defaultPassword":"","enableSoftDeletion":false,"isProfilePublic":true,"enableTour":true,"disableSignin":false,"mfaRememberInHours":12,"balanceCurrency":"USD","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable"},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"ID card info","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self"},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Balance","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Balance credit","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Balance currency","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin"},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable"},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable"},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Properties","visible":false,"viewRule":"Admin","modifyRule":"Admin"},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin"},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin"},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin"},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin"},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin"},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self"},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin"},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin"}]}	{status:"ok", msg:""}	200	t
31	built-in	83047167-a1dd-493a-ae41-02af19829afb	2026-05-11T23:42:10Z	built-in	151.101.192.223	admin	POST	/api/delete-organization	delete-organization	en	{"owner":"admin","name":"organization_xkvo8c","createdTime":"2026-05-11T18:42:07-05:00","displayName":"New Organization - xkvo8c","websiteUrl":"https://door.casdoor.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/favicon.png","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"Plain","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":null,"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":0,"enableSoftDeletion":false,"isProfilePublic":true,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":12,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":false,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":"USD","enableDarkLogo":false}	{status:"ok", msg:""}	200	t
32	built-in	39941c27-ba2c-4e3d-8c0f-f6556fd9a4a8	2026-05-11T23:43:44Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":24,"refreshExpireInHours":24,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
34	built-in	5d5a3d2c-2dc6-4f01-98e3-f4ae39c96147	2026-05-11T23:44:35Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"built-in","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-10T01:14:35Z","displayName":"Transport Deluxe","websiteUrl":"http://localhost:8000","logo":"","logoDark":"","favicon":"","hasPrivilegeConsent":false,"passwordType":"plain","passwordSalt":"","passwordOptions":null,"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":[],"defaultAvatar":"","usePermanentAvatar":false,"defaultApplication":"","userTypes":null,"tags":[],"languages":null,"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":0,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":false,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":24,"refreshExpireInHours":24,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
35	built-in	c973cc95-a1fd-4f55-ab0f-6797ac0de584	2026-05-11T23:44:48Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"transport-deluxe","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-10T01:14:35Z","displayName":"Transport Deluxe","websiteUrl":"http://localhost:8000","logo":"","logoDark":"","favicon":"","hasPrivilegeConsent":false,"passwordType":"plain","passwordSalt":"","passwordOptions":null,"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":[],"defaultAvatar":"","usePermanentAvatar":false,"defaultApplication":"","userTypes":null,"tags":[],"languages":null,"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":0,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":false,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":0,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":""},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":24,"refreshExpireInHours":24,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
53		474a8362-954d-4736-8392-e008766f964a	2026-05-11T23:52:28Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
54		f4eb3698-3092-48b8-9276-e8ef54106859	2026-05-11T23:52:37Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
55		7d3451c2-c969-4ed7-aa84-8cee355742cb	2026-05-11T23:53:06Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
27		80693d28-7025-4630-bf72-396f037d10db	2026-05-11T23:39:49Z		151.101.192.223		POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8003/auth/callback&responseType=code&scope=openid+profile&state=OgGJ_Suuyxs4wotHymLH6_bfTN3GWoTCqHA9c48T87E&type=code	login	en	{"application":"transport-deluxe","organization":"built-in","username":"test-margin-configurator","password":"***","autoSignin":false,"language":"","signinMethod":"Password","type":"code"}	{status:"error", msg:"The user: built-in/test-margin-configurator doesn't exist"}	200	t
29	built-in	a71f3afc-bd3d-4540-b466-3eee51887560	2026-05-11T23:41:41Z	built-in	151.101.192.223	admin	POST	/api/add-user	add-user	en	{"owner":"built-in","name":"user_tj6v1a","createdTime":"2026-05-11T18:41:41-05:00","type":"normal-user","password":"***","passwordSalt":"","displayName":"New User - tj6v1a","avatar":"https://cdn.casbin.org/img/casbin.svg","email":"tj6v1a@example.com","phone":"14935310727","countryCode":"US","address":[],"groups":[],"affiliation":"Example Inc.","tag":"staff","region":"","realName":"","isVerified":false,"isAdmin":true,"IsForbidden":false,"score":2000,"isDeleted":false,"properties":{},"signupApplication":"","registerType":"Add User","registerSource":"built-in/admin","balanceCurrency":"USD"}	{status:"error", msg:"adding a new user to the 'built-in' organization is currently disabled. Please note: all users in the 'built-in' organization are global administrators in Casdoor. Refer to the docs: https://casdoor.org/docs/basic/core-concepts#how-does-casdoor-manage-itself. If you still wish to create a user for the 'built-in' organization, go to the organization's settings page and enable the 'Has privilege consent' option."}	200	t
33		de583b9c-f993-4fc8-8d3c-f066a494011d	2026-05-11T23:43:53Z		151.101.192.223		POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8003/auth/callback&responseType=code&scope=openid+profile&state=OgGJ_Suuyxs4wotHymLH6_bfTN3GWoTCqHA9c48T87E&type=code	login	en	{"application":"transport-deluxe","organization":"built-in","username":"test-margin-configurator","password":"***","autoSignin":false,"language":"","signinMethod":"Password","type":"code"}	{status:"error", msg:"The user: built-in/test-margin-configurator doesn't exist"}	200	t
41		7694cbeb-3ffc-4d5a-81f7-84824bdbd359	2026-05-11T23:48:04Z		151.101.192.223		POST	/api/login	login	en	{"type":"unknown","application":null,"provider":null,"code":"aa447a0db10f34638163","samlRequest":null,"state":null,"invitationCode":"","redirectUri":"http://localhost:8000/callback","method":null,"codeVerifier":null}	{status:"error", msg:"The application:  does not exist"}	200	t
43	transport-deluxe	fed0b526-9efd-4700-a4ac-ef8352b91c98	2026-05-11T23:49:22Z	transport-deluxe	151.101.192.223	test-margin-configurator	POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8000/callback&responseType=code&scope=&state=&type=code	login	en	{"application":"transport-deluxe","organization":"transport-deluxe","username":"test-margin-configurator","password":"***","autoSignin":false,"language":"","signinMethod":"Password","type":"code"}	{status:"ok", msg:""}	200	t
44		38c97a2d-39e6-45a2-bdd2-b21860409140	2026-05-11T23:49:22Z		151.101.192.223		POST	/api/login	login	en	{"type":"unknown","application":null,"provider":null,"code":"3a4a386588c90c96de7b","samlRequest":null,"state":null,"invitationCode":"","redirectUri":"http://localhost:8000/callback","method":null,"codeVerifier":null}	{status:"error", msg:"The application:  does not exist"}	200	t
46		73b5baff-032e-48bd-a97e-65bc02dedb66	2026-05-11T23:50:12Z		151.101.192.223		POST	/api/login	login	en	{"type":"unknown","application":null,"provider":null,"code":"32e105762c1232521e5e","samlRequest":null,"state":null,"invitationCode":"","redirectUri":"http://localhost:8000/callback","method":null,"codeVerifier":null}	{status:"error", msg:"The application:  does not exist"}	200	t
48	transport-deluxe	9632defb-bb1b-44e8-ab4a-baea2a02881b	2026-05-11T23:51:12Z	transport-deluxe	151.101.192.223	test-margin-configurator	POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8003/auth/callback&responseType=code&scope=openid+profile&state=bbgrPKcJVWGmMANTB8eaKiC3SWI9kYFsapPNzJbBsII&type=code	login	en	{"application":"transport-deluxe","organization":"transport-deluxe","username":"test-margin-configurator","password":"***","autoSignin":false,"language":"","signinMethod":"Password","type":"code"}	{status:"ok", msg:""}	200	t
49		8975310b-b4c6-4881-8bfa-17ffe70909d0	2026-05-11T23:51:12Z		172.18.0.8		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=authorization_code&redirect_uri=http%3A%2F%2Flocalhost%3A8003%2Fauth%2Fcallback&code=896d1eb735cb31f3800a&scope=openid+profile&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret	{status:"", msg:""}	200	t
50		0ccdd9dc-c46f-495d-8cdf-22dcf98c63ed	2026-05-11T23:52:03Z		172.18.0.8		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-margin-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
51		0bac1847-97d5-44c7-bc7f-ea116acf829b	2026-05-11T23:52:20Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
36	built-in	9cad0e76-49f0-4d2c-a0f5-fdd654c349d3	2026-05-11T23:47:11Z	built-in	151.101.192.223	admin	POST	/api/update-organization?id=admin/built-in	update-organization	en	{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":12,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":"","enableDarkLogo":false}	{status:"ok", msg:""}	200	t
37	built-in	7fd43ca3-bbd3-472f-b848-fe01b71466e8	2026-05-11T23:47:12Z	built-in	151.101.192.223	admin	POST	/api/update-organization?id=admin/built-in	update-organization	en	{"owner":"admin","name":"built-in","createdTime":"2026-05-10T01:14:34Z","displayName":"Built-in Organization","websiteUrl":"https://example.com","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"bcrypt","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":["US","ES","FR","DE","GB","CN","JP","KR","VN","ID","SG","IN"],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"","userTypes":[],"tags":[],"languages":["en","es","fr","de","ja","zh","vi","pt","tr","pl","uk"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":12,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"disabled","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":"","enableDarkLogo":false}	{status:"ok", msg:""}	200	t
38	built-in	c173f770-c8da-4ceb-8e9d-ae02dc9410d1	2026-05-11T23:47:34Z	built-in	151.101.192.223	admin	POST	/api/add-ldap	add-ldap	en	{"id":"","owner":"transport-deluxe","createdTime":"","serverName":"Example LDAP Server","host":"example.com","port":389,"username":"cn=admin,dc=example,dc=com","password":"***","baseDn":"ou=People,dc=example,dc=com","autosync":0,"lastSync":""}	{status:"ok", msg:""}	200	t
39	built-in	79866952-285d-4cbb-8c3e-7ca5df97ec1e	2026-05-11T23:47:37Z	built-in	151.101.192.223	admin	POST	/api/update-organization?id=admin/transport-deluxe	update-organization	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-10T01:14:35Z","displayName":"Transport Deluxe","websiteUrl":"http://localhost:8000","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"plain","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":[],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"transport-deluxe","userTypes":null,"tags":[],"languages":["en","es"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":12,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":"","enableDarkLogo":false}	{status:"ok", msg:""}	200	t
40	transport-deluxe	6c8d5a06-d40e-4e3a-ac24-38a88e59bb52	2026-05-11T23:48:04Z	transport-deluxe	151.101.192.223	test-margin-configurator	POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8000/callback&responseType=code&scope=&state=&type=code	login	en	{"application":"transport-deluxe","organization":"transport-deluxe","username":"test-margin-configurator","password":"***","autoSignin":false,"language":"","signinMethod":"Password","type":"code"}	{status:"ok", msg:""}	200	t
42		d1c2c3e6-59f8-40a4-ad8a-a5345b4294c2	2026-05-11T23:48:50Z		151.101.192.223		POST	/api/login	login	en	{"type":"unknown","application":null,"provider":null,"code":"aa447a0db10f34638163","samlRequest":null,"state":null,"invitationCode":"","redirectUri":"http://localhost:8000/callback","method":null,"codeVerifier":null}	{status:"error", msg:"The application:  does not exist"}	200	t
45	transport-deluxe	14610862-36d6-4877-80db-7c6efe25e456	2026-05-11T23:50:12Z	transport-deluxe	151.101.192.223	test-margin-configurator	POST	/api/login?clientId=transport-deluxe-client&code_challenge=&code_challenge_method=&nonce=&redirectUri=http%3A//localhost%3A8000/callback&responseType=code&scope=&state=&type=code	login	en	{"application":"transport-deluxe","organization":"transport-deluxe","username":"test-margin-configurator","password":"***","autoSignin":false,"language":"","signinMethod":"Password","type":"code"}	{status:"ok", msg:""}	200	t
47	built-in	307774dc-e404-443a-96d6-325bc2313da7	2026-05-11T23:50:38Z	built-in	151.101.192.223	admin	POST	/api/update-application?id=admin/transport-deluxe	update-application	en	{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-09T20:18:09-05:00","displayName":"Transport Delux","category":"Default","type":"All","scopes":[],"logo":"","title":"","favicon":"","order":0,"homepageUrl":"","description":"","organization":"transport-deluxe","cert":"cert-built-in","defaultGroup":"","headerHtml":"","enablePassword":true,"enableSignUp":true,"enableGuestSignin":false,"disableSignin":false,"enableSigninSession":false,"enableAutoSignin":false,"enableCodeSignin":false,"enableExclusiveSignin":false,"enableSamlCompress":false,"enableSamlC14n10":false,"enableSamlPostBinding":false,"disableSamlAttributes":false,"enableSamlAssertionSignature":false,"useEmailAsSamlNameId":false,"enableWebAuthn":false,"enableLinkWithEmail":false,"orgChoiceMode":"","samlReplyUrl":"","providers":[{"owner":"","name":"provider_captcha_default","canSignUp":false,"canSignIn":false,"canUnlink":false,"bindingRule":null,"countryCodes":null,"prompted":false,"signupGroup":"","rule":"","provider":{"owner":"admin","name":"provider_captcha_default","createdTime":"2026-05-10T01:14:34Z","displayName":"Captcha Default","category":"Captcha","type":"Default","subType":"","method":"","clientId":"","clientSecret":"","clientId2":"","clientSecret2":"","cert":"","customAuthUrl":"","customTokenUrl":"","customUserInfoUrl":"","customLogoutUrl":"","customLogo":"","scopes":"","userMapping":null,"httpHeaders":null,"host":"","port":0,"disableSsl":false,"sslMode":"","title":"","content":"","receiver":"","regionId":"","signName":"","templateCode":"","appId":"","endpoint":"","intranetEndpoint":"","domain":"","bucket":"","pathPrefix":"","metadata":"","idP":"","issuerUrl":"","enableSignAuthnRequest":false,"emailRegex":"","providerUrl":"","enableProxy":false,"enablePkce":false,"state":""}}],"signinMethods":[{"name":"Password","displayName":"Password","rule":"All"}],"signupItems":[{"name":"ID","visible":false,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Random"},{"name":"Username","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Display name","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Confirm password","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Email","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"Normal"},{"name":"Phone","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Agreement","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Signup button","visible":true,"required":true,"prompted":false,"type":"","customCss":"","label":"","placeholder":"","options":null,"regex":"","rule":"None"},{"name":"Providers","visible":true,"required":true,"prompted":false,"type":"","customCss":".provider-img {\\n width: 30px;\\n margin: 5px;\\n }\\n .provider-big-img {\\n margin-bottom: 10px;\\n }\\n ","label":"","placeholder":"","options":null,"regex":"","rule":"small"}],"signinItems":[{"name":"Back button","visible":true,"label":"","customCss":".back-button {\\n      top: 65px;\\n      left: 15px;\\n      position: absolute;\\n}\\n.back-inner-button{}","placeholder":"","rule":"None","isCustom":false},{"name":"Languages","visible":true,"label":"","customCss":".login-languages {\\n    top: 55px;\\n    right: 5px;\\n    position: absolute;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Logo","visible":true,"label":"","customCss":".login-logo-box {}","placeholder":"","rule":"None","isCustom":false},{"name":"Signin methods","visible":true,"label":"","customCss":".signin-methods {}","placeholder":"","rule":"None","isCustom":false},{"name":"Username","visible":true,"label":"","customCss":".login-username {}\\n.login-username-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Password","visible":true,"label":"","customCss":".login-password {}\\n.login-password-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Verification code","visible":true,"label":"","customCss":".verification-code {}\\n.verification-code-input{}","placeholder":"","rule":"None","isCustom":false},{"name":"Agreement","visible":true,"label":"","customCss":".login-agreement {}","placeholder":"","rule":"None","isCustom":false},{"name":"Forgot password?","visible":true,"label":"","customCss":".login-forget-password {\\n    display: inline-flex;\\n    justify-content: space-between;\\n    width: 320px;\\n    margin-bottom: 25px;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Login button","visible":true,"label":"","customCss":".login-button-box {\\n    margin-bottom: 5px;\\n}\\n.login-button {\\n    width: 100%;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Signup link","visible":true,"label":"","customCss":".login-signup-link {\\n    margin-bottom: 24px;\\n    display: flex;\\n    justify-content: end;\\n}","placeholder":"","rule":"None","isCustom":false},{"name":"Providers","visible":true,"label":"","customCss":".provider-img {\\n      width: 30px;\\n      margin: 5px;\\n}\\n.provider-big-img {\\n      margin-bottom: 10px;\\n}","placeholder":"","rule":"small","isCustom":false}],"grantTypes":["authorization_code","password","client_credentials","token","id_token","refresh_token"],"organizationObj":{"owner":"admin","name":"transport-deluxe","createdTime":"2026-05-10T01:14:35Z","displayName":"Transport Deluxe","websiteUrl":"http://localhost:8000","logo":"","logoDark":"","favicon":"https://cdn.casbin.org/img/casbin/favicon.ico","hasPrivilegeConsent":false,"passwordType":"plain","passwordSalt":"","passwordOptions":["AtLeast6"],"passwordObfuscatorType":"","passwordObfuscatorKey":"","passwordExpireDays":0,"countryCodes":[],"defaultAvatar":"https://cdn.casbin.org/img/casbin.svg","usePermanentAvatar":false,"defaultApplication":"transport-deluxe","userTypes":null,"tags":[],"languages":["en","es"],"themeData":null,"masterPassword":"","defaultPassword":"","masterVerificationCode":"","ipWhitelist":"","initScore":2000,"enableSoftDeletion":false,"isProfilePublic":false,"useEmailAsUsername":false,"enableTour":true,"disableSignin":false,"ipRestriction":"","navItems":null,"userNavItems":null,"widgetItems":null,"mfaItems":null,"mfaRememberInHours":12,"accountMenu":"","accountItems":[{"name":"Organization","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"ID","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Name","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Display name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"First name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Last name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Avatar","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"User type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Password","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Email","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Phone","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Country code","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Country/Region","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Location","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Address","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Addresses","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Affiliation","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Title","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card type","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID card info","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Real name","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"ID verification","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Homepage","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Bio","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Tag","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Language","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Gender","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Birthday","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Education","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Balance","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance credit","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Balance currency","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Cart","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Transactions","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Score","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Karma","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Ranking","visible":true,"viewRule":"Public","modifyRule":"Self","regex":"","tab":""},{"name":"Signup application","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register type","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Register source","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Roles","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Permissions","visible":true,"viewRule":"Public","modifyRule":"Immutable","regex":"","tab":""},{"name":"Groups","visible":true,"viewRule":"Public","modifyRule":"Admin","regex":"","tab":""},{"name":"Consents","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"3rd-party logins","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Properties","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is online","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is admin","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is forbidden","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Is deleted","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Multi-factor authentication","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA items","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"WebAuthn credentials","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Last change password time","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"Managed accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Face ID","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"MFA accounts","visible":true,"viewRule":"Self","modifyRule":"Self","regex":"","tab":""},{"name":"Need update password","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""},{"name":"IP whitelist","visible":true,"viewRule":"Admin","modifyRule":"Admin","regex":"","tab":""}],"dcrPolicy":"","ldapAttributes":null,"kerberosRealm":"","kerberosKdcHost":"","kerberosKeytab":"","kerberosServiceName":"","orgBalance":0,"userBalance":0,"balanceCredit":0,"balanceCurrency":"USD"},"certPublicKey":"","tags":[],"samlAttributes":null,"samlHashAlgorithm":"","isShared":false,"ipRestriction":"","clientId":"transport-deluxe-client","clientSecret":"transport-deluxe-secret","clientCert":"","redirectUris":["http://localhost:8000/callback","http://localhost:8003/auth/callback","http://127.0.0.1:33418","https://vscode.dev/redirect"],"backchannelLogoutUri":"","forcedRedirectOrigin":"","tokenFormat":"JWT","tokenSigningMethod":"","tokenFields":[],"tokenAttributes":null,"expireInHours":24,"refreshExpireInHours":24,"cookieExpireInHours":720,"signupUrl":"","signinUrl":"","forgetUrl":"","affiliationUrl":"","ipWhitelist":"","termsOfUse":"","signupHtml":"","signinHtml":"","themeData":null,"footerHtml":"","formCss":"","formCssMobile":"","formOffset":2,"formSideHtml":"","formBackgroundUrl":"","formBackgroundUrlMobile":"","failedSigninLimit":5,"failedSigninFrozenTime":15,"codeResendTimeout":0,"customScopes":[],"domain":"","otherDomains":null,"upstreamHost":"","sslMode":"","sslCert":"","CertObj":null}	{status:"ok", msg:""}	200	t
56		eaf84f0c-35cf-4b8f-a56b-9a3504eb1f80	2026-05-11T23:53:09Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
57		85305be5-4a7f-4f87-8d17-a51b43253b34	2026-05-11T23:53:09Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
58		46fe2060-e2e8-4029-b999-2d519a628094	2026-05-11T23:53:09Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
59		f557ff21-d8b4-4f87-813c-fd9092a1cac8	2026-05-11T23:53:09Z		172.18.0.6		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-cost-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
60		07c8d139-63f6-410a-a418-c16031bc4f5f	2026-05-11T23:53:22Z		172.18.0.8		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-margin-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
61		5be845d0-0dcf-433a-a825-db1ab9ab8299	2026-05-11T23:54:33Z		172.18.0.7		POST	/api/login/oauth/access_token	login/oauth/access_token	en	grant_type=password&client_id=transport-deluxe-client&client_secret=transport-deluxe-secret&username=test-margin-configurator&password=test123&scope=openid+profile	{status:"", msg:""}	200	t
\.


--
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource (owner, name, created_time, "user", provider, application, tag, parent, file_name, file_type, file_format, file_size, url, description) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (owner, name, created_time, display_name, description, users, groups, roles, domains, is_enabled) FROM stdin;
transport-deluxe	cost-configurator	2026-05-10T01:14:35Z	Cost Configurator		["transport-deluxe/test-cost-configurator","transport-deluxe/test-super-configurator"]	null	[]	[]	t
transport-deluxe	margin-configurator	2026-05-10T01:14:35Z	Margin Configurator		["transport-deluxe/test-margin-configurator","transport-deluxe/test-super-configurator"]	null	[]	[]	t
\.


--
-- Data for Name: rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule (owner, name, created_time, updated_time, type, expressions, action, status_code, reason, is_verbose) FROM stdin;
\.


--
-- Data for Name: server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.server (owner, name, created_time, updated_time, display_name, url, token, application, tools) FROM stdin;
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (owner, name, application, created_time, session_id) FROM stdin;
built-in	admin	transport-deluxe	2026-05-11T23:38:39Z	["06abd1afa2b0cd1db6adbd83a22f9945"]
transport-deluxe	test-margin-configurator	transport-deluxe	2026-05-11T23:48:04Z	["06abd1afa2b0cd1db6adbd83a22f9945"]
\.


--
-- Data for Name: site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site (owner, name, created_time, updated_time, display_name, tag, domain, other_domains, need_redirect, disable_verbose, rules, enable_alert, alert_interval, alert_try_times, alert_providers, challenges, host, port, hosts, ssl_mode, public_ip, node, is_self, status, nodes, casdoor_application) FROM stdin;
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription (owner, name, display_name, created_time, description, "user", pricing, plan, payment, start_time, end_time, period, state) FROM stdin;
\.


--
-- Data for Name: syncer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.syncer (owner, name, created_time, organization, type, database_type, ssl_mode, ssh_type, host, port, "user", password, ssh_host, ssh_port, ssh_user, ssh_password, cert, database, "table", table_columns, affiliation_table, avatar_base_url, error_text, sync_interval, is_read_only, is_enabled) FROM stdin;
\.


--
-- Data for Name: third_party_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.third_party_link (owner, user_name, provider_name, provider_id, created_time) FROM stdin;
\.


--
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket (owner, name, created_time, updated_time, display_name, "user", title, content, state, messages) FROM stdin;
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token (owner, name, created_time, application, organization, "user", code, access_token, refresh_token, access_token_hash, refresh_token_hash, expires_in, scope, token_type, code_challenge, code_is_used, code_expire_in, resource, dpop_jkt) FROM stdin;
admin	8393a300-89cf-40de-b0af-867c1f8f2746	2026-05-11T23:38:39Z	transport-deluxe	built-in	admin	cfa4d4d781564f4a40c7	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6ImJ1aWx0LWluIiwibmFtZSI6ImFkbWluIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM0WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNFoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiNjQ5NmNjMGItY2M5My00MGY1LWI2YzctMDNiMDM3YzNiNzgwIiwidHlwZSI6Im5vcm1hbC11c2VyIiwicGFzc3dvcmQiOiIiLCJwYXNzd29yZFNhbHQiOiI5Mzg0NmVmNWIwNzVjNDQwN2M0MCIsInBhc3N3b3JkVHlwZSI6ImJjcnlwdCIsImRpc3BsYXlOYW1lIjoiQWRtaW4iLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6Imh0dHBzOi8vY2RuLmNhc2Jpbi5vcmcvaW1nL2Nhc2Jpbi5zdmciLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJhZG1pbkBleGFtcGxlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIxMjM0NTY3ODkxMCIsImNvdW50cnlDb2RlIjoiVVMiLCJyZWdpb24iOiIiLCJsb2NhdGlvbiI6IiIsImFkZHJlc3MiOltdLCJhZmZpbGlhdGlvbiI6IkV4YW1wbGUgSW5jLiIsInRpdGxlIjoiIiwiaWRDYXJkVHlwZSI6IiIsImlkQ2FyZCI6IiIsImhvbWVwYWdlIjoiIiwiYmlvIjoiIiwibGFuZ3VhZ2UiOiIiLCJnZW5kZXIiOiIiLCJiaXJ0aGRheSI6IiIsImVkdWNhdGlvbiI6IiIsInNjb3JlIjoyMDAwLCJrYXJtYSI6MCwicmFua2luZyI6MSwiaXNEZWZhdWx0QXZhdGFyIjpmYWxzZSwiaXNPbmxpbmUiOmZhbHNlLCJpc0FkbWluIjp0cnVlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiYXBwLWJ1aWx0LWluIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiJBZGQgVXNlciIsInJlZ2lzdGVyU291cmNlIjoiYnVpbHQtaW4vYWRtaW4iLCJnaXRodWIiOiIiLCJnb29nbGUiOiIiLCJxcSI6IiIsIndlY2hhdCI6IiIsImZhY2Vib29rIjoiIiwiZGluZ3RhbGsiOiIiLCJ3ZWlibyI6IiIsImdpdGVlIjoiIiwibGlua2VkaW4iOiIiLCJ3ZWNvbSI6IiIsImxhcmsiOiIiLCJnaXRsYWIiOiIiLCJjcmVhdGVkSXAiOiIxMjcuMC4wLjEiLCJsYXN0U2lnbmluVGltZSI6IiIsImxhc3RTaWduaW5JcCI6IiIsInByZWZlcnJlZE1mYVR5cGUiOiIiLCJyZWNvdmVyeUNvZGVzIjpudWxsLCJ0b3RwU2VjcmV0IjoiIiwibWZhUGhvbmVFbmFibGVkIjpmYWxzZSwibWZhRW1haWxFbmFibGVkIjpmYWxzZSwibGRhcCI6IiIsInByb3BlcnRpZXMiOnt9LCJyb2xlcyI6W10sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoic3RhZmYiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIiwiYXpwIjoidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiLCJzaWduaW5NZXRob2QiOiJQYXNzd29yZCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjY0OTZjYzBiLWNjOTMtNDBmNS1iNmM3LTAzYjAzN2MzYjc4MCIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2MjkxMTksIm5iZiI6MTc3ODU0MjcxOSwiaWF0IjoxNzc4NTQyNzE5LCJqdGkiOiJhZG1pbi84MzkzYTMwMC04OWNmLTQwZGUtYjBhZi04NjdjMWY4ZjI3NDYifQ.upMFrluNBPD0ctRCUtZUVuptoy9EUfrotX43_cOQz-JJXiLVBeDRi4hsR3ITELvTc6afGj1z4B5xHZ-Z2grLpDkscF3yUDbzJacN4rPFG-rxnR4Vc_nhUMH42NE4ZAsvYbMKtm7Zl46QQiuMoTUnosRFRLoQkI8IwhKenwejJ3objqpuPAOmrbqOZzZE9pX85ZvFpl80_QWWjzikpQAPq7P6ZfhlpjYx894teNdgqe0AvYN9FHE32ciInqTXkmIDOiAWkQEwgkkD9ajNLACOijW1JXZD8QUwtcLTjXol6-8VySp4P-znv3jF347ij2sFT2WwU-n29h1dPYiQcse2LnFH0qLh6mNciS0cPbB0JReQolpEcNs7gwEglMpRMzsB8NddpaUMOhYyqAcO581XDQb8Xys3go8DsbyXQLyQE6yQ0pzetn0wQVWCJeb_rIafy_gHoCrPsmEt-dlZtlpI0S_uYeo8poq8Gt03VBifxFFjPh_0k5wXxaRqgRowI5HbskNoydLhUt7y5LtVmQGLhVfxHR9nxWvoHeEUM6HB5Kvie9R9BKLvn00_I7ddddNukdbYHfKF_Tun7RWHT2YPX4VeUzmz5EbiL9iWAp8I-hcgVyPdMIhNydWZLG606lcVnEL7R_5j5mCGLD7Am_l23msKiSKuW7PaErvnLGQQIOI	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6ImJ1aWx0LWluIiwibmFtZSI6ImFkbWluIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM0WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNFoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiNjQ5NmNjMGItY2M5My00MGY1LWI2YzctMDNiMDM3YzNiNzgwIiwidHlwZSI6Im5vcm1hbC11c2VyIiwicGFzc3dvcmQiOiIiLCJwYXNzd29yZFNhbHQiOiI5Mzg0NmVmNWIwNzVjNDQwN2M0MCIsInBhc3N3b3JkVHlwZSI6ImJjcnlwdCIsImRpc3BsYXlOYW1lIjoiQWRtaW4iLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6Imh0dHBzOi8vY2RuLmNhc2Jpbi5vcmcvaW1nL2Nhc2Jpbi5zdmciLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJhZG1pbkBleGFtcGxlLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIxMjM0NTY3ODkxMCIsImNvdW50cnlDb2RlIjoiVVMiLCJyZWdpb24iOiIiLCJsb2NhdGlvbiI6IiIsImFkZHJlc3MiOltdLCJhZmZpbGlhdGlvbiI6IkV4YW1wbGUgSW5jLiIsInRpdGxlIjoiIiwiaWRDYXJkVHlwZSI6IiIsImlkQ2FyZCI6IiIsImhvbWVwYWdlIjoiIiwiYmlvIjoiIiwibGFuZ3VhZ2UiOiIiLCJnZW5kZXIiOiIiLCJiaXJ0aGRheSI6IiIsImVkdWNhdGlvbiI6IiIsInNjb3JlIjoyMDAwLCJrYXJtYSI6MCwicmFua2luZyI6MSwiaXNEZWZhdWx0QXZhdGFyIjpmYWxzZSwiaXNPbmxpbmUiOmZhbHNlLCJpc0FkbWluIjp0cnVlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiYXBwLWJ1aWx0LWluIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiJBZGQgVXNlciIsInJlZ2lzdGVyU291cmNlIjoiYnVpbHQtaW4vYWRtaW4iLCJnaXRodWIiOiIiLCJnb29nbGUiOiIiLCJxcSI6IiIsIndlY2hhdCI6IiIsImZhY2Vib29rIjoiIiwiZGluZ3RhbGsiOiIiLCJ3ZWlibyI6IiIsImdpdGVlIjoiIiwibGlua2VkaW4iOiIiLCJ3ZWNvbSI6IiIsImxhcmsiOiIiLCJnaXRsYWIiOiIiLCJjcmVhdGVkSXAiOiIxMjcuMC4wLjEiLCJsYXN0U2lnbmluVGltZSI6IiIsImxhc3RTaWduaW5JcCI6IiIsInByZWZlcnJlZE1mYVR5cGUiOiIiLCJyZWNvdmVyeUNvZGVzIjpudWxsLCJ0b3RwU2VjcmV0IjoiIiwibWZhUGhvbmVFbmFibGVkIjpmYWxzZSwibWZhRW1haWxFbmFibGVkIjpmYWxzZSwibGRhcCI6IiIsInByb3BlcnRpZXMiOnt9LCJyb2xlcyI6W10sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6InN0YWZmIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Iiwic2lnbmluTWV0aG9kIjoiUGFzc3dvcmQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiLCJzdWIiOiI2NDk2Y2MwYi1jYzkzLTQwZjUtYjZjNy0wM2IwMzdjM2I3ODAiLCJhdWQiOlsidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiXSwiZXhwIjoxNzc4NjI5MTE5LCJuYmYiOjE3Nzg1NDI3MTksImlhdCI6MTc3ODU0MjcxOSwianRpIjoiYWRtaW4vODM5M2EzMDAtODljZi00MGRlLWIwYWYtODY3YzFmOGYyNzQ2In0.Eu3emp3G7AMbk87qntMA948LPyobzxZyXlomRTpzF7btFdoSStl8C5eV5Spr6Yp7-qAtdxR0V_CEdjogeFEH-J2moX5FnsJNx3Mnk6uApZ4wRmdWeZGxT_G5mypoQRktNec_DFb3xZ6JDb6LMBCEMWw95uVbmXjf8C9_AckSLqIMk7R6TeEi_6HEyg2pBvoEeJ_fY8H3cYBC96YbaOXr1OBqfPPSa7krebCLWlp8YuyYjRI1SIBh82O--o9u0kHFOZSo9KGH5-EktcVn2i9xy6Zb2UcR9ZrfQ37NSS6iw7vRsI5ID_nHo97fa6gxUSndjj0VmG8mcA2G-UCfuZD6vDGRA_5FhUxqu82PbHPL96j7bU-kod6aXiNZu6MQa39YAIrhqZzP3tSoHc3roNfJRlB4gKYNEmV453Mn8jcSyqUUy8GC8Pp4PdHFkl2fS9z-XO0x4BAwzjYPs_GGCtN4LG4nxzdY29_66gdnH6F09MST05Rb97SbQwXXqmzd082PcO8trwgyyiBbiRnDjsr6wrKPtgnWsnu4V1kpmUOo1GOFJqDMCtlAzkfKuz6tKa5DnPJNqz_H87rvJ1SKUTf-k9Ol7WUwyf_FtYRQwoZpoizDG0ISil5S4LuL3Uj4SklEzEu8slk0Pg-np-01enJNSRYoqSnfRd3tMz_2cyszv5E	d0447005b8be46e9522b96a9588c7a392494273713e5ab01d6520134618bb020	99b916b6549d72cdc2f4a1d48a94576b826a0c81f3a416a4e6b6477858dc0b38	86400	openid profile	Bearer		t	1778543019
admin	eba181cb-0331-426b-b4cd-d59efaebc2db	2026-05-11T23:48:04Z	transport-deluxe	transport-deluxe	test-margin-configurator	aa447a0db10f34638163	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsInRhZyI6IiIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Iiwic2lnbmluTWV0aG9kIjoiUGFzc3dvcmQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiLCJzdWIiOiJlZGNjYjM4OC0yOTI5LTQ5YWItODhiOS1kYzk5NDBkZTJmNmEiLCJhdWQiOlsidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiXSwiZXhwIjoxNzc4NjI5Njg0LCJuYmYiOjE3Nzg1NDMyODQsImlhdCI6MTc3ODU0MzI4NCwianRpIjoiYWRtaW4vZWJhMTgxY2ItMDMzMS00MjZiLWI0Y2QtZDU5ZWZhZWJjMmRiIn0.T_G_BbRhbkyPup8tVXNPZR86TVjhYnj4XQ3qg7CNJpJZf-1uNQQxjOo9tXInWzU458gRNAA9-nO6QGJavJ_H1_iZ8klu473qpt4naiuzn22H7vz-v_VnfDfIW_aBR5qg_s9Q6fVnzOD4mGS4HEhb07vQVJnJUqWPMeNgowGYzWPJ3Fv2tMdy-9hdXs3LW2QLFHw5mlAbw6VU-uxxpklCCafdK1MNg5d4-w5udL70CJmEKmX_muLlwRdDfaKXnrVGOslY2kyY0zvO33-Ke79B9K52YuNYKAcvLg0b1iFDvrKFus9VEKI_LIKn0IoAp9Av-iH1ANx2WR2CTrboo83esSmvEi6MI_Q6xQ3pOquUjsNf9z9pnUmgLsBazfjw6NlH-z0K34IpChK9chTcb557xKB7reRp_iOx3m_IzHz5pNqtVq7f0GlYkVT0CcF_siZRjAJv5uGkJcd62TGB_yxs7e-dUrwWNcg-WUF0PzBjZRGQoDF-e-upvpNBHZxo860oZ_wtV8mswhadkItvxwf_KRQ9cIPg1szdh3XIpRdP5SxbaesvovFVMhQYyycyrMiR0idAdqYYdXMvEfXJRM5BkiHh_0alVLB26Dyt0FXmXfy8gS5KiZrkWN98vFbyIs7opgXTroOs6MdC7TOi9dsSQ5qm6ckqlOX79VbQfpDOE1o	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJ0YWciOiIiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsInNpZ25pbk1ldGhvZCI6IlBhc3N3b3JkIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTY4NCwibmJmIjoxNzc4NTQzMjg0LCJpYXQiOjE3Nzg1NDMyODQsImp0aSI6ImFkbWluL2ViYTE4MWNiLTAzMzEtNDI2Yi1iNGNkLWQ1OWVmYWViYzJkYiJ9.CStlFkZrZM1jAAcRvjAk5dXHijnoq3qUBkNLNCaRAPaHHQB09oWkSzmtdb3c0Z7Shvj2lnBbqu9VCGHHo4r6Yb2TAJIYdh4AilY85e_81HZ4cXjTSXRYpZipfJ2fIQLVgUWx5vRDkbMS1_RIXpPMSU4Wf5kuHLq6WnQcfxIVdONEUFTu8Lr6KPe4cjUswrll06HcqzhNux7KqCqnJa_mx-OOlJRgyHc1isGNmk-PqjE923E2JN4GrZCKufTVUZsAB7zu3l7Hfl8z1MRgvvH6TjyT37cwS4qsxf3KIglhXLuHMYVJVpecRXwAZJtHmj11FpW89ctwvuLAtZzPSx9D-C2tktccIzhHEYYw23K-JKI97OsZTHNSlPWfoN4XzRq3wyDG4GrQENNhQN5R2XsgSSIf3FSX4oHDTI2enEPSqERar7wanqdRehvfWaHkIJEimaZHOdQKNHwjB-DaFlOlz0_g5YtyKWun0_AIwCT5Lumyk4O85t5fD5hUnEyfhzOC92u3CvSmHu7oMiEzyOLjKaaC9VJgrDCgxkN_AQvDMgMOG407u7vE6g5ibEPXJVyjxE-JPIk1ft9eE31vb153SDF6Lmnjs7daL9169wZ3Uo1yR-2pt6diuiDBj3jbFH5KigzaysyYP_AuKiBXaERHkqXDScft1yHKvMCflq7gGLo	603f16824ab32d65fe5bb0163be91c02dafbc44aa10bfc9a251b24aa78ffb811	5ec91b589b5a8463fbf9d1a4ad3dcd6e452e83a76257ff49405e4f47a03dace3	86400		Bearer		f	1778543584
admin	917e5b76-6fb4-47f1-8e84-252d917be167	2026-05-11T23:49:22Z	transport-deluxe	transport-deluxe	test-margin-configurator	3a4a386588c90c96de7b	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsInRhZyI6IiIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Iiwic2lnbmluTWV0aG9kIjoiUGFzc3dvcmQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiLCJzdWIiOiJlZGNjYjM4OC0yOTI5LTQ5YWItODhiOS1kYzk5NDBkZTJmNmEiLCJhdWQiOlsidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiXSwiZXhwIjoxNzc4NjI5NzYyLCJuYmYiOjE3Nzg1NDMzNjIsImlhdCI6MTc3ODU0MzM2MiwianRpIjoiYWRtaW4vOTE3ZTViNzYtNmZiNC00N2YxLThlODQtMjUyZDkxN2JlMTY3In0.U_3cpRU7KVn91ZwuVt9HQpuAIUnEXR5Cilcc394BfbwaWoQxgiaHN9pX-mDdgpzDiawHvMUqmCaVBuKPLU5EXhZfluFYG7o3J-JfJ-w-Gfoeua0hujBBksdf3PZAtKQ32D5BfBoDR9uaKQ9Tn70iGQz-FxyogehEREZ14QDRgi4TXZx9jiJTwyuXs1XXjeYbdq1crX7NsMCA_aazKXBADgjcoACWwl4MlIIEaHO8qkx-eicNAN2fgznYb9oHfMBh7Vff-6t02qt95ZZDPmHf6wQvebAdZzdNxlWGS4g81TQY5O7KY753OnfTSIEqpdAM8BCyIh7s4Gqmc7Gq4zg9pGCdrP02vPQjaZMngdzuNW4mxauyfszmBK1er1KwL5wOc7dJMve-ARUqW1AKm-aMRLway6O2YgS4t3TR2CuVP1W033OhOOhLA_KRZ5eQYpJTj_mx6zI9-nfmsJ8xOuUDwYgAmrcqbGT0YNhruz4ddvUyL0XBD0aDfC3NnP9ZfkWH7rpTl7ZQ4QfexjZ6EzNzkQ7r29VXeMlgi0m7ceGCgoy3UG6LZBZUNXHttZuk2LikQCJTvNWzOpOhVv4Pt-fdkmra0DL9Nkk4p45Hr2z5Jr4wIK30B7p0zfQLTj54F7Njhy9B6cQqbZtulD3gG8Eva7Jj4l4qIA9h0k0uQCCOEdQ	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJ0YWciOiIiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsInNpZ25pbk1ldGhvZCI6IlBhc3N3b3JkIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTc2MiwibmJmIjoxNzc4NTQzMzYyLCJpYXQiOjE3Nzg1NDMzNjIsImp0aSI6ImFkbWluLzkxN2U1Yjc2LTZmYjQtNDdmMS04ZTg0LTI1MmQ5MTdiZTE2NyJ9.xDdoXv5JMJIjnmWAIevbjn5_Z0pxF0rcET5QngUoUTuDb8QpOo1XUpU-acRE4k55aXLs07IzUv9VHDfIXmObHWFenixWBBjPQIAWFg0zhMZ7dcuCVMYuLfD9TIYpk7gN28FgLFDUnEE8-w9pYTJO3VbCpfmUWmwXhEzIA6fhTyT2R4-WjXBZVpCwBb27p4nzW070qaJlX-4CAUWzlbUtADGF2iQdiB_AWooB-49xKXxLouODYni7NGSJsrpeuchZPS_GucJgnzvYQwahwhS4JJy6mzN5QdGamcVKOmDOqPhAQp-VsT3C2Zujn_h0X1fzC0PCnx1yOubeA9oOuxGICKHykIBFNPOgkVQodkOzzJYKj_CHQDXpR6pdwJNcYeEo08pa2oXK2-Rz-NxhvPKZVaopfV-aW0oJMaYs6k-kss_RHXO1Jdjmaae2jR02lSARWLTc49A2jO_2XI-lM27a4PDEOgvaV8m2r9ee1_kxS9G1_W2ZvNhblE_2DD_puYQDOuu5JLOq09H-R4X-9dQSR90LH8xnwOC5WtRXf5ZX2eyy77fmysYlcGFJ8cvGCUMTC2k20JgQrs3KXBr0rSPhmy7FNaPV7XOQ0qoJHq3V0x1luA4HLL-mB74Wd3aAx5jeYCClrpswVAFN2OM_cs_rEfOCERamvTJLrQxJuac7Bzc	af7cd2fb240107eecd9d3014d59d0c10f27e7ae476371068e1b08a04df3732c1	dc37c8e24ad5b0728600821b3827e555f76f0ca8f840008234706585e1f41831	86400		Bearer		f	1778543662
admin	1caa7813-ba01-43d6-b884-4588a33c2b08	2026-05-11T23:50:12Z	transport-deluxe	transport-deluxe	test-margin-configurator	32e105762c1232521e5e	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsInRhZyI6IiIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Iiwic2lnbmluTWV0aG9kIjoiUGFzc3dvcmQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiLCJzdWIiOiJlZGNjYjM4OC0yOTI5LTQ5YWItODhiOS1kYzk5NDBkZTJmNmEiLCJhdWQiOlsidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiXSwiZXhwIjoxNzc4NjI5ODEyLCJuYmYiOjE3Nzg1NDM0MTIsImlhdCI6MTc3ODU0MzQxMiwianRpIjoiYWRtaW4vMWNhYTc4MTMtYmEwMS00M2Q2LWI4ODQtNDU4OGEzM2MyYjA4In0.Ke7AJOZslIos8Nm7KuNQY73Fd6QJ5toGLoKtqCP5GOpQ6ZGGj8TdYs9ymjpkMKTHZNO-59bmc_8dUTKk84tqHJmilFsS1bFTuRtDk0vl3zcod9DuDyu2mlzziAEvGcgW64JigNzvu3l9LgzH0KoN-ra5EnsXC1FScIMPociuVjeCZHYi_9ppi05RHHjFWLsA48TklAZfzfPKIELCuN6mMqsiQ-eSjIGhuT5AwIoltJ2LXlMpHF-gc4BwzGoe25VDtE_cnglpN1CmzWAfEa9L_HkWFA_1Y39tANb9gTSi1B_yTSfOmXsY2PyREvrtJs7qKh2fDLZGllgCQzVUheeVoefEWUogFCiCNCyrZnuORiOmaYhliIo6YZKPBuiYmEYRbIQas0LVjxEN4nltwEhlkbnt5WAvFplSm2tHp5w9kpGXDq8bo9jnwtYkHNe9tB1Y-iMr9sKuNDhHhLkPBcncMUPccVPk7-tPE1gdCk-s4S7L9QYXtd70VHS8YKfTSS-A0FMrKuartpvI744AGFGcuwkaqlrSLl5OI9MTee3ird7vZOhdKGFKTytr-4Tz0FxVCr9TwCg0jsAvSR2dtjqw-zZ9EbYw-orRVK7_KDSzKNyNWsT2r35Elw3zNQ3oHK0gi2wN_vPyG12_vF8zgsrUuUMv5Hcgsj1zs9J5NUelwc0	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJ0YWciOiIiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsInNpZ25pbk1ldGhvZCI6IlBhc3N3b3JkIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTgxMiwibmJmIjoxNzc4NTQzNDEyLCJpYXQiOjE3Nzg1NDM0MTIsImp0aSI6ImFkbWluLzFjYWE3ODEzLWJhMDEtNDNkNi1iODg0LTQ1ODhhMzNjMmIwOCJ9.TQ8Vg54r0bSPSq16b3R4qj0N7E6pLUu14jqIYJ_Oa89i8mZTK07dimW9WVoe0nU3ZctrBkO8GNRFB5CFERBV6QoQx1jVHK9Ki72NYEYmXcdD5Cs132BK1khLL2OzhkbEFwqIEMHRUc3xcNIgwjObRJc9GDzKJmMFh5w3drpKT9jZxZuJx0trzvcBKkbL4Fv8E7buRM1y7a9q_Qy3dVz7JP36rm9ZGR_icM9TPg5arJwIeMqFWKfASckamFUuYeW5BvrVy1v-MuTvw9LJK2bvdBe0MSscrHlLWXargp-DuIYvA-6v4G84ulbqJ-z-g5fiA14zVuYk59glbYQFMtQ_tHOPr54QunFYki5W1dvW4FfKU3sFSem9bivbR5yQouvoYgZZZ8CV-vY6qpvYSbxSRLpRSj5u9UChCj8bKXqv6HtUJW-Xl3Is5UaYhhIDLR8rnBLVFEZqEdoLQZAnoEnaEkakUUoj6IowD2cpLMHwHqDq0fxoLrmmATZXd2R-Ch7P9156dKk_SdY4gKSzM5gcGQJgcsMRMfd4XaANiYBw20E_I7_vTZzNAMmVW9KYPqn_2EoVGZexgnX-QuGs8nTYW0zmspc2VfiVPIqw_QdWfw-OOVN8OXnswAbaw8OtWCpwPmF7_HVlMczJOU8EygTIlcEvgvWNU2ovd4-f8FPXDPs	f8144b29c81e8591dca49bee666c9cf5eba259fe73917f39d9305717042a7ab8	b2b61a782ca5ee4407a9e6b357183ab1788d537acca02bf19814433f22da843c	86400		Bearer		f	1778543712
admin	511ff9e5-f043-4f7b-8617-2651d44eb369	2026-05-11T23:51:12Z	transport-deluxe	transport-deluxe	test-margin-configurator	896d1eb735cb31f3800a	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsInNpZ25pbk1ldGhvZCI6IlBhc3N3b3JkIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTg3MiwibmJmIjoxNzc4NTQzNDcyLCJpYXQiOjE3Nzg1NDM0NzIsImp0aSI6ImFkbWluLzUxMWZmOWU1LWYwNDMtNGY3Yi04NjE3LTI2NTFkNDRlYjM2OSJ9.IkCnb5nxqp6-RPsfT2jH8dUga7ELTTIyEOeP_YkQaJvpikhO9EeItrCgiAklFxuS7cx2wqZaN5DkXPOpzWoOIoUtI29KxtcE1sZ7ihu_2NMPmdBLdbKc1h2dW4jDKghNrVivU8ol-HgQnUWx7skJUg4KGe2LTDU_AVzPEEGTn4McqcI6reyzt8PUy_KulBQ1KrBw34LdjZ45zD3F_62NvhS-j_fXsU-m1H1tGnDkN_rlzrVdZkfbxOsgWNLemlUrVaKJSn7_Avr1oI5L4nVfzzkC5hVw6glnqQ7GWzkGrVq7VHFEgZ1pZfWX_zlgFmWPJtyBoZw47QGNgFFsJehUr1HTjTiIZf3h4iAILYVvX2tqTMiYqsVvNGAnAXTDTN8WNQ-6i-i_hYfSTsmuDKqvfCLgPBrjJMGbG8PbovDNAC-uhGPh2vgkpwQ-ERCWnnqg5WhKlTtOm3Ph4sHSaUar3kI8_dPod4yAb7ekXixV8U3T4NMlTwabXSXzrMymVnD9uXbEOFETlmARzd7n0wSTQr5a4ymxN24rTq_s893z_Sev3yw16dc3PE3inP8tquEPhX14eYj3pTdOLk-TnWYOKLtIORbfA6c-42vagxydIFw7IvxVgyayFbIWB_aomDvXo4xdTwjvbBWl-vt6WXtScJk9zY512fcyGDVVE4V7lzI	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJ0YWciOiIiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIiwiYXpwIjoidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiLCJzaWduaW5NZXRob2QiOiJQYXNzd29yZCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6ImVkY2NiMzg4LTI5MjktNDlhYi04OGI5LWRjOTk0MGRlMmY2YSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk4NzIsIm5iZiI6MTc3ODU0MzQ3MiwiaWF0IjoxNzc4NTQzNDcyLCJqdGkiOiJhZG1pbi81MTFmZjllNS1mMDQzLTRmN2ItODYxNy0yNjUxZDQ0ZWIzNjkifQ.lXEzAOb67BElIO5JVC5SsS7nyQaOZbGHXRBT9phRAXM6DXG2c8saMdOhWQ4MVaYX-xWq10-29x7C5MJPUQjfC8MUuhYWW2epbVJG0cYMnVaK1PP6FP_DGxyFmpZxZ11Sa0YV6thquocOvI_wh2zvPGr1GrBQkCLExZMY4jSZACjooLxhsAyWOEeWI8IyEpuKCu_9pBfJuReJkeBlhnvf9LV6uZMJ1SPJ6tAR_K9ICR0I5vS-iS3IcPd4DEJUoBy1P4NnhKNrTtVuUL91uafk2YVPmZJmdkZng0e7BJhqDj-piBPdfzsfH901rG3ahxGu2Sr7aD0fhFyJF8LHbz0rEWeNiR7SXF7hwxGGLh9YB98zMRj1d9yRQhA6-jbuMOC9b19-CWWNWZffJFXpjMv4o6xBHJ-1p2RgySs9mB4jTcr0Gl6R4xuLUt5wHNDqCoanftzHXsSF_ztuVs0c9f-MHLE-6WC5IIiZUrzsLC7km8NdbEZ1wbzCAf977m1xpRpY8HJfOGX_fuirJrPkIuHeKofyCHYC0H1QXQ3_eDy57jW3mdtwAnu56jSJSFJBw8bCtjuXIR_6_9cbmJ8MofevZOQHX2LxwpLU_jDC7qAbyN7hqf6DAQtEzmnrHl5treDIYa58Ci077wuAeWm_tN-uhFbiUginJKTJ8jmCKX64028	7e5ee67ffd0c74357a12e326f90b05bffb723d56596c56cae0131a13a9defda5	7c36bd211fab444799bb2960167588da8da4192a8927bf4f402f6fd2ab347d02	86400	openid profile	Bearer		t	1778543772
admin	7a1ec48a-f769-496f-85ab-afa7998303c2	2026-05-11T23:52:03Z	transport-deluxe	transport-deluxe	test-margin-configurator	6b9e229326a3260e489d	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6ImVkY2NiMzg4LTI5MjktNDlhYi04OGI5LWRjOTk0MGRlMmY2YSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5MjMsIm5iZiI6MTc3ODU0MzUyMywiaWF0IjoxNzc4NTQzNTIzLCJqdGkiOiJhZG1pbi83YTFlYzQ4YS1mNzY5LTQ5NmYtODVhYi1hZmE3OTk4MzAzYzIifQ.a1X9wf7fvw_hbIPj0ROW_DJcPyZeUYyqdFWoPVgRl0tFbRA8c7h-8QHunwbdsv-Tr8iT0pwd5MEAAeP3pDZrFgAWmPyMv7OOMlLg_qqbJzpdlG2bcG5O_lAGO4jrD0PxiUcLG4OB083T-UZLMEFiSIB8KZOsD0D2kLONB_rf-vBheLwZPoShDPa2199vSaxvyEqi6iwlK42-76Q6mBbrTlNKIftZBZvQf6aLXmrHpUTaNJGf0XKMlEgoX45k8L0d80KHoygqeAfZc-bdKBnRRtwPTMWq3WE7KwjnQH8tYOr2BLTYqgWzZeN71zLHtuWuB19z-D5J3nRIdC_pTdFujyhKtntSmO1HHYCHHOkosy_Mdd5b30hUDJSbNY_THgBso7t4nzNLmuAzvdlhenMIXwdiqQiKzpPUs5OYYFgN2WrX2A4jkqDdaIfai-2C8C4j4QWYGeD0TpdfU2_mJkk7F9tzP8uw4_1Tga1Y9o3Dp43ESPkWxnCmAptGAAz6gf9XydZFsrCKlOCq8rq3yPesB04D7igkjnM23GXx9gnhgcGfKw8WHaNDeLMTvM7XSh8aj98FlyPDsf3n7EYUJ_HngMv3SV1tVi-CEZNk8k8d1RMAW0dj-I7Rguc0nEFbu_EIuJpX4lQ-KNI8yoQzbcPaZSojjzYUBvqi5KaSKJZGU0Q	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJ0YWciOiIiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIiwiYXpwIjoidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiLCJzdWIiOiJlZGNjYjM4OC0yOTI5LTQ5YWItODhiOS1kYzk5NDBkZTJmNmEiLCJhdWQiOlsidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiXSwiZXhwIjoxNzc4NjI5OTIzLCJuYmYiOjE3Nzg1NDM1MjMsImlhdCI6MTc3ODU0MzUyMywianRpIjoiYWRtaW4vN2ExZWM0OGEtZjc2OS00OTZmLTg1YWItYWZhNzk5ODMwM2MyIn0.PnWmTmT81fmgvzlh51kUiLbIeqH4s_HO-1rLspWrSfU2woYDsMgWVlJQ7TDYJ-VNnX5FYIFR44ZbN_pvx69KICEdX6vFCu5dm7xhRrZZsYg9C6XN-xsuy42ZLqYDswPRAcS5xblmDrGg37ETV5MGnziDyNoLX5p_5FCBqHrYuysf9agBX1HvwpqhFze-82pxcouiccQIZo9m54oBUseDH5DtgIo5IM5O10Fjm_rv8mNLcxQdrL_aKvXzvWSema493JhAaT56ShbIbWhWm9ihchBkjDaOxPyKUTNc3v8tBiKufCYRB7G0Qzfr7_FQJClPVTSpb8_1l3TJjEXLtB-Umf8WDEPquRQ7RMMiSkAH3DoC5x20-KmquvtQfj2YWpmm-IuBF2ZixNxMDbd62ljI-0FuW-7L13K64U3NVpsYZ5iR_wgkaEvHDLVXhcre0nSIjIlzzqVcPreOBWc6EbEMsUGLuckO-wO88qXaYyCLMccBCw1wvlvgJLjlefJ8zDkX9xbN3FMBQNNN5VMT68zLKSICvEqMvpZM5XxNonws1VT9grn-MTZRBXPqesBcHZ2OPB6pSd0YyMex5tgxusQC37k5Bnfhx30naYzVyNI6mWYlURXcIlbrd37VGwzajPeh2Bc8VEcenkn1UnB6SVS57kTJAghgOAFYv_NAdQPefq8	9646de8083d3c13121322274601841db6a09219ca99602f3fcff3b658115b75e	b27fc4ded71732014935929b376a08a342402e273e8ff4bfaf2a44410aee06f6	86400	openid profile	Bearer		t	0
admin	b4a4e131-d9c6-4ea1-94c8-8df38de13d78	2026-05-11T23:52:20Z	transport-deluxe	transport-deluxe	test-cost-configurator	e9562deaffde3d6ea3ab	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk0MCwibmJmIjoxNzc4NTQzNTQwLCJpYXQiOjE3Nzg1NDM1NDAsImp0aSI6ImFkbWluL2I0YTRlMTMxLWQ5YzYtNGVhMS05NGM4LThkZjM4ZGUxM2Q3OCJ9.jZKteGJLhPnKMAFTfHjVUtMWHBC2rtrs7Rzf2DaEYkbJ9fSWMWDeR_aFbVFXe9pQXQW8Blnk7UmuCHVHpiNcaTok6_hef64OoIBfGUJogS6qrSH0mKyFmn_RNi0G607S0q3v_4vhmPFFjrnubpKIWPKhltyTQL5BepfCpaVGhtx_cn1JWXnr0Lf-z6XYzfLmPZGl2LZ_2rUSP5eP5Tk5hFDYOjcSgC2gjdDF9vQ_bVEc4ux4Pq8_2yCgMh3-wUHy-zb2b9x_GmxE2sofm-N3E3FHI7QP9h0KD3GNkOp1DedzE31PlwVUXrsN3YJ3DloCpe9apLgdAvsKQSHTgvoh_FVDoKrHykn0WG_yuhS9W05KbeW-2SZSD2HeQIDTbI8qpzh0E_HPAHwatB5kYZMWFF6LILrcwnZwflmgSO-4BKSyzxQaOuc370A_dFFPV9w5V7S8mgR6K4-4ysqFCCNAoU3HqceKMAFcnxTtY7pKsCI4HNuf24YWyABeV9whf9Qoj9qauDCzeTeWJ1zqd2McDa9eW0Rj1yrzqm1o0HfrscCXiKbzfQpPf7WIG78j0CxzXpDjLJZc2bn_kyNLkXlP--9n3bCvTH-6B3sJKGXEscwZLbCz5H9jktEZVNsKIwskuHj4yKrCwRcB_foIwJNEh-1FHo-DWoxp6JopN6O5K_k	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5NDAsIm5iZiI6MTc3ODU0MzU0MCwiaWF0IjoxNzc4NTQzNTQwLCJqdGkiOiJhZG1pbi9iNGE0ZTEzMS1kOWM2LTRlYTEtOTRjOC04ZGYzOGRlMTNkNzgifQ.dzxAS1Mfy2z5QYcB2v5bEyiUUAGer9ZMgjDEdaGFZ9kUeqYAwSTS4PDAn_tR4OQoWke45DKI7mAUdthQtRjvNNoqJ7mapnzsFQShWApMXT34WcmTT8544A4Ipdi63c9ipI8hBtEzXySlcz7Tjc_kh0W6DfhStJDLLXcxsQmkAYKnVi5IApnIO6Ptg-kvbECNe0ZSlwJ8MW7WvOcZwcUebV2L5M97L7YZvhl3TFGnGaUU26oNe2LWSxuCoZcEiM47Kj7Na9eMEOE11h9pQDXGF-MoH4TvIT-uU7j6m33FC6g3SSjcCE_9jyZ1Pz4YfI3XlErxwZsaoqmr4XnPM1eKliltMk328UHzN3zg9r1J_yO4DJE-OnIHI04yluXqekFohsj52pEOpOQDpga-up3VD3LsanxyXiETZsl1uZEywRM63xgVmJdwoiCFty9gdW1mqGavqy7NxynOFrMXZsOkX9QIyOWZ59zySno7mXUEQ3gI3DOjZAlH_VVvc5KjfPRHSC-I8fxnOD_YDzixalWjFhEf1Pk1KnNgbceh7MARm9luZVFkzOAnjb09mQQX0HIiCZ68SKd5K7ajFRb6a3d7ZinM51oBFPmf3nRhZp2xFKYL4hqk8-ysVE3MRYxVN_lu9WYxsvHOlka8NTttudqPaoz_UC5gU-EveevBCjttnQ4	82ba18ec2d43f0f12b2fe388d1fb8f02b21210835945f2bf3e1b24199d93d541	61718c1939278135795aa18835e96e9b5fb7e3064f858512e6b7bf5af2343454	86400	openid profile	Bearer		t	0
admin	ae5e0eb5-3a83-4353-ba7e-8506a5a59963	2026-05-11T23:52:27Z	transport-deluxe	transport-deluxe	test-cost-configurator	93fcc9315fd04ff478f2	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk0NywibmJmIjoxNzc4NTQzNTQ3LCJpYXQiOjE3Nzg1NDM1NDcsImp0aSI6ImFkbWluL2FlNWUwZWI1LTNhODMtNDM1My1iYTdlLTg1MDZhNWE1OTk2MyJ9.npg15FJeCs-zjwSSIaEkS1xO6yE4yD2N3VkKVKRIFZlaBXmr2XPK9rjrGYan9-eAO2N6tPS9XxBsU7MHYPNGGrdpeJAVI3GB_5-N9maFovyHoF6vDY95w67yOM26UrJqwg5hSi8Vwjt4eWXpX_EFfkV2DVcvs8flyMQMwkDZ12_mCPDDAr72QpsIgvGrtrvmNAXFsFTCh0tQm3lfELQlpsS_E43Z-iBD4L8Orem2AYww_vzgbieOGdW8ZIje1QPbvIA2uEtOjSW0uP2O0eq3awG-tZFjWzelkz_VCSNy6LfoSrl-cCO_A02ICTbhlH9slSEWeKrGnLtH19-rHJF6hnJFdECjhY77sP4awtvhiDL3Hh6qT6ErD-NhlIz95NMG7jzmYesLoCdqIiZ9CQEL9K6U0kEGWXk4h9pvZ4UPobmBYcOqT6vV7meUVO5AgP4vmRCiBQV-Vhko3KkvqqWKnoCQa22MXCxVBimgs4d7hYcmj_ed_LuXlCn-WREKm7jA4EhlXAdFt9NI5U9lHBOHDHlDc6RRZc4NncsdRN-tQJKMEM9uwlYn53telqTLs6pysUEuBuvsG-L1HI1WTAwht9Ri50YjwGwHY4BEcP9GsfRtVBzykHGMxebZLJYTweXu-fBkE06JyzYUDT5kBCshC6IscZZxX7YuVs4_YhkE-I0	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5NDcsIm5iZiI6MTc3ODU0MzU0NywiaWF0IjoxNzc4NTQzNTQ3LCJqdGkiOiJhZG1pbi9hZTVlMGViNS0zYTgzLTQzNTMtYmE3ZS04NTA2YTVhNTk5NjMifQ.FLTll2A7LTQ2cJ3ASwXlsExCwzDHRmsYUY_bBljCgNR7wmlmamDN8i76U9OUJjLyGwZ7Hx0I3t-97ryBLZuMF3H8Uf3Kcxy_LYBvE_86WI-GCQuEavWk7pBW9L_3fQ0kI0my7ZwH482FowUCIdtykqRYWeocSIlWZjDE_2YDQWktV7_5GAt6UDOeccYCvOy9BPxmAN9IxMFyme3ITcKPc8RcBu14oLOWqdR2XHuEU-Us3BMwYuO4FWN4pmpjKAOnpqhvjo2o9ncOh6wxO95lGlyZ6Fi8UXI3Dl36KQW6IPlXqBTYfhtQ70mkmbL8_6pNcgpgR3Hs5_2jEgy1NWaVLg_TR7pdm-oOQuWYahuDuBEgwunSGVnLouXN9jQ76aJ2yjR_wAZU95dj9hnyE79lxH6ZvKl-We5S1DG4zxkF5C1zWj5QVLK4JLMwqN-YqCDgw5mc8Kgnhm8Nn6eVGDLWksG5dCtCVFZZ5cXGtSZywrYdhiHbbQxRQWKnh2cTQokMByBUTl4nNX6-ZlgMZ78ScmUpigtRWBhNo3ixDyhscltX1mhjQuJm9bD3lWANxILpn4YpeVwcvkY0N99JUhCAUbPywmmd32UdLPLAciLaS6ypKu6H0YYrxVEF8r9NfPs53_0zDweT-mSk99j3bDya0wHFFYTkG5d0ZXl5jaC0e0Y	1d8285f0f2f6bf7e44a68f250ed37dace606c55cb3145928680074039c1ebab2	e6652edd4b4e1fafc3a90369f3cf77caac84e2cbe8a166c86d41926508a7ed78	86400	openid profile	Bearer		t	0
admin	5ec2de0d-b02f-4079-a88f-ec1e11d5d0ad	2026-05-11T23:52:28Z	transport-deluxe	transport-deluxe	test-cost-configurator	04076337f54f029b3658	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk0OCwibmJmIjoxNzc4NTQzNTQ4LCJpYXQiOjE3Nzg1NDM1NDgsImp0aSI6ImFkbWluLzVlYzJkZTBkLWIwMmYtNDA3OS1hODhmLWVjMWUxMWQ1ZDBhZCJ9.AkQU82JLaxp8_FNGUXylG623VnH4KBWR4UF9el7pimh9vjDhBU33QrfxFvcawrbQRVsw9IyHxfEfgOWh1cYD6uOW5i9MF0xH7ty1rkxiw4iqLpM2pxj8KNQuNHCAG-ap4dUiPV9FenANEZTSUMv1PrzIgyFk2VyHmGHgA_BaBlVZhEjtCkH75wkBkG_Y0wTKwQQLkNWWN_1lqBSyjHQ5RO01xg9PYDmpvBz5y-rd7iEiDjHoTTI9stO9V-LDePkH2ZOoahfAyhFhUcZph_3WR9ZUikqeCQhZz6ZGIc58Q1DL3NCk9PKL_mL4y9PyLztVW1bl54HuP6H0zo4oXrLaKjyz_tm2K_3BKL-Tbr6n5BuZoQMaMyZkLp40xHkuGqK0OBgb9SuzsfFpCypQiBu6oC10pXEihkYOtLiWOMQt4xo8FqHo-fMR9gkgngzJCBTFIJAFzDH9qxRfDRTgfDEELADtE28fHe1UciZG7gONx1YsxMdkeXf0iQXPZv8rPn56_KDX8CV4oyfa41x4ZqojjGkKMRLRFDV8dGp2bzYaUaG-9M1PDpb1dnzG2SudlTpcP39H0ksmkJlNNQiPzwy-Kh-BGXG2MyyRTnMrivFqij6Rc_1x4TggUeQIinT2VPsPKiP9tboZ3x2GzxKqhfJ1cdjRbhYUHVTxHP2n5K8ufFc	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5NDgsIm5iZiI6MTc3ODU0MzU0OCwiaWF0IjoxNzc4NTQzNTQ4LCJqdGkiOiJhZG1pbi81ZWMyZGUwZC1iMDJmLTQwNzktYTg4Zi1lYzFlMTFkNWQwYWQifQ.RapB_sZ7YSPLyUaJ5fO7AZlfV_03cyEo6_xt2RSQO6lgA00SmfIWmRhjhD_BVzeNekn1yUCJ6CzuWchw66HnW2kFEAMWemSjJFQU4f5GSSiQo0ap-KPb1e9MF5QGEGf3vrAido9GWKP64hokRmJVgw5D2g5-EIJdyObLRpXpzWoHE0ajCcNW9TmCnkwadaWT7mLVOK1d74YHJifQDcxooLsUd2hranL72pRqQkFr3pWaX6k-Lw3LSBQs1VIGOJ4-WOid23RPjhu-B8gvQmXiO05Fwg8URZaeMptoQ64k4-lHIEuApea5-KVO9TXg74jk5sOdRX2O8TFNIYZM3zELkmr-AVTrDTXpFO7WRdNgGxtkAKOS3OHNwms2m_wxhdvZkD9g0gmcrSp92VyqOyYbIhOnr2JG7Gk9dRgIroIQVvoShwU72OTdpYv6HNGNPbS6LA5tB7ZltlrYMpTC62kpPrwuJDoLkvZoa5Zk7awZtfnotZwp7qXgR-KAVs7AmHaKLYJGzqlis5ntPVhm-hu-uL0YAZk-5UnWKRMpaX7svWTrTQWFL-VrvUTSNFURahfM-KaSn1ENuW_DYouIA0ygHWZcccsmwdEQBbo-Eh9DRRZUmq84RYNfV62_aCd3Y4rVwpBg7PV26eB3GJUlcXZGSq2Wk_wnQGf22jpkSwGfRRc	c3abeebeb244438c408967fd4cccce636eab85d1179cd709f4fd69a5d0b6ee91	6e6fc956c20acdfd0bbaaca02f991acd45d8e87d8b954ce34d8096975a35a7b3	86400	openid profile	Bearer		t	0
admin	ee2f3a7e-b29a-411c-aa23-947013450cef	2026-05-11T23:52:37Z	transport-deluxe	transport-deluxe	test-cost-configurator	5b3df5a4c9b50c23fe4e	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk1NywibmJmIjoxNzc4NTQzNTU3LCJpYXQiOjE3Nzg1NDM1NTcsImp0aSI6ImFkbWluL2VlMmYzYTdlLWIyOWEtNDExYy1hYTIzLTk0NzAxMzQ1MGNlZiJ9.AI_rH9rKYLllJGDOrn3ag6CAkbPh2o_kytTrc7tssp_80NxmT09ubGoa2coNYKPUZJEZU2AQ0AJO3WBbz3W_psA0ooBM_G47DkL3Eu6jgTaK6ioQ6aQBaZ9WRgHcDXqQ2CPWfJ1y4sPiSImKDv6i86HIE6nhajehyoOTT3HC4MD5K8uAD5f20R8nFL9fcW9i9Tw_2A606AXrebD2J3IVWbIQ1L65Ymn4cz1wzqMdRU4zXh3JGyWzdTEbI6pSEMZ4ExomzQIZR6uYGgtB52A8QUpaqBxNi41uknOtglRLDAX6LjdfEn8N2EojN-XQcLxsvRDWBsOu8V8Vop3cz5Bi8xPixJMjCOBmTfImNoKRbJSXGBnsqkoU9Jd6_wpl3tsmTQJMaCCWtGYlw7WGIb314YdnCxmsKZ8_m5l5BrZd2VDx2f_z0QZ57OfU2LXTPkRhbqIIKYdi_28KnSEF5WbjQOjnGxy_Q1wqeuw6eJNnCSZ88UeFcqZMROVqjRUsIrlag6EP4M3rXuj8ZQ2McqrHL_IBVSSB_61KF4sqyr0OxdHDXS-Z6YuyTN56bURQB2y7vfrHwyIXIsJyN1Xh6ZeR5HEZcrkcG3cI2XwsxaOwKFO8s1ou-PVA4eTL6oPnJWCilHaxpUh19fmVa0Te3CVvzdNL3OKSiTZ_08thxwLKmjA	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5NTcsIm5iZiI6MTc3ODU0MzU1NywiaWF0IjoxNzc4NTQzNTU3LCJqdGkiOiJhZG1pbi9lZTJmM2E3ZS1iMjlhLTQxMWMtYWEyMy05NDcwMTM0NTBjZWYifQ.Wq7FmwBRvEI5H8M7LDCNUXwlmZskyhuPck2337Ni9pF1VCr5FVkoUqRFlf-_9LDdhK6vmeL199MwX18sGYKz0YRs5pjKLqFq21-HflEaJG3Lu8eG1DUei44FiVlb6xp48VNl_uvqxdnlKT1iupmTgJ8gqTCLUKgquPO9t892cPoRJJmkaXLeTa9KGZiNTC5nX6BImw1umvhtrRua3Lf_cWjO6f9D7yoqMG1lFfr8gbBznQPoGzSTrknuCzqwN3heIJdWk89JTREzw_Svh_-diB-EWUGPZWuy_KbTu3LAjbwjPmMTuHzA-R2PtJmzAvGQQnApXelvzWlGSUcO4NyLzHEcxoB0FeN6sc3WFGhUiwwWkKDdd97skM_72xJQsP4aT8jM8o218BooTflZfxMnnpboZkXTB0nQXv3BRvk1GACGn_oaE0chy68fjJbfd76qU3XBal0gY5rTcN1gSiiOadC_-SI8fXCPZgosraOCjZWl2aytVT_6iTavrXgb8t9v97mdar9LwaaHNl2IzX39Uaxj2znV3PmzP3bveuiv1B61YdXfbhR5fWt97BioetuQnA9W2nUdyoxaz_r27qanSkO7duURXHWAfh-n82cmXhq2vsnZML5jk9QcfUPa-5HgsrcFPu-KTk5FqRD1AepzEdfRyiddoavyXb-9_iI7f6I	2cc66573d19c3dbe297fc0240136503e3ce3f2d09e33847c8d3b5e58a46e04f9	d1ae76d04f0847ff76c712c03e9a9b85c65e2a602dfed29d43f675f3d257a37b	86400	openid profile	Bearer		t	0
admin	941403a1-847c-432c-8e42-b1d275c27136	2026-05-11T23:53:06Z	transport-deluxe	transport-deluxe	test-cost-configurator	bc8f6ad753d625317600	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk4NiwibmJmIjoxNzc4NTQzNTg2LCJpYXQiOjE3Nzg1NDM1ODYsImp0aSI6ImFkbWluLzk0MTQwM2ExLTg0N2MtNDMyYy04ZTQyLWIxZDI3NWMyNzEzNiJ9.X6aWDe28CtBVbtPSXeYakWjmtSn0qAXY6cz6bP9CkeYONcnNM_BU2ob5MgVaYZJZ2dsjaTwamCH1gdLRfMnnuwybcnWITMeNRnjUkJGRwo2oCyI-tJ2OEhDbTCnxhabfPXRrJuxOwEY-9MWxL3kNifjWYkzRNmMMoY90vHT0kEriPJSbZXll8JhlUve4UYbtx8u3kp5VpoxZcp9wWb7F0ACns7pRnXMLhSWf0eFAbn5fAgUeC7AgCBzaHM1n5MnoSJQF7WBLikU24GddLYZ7boWP5FIr8ZR2W0LW1q9CiO3R3bgqUHxIykRM5j3vJOnyQPM65v5a5Fy56sDT-XXGicLEvaiqiUJqtD_SpFGQ9PmNGreP27Abjnpgb67d9FVx_uQ87K8yo-t4nJhqwJCac9rURQXt5sfDUOEZCyHmp_hD7LmhgPyJMbqivLmb6iMr5LOK7XGoZAHtg-_-4_A8LcjTn2MbzSzg3Q1p__qoEU1F128v_ZtfdCwldKx7vOmDTVghdL2wY-3ZYDl5lZmYAABgbkoYvbFv7QmPqUUvbcVHKKbEzuo3YNygcInVB-mjuRnCkhF4PCFrL8y4yMfmZJnTGiqneJcCCRhdnEffnXompmaBaDPD1IgMplYp5CI_vF92rQvrZKF8OONb6lJFJZzOdwWuWvnzQV0RHY2CEnw	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5ODYsIm5iZiI6MTc3ODU0MzU4NiwiaWF0IjoxNzc4NTQzNTg2LCJqdGkiOiJhZG1pbi85NDE0MDNhMS04NDdjLTQzMmMtOGU0Mi1iMWQyNzVjMjcxMzYifQ.uIzmvzlhC5GTlKHRZKWWAos-FOEaIoL-s4KvLQW9waIeWi7vaax68kSuoOEpAfHTjBsQkWE3hrdhNy2lj6c-BGZ3csHRb08nEjiWldownV26YSgYBQlub5r5ER-eOXmX3njRPHKWBfiKDP1QRC4QFmIYyqKG-8AnERwUZ-uUFyNMM8ONrSJIG641nrsfX1kxac7QOzEz-zjvMXem4ZxPeVPGs1deEu0zrbjonivCfnBO-P1TKM4NyGPrTnUAY3CWrP1kml66kMLjZfQvDZuaVRBnXGDLjR7ocUP4LQUwN8NugqNL-buqxA0087RzXe0Gfenmx6Av2MttLozg4GGl2UsS1JgRq5nf3sQJp8UNNc6XNNqdPwCI83OAcl9s3FXHrNITTMOdhIxIwvwyomjsePQ96_ZB0I94jgkaackimdmTBgocnWvjBUbkczEa38qTFvUjzaxguXFSx1EIJGqYooc7PhroMvweF7aw6qToj0VT5fVcVOePIGUxsM__kVuDATAWBxjIF5RspSTnhm7TNekZS2cIuk9g4B0CZ7PFRd4AkVMoSvXzSQY3Bo1VUNFrCERWsaOPqjywCuPp4oggN5SrEmHKI2o1jQajJ5VOTss89QNJiNiLnFmh1nkwga-QuJyT5so3xsFBZN8Z2H-yuS6NA8VehZuPnXEvl5OE4Vw	c55d65b5372c9384d1c3c6e4332659544591b15475d337f0d149157b7869fe76	b18a6c933ff44497945d91f1a292733a3bca135463812036f16ab633689554a5	86400	openid profile	Bearer		t	0
admin	6fafa197-0ee8-4b02-aff7-06ae6041178a	2026-05-11T23:53:09Z	transport-deluxe	transport-deluxe	test-cost-configurator	79b07558f8ac27d34e4a	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk4OCwibmJmIjoxNzc4NTQzNTg4LCJpYXQiOjE3Nzg1NDM1ODgsImp0aSI6ImFkbWluLzZmYWZhMTk3LTBlZTgtNGIwMi1hZmY3LTA2YWU2MDQxMTc4YSJ9.rqSEaufJMYALw12aYquUC2fM-fOIQtWIzJKzVq4S8wXMy6dkM7_eJaAIMZaJRqgEXE9vNsp7qQ7lC-0zCkgKTBeBsKYycUQAEyEtV7ElJY9jEkLoPzqZ6feZtTJq3pz_ZwK3Zyw6ov3hQmcjvFO07m6GKEApLr7w8neuckFjmu6gKFOUJvfpYxbzJXmaRq7aq4j3E_k-xqASCWqMpqFWU6ZW7JIY_re_YZGBWDVqFtEkgIQ6n1zkbW4loltyDVdx8GqZ_3tZtJz4J0ffrqd9UqixXqEn8d8dvlRCOOfomrXaUgYxhlWIHFUsfev8X89vU913uTJgTPLDm3gzf4GsaAkohgTPJKC8TaxmRBVHpNwxC_2oNWzXJbjtconagyhwEAueTIBdbMcnBYaFMKpgMWJ1nzRUM21SFZK7XkEa2hkDdFQ5-wBcalavjlJP6Or9HWzwi5DrrPxuNm1vCz0HGXmh-MYLISySkbtbZII4n0ZPOQWRdV-s2LyxlYOPb8vKQ0eKktuzahDeosOXzVvTyc1ifcW-r--03eHM_YRPAmNgbzjNm2wwtgNX7XOTXSnp1MXL3EzuDQQh0VBeCLwP1g6E6j3g_k-deQ3Ccs9V3SATlFQEdq0LMVDxTobdfuKl6HQfsKw0MkrRJTsa71EfSJKusKk4eq7CgHNbozA9n94	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5ODgsIm5iZiI6MTc3ODU0MzU4OCwiaWF0IjoxNzc4NTQzNTg4LCJqdGkiOiJhZG1pbi82ZmFmYTE5Ny0wZWU4LTRiMDItYWZmNy0wNmFlNjA0MTE3OGEifQ.u8EyAEDZIvN1KsSP-fU8yt-H7-N5sXYdL9_qFrKQe4nqWC5EhnnPuP8LkjSU-_ZylaQCNgUTRuZQgYNh_pTw-eDQiJpew6yRMs5BIXkh5RdCJrv0tHDGBTEfif_kg_vSASHzIE5ZRivQ1la7NqjHCtr9GPZZ8oMXf-Sqjpvme4dWOBa3RXHZEB1ZvdrN3qvLD6KiTSjeesjLje2rIzAUTkJJTHM9o3YnCqIPztpKMkX3dqD8RX4CyoDouQIi9m-IsE91zP575_bRo1WERa_OPw168yKl04ugJNcQY2YJ0lQq7BdMeb5JU8ZxMqatt-IKr738ttgmAm4HNZIJR9rqP10NdEyF0r2xwtiFOUY6IcwqByj-E1XfM4qSV0HvqKAP5XtYbN3hMZLCXdHc7Lh7MjWqftiD7JdKnDLxvwzxxZ7t0f1eG2PEwF8Ays8_mAcdR74WwaH-Rh8-6ncV1FULq9qfp0ezgUluinW25NKyVY41DeCin-fRNLA1vy7OvR1BcDqsEjs8sbHyizGM33q46U0ZPpDmIkM6NmxEyZe38JRCMSZRMpuJXPIkeAg5m3GwORU7t4XxzbT9JNKBVYBXIPgqzaPhgwysreCasSBkmC05httY5rLyNV1BzVz8gN2XEBZh_kA7EX_ABp0IdtzqflqA_0FteyN5EGE6EcVAMck	af4247e35d8475ce5cb495a1717dd63d58881839412fe71d43dbf34fa4f7a31a	2b1eae5471aa512fa8622b13091992a78668aa0f68b8f03b6b68b4bc13c367cc	86400	openid profile	Bearer		t	0
admin	b019d367-76ec-413b-849e-8783c1fa4ca3	2026-05-11T23:53:09Z	transport-deluxe	transport-deluxe	test-cost-configurator	b7c54f74569980c4ba22	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk4OSwibmJmIjoxNzc4NTQzNTg5LCJpYXQiOjE3Nzg1NDM1ODksImp0aSI6ImFkbWluL2IwMTlkMzY3LTc2ZWMtNDEzYi04NDllLTg3ODNjMWZhNGNhMyJ9.Pn-gKSOGrJjwOBZxALJDuO5s8Atk569qMyTFb00cThtZh8uJTX-yYn_LoY7JXYX2NDpwdW6pYhXNKNt3QTzd3YDvhoUNMhg2SFL2gIGellIyNEnqOYAk68sTlQHdtos1HL0g-YLBXvIIR_aHuWoOl7xdsnlaYwrqPaoVvfzcxHc4f8z_1wYxeTz2WuImTkd3LaKxUzXBc5UHxqmozkYrE8TshiWLGRv3tc-1VIyDfpzA5T-U5IvQ275u5-ssiikTq8JEOf-Ltc1ubbx_MYVvCCntdfUBjGHT5gApZ22uZ23PhFEfLv91GU0TA78pP6H7PX7eGO0E4hFnPT3NmjKdrG5T9MhZ8HfAE6sAZv5979iPdYJNZBsxIIdDaplLVd0ZrSTtBjpSHnC8SCaR0MW6pStJ7-nhibynWfg2NOjUTw1JKneqXUwuvLw96keQyMU-cF4RJyQtA5MWV2TyIUzESC4H8LrXSdiKMqb7TWczrsbNKunfgvFkgNMxKVujXaUllSs_SY0-yajuOMuIKBliTBtWwVuHOOE3b1OYjFVFR1KnLbY5rav2lM39KtWXy0rQdAnRcXgHo0Hpq1ug6hbitpFaCF7ulY5XGd7PXeMDBNUhe-WeZ6AIdU-nYqssty447fRmAGPkEnKNFlhg3kdF072oGTTNVXhO6Pvhp61-LB4	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5ODksIm5iZiI6MTc3ODU0MzU4OSwiaWF0IjoxNzc4NTQzNTg5LCJqdGkiOiJhZG1pbi9iMDE5ZDM2Ny03NmVjLTQxM2ItODQ5ZS04NzgzYzFmYTRjYTMifQ.Nc3woTPPzeuNSAN8ThDVEEIUxKwHRQjS14BsGgVAkN9yhhWaZaLFI8EzhOQpihmJxZBz7uDlMtSOkL4sk0_cNXrBQmcRSzFmISVVpR8AZVzefb8PZBtg2LMIDKtqHCH0s2sJR9Ml_B-krUToQGHDkMm75uVAG2IUHfJ9i-43pVwxaSTaC2ApBVKzWgfekUuWSX-qRX7ZR5IKhsP2HYUNaU9Yg0RGyoLpCO-DLhc1Ud0__gERnLfMKCDjpicb6c5zgG6Z-rEW0GjIpaw1ir8euhOvCsxW_dDRseZA1XhtcUIsWTDPsaOupTqHkLQmsY3YSpWf5UMoul2DbKN82B5FnOnOJeU35rYePa9rEgKwUwq5dp_JAEJXeY11ygDInmk3NmHrX_t4embLcQtx8MvnI45hZfwUuZrITBVKbGE2ln_y8TZf9QsMomxSWWQ-mV3L9Gsruj0A1Ar_Mcfuhld3MTQNlA8V2jOicBQCrVLBnpBk91p42rucLYQKMzk-k-8Rxouz23fgZCTKMmHspKGZGenvdMUamWxzu-2dM9jGZfNhW8vOZSs-KtM0l9QYRH8smexzYacnkfGnCgo7oHO-s4gKeimWUpLoU5_ufEm1xzby_5hS6Cml4xpHb5IQntvWfyjg0BSGF1VDCAlBvCHzfIHGWtMmxtQ6Tha-VrOkrWU	4b1dab67a389eac45300946ed86577ff89ff9277f2ef3f33f6964937246fe0fa	4fd27162272919efdf9b4f21c19d8b45d9c607532ed029c2be72eff836620ce4	86400	openid profile	Bearer		t	0
admin	b284c9f0-2e52-4edd-9b23-9075600e5629	2026-05-11T23:53:09Z	transport-deluxe	transport-deluxe	test-cost-configurator	b4e7113b2c75b55b3983	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk4OSwibmJmIjoxNzc4NTQzNTg5LCJpYXQiOjE3Nzg1NDM1ODksImp0aSI6ImFkbWluL2IyODRjOWYwLTJlNTItNGVkZC05YjIzLTkwNzU2MDBlNTYyOSJ9.HCLXdVY0H6f85Yg4pBKM0tb7wHv839_Zlg9cUOLk49liUFleypCV_4n-OHlR2HAzcTVi8DamWSdvaRjIn8QmT0k6zoAhiAsxWaaZUep9xI8xL0M1lKqlyEi74I0td-ZDuSWgn8spXGS3rs2H-9J2nc2W-DHNGp6xQidYl5CEaFohQmDBmKxVkIr-Y1-24z-b82mvcmle_Ysl-oxMC5pTuQQ6nrxoIh_X9tEHA62Df3MsfVEr0InYasoC8egfUErjE8aHjvKYfTPtzRZB0KdZ3Pux73pwawNceZNBaX7MXSpNk7tC1aAmizVGmAbvRZ7mqNzu_kOtmKlI_pCLpBeR3NRsum2eRIVGgM2NVZ0HounqpEqp_bGhGDlNaBkN5zLSxFxtAfapHGDok1wVSCweHrZzcmdO35TQLGXUJSsDgQTetwJDzuedM7SQ9PBm8KGUdr_noEYlGuZEdGixklviWMnEN7ErznPZAWbN-bFfMXcppzaCuhriOtyUat1w3SLn_Wr3M4tCZhbCC7DCxRxzc59-qCYMerOc72Vz38In1igCCED3N0k2r8BmwOH0G2eEhWgpjMseUOJH8V0KVIQ-r_U5kUBOAmJd3zBE5mjrJpUzr_VqVvfYIYunvf3fR_pSY2QLzcPexptxYyLuMcOlJASOz2cOYnRTnJQoPjnvpzI	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5ODksIm5iZiI6MTc3ODU0MzU4OSwiaWF0IjoxNzc4NTQzNTg5LCJqdGkiOiJhZG1pbi9iMjg0YzlmMC0yZTUyLTRlZGQtOWIyMy05MDc1NjAwZTU2MjkifQ.jzG8gGIEzHwc9aqpaHXgzQw3RReGu63vggom3EryKSUSIxag6xdrJvbSm0pptkvWOQo10TNohIDHd4_ytsTTzR__ic3sT_lA2jYF1Dcj0nXVgbYzZwKgPrjJEosw5oMErgcAXFdCXrs5RkMwHqzUUL_my5F3hI2WVTeyQHMKD3gIjjqfz9rdafHHqVX0y4GYosWYZqrDG-1_d3Gi6tS87hbAzoS7qjKWYjBCOhV-YED1dH1xa46oYxDYl2iSope6hGjEmdX1KRXVgzoBvE7SfiQe9MdkWC-ExOKfgd8mdGxxRnLbR0MXRfi4TYNd-kiPQjmnG1gEdeC4epiZhCjJ3OQAxMvZdtjwfhHjyEQkXvnWfMexK0TeSZpAhuJUz7rr8_EqVTde-cUshgx91816BJoysZZVDAK6PZGDcvbcGC5-gLs7PCG-vvVCdN6eatdanEBf66sh-ZlmMeLMXYr8qGldr7AuZY3yz8ihjybHXkgjyd9N01pd5Y0NXm2w4CWcaROF3_eoBiMcqJLyjS2tI-Zpx602p7hsYINszaNb_AfV-ekw4A-xWGaHQqv9a8yqOU1Ap3D6QvhjwxeA6cVBkqgG9pw5fJ8GcF6TfNP2n-gE9ELaIXyAzLSev-mu7Phyf-yEStVXInZjaZoEQN4TXA5Y7QlcYVnkEiSo-8D-Fcs	6cf11de471e4399e4de71726072c0cf598642777aec19ba7f2b43842391f24ab	3fdf1676f6a7491b63563e6b8fbcf0efb4f35818d11f976e176d223478a48a75	86400	openid profile	Bearer		t	0
admin	0b0e7e14-e599-4f2c-909f-f558ef911896	2026-05-11T23:53:09Z	transport-deluxe	transport-deluxe	test-cost-configurator	05d2f131b1bf6323de18	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoiYWNjZXNzLXRva2VuIiwidGFnIjoiIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSIsImF6cCI6InRyYW5zcG9ydC1kZWx1eGUtY2xpZW50IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDAwIiwic3ViIjoiMzAyZWI0MWEtZGU1Yy00NzY1LTgyNjEtNzk3OTY4ODRmZmQxIiwiYXVkIjpbInRyYW5zcG9ydC1kZWx1eGUtY2xpZW50Il0sImV4cCI6MTc3ODYyOTk4OSwibmJmIjoxNzc4NTQzNTg5LCJpYXQiOjE3Nzg1NDM1ODksImp0aSI6ImFkbWluLzBiMGU3ZTE0LWU1OTktNGYyYy05MDlmLWY1NThlZjkxMTg5NiJ9.e5vklnWd5VPUeQ5BKMIkh0sBekj37rSWWAyDFZFfXWrRPFCaBrz2TRA2bySU81bgWWvYoEtanMFIr4GkFhs6WJpqEeOV34U9BQai5mDxV-m1iYX1lK_D7eGxR-TDoGgcRYxyHIsp-hSaYD8-aA7b_pD5SLuzdvocdUejVGdvgt6w590IlzB1AVd4TQAD4dXJcL0vXTRu1c0bXXH_TIPj71faxzsFXdic_aIgjAMn0KdtqBgt_kxVaOc3KRyxdO1_dDwyRCw_D-37RoIUk0GkMpwv8vq40iG0dOw4blDnlKpi4Ujbjql8YX-lZywikvZyvB2JHAQ_4vWYuDamzf5FboPM6zw_jCQlb5wDKLc7CTf_tZ8ocuWXKe-gEaQ-6n5uOIYr8tYq7FGFGOmCVnbQjlYj3i6aNYxY8FcYrxXtVVT9V_DyRpkRGhVIS34ewzALV0_No_nbwD8eyQ8WJUXu7KI_5eJQKxynZfJOzIC8hDSEyhn0p2FVLNbyPHJBk4qNFmx501THahtT2ilgiVStefjTtbBL35zFxXNPL7Gin_w-iYblAKnOsKrJSc7YtljMfRiy68BlvhT2unQGKK35l7TZwjYunPVxVIr8eU9PiSieEj-x9CAU2AtciLDsE82QJpgyczNYNftFo0KjyRTv0yy8h6Qeg5J1NoYr_40UBe0	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1jb3N0LWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJ1cGRhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGVsZXRlZFRpbWUiOiIiLCJpZCI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsInR5cGUiOiIiLCJwYXNzd29yZCI6IiIsInBhc3N3b3JkU2FsdCI6IjgxNjk3NjIzYjQwNmZjNTc1YWZhIiwicGFzc3dvcmRUeXBlIjoicGxhaW4iLCJkaXNwbGF5TmFtZSI6IlRlc3QgQ29zdCBDb25maWd1cmF0b3IiLCJmaXJzdE5hbWUiOiIiLCJsYXN0TmFtZSI6IiIsImF2YXRhciI6IiIsImF2YXRhclR5cGUiOiIiLCJwZXJtYW5lbnRBdmF0YXIiOiIiLCJlbWFpbCI6InRlc3QtY29zdC1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjoyLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoiY29zdC1jb25maWd1cmF0b3IiLCJjcmVhdGVkVGltZSI6IjIwMjYtMDUtMTBUMDE6MTQ6MzVaIiwiZGlzcGxheU5hbWUiOiJDb3N0IENvbmZpZ3VyYXRvciIsImRlc2NyaXB0aW9uIjoiIiwidXNlcnMiOm51bGwsImdyb3VwcyI6bnVsbCwicm9sZXMiOltdLCJkb21haW5zIjpbXSwiaXNFbmFibGVkIjp0cnVlfV0sInBlcm1pc3Npb25zIjpbXSwiZ3JvdXBzIjpbXSwibGFzdFNpZ25pbldyb25nVGltZSI6IiIsInNpZ25pbldyb25nVGltZXMiOjAsIm1hbmFnZWRBY2NvdW50cyI6bnVsbCwidG9rZW5UeXBlIjoicmVmcmVzaC10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6IjMwMmViNDFhLWRlNWMtNDc2NS04MjYxLTc5Nzk2ODg0ZmZkMSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2Mjk5ODksIm5iZiI6MTc3ODU0MzU4OSwiaWF0IjoxNzc4NTQzNTg5LCJqdGkiOiJhZG1pbi8wYjBlN2UxNC1lNTk5LTRmMmMtOTA5Zi1mNTU4ZWY5MTE4OTYifQ.FTTpJvx2eenLPgV7xNZ6a2Kmzgfv3Bf6a1tgas5imAA_o-Rtubx9313XT0O7_jyZjVQLOJNpiyE8pYsg04zG8EuCj-mkK63O4AdU5NSMqnGv-dIPrjf8mOoCitDLU1iAc8-dIqEzppD_BLy-LoJBXtT7B5E6SV2aSGii80OPb-yIXe7nF1GzY_ekdmgi7rBlZg43EFyp_IqcL4XZ_dim3mIGrvelahCurtFEceZamnVzixZT7TV578k4pNf3eAjICyGNbUS0iFAQmi9TzW9bq-PrFoLqqNMCfKojoGVHJY-Px_15yvIK95C5p4T_b_MmBCPSag7yNh4JoLCAtmRZQ1_sNvoa7QfOYhhMvYuBkTppyQa031KLY-WIyMc7ygaaUSxDOVcJw6u8NsQb3XqDRrDZBRSr2UGkZXmb5DhPAu0gOj5_SE-pYfWl6sdCipCOEULcbR_agnvfDy9G2ADkVsHVtIu4jWPdsPZu80FlmHMOnAdCQRlO3H_p5hqdD2_a-Vh72aJGhyCntebBA4kiCq2psOO3Lo_jE_PByXc4SkIUY3m5yGzvnqV6SAyQCr1vUo3nj-jF1BLChZyDsZ9L7BgJg-zjMNqyLrrJuhHyuVuqrKZHVfIWeVZqKqMf9ntxpaC6nNnwjKjCfxprId2HjI5yQgCK16XmO1g14crvtpA	e12dc5db8c45cd8fc12ec461e9c7a5fc3172d8b910d89f67b039df76c16d8b79	4db95282f243a13a246f32f900a577f805bcead2f02aa4e12b1d75297da540d5	86400	openid profile	Bearer		t	0
admin	adef8d12-7a9a-48fd-9807-5a89e49ebebb	2026-05-11T23:53:22Z	transport-deluxe	transport-deluxe	test-margin-configurator	3d2245c951d4330b05aa	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6ImVkY2NiMzg4LTI5MjktNDlhYi04OGI5LWRjOTk0MGRlMmY2YSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2MzAwMDIsIm5iZiI6MTc3ODU0MzYwMiwiaWF0IjoxNzc4NTQzNjAyLCJqdGkiOiJhZG1pbi9hZGVmOGQxMi03YTlhLTQ4ZmQtOTgwNy01YTg5ZTQ5ZWJlYmIifQ.ljW1CjTCvUC_Y9evyNlLykK-yngtT5R8mu--rTPPPloQSV9TC6nv8b6Rc_OjEa8E0p4OL8YqzBwWuOld0CCfmUzmjHdvL_UAY25AS4TxivKsbm2uQ1ormQiFJn7WJfYUjqccpatHW6oZtlZlGTTZ9Ag-KeHyf67c-R73kpmN494DVLEqRBi-uM2IkE_uR02XvDi607NbSahJJGBKtZ1Bdd5U_UTMg3pGvIALJ2DZBH721TqL8k6Z8gs1nSxVfzoVx1RTWDq-zlBXmynyO9GVB74x8p4PQ8zwttmzONj2dj7zvBo8A7iPbLGUXKJtlY4gIzvFqHTtPJIfuJq0AL9BCJ5VXAByb47-kbhQqHBta8unqh5cDy5iNmGFeBUM-sgkJW1nSiFv9TEijhrTb8KSn7uAZE1boNgfpkI9leacI3kf0BUmzkF6pWN4Rp_sq4r0aTod915OoRPXOPh0ezw3zkVZYMreanq_kH8db0Aw-mE_S7_e6WvTC0Bs2Ogdzazw1Mtu6TquTZg8oRznMLTEh-RRp_NS4nRzCgkR7Y1--DwGGHYQnb8M1OLJyR9P0ECmWUOhESmR6yD_G8dcRUBwqadrpWJeB4CHWUiHKgF7swFG0VqapOM9FqG0LM3SfA5zjYT_BO2xYKcNSN9W_-7vawxGJE3GzQmvtZsCVnp7M3o	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJ0YWciOiIiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIiwiYXpwIjoidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiLCJzdWIiOiJlZGNjYjM4OC0yOTI5LTQ5YWItODhiOS1kYzk5NDBkZTJmNmEiLCJhdWQiOlsidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiXSwiZXhwIjoxNzc4NjMwMDAyLCJuYmYiOjE3Nzg1NDM2MDIsImlhdCI6MTc3ODU0MzYwMiwianRpIjoiYWRtaW4vYWRlZjhkMTItN2E5YS00OGZkLTk4MDctNWE4OWU0OWViZWJiIn0.A3AeLuO2_KY1V88bKMjyjJ0j3QrSZW72_cKp8_p604gsVSqxOEtkUK8bf34WRSx_wVNvYNI8RmO4l_V2yKjew8QpLj6CxUtAHU-zcRndSQqSn4FsYt9HwFzaA5g8Bvxw4tMgtUmqocfo64-1Qbq11EQBC6z5SSUNckcD6PZv1eVOrISugg0Tnd8ZZnQ3NndxV4K-B7cuuwj9a9qm27Voy7uEmwDnezoUjJHp97ooAgQcwn6BNaiEnytY4BK6BMkNcea9kfmKGy1Vildc-U5R3CG0UR4vKU7TriROqDCcaMyDWZBdYHKI7pEqN32XmFb8zVRkGBRB-klbVKVnMO2Bhvmp8v4KR9dVwHgezPfPvPRuAibANZmP2PDV9Hlv-GVhHZXXYJCAQybNMj1axOP53vHHmWzFE11rroQWmV7K9KO8CdJ1cM-MyxyCy5d3oT-uAJ7etPMp_O3dETwNA299gToZaRVJivmuT1HOcXZa8qjp_m5jg0Z54hVI9LY69kKUXJR1b6YnWsBK7YvX3I1KlpS_N-az_MEq82Uz_6MA6IPx_P29UlxSMAbXHEZX4Th7QpQMeuqyJH14WzPOaRbEXj2NB83GZ43TSEY2r8M4h5hdJp5-gA0aQh4XHoe6CwjzEcDL_iXcBpIBFJbVvem4xvNWQKlJ1k60uM4nJDIjtwA	7ff9ded54ae8e1ecb0c4a4ac0d60d8c43d58033eb94d6ac02ba0f421fd3c958d	a4b6b29ca986ac009732aa0b7c6e99bd210df7f462ea3c508e5eb165bef12e4f	86400	openid profile	Bearer		t	0
admin	07043c6c-2dfc-4515-bf20-b3209ac31d93	2026-05-11T23:54:33Z	transport-deluxe	transport-deluxe	test-margin-configurator	d8fc27a6fa5a2ef6c9ff	eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlcnQtYnVpbHQtaW4iLCJ0eXAiOiJKV1QifQ.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6ImFjY2Vzcy10b2tlbiIsInRhZyI6IiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUiLCJhenAiOiJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCIsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCIsInN1YiI6ImVkY2NiMzg4LTI5MjktNDlhYi04OGI5LWRjOTk0MGRlMmY2YSIsImF1ZCI6WyJ0cmFuc3BvcnQtZGVsdXhlLWNsaWVudCJdLCJleHAiOjE3Nzg2MzAwNzMsIm5iZiI6MTc3ODU0MzY3MywiaWF0IjoxNzc4NTQzNjczLCJqdGkiOiJhZG1pbi8wNzA0M2M2Yy0yZGZjLTQ1MTUtYmYyMC1iMzIwOWFjMzFkOTMifQ.D7IINc64Eh_1FsbOZGdpMp0cjaXtsD6NISQXA4kBP8Esw1GMnUbjyvMq0wqr1fpuftH9AIY4uPR4Iomd6xi5WM8gNdpsOaZyA_Gq7sacDLY4p0XFh9pLkn180DJcui9TEisQihkTvxorb2H02aiuzXtR9Px43WHj8_B6cxqYpi-bt_NYTfLeyS8KYyC6P_uhExdBC_UaiY0wYIqSWE1uoCXUSnZCREsPwf_s3bQxqPg7nPKT64TLBQeAs2MAIXeiP64VUFAWLhdsV4z_KsUYir9Dm0eazxmXcTh2L2dS8Mih1dADoxwF-Bam6zdQizOznnQwq4PMAW-G3PmMmfG87FIOsUgQRF3kFQe8MF2qdhjh0s9we73JlA2A-FzbVHjTCVKxp_2oCoPPN3UH923Tw8WUNayAQqh9awkhwbaxD58aS5194_4IEQKGTcAdOZD75W4DqP_dVkB7K_RSOuZ0Cuj161jCyGUEucollHXHNsB7KddAKfE085li23a6LLnMXP-_h8xiuhY2FHIFw7yl3bUO1IqB03KZyU2CVAuyb_xMVXBzOA9N1apuqGdq9J1x5EOomo6xKP4dOE0iYObueSyOPK2oGhAyt-TFKm32HGtneOW73OCgp3MHE142XPXCRpZFnspV6kgiBa8-uvatS28TBP78d48eNwFTxt1qqjA	eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoidGVzdC1tYXJnaW4tY29uZmlndXJhdG9yIiwiY3JlYXRlZFRpbWUiOiIyMDI2LTA1LTEwVDAxOjE0OjM1WiIsInVwZGF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkZWxldGVkVGltZSI6IiIsImlkIjoiZWRjY2IzODgtMjkyOS00OWFiLTg4YjktZGM5OTQwZGUyZjZhIiwidHlwZSI6IiIsInBhc3N3b3JkIjoiIiwicGFzc3dvcmRTYWx0IjoiYmFhOGI2NTM5MWY1ZTUzOTQyZDYiLCJwYXNzd29yZFR5cGUiOiJwbGFpbiIsImRpc3BsYXlOYW1lIjoiVGVzdCBNYXJnaW4gQ29uZmlndXJhdG9yIiwiZmlyc3ROYW1lIjoiIiwibGFzdE5hbWUiOiIiLCJhdmF0YXIiOiIiLCJhdmF0YXJUeXBlIjoiIiwicGVybWFuZW50QXZhdGFyIjoiIiwiZW1haWwiOiJ0ZXN0LW1hcmdpbi1jb25maWd1cmF0b3JAdHJhbnNwb3J0LWRlbHV4ZS5sb2NhbCIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmUiOiIiLCJjb3VudHJ5Q29kZSI6IiIsInJlZ2lvbiI6IiIsImxvY2F0aW9uIjoiIiwiYWRkcmVzcyI6W10sImFmZmlsaWF0aW9uIjoiIiwidGl0bGUiOiIiLCJpZENhcmRUeXBlIjoiIiwiaWRDYXJkIjoiIiwiaG9tZXBhZ2UiOiIiLCJiaW8iOiIiLCJsYW5ndWFnZSI6IiIsImdlbmRlciI6IiIsImJpcnRoZGF5IjoiIiwiZWR1Y2F0aW9uIjoiIiwic2NvcmUiOjAsImthcm1hIjowLCJyYW5raW5nIjozLCJpc0RlZmF1bHRBdmF0YXIiOmZhbHNlLCJpc09ubGluZSI6ZmFsc2UsImlzQWRtaW4iOmZhbHNlLCJpc0ZvcmJpZGRlbiI6ZmFsc2UsImlzRGVsZXRlZCI6ZmFsc2UsInNpZ251cEFwcGxpY2F0aW9uIjoiIiwiaGFzaCI6IiIsInByZUhhc2giOiIiLCJyZWdpc3RlclR5cGUiOiIiLCJyZWdpc3RlclNvdXJjZSI6IiIsImdpdGh1YiI6IiIsImdvb2dsZSI6IiIsInFxIjoiIiwid2VjaGF0IjoiIiwiZmFjZWJvb2siOiIiLCJkaW5ndGFsayI6IiIsIndlaWJvIjoiIiwiZ2l0ZWUiOiIiLCJsaW5rZWRpbiI6IiIsIndlY29tIjoiIiwibGFyayI6IiIsImdpdGxhYiI6IiIsImNyZWF0ZWRJcCI6IiIsImxhc3RTaWduaW5UaW1lIjoiIiwibGFzdFNpZ25pbklwIjoiIiwicHJlZmVycmVkTWZhVHlwZSI6IiIsInJlY292ZXJ5Q29kZXMiOm51bGwsInRvdHBTZWNyZXQiOiIiLCJtZmFQaG9uZUVuYWJsZWQiOmZhbHNlLCJtZmFFbWFpbEVuYWJsZWQiOmZhbHNlLCJsZGFwIjoiIiwicHJvcGVydGllcyI6e30sInJvbGVzIjpbeyJvd25lciI6InRyYW5zcG9ydC1kZWx1eGUiLCJuYW1lIjoibWFyZ2luLWNvbmZpZ3VyYXRvciIsImNyZWF0ZWRUaW1lIjoiMjAyNi0wNS0xMFQwMToxNDozNVoiLCJkaXNwbGF5TmFtZSI6Ik1hcmdpbiBDb25maWd1cmF0b3IiLCJkZXNjcmlwdGlvbiI6IiIsInVzZXJzIjpudWxsLCJncm91cHMiOm51bGwsInJvbGVzIjpbXSwiZG9tYWlucyI6W10sImlzRW5hYmxlZCI6dHJ1ZX1dLCJwZXJtaXNzaW9ucyI6W10sImdyb3VwcyI6W10sImxhc3RTaWduaW5Xcm9uZ1RpbWUiOiIiLCJzaWduaW5Xcm9uZ1RpbWVzIjowLCJtYW5hZ2VkQWNjb3VudHMiOm51bGwsInRva2VuVHlwZSI6InJlZnJlc2gtdG9rZW4iLCJ0YWciOiIiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIiwiYXpwIjoidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiLCJzdWIiOiJlZGNjYjM4OC0yOTI5LTQ5YWItODhiOS1kYzk5NDBkZTJmNmEiLCJhdWQiOlsidHJhbnNwb3J0LWRlbHV4ZS1jbGllbnQiXSwiZXhwIjoxNzc4NjMwMDczLCJuYmYiOjE3Nzg1NDM2NzMsImlhdCI6MTc3ODU0MzY3MywianRpIjoiYWRtaW4vMDcwNDNjNmMtMmRmYy00NTE1LWJmMjAtYjMyMDlhYzMxZDkzIn0.sbIyQcfR8WvgUF6GlBX3IKalGwoUUcb6wdLlfCDjUcdsqI_BxcPWrjLixRnBUcjudOkYKWoSotqBeokmftbWMjS0nBT9X_xcQi5rEh7jCbxTOl2ymGhT2rPfhiCenssJuD1t65ge9NkDhEuGDCGfYeoCQ6b_O7TjLiBIpsYiW4afXMskGiCjpGIQbjhiXm9qACr5WcDbq18JHO1qB3Hi1zqS9D8xgfuJMHRWdZRVkG4e6jglKzF47PL1AxCVY84OnD6eCHppF22z5s-k4CX7GJiKMZ1Gc0szj7f_B5orImC-8kx0n29Na_ccbKzraUWCC_kZcMdrJ9E-RYGgLI7NKfap7-Ue2wQZoYDyiuEHCabxLFsid5csMUOBSdT8rmPEinom_dKn_iIJ86qmQXkgUdROUVMATwNb_HoObycCtKoeVgElRnf02AvZDzB4Lart4f4T9L3WDEFhyBQdem9SJpW7d3FqE-0DaMJ1y_43mpabKWGsm7o9rZG1MytfkRgWQRTu423rAMKrANlcNgoLW5iffEWhnR-5h4OB5KRZIZZB75mW1rA76rPKbTDFQuf_H2qWIz4E18V2tOeNcqYzMDFPQRKXTg_ez5KCCW71I7cTeiBzuxP6uMltsiI3KBNpynOtxLVO_koh-yHW-QUhXY0A6m2BQA3TB60pDCvaKe0	8054080c69aa46cf98dc4bc6f1b747ec009f0a650ae76e83a60e5d1c0cbd1d69	aa77967b4657ce3913cffcfc3c70de7aafd5f8e770777de5c7bb1a6b53abecd8	86400	openid profile	Bearer		t	0
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction (owner, name, created_time, display_name, application, domain, category, type, subtype, provider, "user", tag, amount, currency, payment, state) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (owner, name, created_time, updated_time, deleted_time, id, external_id, type, password, password_salt, password_type, display_name, first_name, last_name, avatar, avatar_type, permanent_avatar, email, email_verified, phone, country_code, region, location, address, addresses, affiliation, title, id_card_type, id_card, real_name, is_verified, homepage, bio, tag, language, gender, birthday, education, score, karma, ranking, balance, balance_credit, currency, balance_currency, is_default_avatar, is_online, is_admin, is_forbidden, is_deleted, signup_application, hash, pre_hash, register_type, register_source, access_token, original_token, original_refresh_token, created_ip, last_signin_time, last_signin_ip, github, google, qq, wechat, facebook, dingtalk, weibo, gitee, linkedin, wecom, lark, gitlab, adfs, baidu, alipay, casdoor, infoflow, apple, azuread, azureadb2c, slack, steam, bilibili, okta, douyin, kwai, line, amazon, auth0, battlenet, bitbucket, box, cloudfoundry, dailymotion, deezer, digitalocean, discord, dropbox, eveonline, fitbit, gitea, heroku, influxcloud, instagram, intercom, kakao, lastfm, mailru, meetup, microsoftonline, naver, nextcloud, onedrive, oura, patreon, paypal, salesforce, shopify, soundcloud, spotify, strava, stripe, telegram, tiktok, tumblr, twitch, twitter, typetalk, uber, vk, wepay, xero, yahoo, yammer, yandex, zoom, metamask, web3onboard, custom, custom2, custom3, custom4, custom5, custom6, custom7, custom8, custom9, custom10, "webauthnCredentials", preferred_mfa_type, recovery_codes, totp_secret, mfa_phone_enabled, mfa_email_enabled, mfa_radius_enabled, mfa_radius_username, mfa_radius_provider, mfa_push_enabled, mfa_push_receiver, mfa_push_provider, invitation, invitation_code, face_ids, cart, ldap, properties, roles, permissions, groups, last_change_password_time, last_signin_wrong_time, signin_wrong_times, "managedAccounts", "mfaAccounts", mfa_items, mfa_remember_deadline, need_update_password, ip_whitelist, application_scopes) FROM stdin;
built-in	admin	2026-05-10T01:14:34Z	2026-05-10T01:14:34Z		6496cc0b-cc93-40f5-b6c7-03b037c3b780		normal-user	$2a$10$KcFc1934ZDOcxtdgspjuT.S.OFs6NAjlkirfSZ6K4zaQFgTIwHdpO	93846ef5b075c4407c40	bcrypt	Admin			https://cdn.casbin.org/img/casbin.svg			admin@example.com	f	12345678910	US			[]	\\x6e756c6c	Example Inc.					f			staff					2000	0	1	0	0		USD	f	f	t	f	f	app-built-in			Add User	built-in/admin				127.0.0.1																																																																																											\\x6e756c6c		null		f	f	f			f					null	null		{}	null	null	null			0	\\x6e756c6c	\\x6e756c6c	null		f		null
transport-deluxe	admin	2026-05-10T01:14:35Z	2026-05-10T01:14:35Z		089ac919-f55b-4ec7-b506-8bd91ff7d713			123	102111070abb684433be	plain	Admin						admin@transport-deluxe.local	f					null	\\x6e756c6c						f								0	0	1	0	0		USD	f	f	t	f	f																																																																																																				\\x6e756c6c		null		f	f	f			f					null	null		{}	null	null	null			0	\\x6e756c6c	\\x6e756c6c	null		f		null
transport-deluxe	test-cost-configurator	2026-05-10T01:14:35Z	2026-05-10T01:14:35Z		302eb41a-de5c-4765-8261-79796884ffd1			test123	81697623b406fc575afa	plain	Test Cost Configurator						test-cost-configurator@transport-deluxe.local	f					null	\\x6e756c6c						f								0	0	2	0	0		USD	f	f	f	f	f																																																																																																				\\x6e756c6c		null		f	f	f			f					null	null		{}	null	null	null			0	\\x6e756c6c	\\x6e756c6c	null		f		null
transport-deluxe	test-margin-configurator	2026-05-10T01:14:35Z	2026-05-10T01:14:35Z		edccb388-2929-49ab-88b9-dc9940de2f6a			test123	baa8b65391f5e53942d6	plain	Test Margin Configurator						test-margin-configurator@transport-deluxe.local	f					null	\\x6e756c6c						f								0	0	3	0	0		USD	f	f	f	f	f																																																																																																				\\x6e756c6c		null		f	f	f			f					null	null		{}	null	null	null			0	\\x6e756c6c	\\x6e756c6c	null		f		null
transport-deluxe	test-predictor	2026-05-10T01:14:35Z	2026-05-10T01:14:35Z		261dc68b-e656-421d-9149-b95d0a2e0d80			test123	63233d185fc38ac65257	plain	Test Predictor						test-predictor@transport-deluxe.local	f					null	\\x6e756c6c						f								0	0	4	0	0		USD	f	f	f	f	f																																																																																																				\\x6e756c6c		null		f	f	f			f					null	null		{}	null	null	null			0	\\x6e756c6c	\\x6e756c6c	null		f		null
transport-deluxe	test-super-configurator	2026-05-10T01:14:35Z	2026-05-10T01:14:35Z		89ad4fa7-9587-4623-84e4-99405d68bf91			test123	a39a8babbc883b99f4c7	plain	Test Super Configurator						test-super-configurator@transport-deluxe.local	f					null	\\x6e756c6c						f								0	0	5	0	0		USD	f	f	f	f	f																																																																																																				\\x6e756c6c		null		f	f	f			f					null	null		{}	null	null	null			0	\\x6e756c6c	\\x6e756c6c	null		f		null
\.


--
-- Data for Name: verification_record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verification_record (owner, name, created_time, remote_addr, type, "user", provider, receiver, code, "time", is_used) FROM stdin;
\.


--
-- Data for Name: webhook; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook (owner, name, created_time, organization, url, method, content_type, headers, events, token_fields, object_fields, is_user_extended, single_org_only, is_enabled, max_retries, retry_interval, use_exponential_backoff) FROM stdin;
\.


--
-- Data for Name: webhook_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook_event (owner, name, created_time, updated_time, webhook, organization, event_type, state, payload, extended_user, attempt_count, max_retries, next_retry_time, last_status_code, last_response, last_error) FROM stdin;
\.


--
-- Name: casbin_api_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.casbin_api_rule_id_seq', 96, true);


--
-- Name: casbin_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.casbin_rule_id_seq', 1, false);


--
-- Name: casbin_user_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.casbin_user_rule_id_seq', 1, false);


--
-- Name: coupon_usage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coupon_usage_id_seq', 1, false);


--
-- Name: permission_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permission_rule_id_seq', 3, true);


--
-- Name: record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.record_id_seq', 61, true);


--
-- Name: adapter adapter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adapter
    ADD CONSTRAINT adapter_pkey PRIMARY KEY (owner, name);


--
-- Name: agent agent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agent
    ADD CONSTRAINT agent_pkey PRIMARY KEY (owner, name);


--
-- Name: application application_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_pkey PRIMARY KEY (owner, name);


--
-- Name: casbin_api_rule casbin_api_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casbin_api_rule
    ADD CONSTRAINT casbin_api_rule_pkey PRIMARY KEY (id);


--
-- Name: casbin_rule casbin_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casbin_rule
    ADD CONSTRAINT casbin_rule_pkey PRIMARY KEY (id);


--
-- Name: casbin_user_rule casbin_user_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.casbin_user_rule
    ADD CONSTRAINT casbin_user_rule_pkey PRIMARY KEY (id);


--
-- Name: cert cert_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cert
    ADD CONSTRAINT cert_pkey PRIMARY KEY (owner, name);


--
-- Name: coupon coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupon
    ADD CONSTRAINT coupon_pkey PRIMARY KEY (owner, name);


--
-- Name: coupon_usage coupon_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coupon_usage
    ADD CONSTRAINT coupon_usage_pkey PRIMARY KEY (id);


--
-- Name: enforcer enforcer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enforcer
    ADD CONSTRAINT enforcer_pkey PRIMARY KEY (owner, name);


--
-- Name: entry entry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.entry
    ADD CONSTRAINT entry_pkey PRIMARY KEY (owner, name);


--
-- Name: form form_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.form
    ADD CONSTRAINT form_pkey PRIMARY KEY (owner, name);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (owner, name);


--
-- Name: invitation invitation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation
    ADD CONSTRAINT invitation_pkey PRIMARY KEY (owner, name);


--
-- Name: key key_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.key
    ADD CONSTRAINT key_pkey PRIMARY KEY (owner, name);


--
-- Name: ldap ldap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ldap
    ADD CONSTRAINT ldap_pkey PRIMARY KEY (id);


--
-- Name: model model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_pkey PRIMARY KEY (owner, name);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (owner, name);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (owner, name);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (owner, name);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (owner, name);


--
-- Name: permission_rule permission_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_rule
    ADD CONSTRAINT permission_rule_pkey PRIMARY KEY (id);


--
-- Name: plan plan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (owner, name);


--
-- Name: pricing pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pricing
    ADD CONSTRAINT pricing_pkey PRIMARY KEY (owner, name);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (owner, name);


--
-- Name: provider provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT provider_pkey PRIMARY KEY (owner, name);


--
-- Name: radius_accounting radius_accounting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.radius_accounting
    ADD CONSTRAINT radius_accounting_pkey PRIMARY KEY (owner, name);


--
-- Name: record record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_pkey PRIMARY KEY (id);


--
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (owner, name);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (owner, name);


--
-- Name: rule rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule
    ADD CONSTRAINT rule_pkey PRIMARY KEY (owner, name);


--
-- Name: server server_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.server
    ADD CONSTRAINT server_pkey PRIMARY KEY (owner, name);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (owner, name, application);


--
-- Name: site site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site
    ADD CONSTRAINT site_pkey PRIMARY KEY (owner, name);


--
-- Name: subscription subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT subscription_pkey PRIMARY KEY (owner, name);


--
-- Name: syncer syncer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syncer
    ADD CONSTRAINT syncer_pkey PRIMARY KEY (owner, name);


--
-- Name: third_party_link third_party_link_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.third_party_link
    ADD CONSTRAINT third_party_link_pkey PRIMARY KEY (owner, user_name, provider_name);


--
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (owner, name);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (owner, name);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (owner, name);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (owner, name);


--
-- Name: verification_record verification_record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification_record
    ADD CONSTRAINT verification_record_pkey PRIMARY KEY (owner, name);


--
-- Name: webhook_event webhook_event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook_event
    ADD CONSTRAINT webhook_event_pkey PRIMARY KEY (owner, name);


--
-- Name: webhook webhook_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_pkey PRIMARY KEY (owner, name);


--
-- Name: IDX_casbin_api_rule_ptype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_api_rule_ptype" ON public.casbin_api_rule USING btree (ptype);


--
-- Name: IDX_casbin_api_rule_v0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_api_rule_v0" ON public.casbin_api_rule USING btree (v0);


--
-- Name: IDX_casbin_api_rule_v1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_api_rule_v1" ON public.casbin_api_rule USING btree (v1);


--
-- Name: IDX_casbin_api_rule_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_api_rule_v2" ON public.casbin_api_rule USING btree (v2);


--
-- Name: IDX_casbin_api_rule_v3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_api_rule_v3" ON public.casbin_api_rule USING btree (v3);


--
-- Name: IDX_casbin_api_rule_v4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_api_rule_v4" ON public.casbin_api_rule USING btree (v4);


--
-- Name: IDX_casbin_api_rule_v5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_api_rule_v5" ON public.casbin_api_rule USING btree (v5);


--
-- Name: IDX_casbin_rule_ptype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_rule_ptype" ON public.casbin_rule USING btree (ptype);


--
-- Name: IDX_casbin_rule_v0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_rule_v0" ON public.casbin_rule USING btree (v0);


--
-- Name: IDX_casbin_rule_v1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_rule_v1" ON public.casbin_rule USING btree (v1);


--
-- Name: IDX_casbin_rule_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_rule_v2" ON public.casbin_rule USING btree (v2);


--
-- Name: IDX_casbin_rule_v3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_rule_v3" ON public.casbin_rule USING btree (v3);


--
-- Name: IDX_casbin_rule_v4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_rule_v4" ON public.casbin_rule USING btree (v4);


--
-- Name: IDX_casbin_rule_v5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_rule_v5" ON public.casbin_rule USING btree (v5);


--
-- Name: IDX_casbin_user_rule_ptype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_user_rule_ptype" ON public.casbin_user_rule USING btree (ptype);


--
-- Name: IDX_casbin_user_rule_v0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_user_rule_v0" ON public.casbin_user_rule USING btree (v0);


--
-- Name: IDX_casbin_user_rule_v1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_user_rule_v1" ON public.casbin_user_rule USING btree (v1);


--
-- Name: IDX_casbin_user_rule_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_user_rule_v2" ON public.casbin_user_rule USING btree (v2);


--
-- Name: IDX_casbin_user_rule_v3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_user_rule_v3" ON public.casbin_user_rule USING btree (v3);


--
-- Name: IDX_casbin_user_rule_v4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_user_rule_v4" ON public.casbin_user_rule USING btree (v4);


--
-- Name: IDX_casbin_user_rule_v5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_casbin_user_rule_v5" ON public.casbin_user_rule USING btree (v5);


--
-- Name: IDX_invitation_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_invitation_code" ON public.invitation USING btree (code);


--
-- Name: IDX_key_access_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_key_access_key" ON public.key USING btree (access_key);


--
-- Name: IDX_permission_rule_ptype; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_permission_rule_ptype" ON public.permission_rule USING btree (ptype);


--
-- Name: IDX_permission_rule_v0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_permission_rule_v0" ON public.permission_rule USING btree (v0);


--
-- Name: IDX_permission_rule_v1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_permission_rule_v1" ON public.permission_rule USING btree (v1);


--
-- Name: IDX_permission_rule_v2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_permission_rule_v2" ON public.permission_rule USING btree (v2);


--
-- Name: IDX_permission_rule_v3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_permission_rule_v3" ON public.permission_rule USING btree (v3);


--
-- Name: IDX_permission_rule_v4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_permission_rule_v4" ON public.permission_rule USING btree (v4);


--
-- Name: IDX_permission_rule_v5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_permission_rule_v5" ON public.permission_rule USING btree (v5);


--
-- Name: IDX_radius_accounting_acct_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_radius_accounting_acct_session_id" ON public.radius_accounting USING btree (acct_session_id);


--
-- Name: IDX_radius_accounting_acct_start_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_radius_accounting_acct_start_time" ON public.radius_accounting USING btree (acct_start_time);


--
-- Name: IDX_radius_accounting_acct_stop_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_radius_accounting_acct_stop_time" ON public.radius_accounting USING btree (acct_stop_time);


--
-- Name: IDX_radius_accounting_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_radius_accounting_username" ON public.radius_accounting USING btree (username);


--
-- Name: IDX_record_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_record_name" ON public.record USING btree (name);


--
-- Name: IDX_record_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_record_owner" ON public.record USING btree (owner);


--
-- Name: IDX_ticket_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ticket_user" ON public.ticket USING btree ("user");


--
-- Name: IDX_token_access_token_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_token_access_token_hash" ON public.token USING btree (access_token_hash);


--
-- Name: IDX_token_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_token_code" ON public.token USING btree (code);


--
-- Name: IDX_token_refresh_token_hash; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_token_refresh_token_hash" ON public.token USING btree (refresh_token_hash);


--
-- Name: IDX_user_created_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_created_time" ON public."user" USING btree (created_time);


--
-- Name: IDX_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_email" ON public."user" USING btree (email);


--
-- Name: IDX_user_external_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_external_id" ON public."user" USING btree (external_id);


--
-- Name: IDX_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_id" ON public."user" USING btree (id);


--
-- Name: IDX_user_id_card; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_id_card" ON public."user" USING btree (id_card);


--
-- Name: IDX_user_invitation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_invitation" ON public."user" USING btree (invitation);


--
-- Name: IDX_user_invitation_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_invitation_code" ON public."user" USING btree (invitation_code);


--
-- Name: IDX_user_phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_user_phone" ON public."user" USING btree (phone);


--
-- Name: IDX_verification_record_receiver; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_verification_record_receiver" ON public.verification_record USING btree (receiver);


--
-- Name: IDX_webhook_event_organization; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_webhook_event_organization" ON public.webhook_event USING btree (organization);


--
-- Name: IDX_webhook_event_state; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_webhook_event_state" ON public.webhook_event USING btree (state);


--
-- Name: IDX_webhook_event_webhook; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_webhook_event_webhook" ON public.webhook_event USING btree (webhook);


--
-- Name: IDX_webhook_organization; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_webhook_organization" ON public.webhook USING btree (organization);


--
-- Name: UQE_coupon_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UQE_coupon_code" ON public.coupon USING btree (code);


--
-- Name: UQE_group_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UQE_group_name" ON public."group" USING btree (name);


--
-- Name: UQE_provider_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UQE_provider_name" ON public.provider USING btree (name);


--
-- Name: UQE_third_party_link_link_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UQE_third_party_link_link_unique" ON public.third_party_link USING btree (owner, provider_name, provider_id);


--
-- PostgreSQL database dump complete
--

\unrestrict dZoZjtIN8zYencgIlyh6eRccaf6Cl3kxv7JfswhpLy3yTC3E9rXAEkJhCIbLXdd

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

\restrict 5AlxgmY5kKOdK2RFgDsFU6wjvCfCkgQlSshRSBFcY7d7UnedYBR3ur0a0P6hbRh

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\unrestrict 5AlxgmY5kKOdK2RFgDsFU6wjvCfCkgQlSshRSBFcY7d7UnedYBR3ur0a0P6hbRh
\connect postgres
\restrict 5AlxgmY5kKOdK2RFgDsFU6wjvCfCkgQlSshRSBFcY7d7UnedYBR3ur0a0P6hbRh

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

\unrestrict 5AlxgmY5kKOdK2RFgDsFU6wjvCfCkgQlSshRSBFcY7d7UnedYBR3ur0a0P6hbRh

--
-- Database "transport_deluxe" dump
--

--
-- PostgreSQL database dump
--

\restrict AWGxvR5GU6au3kHUZMSauyjcaxkbND2BxGGvJ0cdSLhWW8h1mOT29T6ILjzbKQ6

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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
-- Name: transport_deluxe; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE transport_deluxe WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE transport_deluxe OWNER TO postgres;

\unrestrict AWGxvR5GU6au3kHUZMSauyjcaxkbND2BxGGvJ0cdSLhWW8h1mOT29T6ILjzbKQ6
\connect transport_deluxe
\restrict AWGxvR5GU6au3kHUZMSauyjcaxkbND2BxGGvJ0cdSLhWW8h1mOT29T6ILjzbKQ6

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
-- Name: base_margin_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA base_margin_config;


ALTER SCHEMA base_margin_config OWNER TO postgres;

--
-- Name: costing_engine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA costing_engine;


ALTER SCHEMA costing_engine OWNER TO postgres;

--
-- Name: driver_tariff_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA driver_tariff_config;


ALTER SCHEMA driver_tariff_config OWNER TO postgres;

--
-- Name: fuel_cost_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA fuel_cost_config;


ALTER SCHEMA fuel_cost_config OWNER TO postgres;

--
-- Name: lead_time_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lead_time_config;


ALTER SCHEMA lead_time_config OWNER TO postgres;

--
-- Name: margin_engine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA margin_engine;


ALTER SCHEMA margin_engine OWNER TO postgres;

--
-- Name: pricing_engine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pricing_engine;


ALTER SCHEMA pricing_engine OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: base_margin_config; Owner: postgres
--

CREATE TABLE base_margin_config.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE base_margin_config.alembic_version OWNER TO postgres;

--
-- Name: base_margin_config; Type: TABLE; Schema: base_margin_config; Owner: postgres
--

CREATE TABLE base_margin_config.base_margin_config (
    uuid uuid NOT NULL,
    version integer NOT NULL,
    customer_name character varying,
    customer_subname character varying,
    pickup_country character varying,
    pickup_state character varying,
    pickup_city character varying,
    pickup_postal_code character varying,
    drop_country character varying,
    drop_state character varying,
    drop_city character varying,
    drop_postal_code character varying,
    margin_percent numeric(10,4) NOT NULL,
    created_by character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    CONSTRAINT chk_at_least_one_field CHECK (((customer_name IS NOT NULL) OR (pickup_country IS NOT NULL) OR (drop_country IS NOT NULL))),
    CONSTRAINT chk_customer_subname_requires_name CHECK (((customer_subname IS NULL) OR (customer_name IS NOT NULL))),
    CONSTRAINT chk_drop_city_requires_state CHECK (((drop_city IS NULL) OR (drop_state IS NOT NULL))),
    CONSTRAINT chk_drop_postal_requires_city CHECK (((drop_postal_code IS NULL) OR (drop_city IS NOT NULL))),
    CONSTRAINT chk_drop_state_requires_country CHECK (((drop_state IS NULL) OR (drop_country IS NOT NULL))),
    CONSTRAINT chk_pickup_city_requires_state CHECK (((pickup_city IS NULL) OR (pickup_state IS NOT NULL))),
    CONSTRAINT chk_pickup_postal_requires_city CHECK (((pickup_postal_code IS NULL) OR (pickup_city IS NOT NULL))),
    CONSTRAINT chk_pickup_state_requires_country CHECK (((pickup_state IS NULL) OR (pickup_country IS NOT NULL)))
);


ALTER TABLE base_margin_config.base_margin_config OWNER TO postgres;

--
-- Name: alembic_version; Type: TABLE; Schema: costing_engine; Owner: postgres
--

CREATE TABLE costing_engine.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE costing_engine.alembic_version OWNER TO postgres;

--
-- Name: costing_audit; Type: TABLE; Schema: costing_engine; Owner: postgres
--

CREATE TABLE costing_engine.costing_audit (
    id integer NOT NULL,
    correlation_id uuid NOT NULL,
    step_name character varying(255) NOT NULL,
    step_type character varying(50) NOT NULL,
    input json,
    output json,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE costing_engine.costing_audit OWNER TO postgres;

--
-- Name: costing_audit_id_seq; Type: SEQUENCE; Schema: costing_engine; Owner: postgres
--

CREATE SEQUENCE costing_engine.costing_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE costing_engine.costing_audit_id_seq OWNER TO postgres;

--
-- Name: costing_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: costing_engine; Owner: postgres
--

ALTER SEQUENCE costing_engine.costing_audit_id_seq OWNED BY costing_engine.costing_audit.id;


--
-- Name: alembic_version; Type: TABLE; Schema: driver_tariff_config; Owner: postgres
--

CREATE TABLE driver_tariff_config.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE driver_tariff_config.alembic_version OWNER TO postgres;

--
-- Name: driver_tariff_config; Type: TABLE; Schema: driver_tariff_config; Owner: postgres
--

CREATE TABLE driver_tariff_config.driver_tariff_config (
    uuid uuid NOT NULL,
    version integer NOT NULL,
    pickup_state character varying(50),
    drop_state character varying(50),
    tariff_factor numeric(10,4) NOT NULL,
    created_by character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE driver_tariff_config.driver_tariff_config OWNER TO postgres;

--
-- Name: alembic_version; Type: TABLE; Schema: fuel_cost_config; Owner: postgres
--

CREATE TABLE fuel_cost_config.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE fuel_cost_config.alembic_version OWNER TO postgres;

--
-- Name: fuel_cost_config; Type: TABLE; Schema: fuel_cost_config; Owner: postgres
--

CREATE TABLE fuel_cost_config.fuel_cost_config (
    uuid uuid NOT NULL,
    version integer NOT NULL,
    customer_name character varying(255),
    customer_subname character varying(255),
    truck_type character varying(50) NOT NULL,
    fuel_cost_per_km numeric(10,4) NOT NULL,
    created_by character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE fuel_cost_config.fuel_cost_config OWNER TO postgres;

--
-- Name: alembic_version; Type: TABLE; Schema: lead_time_config; Owner: postgres
--

CREATE TABLE lead_time_config.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE lead_time_config.alembic_version OWNER TO postgres;

--
-- Name: lead_time_config; Type: TABLE; Schema: lead_time_config; Owner: postgres
--

CREATE TABLE lead_time_config.lead_time_config (
    uuid uuid NOT NULL,
    version integer NOT NULL,
    min_days integer NOT NULL,
    max_days integer,
    configuration_factor numeric(5,4) NOT NULL,
    created_by character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE lead_time_config.lead_time_config OWNER TO postgres;

--
-- Name: margin_audit; Type: TABLE; Schema: margin_engine; Owner: postgres
--

CREATE TABLE margin_engine.margin_audit (
    id integer NOT NULL,
    correlation_id uuid NOT NULL,
    step_name character varying(255) NOT NULL,
    step_type character varying(50) NOT NULL,
    input json,
    output json,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE margin_engine.margin_audit OWNER TO postgres;

--
-- Name: margin_audit_id_seq; Type: SEQUENCE; Schema: margin_engine; Owner: postgres
--

CREATE SEQUENCE margin_engine.margin_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE margin_engine.margin_audit_id_seq OWNER TO postgres;

--
-- Name: margin_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: margin_engine; Owner: postgres
--

ALTER SEQUENCE margin_engine.margin_audit_id_seq OWNED BY margin_engine.margin_audit.id;


--
-- Name: pricing_audit; Type: TABLE; Schema: pricing_engine; Owner: postgres
--

CREATE TABLE pricing_engine.pricing_audit (
    id integer NOT NULL,
    correlation_id uuid NOT NULL,
    step_name character varying(255) NOT NULL,
    step_type character varying(50) NOT NULL,
    input json,
    output json,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE pricing_engine.pricing_audit OWNER TO postgres;

--
-- Name: pricing_audit_id_seq; Type: SEQUENCE; Schema: pricing_engine; Owner: postgres
--

CREATE SEQUENCE pricing_engine.pricing_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pricing_engine.pricing_audit_id_seq OWNER TO postgres;

--
-- Name: pricing_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: pricing_engine; Owner: postgres
--

ALTER SEQUENCE pricing_engine.pricing_audit_id_seq OWNED BY pricing_engine.pricing_audit.id;


--
-- Name: costing_audit id; Type: DEFAULT; Schema: costing_engine; Owner: postgres
--

ALTER TABLE ONLY costing_engine.costing_audit ALTER COLUMN id SET DEFAULT nextval('costing_engine.costing_audit_id_seq'::regclass);


--
-- Name: margin_audit id; Type: DEFAULT; Schema: margin_engine; Owner: postgres
--

ALTER TABLE ONLY margin_engine.margin_audit ALTER COLUMN id SET DEFAULT nextval('margin_engine.margin_audit_id_seq'::regclass);


--
-- Name: pricing_audit id; Type: DEFAULT; Schema: pricing_engine; Owner: postgres
--

ALTER TABLE ONLY pricing_engine.pricing_audit ALTER COLUMN id SET DEFAULT nextval('pricing_engine.pricing_audit_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: base_margin_config; Owner: postgres
--

COPY base_margin_config.alembic_version (version_num) FROM stdin;
001
\.


--
-- Data for Name: base_margin_config; Type: TABLE DATA; Schema: base_margin_config; Owner: postgres
--

COPY base_margin_config.base_margin_config (uuid, version, customer_name, customer_subname, pickup_country, pickup_state, pickup_city, pickup_postal_code, drop_country, drop_state, drop_city, drop_postal_code, margin_percent, created_by, created_at) FROM stdin;
023aa56b-2a93-481d-b70d-16c7240e9b1d	1	CustomerA	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.1000	test-margin-configurator	2026-05-11 23:57:34.790262
d78f9933-010a-4439-8039-a629e2c329cb	1	CustomerA	SubCustomerA2	\N	\N	\N	\N	\N	\N	\N	\N	0.1400	test-margin-configurator	2026-05-11 23:57:34.805343
6376746b-bb7c-4fd5-ac79-2afcd75d4444	1	CustomerA	SubCustomerA1	\N	\N	\N	\N	\N	\N	\N	\N	0.1200	test-margin-configurator	2026-05-11 23:57:34.803616
c320009e-68af-4083-98e1-5d76abe9af22	1	CustomerB	SubCustomerB1	\N	\N	\N	\N	\N	\N	\N	\N	0.1600	test-margin-configurator	2026-05-11 23:57:34.808215
624e8d9e-fe28-40bd-ae6f-dfccc967c1d7	1	CustomerB	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.1500	test-margin-configurator	2026-05-11 23:57:34.808705
4eb7b7f0-4b02-4503-a041-371a93c84af6	1	\N	\N	US	TX	\N	\N	US	\N	\N	\N	0.1100	test-margin-configurator	2026-05-11 23:57:46.864256
d28507ba-6ff2-456a-962c-651f71804525	1	\N	\N	US	\N	\N	\N	MX	\N	\N	\N	0.1500	test-margin-configurator	2026-05-11 23:57:46.86523
e8fd5114-b4a3-4bf5-85c6-40e132668d1d	1	\N	\N	US	TX	Dallas	\N	US	IL	Chicago	\N	0.1800	test-margin-configurator	2026-05-11 23:57:46.87184
2bda99e1-aac7-4680-89bf-7a3d47a7a2b7	1	\N	\N	MX	\N	\N	\N	US	\N	\N	\N	0.1200	test-margin-configurator	2026-05-11 23:57:46.873502
8935e21a-4a63-4fb1-8ad3-c6f238f0f409	1	\N	\N	US	CA	\N	\N	US	TX	\N	\N	0.1700	test-margin-configurator	2026-05-11 23:57:46.873916
60ba5e3b-ecc6-4002-b8d7-718f54c2b6cb	1	\N	\N	MX	NLE	Monterrey	64000	US	TX	Laredo	78041	0.1900	test-margin-configurator	2026-05-11 23:57:46.883827
0022b3ca-f3dd-4b00-ab9d-e2f70173abc7	1	\N	\N	MX	NLE	\N	\N	US	IL	\N	\N	0.1300	test-margin-configurator	2026-05-11 23:57:46.884062
246c28e6-1be1-42d8-9182-e3cc61bf7d3c	1	\N	\N	US	TX	Dallas	75001	US	IL	Chicago	60654	0.2000	test-margin-configurator	2026-05-11 23:57:46.885994
78ae7799-69b1-4145-9704-b31f93253b7c	1	\N	\N	MX	NLE	Monterrey	\N	US	TX	Laredo	\N	0.1600	test-margin-configurator	2026-05-11 23:57:46.886933
4458ca52-91df-41ab-8b6f-d3185e46ea2e	1	\N	\N	US	\N	\N	\N	US	\N	\N	\N	0.1000	test-margin-configurator	2026-05-11 23:57:46.886644
ae118e8d-98bf-4983-9da6-b4b096d74a33	1	CustomerC	SubCustomerC2	\N	\N	\N	\N	US	TX	\N	\N	0.1300	test-margin-configurator	2026-05-11 23:57:58.969424
697def14-077e-45fe-819a-2332908c70f2	1	CustomerA	\N	US	TX	\N	\N	US	TX	Austin	\N	0.1800	test-margin-configurator	2026-05-11 23:57:58.969896
0723211a-1e25-4254-b992-d71552b008c8	1	CustomerC	\N	MX	\N	\N	\N	US	\N	\N	\N	0.1100	test-margin-configurator	2026-05-11 23:57:58.978215
5dd461e3-2e2a-4dc2-823a-c36a050628c7	1	CustomerC	SubCustomerC3	US	\N	\N	\N	US	TX	Laredo	\N	0.1600	test-margin-configurator	2026-05-11 23:57:58.979689
25cb4a2c-c05f-420f-b4f1-ed0101138c68	1	CustomerA	\N	US	TX	\N	\N	US	\N	\N	\N	0.1400	test-margin-configurator	2026-05-11 23:57:58.980879
5f0f2f11-ff85-4953-98f7-6090a1c30fbd	1	CustomerC	\N	US	\N	\N	\N	MX	\N	\N	\N	0.1000	test-margin-configurator	2026-05-11 23:57:58.987276
7874c5a1-e05d-451f-9a0c-efe02dbf204f	1	CustomerC	SubCustomerC1	US	CA	\N	\N	\N	\N	\N	\N	0.1200	test-margin-configurator	2026-05-11 23:57:58.988567
9ae6d6e8-3055-4e16-9add-7d2e022af6b4	1	CustomerA	SubCustomerA1	US	TX	Dallas	\N	US	\N	\N	\N	0.1700	test-margin-configurator	2026-05-11 23:57:59.013091
c53b35c8-5132-4444-8f99-50f86e5aba7f	1	CustomerB	\N	MX	JAL	Guadalajara	\N	US	\N	\N	\N	0.1900	test-margin-configurator	2026-05-11 23:57:59.014518
03a4af46-c70e-456a-ad22-b8e519fc518b	1	CustomerB	SubCustomerB1	US	TX	\N	\N	MX	NLE	\N	\N	0.1500	test-margin-configurator	2026-05-11 23:57:59.014337
66439e9a-8f37-4d27-a2bf-99cb26fd3c51	1	CustomerC	SubCustomerC2	US	TX	Austin	73301	US	IL	Chicago	60601	0.1000	test-margin-configurator	2026-05-11 23:58:10.351399
790ffce5-b84e-46dd-8b9c-3a16f0dd6d5a	1	CustomerB	SubCustomerB1	US	TX	Laredo	78041	MX	NLE	Monterrey	64000	0.1300	test-margin-configurator	2026-05-11 23:58:10.358617
0510af39-b68e-44a5-bf03-a4d17ee8ad15	1	CustomerA	SubCustomerA2	MX	NLE	Monterrey	64000	US	TX	Dallas	75001	0.1500	test-margin-configurator	2026-05-11 23:58:10.36509
fcc6ea1b-c00a-4ac3-b621-83e1a8f1bd6b	1	CustomerC	SubCustomerC3	MX	JAL	Guadalajara	44100	US	CA	Los Angeles	90001	0.1700	test-margin-configurator	2026-05-11 23:58:10.364875
5b2a7e56-6899-4da2-9541-af66020437fd	1	CustomerA	\N	US	TX	Dallas	75001	US	TX	Austin	73301	0.1100	test-margin-configurator	2026-05-11 23:58:10.365722
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: costing_engine; Owner: postgres
--

COPY costing_engine.alembic_version (version_num) FROM stdin;
001
\.


--
-- Data for Name: costing_audit; Type: TABLE DATA; Schema: costing_engine; Owner: postgres
--

COPY costing_engine.costing_audit (id, correlation_id, step_name, step_type, input, output, "timestamp") FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: driver_tariff_config; Owner: postgres
--

COPY driver_tariff_config.alembic_version (version_num) FROM stdin;
001_initial
\.


--
-- Data for Name: driver_tariff_config; Type: TABLE DATA; Schema: driver_tariff_config; Owner: postgres
--

COPY driver_tariff_config.driver_tariff_config (uuid, version, pickup_state, drop_state, tariff_factor, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: fuel_cost_config; Owner: postgres
--

COPY fuel_cost_config.alembic_version (version_num) FROM stdin;
001_initial
\.


--
-- Data for Name: fuel_cost_config; Type: TABLE DATA; Schema: fuel_cost_config; Owner: postgres
--

COPY fuel_cost_config.fuel_cost_config (uuid, version, customer_name, customer_subname, truck_type, fuel_cost_per_km, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: lead_time_config; Owner: postgres
--

COPY lead_time_config.alembic_version (version_num) FROM stdin;
001_initial
\.


--
-- Data for Name: lead_time_config; Type: TABLE DATA; Schema: lead_time_config; Owner: postgres
--

COPY lead_time_config.lead_time_config (uuid, version, min_days, max_days, configuration_factor, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: margin_audit; Type: TABLE DATA; Schema: margin_engine; Owner: postgres
--

COPY margin_engine.margin_audit (id, correlation_id, step_name, step_type, input, output, "timestamp") FROM stdin;
\.


--
-- Data for Name: pricing_audit; Type: TABLE DATA; Schema: pricing_engine; Owner: postgres
--

COPY pricing_engine.pricing_audit (id, correlation_id, step_name, step_type, input, output, "timestamp") FROM stdin;
\.


--
-- Name: costing_audit_id_seq; Type: SEQUENCE SET; Schema: costing_engine; Owner: postgres
--

SELECT pg_catalog.setval('costing_engine.costing_audit_id_seq', 1, false);


--
-- Name: margin_audit_id_seq; Type: SEQUENCE SET; Schema: margin_engine; Owner: postgres
--

SELECT pg_catalog.setval('margin_engine.margin_audit_id_seq', 1, false);


--
-- Name: pricing_audit_id_seq; Type: SEQUENCE SET; Schema: pricing_engine; Owner: postgres
--

SELECT pg_catalog.setval('pricing_engine.pricing_audit_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: base_margin_config; Owner: postgres
--

ALTER TABLE ONLY base_margin_config.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: base_margin_config base_margin_config_pkey; Type: CONSTRAINT; Schema: base_margin_config; Owner: postgres
--

ALTER TABLE ONLY base_margin_config.base_margin_config
    ADD CONSTRAINT base_margin_config_pkey PRIMARY KEY (uuid, version);


--
-- Name: base_margin_config uq_base_margin_config_active_lookup; Type: CONSTRAINT; Schema: base_margin_config; Owner: postgres
--

ALTER TABLE ONLY base_margin_config.base_margin_config
    ADD CONSTRAINT uq_base_margin_config_active_lookup UNIQUE (customer_name, customer_subname, pickup_country, pickup_state, pickup_city, pickup_postal_code, drop_country, drop_state, drop_city, drop_postal_code);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: costing_engine; Owner: postgres
--

ALTER TABLE ONLY costing_engine.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: costing_audit costing_audit_pkey; Type: CONSTRAINT; Schema: costing_engine; Owner: postgres
--

ALTER TABLE ONLY costing_engine.costing_audit
    ADD CONSTRAINT costing_audit_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: driver_tariff_config; Owner: postgres
--

ALTER TABLE ONLY driver_tariff_config.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: driver_tariff_config driver_tariff_config_pkey; Type: CONSTRAINT; Schema: driver_tariff_config; Owner: postgres
--

ALTER TABLE ONLY driver_tariff_config.driver_tariff_config
    ADD CONSTRAINT driver_tariff_config_pkey PRIMARY KEY (uuid, version);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: fuel_cost_config; Owner: postgres
--

ALTER TABLE ONLY fuel_cost_config.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: fuel_cost_config fuel_cost_config_pkey; Type: CONSTRAINT; Schema: fuel_cost_config; Owner: postgres
--

ALTER TABLE ONLY fuel_cost_config.fuel_cost_config
    ADD CONSTRAINT fuel_cost_config_pkey PRIMARY KEY (uuid, version);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: lead_time_config; Owner: postgres
--

ALTER TABLE ONLY lead_time_config.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: lead_time_config lead_time_config_pkey; Type: CONSTRAINT; Schema: lead_time_config; Owner: postgres
--

ALTER TABLE ONLY lead_time_config.lead_time_config
    ADD CONSTRAINT lead_time_config_pkey PRIMARY KEY (uuid, version);


--
-- Name: margin_audit margin_audit_pkey; Type: CONSTRAINT; Schema: margin_engine; Owner: postgres
--

ALTER TABLE ONLY margin_engine.margin_audit
    ADD CONSTRAINT margin_audit_pkey PRIMARY KEY (id);


--
-- Name: pricing_audit pricing_audit_pkey; Type: CONSTRAINT; Schema: pricing_engine; Owner: postgres
--

ALTER TABLE ONLY pricing_engine.pricing_audit
    ADD CONSTRAINT pricing_audit_pkey PRIMARY KEY (id);


--
-- Name: ix_base_margin_config_lookup; Type: INDEX; Schema: base_margin_config; Owner: postgres
--

CREATE INDEX ix_base_margin_config_lookup ON base_margin_config.base_margin_config USING btree (customer_name, customer_subname, pickup_country, pickup_state, pickup_city, pickup_postal_code, drop_country, drop_state, drop_city, drop_postal_code);


--
-- Name: ix_costing_audit_correlation_id; Type: INDEX; Schema: costing_engine; Owner: postgres
--

CREATE INDEX ix_costing_audit_correlation_id ON costing_engine.costing_audit USING btree (correlation_id);


--
-- Name: idx_dtc_lookup; Type: INDEX; Schema: driver_tariff_config; Owner: postgres
--

CREATE INDEX idx_dtc_lookup ON driver_tariff_config.driver_tariff_config USING btree (pickup_state, drop_state);


--
-- Name: idx_dtc_sort; Type: INDEX; Schema: driver_tariff_config; Owner: postgres
--

CREATE INDEX idx_dtc_sort ON driver_tariff_config.driver_tariff_config USING btree (created_at DESC);


--
-- Name: idx_dtc_uuid; Type: INDEX; Schema: driver_tariff_config; Owner: postgres
--

CREATE INDEX idx_dtc_uuid ON driver_tariff_config.driver_tariff_config USING btree (uuid);


--
-- Name: idx_fcc_lookup; Type: INDEX; Schema: fuel_cost_config; Owner: postgres
--

CREATE INDEX idx_fcc_lookup ON fuel_cost_config.fuel_cost_config USING btree (customer_name, customer_subname, truck_type);


--
-- Name: idx_fcc_sort; Type: INDEX; Schema: fuel_cost_config; Owner: postgres
--

CREATE INDEX idx_fcc_sort ON fuel_cost_config.fuel_cost_config USING btree (created_at DESC);


--
-- Name: idx_fcc_uuid; Type: INDEX; Schema: fuel_cost_config; Owner: postgres
--

CREATE INDEX idx_fcc_uuid ON fuel_cost_config.fuel_cost_config USING btree (uuid);


--
-- Name: ix_margin_audit_correlation_id; Type: INDEX; Schema: margin_engine; Owner: postgres
--

CREATE INDEX ix_margin_audit_correlation_id ON margin_engine.margin_audit USING btree (correlation_id);


--
-- Name: ix_pricing_audit_correlation_id; Type: INDEX; Schema: pricing_engine; Owner: postgres
--

CREATE INDEX ix_pricing_audit_correlation_id ON pricing_engine.pricing_audit USING btree (correlation_id);


--
-- PostgreSQL database dump complete
--

\unrestrict AWGxvR5GU6au3kHUZMSauyjcaxkbND2BxGGvJ0cdSLhWW8h1mOT29T6ILjzbKQ6

--
-- Database "transport_deluxe_test" dump
--

--
-- PostgreSQL database dump
--

\restrict 9GtAfHP5aM47N1IXVxNctVF6pfPxwxNMgogyOkWDNHaUMDzwSv8H1dcPlCYbzoi

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

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
-- Name: transport_deluxe_test; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE transport_deluxe_test WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE transport_deluxe_test OWNER TO postgres;

\unrestrict 9GtAfHP5aM47N1IXVxNctVF6pfPxwxNMgogyOkWDNHaUMDzwSv8H1dcPlCYbzoi
\connect transport_deluxe_test
\restrict 9GtAfHP5aM47N1IXVxNctVF6pfPxwxNMgogyOkWDNHaUMDzwSv8H1dcPlCYbzoi

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
-- Name: base_margin_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA base_margin_config;


ALTER SCHEMA base_margin_config OWNER TO postgres;

--
-- Name: costing_engine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA costing_engine;


ALTER SCHEMA costing_engine OWNER TO postgres;

--
-- Name: driver_tariff_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA driver_tariff_config;


ALTER SCHEMA driver_tariff_config OWNER TO postgres;

--
-- Name: fuel_cost_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA fuel_cost_config;


ALTER SCHEMA fuel_cost_config OWNER TO postgres;

--
-- Name: lead_time_config; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lead_time_config;


ALTER SCHEMA lead_time_config OWNER TO postgres;

--
-- Name: margin_engine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA margin_engine;


ALTER SCHEMA margin_engine OWNER TO postgres;

--
-- Name: pricing_engine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pricing_engine;


ALTER SCHEMA pricing_engine OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

\unrestrict 9GtAfHP5aM47N1IXVxNctVF6pfPxwxNMgogyOkWDNHaUMDzwSv8H1dcPlCYbzoi

--
-- PostgreSQL database cluster dump complete
--
