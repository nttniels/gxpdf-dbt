-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("sap_s4h", "mara") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (
    select 
        matnr::string(18) as material_id,
        bismt::string(18) as old_material_id,
        meins::string(3) as uom_base,
        matkl::string(6) as material_group,
        ersda::date as created_on
    from bronze_raw_table
)

-- SELECT MODEL
select * from bronze_polished_model {{ env_var("DBT_LIMIT") }}
