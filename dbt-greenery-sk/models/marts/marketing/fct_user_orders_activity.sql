{{ config(materialized='table') }}

SELECT 
    user_id,
    count(1) as num_orders,
    min(fct_orders.created_at) as first_order_date,
    max(fct_orders.created_at) as last_order_date,
    sum(order_cost) as sum_order_cost,
    sum(shipping_cost) as sum_shipping_cost,
    sum(order_total) as sum_order_total
from {{ref('dim_users')}}
LEFT JOIN {{ref('fct_orders')}} using (user_id)
group by 1