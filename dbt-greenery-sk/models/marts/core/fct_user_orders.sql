{{ config(materialized='table') }}

SELECT 
    user_id,
    count(1) as num_orders
from {{ref('dim_users')}}
LEFT JOIN {{ref('fct_orders')}} using (user_id)
group by 1