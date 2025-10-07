{{ config(materialized='view') }}

SELECT
    order_id AS order_key,
    customer_id,
    order_date,
    status,
    load_date
FROM {{ source('landing', 'raw_orders') }}