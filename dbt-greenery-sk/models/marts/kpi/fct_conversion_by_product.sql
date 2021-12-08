with sessions_with_checkout as (
    select 
        session_id,
        max(case when event_type='checkout' then 1 else 0 end) has_checkout
    from {{ref('stg_events')}}
    group by session_id
)
, sessions_with_product as (
    select
        session_id,
        split_part(page_url,'/',5) as product_id
    from {{ref('stg_events')}}
    where event_type = 'add_to_cart'
    {{ dbt_utils.group_by(n=2) }}

)

SELECT 
    product_id,
    dim_products.name,
    sum(has_checkout)::numeric / count(session_id) as conv_rate
from sessions_with_product
left join sessions_with_checkout using (session_id)
left join {{ref('dim_products')}} using (product_id)
{{ dbt_utils.group_by(n=2) }}