{{ config(materialized='table') }}

select 
    created_at
    , user_id
    , zipcode
    , state
    , country
    , first_name
    , last_name
    , email
from {{ref('stg_users')}}
LEFT JOIN {{ref('stg_addresses')}} using (address_id) 
