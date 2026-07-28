--drop table if exists category_translation cascade;
--drop table if exists geolocation cascade;
-- drop table if exists order_items cascade;
--drop table if exists orders cascade;
-- drop table if exists order_items cascade;

-- Customer table (~99,441 rows expected)

--
--CREATE TABLE customers (
--    customer_id                VARCHAR(50) PRIMARY KEY,
--    customer_unique_id         VARCHAR(50) NOT NULL,
--    customer_zip_code_prefix   INTEGER,
--    customer_city               VARCHAR(100),
--    customer_state              VARCHAR(2)
--);
--
--
---- 2. Sellers  (~3,095 rows expected)
--CREATE TABLE sellers (
--    seller_id                  VARCHAR(50) PRIMARY KEY,
--    seller_zip_code_prefix     INTEGER,
--    seller_city                 VARCHAR(100),
--    seller_state                 VARCHAR(2)
--);
-- 
---- 3. Product category translation (~71 rows expected)
--CREATE TABLE category_translation (
--    product_category_name          VARCHAR(100) PRIMARY KEY,
--    product_category_name_english  VARCHAR(100)
--);
-- 
---- 4. Products  (~32,951 rows expected)
--CREATE TABLE products (
--    product_id                  VARCHAR(50) PRIMARY KEY,
--    product_category_name       VARCHAR(100),
--    product_name_lenght         INTEGER,
--    product_description_lenght  INTEGER,
--    product_photos_qty          INTEGER,
--    product_weight_g            INTEGER,
--    product_length_cm           INTEGER,
--    product_height_cm           INTEGER,
--    product_width_cm            INTEGER
--);
-- 
---- 5. Orders  (~99,441 rows expected) — the anchor table
--CREATE TABLE orders (
--    order_id                        VARCHAR(50) PRIMARY KEY,
--    customer_id                     VARCHAR(50) REFERENCES customers(customer_id),
--    order_status                    VARCHAR(20),
--    order_purchase_timestamp        TIMESTAMP,
--    order_approved_at               TIMESTAMP,
--    order_delivered_carrier_date    TIMESTAMP,
--    order_delivered_customer_date   TIMESTAMP,
--    order_estimated_delivery_date   TIMESTAMP
--);
-- 
---- 6. Order items  (~112,650 rows expected)
--CREATE TABLE order_items (
--    order_id             VARCHAR(50) REFERENCES orders(order_id),
--    order_item_id        INTEGER,
--    product_id           VARCHAR(50) REFERENCES products(product_id),
--    seller_id            VARCHAR(50) REFERENCES sellers(seller_id),
--    shipping_limit_date  TIMESTAMP,
--    price                NUMERIC(10,2),
--    freight_value        NUMERIC(10,2),
--    PRIMARY KEY (order_id, order_item_id)
--);
-- 
---- 7. Order payments  (~103,886 rows expected)
--CREATE TABLE order_payments (
--    order_id              VARCHAR(50) REFERENCES orders(order_id),
--    payment_sequential    INTEGER,
--    payment_type          VARCHAR(20),
--    payment_installments  INTEGER,
--    payment_value         NUMERIC(10,2),
--    PRIMARY KEY (order_id, payment_sequential)
--);
-- 
---- 8. Order reviews  (~99,224 rows expected)
--
--CREATE TABLE order_reviews (
--    review_id                VARCHAR(50),
--    order_id                 VARCHAR(50) REFERENCES orders(order_id),
--    review_score             INTEGER,
--    review_comment_title     TEXT,
--    review_comment_message   TEXT,
--    review_creation_date     TIMESTAMP,
--    review_answer_timestamp  TIMESTAMP
--);
-- 
---- 9. Geolocation  (~1,000,163 rows expected — the big one, no FK, imports independently)
--CREATE TABLE geolocation (
--    geolocation_zip_code_prefix  INTEGER,
--    geolocation_lat              NUMERIC(10,6),
--    geolocation_lng              NUMERIC(10,6),
--    geolocation_city             VARCHAR(100),
--    geolocation_state            VARCHAR(2)
--);

select 'customers' as table_name, count(*) from customers 
union all 
select 'orders', count(*) from orders 
union all
select 'order_items',count(*) from order_items
union all
select 'order_payments',count(*) from order_payments 
union all
select 'order_reviews',count(*) from order_reviews
union all
select 'products',count(*) from products 
union all
select 'sellers',count(*) from sellers 
union all
select 'order_items',count(*) from order_items
union all
select 'geolocation',count(*) from geolocation



select * from customers
where customer_id is null or customer_unique_id is null or customer_state is null;

select * from orders
where order_purchase_timestamp is null;


--order_delivered_customer_date can have null values because of order cancelled never deliverd
select * from orders o
where o.order_delivered_customer_date is null;


select * from order_items 
where product_id is null or price is null;

select * from order_payments
where payment_value is null;

select * from products
where product_category_name is null;



select * from category_translation;


select count(distinct customer_unique_id ),
		count(distinct customer_id )
from customers;



SELECT COUNT(*) FILTER (WHERE product_category_name_english IS NULL) AS null_translation
FROM category_translation;

 
select customer_id,count(*) from customers
group by customer_id
having count(*) > 1;


select order_id, count(*) from orders
group by order_id
having count(*) > 1;




select min(order_purchase_timestamp ) earliest_order,
		max(order_purchase_timestamp) latest_order
from orders;


SELECT
  COUNT(DISTINCT customer_id)        AS unique_customer_id_count,
  COUNT(DISTINCT customer_unique_id) AS unique_real_person_count
FROM customers;








--
--SELECT COUNT(*) FROM order_reviews;
--TRUNCATE TABLE order_reviews;











