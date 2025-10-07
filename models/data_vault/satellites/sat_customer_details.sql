{{ config(materialized='table') }}

SELECT
    hc.customer_pk,
    sc.customer_name,
    sc.email,
    sc.load_date,
    'STG_CUSTOMERS' AS record_source
FROM {{ ref('stg_customers') }} sc
INNER JOIN {{ ref('hub_customer') }} hc ON sc.customer_key = hc.customer_key