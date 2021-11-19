SELECT 
    order_id,
    product_id,
    quantity
FROM {{ source('src_public', 'order_items') }}