WITH source_data AS (
    SELECT
        customer_id,
        order_key
    FROM {{ ref('stg_orders') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['sd.customer_id', 'sd.order_key']) }} AS link_customer_order_pk,
    hc.customer_pk,
    ho.order_pk,
    CURRENT_TIMESTAMP() AS load_date,
    'STG_ORDERS' AS record_source
FROM source_data sd
INNER JOIN {{ ref('hub_customer') }} hc ON sd.customer_id = hc.customer_key
INNER JOIN {{ ref('hub_order') }} ho ON sd.order_key = ho.order_key