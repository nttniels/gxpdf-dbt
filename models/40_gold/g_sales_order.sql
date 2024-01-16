-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD"), schema="data_products") }}


-- -- SELECTED FIELDS FROM SILVER
with
s1 as (select * from {{ ref('s_sales_order_header') }}),
s2 as (select * from {{ ref('s_sales_order_line') }}),

gold_model as (
    
    select 
        s1.sales_document,
        s1.net_value,
        s1.currency,
        s1.sales_organization,
        s1.disctribution_channel,
        s1.created_by,
        s1.created_on,
        s2.item_nr,
        s2.material,
        s2.material_group,
        s2.quantity,
        s2.quantity_unit,
        s2.weight_brut,
        s2.weight_net,
        s2.weight_unit,
        s2.plant,
        s2.price_net,
        s2.price_qty,
        s2.price_unit,
        s2.first_date
    from sales_order_header
    left join s2 on s1.sales_document = s1.sales_document
    
)

select * from gold_model {{ env_var("DBT_LIMIT") }}