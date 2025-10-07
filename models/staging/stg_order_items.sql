{{ config(materialized='view') }}

SELECT
    order_id AS order_key,
    product_id,
    quantity,
    load_date
FROM {{ source('landing', 'raw_order_items') }}