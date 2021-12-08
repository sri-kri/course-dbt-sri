{% macro sessions_with_checkout() %}
with sessions_with_checkout as (
    select 
        session_id,
        max(case when event_type='checkout' then 1 else 0 end) has_checkout
    from {{ref('stg_events')}}
    group by session_id
)
{% endmacro %}