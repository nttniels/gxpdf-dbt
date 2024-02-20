-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("sap_s4h", "makt") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (
    select
        matnr::string(18) as material_id,
        spras::string(1) as lang,
        maktx::string(40) as description
    from bronze_raw_table
    where lang = 'E' or lang = 'D'    

)

-- SELECT MODEL
select * from bronze_polished_model {{ env_var("DBT_LIMIT") }}

