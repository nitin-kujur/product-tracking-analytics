--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.11
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE addresses (
    id bigint NOT NULL,
    order_id integer,
    first_name character varying,
    last_name character varying,
    company character varying,
    address1 character varying,
    address2 text,
    city character varying,
    province character varying,
    country character varying,
    country_name character varying,
    zip character varying,
    phone character varying,
    name character varying,
    province_code character varying,
    country_code character varying,
    "default" boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE customers (
    id bigint NOT NULL,
    shop_id integer,
    first_name character varying,
    last_name character varying,
    shopify_customer_id integer,
    email character varying,
    total_spent double precision,
    orders_count integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: line_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE line_items (
    id bigint NOT NULL,
    order_id integer,
    product_id integer,
    shopify_vaiant_id integer,
    shopify_line_item_id integer,
    variant_id integer,
    title text,
    quantity integer,
    price numeric,
    sku character varying,
    fulfillment_service character varying,
    shopify_product_id integer,
    requires_shipping boolean,
    properties json,
    fulfillable_quantity integer,
    total_discount numeric,
    fulfillment_status character varying,
    origin_location json,
    destination_location json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE line_items OWNER TO postgres;

--
-- Name: line_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE line_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE line_items_id_seq OWNER TO postgres;

--
-- Name: line_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE line_items_id_seq OWNED BY line_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE orders (
    id bigint NOT NULL,
    shop_id integer,
    customer_id integer,
    shopify_order_id integer,
    email character varying,
    closed_at timestamp without time zone,
    shopify_created_at timestamp without time zone,
    shopify_updated_at timestamp without time zone,
    number integer,
    total_price numeric,
    subtotal_price numeric,
    total_weight double precision,
    total_tax double precision,
    financial_status character varying,
    total_line_items_price numeric,
    cancelled_at timestamp without time zone,
    cancel_reason text,
    user_id integer,
    processed_at timestamp without time zone,
    order_number character varying,
    fulfillment_status character varying,
    tags text,
    contact_email character varying,
    billing_address_id integer,
    shipping_address_id integer,
    shopify_customer_id integer,
    customer_email character varying,
    order_region character varying,
    deleted_at timestamp without time zone,
    discount_codes json,
    deleted_by integer,
    client_details json,
    parent_order_id integer,
    parent_customer_id integer,
    shopify_tracking_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products (
    id bigint NOT NULL,
    shop_id integer,
    "Number_of_orders" integer,
    title character varying,
    product_type character varying,
    vendor character varying,
    body_html character varying,
    handle character varying,
    tags character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: shops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE shops (
    id bigint NOT NULL,
    shop_name character varying,
    shop_domain character varying,
    shop_private_api_keys character varying,
    shop_private_api_secret character varying,
    shop_private_api_password character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE shops OWNER TO postgres;

--
-- Name: shops_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE shops_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shops_id_seq OWNER TO postgres;

--
-- Name: shops_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE shops_id_seq OWNED BY shops.id;


--
-- Name: variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE variants (
    id bigint NOT NULL,
    product_id integer,
    shopify_product_id integer,
    title character varying,
    sku character varying,
    inventory_policy character varying,
    "position" character varying,
    inventory_quantity integer,
    source character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE variants OWNER TO postgres;

--
-- Name: variants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE variants_id_seq OWNER TO postgres;

--
-- Name: variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE variants_id_seq OWNED BY variants.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: line_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY line_items ALTER COLUMN id SET DEFAULT nextval('line_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: shops id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shops ALTER COLUMN id SET DEFAULT nextval('shops_id_seq'::regclass);


--
-- Name: variants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY variants ALTER COLUMN id SET DEFAULT nextval('variants_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY addresses (id, order_id, first_name, last_name, company, address1, address2, city, province, country, country_name, zip, phone, name, province_code, country_code, "default", created_at, updated_at) FROM stdin;
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('addresses_id_seq', 1, false);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2018-03-05 07:44:20.594546	2018-03-05 07:44:20.594546
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY customers (id, shop_id, first_name, last_name, shopify_customer_id, email, total_spent, orders_count, created_at, updated_at) FROM stdin;
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customers_id_seq', 1, false);


--
-- Data for Name: line_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY line_items (id, order_id, product_id, shopify_vaiant_id, shopify_line_item_id, variant_id, title, quantity, price, sku, fulfillment_service, shopify_product_id, requires_shipping, properties, fulfillable_quantity, total_discount, fulfillment_status, origin_location, destination_location, created_at, updated_at) FROM stdin;
\.


--
-- Name: line_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('line_items_id_seq', 1, false);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY orders (id, shop_id, customer_id, shopify_order_id, email, closed_at, shopify_created_at, shopify_updated_at, number, total_price, subtotal_price, total_weight, total_tax, financial_status, total_line_items_price, cancelled_at, cancel_reason, user_id, processed_at, order_number, fulfillment_status, tags, contact_email, billing_address_id, shipping_address_id, shopify_customer_id, customer_email, order_region, deleted_at, discount_codes, deleted_by, client_details, parent_order_id, parent_customer_id, shopify_tracking_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orders_id_seq', 1, false);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products (id, shop_id, "Number_of_orders", title, product_type, vendor, body_html, handle, tags, created_at, updated_at) FROM stdin;
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20180305073144
20180305073210
20180305073216
20180305073222
20180305073226
20180305073231
20180305073235
\.


--
-- Data for Name: shops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY shops (id, shop_name, shop_domain, shop_private_api_keys, shop_private_api_secret, shop_private_api_password, created_at, updated_at) FROM stdin;
\.


--
-- Name: shops_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('shops_id_seq', 1, false);


--
-- Data for Name: variants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY variants (id, product_id, shopify_product_id, title, sku, inventory_policy, "position", inventory_quantity, source, created_at, updated_at) FROM stdin;
\.


--
-- Name: variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('variants_id_seq', 1, false);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: line_items line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY line_items
    ADD CONSTRAINT line_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shops shops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY shops
    ADD CONSTRAINT shops_pkey PRIMARY KEY (id);


--
-- Name: variants variants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY variants
    ADD CONSTRAINT variants_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

