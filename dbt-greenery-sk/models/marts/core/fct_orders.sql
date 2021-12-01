{{ config(materialized='table') }}

SELECT 
    created_at,
    order_id,
    user_id,
    order_cost,
    shipping_cost,
    order_total,
    status as order_status,
    count(product_id) as product_count
from {{ref('stg_orders')}}
LEFT JOIN {{ref('stg_order_items')}} using (order_id)
group by 1,2,3,4,5,6,7