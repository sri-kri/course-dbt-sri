SELECT 
    promo_id,
    discout as discount,
    status
FROM {{ source('src_public', 'promos') }}