--select * from category_translation;
--
--select * from customers
--
--select * from order_items;
--
--
--
--select * from orders;
--
--
--select * from products;

create or replace view customer_category_spend as
select
c.customer_unique_id,
ct.product_category_name_english   category,
sum(oi.price)   category_spend
from order_items oi 
join orders o on oi.order_id = o.order_id 
join customers c on o.customer_id = c.customer_id 
join products p on oi.product_id = p.product_id
left join category_translation ct on p.product_category_name = ct.product_category_name 
where o.order_status = 'delivered'
group by c.customer_unique_id,ct.product_category_name_english;


--select * from customer_category_spend

create or replace view customer_top_category as 
select 
customer_unique_id,
category top_category
from (
select 
customer_unique_id,
category,
row_number() over(partition  by customer_unique_id order by category_spend desc) rnk
from customer_category_spend
)t
where rnk = 1;

--select * from customer_top_category



--
--select * from order_clean oc 

create or replace view customer_state_latest as
select distinct on(customer_unique_id)
customer_unique_id,
customer_state,
order_purchase_timestamp 
from order_clean
order by customer_unique_id, order_purchase_timestamp desc;


--select * from customer_state_latest

drop table if exists customer_segments;

CREATE TABLE customer_segments AS
SELECT
    r.customer_unique_id,
    r.recency_days,
    r.frequency,
    r.monetary,
    cs.customer_state,
    tc.top_category
FROM rfm_base r
JOIN customer_state_latest cs ON r.customer_unique_id = cs.customer_unique_id
LEFT JOIN customer_top_category tc ON r.customer_unique_id = tc.customer_unique_id;

--select * from customer_segments;


SELECT
    (SELECT COUNT(*) FROM rfm_base)          AS rfm_customers,
    (SELECT COUNT(*) FROM customer_segments) AS segment_customers;




