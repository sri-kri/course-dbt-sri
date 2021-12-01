{{ config(materialized='table') }}

SELECT 
    page_url,
    count(1) as page_views
from {{ref('stg_events')}}
group by 1