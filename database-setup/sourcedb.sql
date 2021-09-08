CREATE SCHEMA IF NOT EXISTS ecommerce;

DROP TABLE IF EXISTS ecommerce.customers;
DROP TABLE IF EXISTS ecommerce.orders;
DROP TABLE IF EXISTS ecommerce.geolocation;

CREATE TABLE ecommerce.customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix CHAR(5),
    customer_city TEXT,
    customer_state CHAR(2)
);
CREATE TABLE ecommerce.orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);
CREATE TABLE ecommerce.geolocation (
    geolocation_zip_code_prefix CHAR(5),
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city TEXT,
    geolocation_state CHAR(2)
);

COPY ecommerce.customers
FROM
  '/source-data/olist_customers_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.orders
FROM
  '/source-data/olist_orders_dataset.csv' CSV DELIMITER ',' HEADER;
COPY ecommerce.geolocation
FROM
  '/source-data/olist_geolocation_dataset.csv' CSV DELIMITER ',' HEADER;