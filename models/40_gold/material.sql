-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD"), schema="data_products") }}


--
with
    silver_model as (select * from {{ ref('s_material') }}),

    gold_model as (select * from silver_model)

select *
from gold_model {{ env_var("DBT_LIMIT") }}