{{ config(materialized='view') }}

SELECT
    customer_id AS customer_key,
    customer_name,
    email,
    load_date
FROM {{ source('landing', 'raw_customers') }}