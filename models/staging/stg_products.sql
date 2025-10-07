{{ config(materialized='view') }}

SELECT
    product_id AS product_key,
    product_name,
    category,
    price,
    load_date
FROM {{ source('landing', 'raw_products') }}