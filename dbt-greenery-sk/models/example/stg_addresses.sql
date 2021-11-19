SELECT 
    address_id,
    address,
    zipcode,
    state,
    country
FROM {{ source('src_public', 'addresses') }}