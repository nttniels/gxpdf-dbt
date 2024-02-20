-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD")) }}


-- -- SELECTED FIELDS FROM SILVER
with
-- s1 as (select * from {{ ref('s_material') }}),
bp1 as (select * from {{ ref('bp_SAP_S4H_makt') }}),

gold_model as (
    select 
        material_id,
        lang,
        description
    from bp1
)

select * 
from gold_model {{ env_var("DBT_LIMIT") }}