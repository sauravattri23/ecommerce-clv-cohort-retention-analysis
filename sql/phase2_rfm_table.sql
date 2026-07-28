--	select * from orders_fact

--select
--customer_unique_id,
--current_date - date(max(order_purchase_timestamp)) recency,
--count(order_id) frequency,
--sum(total_order_value) monetary
--from orders_fact
--group by customer_unique_id;

--drop table if exists rfm_base;

create table rfm_base as
with snapshot as(
select (max(order_purchase_timestamp)::date + 1) snapshotdate
from orders_fact 
)
select
customer_unique_id,
max(of.order_purchase_timestamp)::date   last_purchase_date,
s.snapshotdate - max(order_purchase_timestamp)::date   recency_days,
count(distinct of.order_id) frequency,
round(sum(of.total_order_value)::numeric ,2)   monetary
from orders_fact of
cross join snapshot s
group by customer_unique_id, s.snapshotdate;

-- sanatiry checks 

select count(*) from rfm_base;


SELECT
    MIN(recency_days)  AS min_recency,   MAX(recency_days)  AS max_recency,
    MIN(frequency)      AS min_freq,      MAX(frequency)      AS max_freq,
    MIN(monetary)        AS min_monetary,  MAX(monetary)        AS max_monetary,
    ROUND(AVG(frequency)::numeric, 3)     AS avg_frequency
FROM rfm_base;



