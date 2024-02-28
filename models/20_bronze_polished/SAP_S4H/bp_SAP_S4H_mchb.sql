-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("sap_s4h", "mchb") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (
    select
        matnr::string(18) as material_id,
        charg::string(10) as charge_id,
        werks::string (4) as plant_id,
        lgort::string (4) as sloc_id, 
        clabs::number (13) as unrestrict_qty
    from bronze_raw_table
)

-- SELECT MODEL
select * from bronze_polished_model {{ env_var("DBT_LIMIT") }}

