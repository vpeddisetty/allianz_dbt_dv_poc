{{ config(materialized='table') }}

WITH source_data AS (
    SELECT DISTINCT customer_key FROM {{ ref('stg_customers') }}
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['customer_key']) }} AS customer_pk,
    customer_key,
    CURRENT_TIMESTAMP() AS load_date,
    'STG_CUSTOMERS' AS record_source
FROM source_data