--select * from orders_fact limit 10;

--drop table if exists cohort_base;

create table if not exists cohort_base as
with first_purchase as(
select 
customer_unique_id,
min(date_trunc('month',order_purchase_timestamp)) cohort_month
from orders_fact
group by customer_unique_id
)
select 
of.customer_unique_id,
fp.cohort_month,
date_trunc('month',of.order_purchase_timestamp) order_month,

(date_part('year',of.order_purchase_timestamp) - date_part('year',fp.cohort_month)) * 12
+
date_part('month',of.order_purchase_timestamp) - date_part('month',fp.cohort_month) as month_number
from orders_fact of
join first_purchase fp
on of.customer_unique_id = fp.customer_unique_id;

select * from cohort_base ;

--sanity check
SELECT COUNT(*) AS invalid_negative_months
FROM cohort_base
WHERE month_number < 0;