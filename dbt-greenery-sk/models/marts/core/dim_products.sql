{{ config(materialized='table') }}

select 
    product_id
    , name
    , quantity as product_inventory
from {{ref('stg_products')}}
