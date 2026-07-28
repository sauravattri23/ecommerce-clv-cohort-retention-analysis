--select * from orders_fact;

--select 
--count(*) customers_with_multiple_orders
--from (
--select
--customer_unique_id
--from orders_fact
--group by customer_unique_id 
--having count(distinct order_id)>1
--)


--select 
--count(*) total_customers,
--count(*) filter(where order_count > 1) repeat_customers,
--round(count(*) filter(where order_count > 1) * 100.0 /count(*), 2) repeat_customer_percentage
--from (
--select
--customer_unique_id,
--count(distinct order_id) as order_count
--from orders_fact
--group by customer_unique_id 
--)


--Only about 3% of customers placed more than one order during the period covered by the dataset,
-- while approximately 97% were one-time buyers.

--select * from rfm_base 


SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE frequency > 1) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE frequency > 1) / COUNT(*), 2
    ) AS repeat_purchase_rate_pct
FROM rfm_base;






















