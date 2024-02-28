-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER")) }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_equi") }}),
bp2 as (select * from {{ ref("bp_SAP_S4H_eqkt") }}),

silver_model as (
    select
        bp1.equipment_id,
        bp2.equipment_description,
        bp1.record_creation_date,
        bp1.created_by,
        bp1.manufacturer,
        bp1.manufacturer_country,
        bp1.manufacturer_drawing_id,
        bp1.manufacturer_serial_no,
        bp1.equipment_model_number,
        bp1.construction_year,
        bp1.construnction_month,
        bp1.startup_date,
        bp1.object_no,
        bp1.row_load_date
    from bp1
    left join bp2 on bp1.equipment_id = bp2.equipment_id
)

select *
from silver_model {{ env_var("DBT_LIMIT") }}
