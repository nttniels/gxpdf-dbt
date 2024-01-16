-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD"), schema="data_products") }}


-- -- SELECTED FIELDS FROM SILVER
with
silver_model as (select * from {{ ref('s_material') }}),

gold_model as (
    select 
        material,
        description
    from silver_model
)

select * from gold_model {{ env_var("DBT_LIMIT") }}