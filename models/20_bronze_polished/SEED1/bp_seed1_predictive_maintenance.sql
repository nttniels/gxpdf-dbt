-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="seed1") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("seed1", "predictive_maintenance") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (
    select

        UDI::number,
        PRODUCT_ID,
        TYPE::number,
        AIR_TEMP_K::number,
        PROCESS_TEMP_K::number,
        ROTATION_SPEED::number,
        TORQUE_NM::number,
        TOOL_WEAR_MINUTES::number,
        TARGET::number,
        FAILURE_TYPE::string
        
    from bronze_raw_table
    
)

-- SELECT MODEL
select * from bronze_polished_model {{ env_var("DBT_LIMIT") }}

