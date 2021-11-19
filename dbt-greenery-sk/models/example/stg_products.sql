SELECT 
    product_id,
    name,
    price,
    quantity
FROM {{ source('src_public', 'products') }}