-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD")) }}


-- -- SELECTED FIELDS FROM SILVER
with
silver_model as (select * from {{ ref('s_batch') }}),

gold_model as (

    select
        charge_id,
        plant_id,
        sloc_id,
        expiry_date,
        material_id,
        description,
        unrestrict_qty
    from silver_model
)

select *
from gold_model {{ env_var("DBT_LIMIT") }}
