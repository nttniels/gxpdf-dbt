-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("sap_s4h", "eqkt") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (
    select
        eqktx::string(40) as equipment_description,
        equnr::string(18) as equipment_id,
        spras::string(1) as language_key,
        _gxpdf_loaded_at::date as row_load_date
    from bronze_raw_table
    where language_key = 'E'  
)

-- SELECT MODEL
select * from bronze_polished_model {{ env_var("DBT_LIMIT") }}
