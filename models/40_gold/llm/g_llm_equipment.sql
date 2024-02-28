-- LAYER: GOLD
{{ config(database=env_var("DBT_GOLD")) }}


-- -- SELECTED FIELDS FROM SILVER
with
silver_model as (select * from {{ ref('s_equipment') }}),

gold_model as (

    select
        equipment_id,
        equipment_description,
        record_creation_date,
        created_by,
        manufacturer,
        manufacturer_country,
        manufacturer_drawing_id,
        manufacturer_serial_no,
        equipment_model_number,
        construction_year,
        construnction_month,
        startup_date,
        object_no,
        row_load_date
    from silver_model
)

select *
from gold_model {{ env_var("DBT_LIMIT") }}
