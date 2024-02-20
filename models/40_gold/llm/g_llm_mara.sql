-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD")) }}


-- -- SELECTED FIELDS FROM SILVER
with
silver_model as (select * from {{ ref('s_material') }}),

gold_model as (

    select 
        material_id,
        old_material_id,
        uom_base,
        material_group,
        created_on
    from silver_model
    
)

select * 
from gold_model {{ env_var("DBT_LIMIT") }}
