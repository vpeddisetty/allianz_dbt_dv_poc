{{ config(materialized='table') }}

WITH source_data AS (
    SELECT DISTINCT order_key FROM {{ ref('stg_orders') }}
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['order_key']) }} AS order_pk,
    order_key,
    CURRENT_TIMESTAMP() AS load_date,
    'STG_ORDERS' AS record_source
FROM source_data