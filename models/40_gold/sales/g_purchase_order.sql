-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD")) }}


-- -- SELECTED FIELDS FROM SILVER
with
s1 as (select * from {{ ref('s_purchase_order_header') }}),

s2 as (select * from {{ ref('s_purchase_order_item') }}),

s3 as (select * from {{ ref('s_material') }}),

gold_model as (
    select
        s2.purchase_order,
        s2.purchase_order_item,
        s1.company_code,
        s1.purchase_doc_category,
        s1.purchase_doc_type,
        s1.status_document,
        s1.purchase_organsation,
        s1.purchase_group,
        s1.vendor_nr,
        s1.creation_date,
        s1.last_change_datetime,
        s2.purchase_order_quantity,
        s2.quantity_unit,
        s2.net_price,
        s2.price_unit,
        s2.deletion_indicator,
        s2.material_id,
        s3.description as material_description
    from s2

    left join s1 on s2.purchase_order = s1.purchase_order
    left join s3 on s2.material_id = s3.material_id
    order by s2.purchase_order asc
)

select * from gold_model {{ env_var("DBT_LIMIT") }}
