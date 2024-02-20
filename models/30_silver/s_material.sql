-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER")) }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_mara") }}),
bp2 as (select * from {{ ref("bp_SAP_S4H_makt") }}),

silver_model as (
    select 
        bp1.material_id,
        bp1/old_material_id,
        bp1.uom_base,
        bp1.material_group,
        bp1.created_on,
        bp2.lang,
        bp2.description
    from bp1
    left join bp2 on bp1.material_id = bp2.material_id
)

select *
from silver_model {{ env_var("DBT_LIMIT") }}
