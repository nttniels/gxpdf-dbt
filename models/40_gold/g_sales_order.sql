-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD"), schema="data_products") }}


-- -- SELECTED FIELDS FROM SILVER
with
sales_order_header as (select * from {{ ref('s_sales_order_header') }}),
sales_order_line as (select * from {{ ref('s_sales_order_line') }}),

gold_model as (
    
    select 
        sales_order_header.*,
        sales_order_line.*
    from sales_order_header
    left join sales_order_line on sales_order_header.sales_document = sales_order_line.sales_document
    
)

select * from gold_model {{ env_var("DBT_LIMIT") }}