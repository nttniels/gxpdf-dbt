-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD")) }}


-- -- SELECTED FIELDS FROM SILVER
with
s1 as (select * from {{ ref('s_sales_order_header') }}),
s2 as (select * from {{ ref('s_sales_order_line') }}),
s3 as (select * from {{ ref('s_material') }}),

gold_model as (
    
    select 
        s1.document_id,
        s1.net_value,
        s1.currency,
        s1.sales_organization,
        s1.disctribution_channel,
        s1.created_by,
        s1.created_on,
        s2.item_id,
        s2.material,
        s3.description,
        s2.material_group,
        -- s2.quantity,
        s2.quantity_unit,
        s2.weight_brut,
        s2.weight_net,
        s2.weight_unit,
        s2.plant,
        s2.price_net,
        s2.price_qty,
        s2.price_unit,
        s2.first_date
    from s2

    left join s1 on s1.document_id = s2.document_id
    left join s3 on s2.material = s3.material_id

    order by s1.document_id asc
    
)

select * from gold_model {{ env_var("DBT_LIMIT") }}