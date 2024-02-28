-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER")) }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_mcha") }}),
bp2 as (select * from {{ ref("bp_SAP_S4H_mchb") }}),
bp3 as (select * from {{ ref("bp_SAP_S4H_makt") }})

silver_model as (
    select 
        bp1.charge_id,
        bp1.plant_id,
        bp1.expiry_date,
        bp1.material_id,
        bp3.description,
        bp2.sloc_id,
        bp2.unrestrict_qty
    from bp1
    left join bp2 on bp1.charge_id = bp2.charge_id,
    left join bp3 on bp1.material_id = bp3.material_id
)

select *
from silver_model {{ env_var("DBT_LIMIT") }}
