--select count(*) from orders
--where order_status = 'delivered';
--
--
--select * from customers limit 5;

create or replace view order_clean as
select 
o.order_id ,
c.customer_id,
c.customer_unique_id,
c.customer_state ,
o.order_purchase_timestamp
from customers c  
join orders o 
on c.customer_id = o.customer_id 
where o.order_status = 'delivered' and o.order_purchase_timestamp is not null;


--select 'order_clean', count(*) from order_clean;

--select * from order_payments limit 5;

create or replace view order_value as
select
order_id,
sum(payment_value) total_order_value
from order_payments
group by order_id;

--select * from order_value
--where total_order_value <=0;

create or replace view orders_fact as
select
oc.order_id,
oc.customer_unique_id,
oc.customer_state,
oc.order_purchase_timestamp,
ov.total_order_value
from order_clean oc
join order_value ov
on oc.order_id = ov.order_id
where total_order_value > 0;

--select * from orders_fact;



SELECT
    (SELECT COUNT(*) FROM order_clean) AS delivered_orders,
    (SELECT COUNT(*) FROM orders_fact)  AS orders_with_confirmed_payment,
    (SELECT COUNT(*) FROM order_clean) - (SELECT COUNT(*) FROM orders_fact) AS dropped_no_payment;








--select * from order_value;

--select * from order_items limit 5;