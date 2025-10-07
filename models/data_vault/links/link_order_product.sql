WITH source_data AS (
    SELECT
        o.product_id,
        o.order_key
    FROM {{ ref('stg_order_items') }} o
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['sd.product_id', 'sd.order_key']) }} AS link_order_product_pk,
    hc.product_key,
    ho.order_pk,
    CURRENT_TIMESTAMP() AS load_date,
    'STG_ORDER_ITEMS' AS record_source
FROM source_data sd
INNER JOIN {{ ref('hub_product') }} hc ON sd.product_id = hc.product_key
INNER JOIN {{ ref('hub_order') }} ho ON sd.order_key = ho.order_key