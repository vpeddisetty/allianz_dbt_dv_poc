{{ config(materialized='table') }}

WITH source_data AS (
    SELECT DISTINCT product_key FROM {{ ref('stg_products') }}
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['product_key']) }} AS product_pk,
    product_key,
    CURRENT_TIMESTAMP() AS load_date,
    'STG_PRODUCTS' AS record_source
FROM source_data