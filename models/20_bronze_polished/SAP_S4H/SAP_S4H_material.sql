-- LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with
    bronze_raw_table as (select * from {{ source("SAP_S4H", "mara") }}),

    -- PREPARE DATA FOR USAGE IN SILVER
    bronze_polished_model as (select matnr as numerics from bronze_raw_table)

-- SELECT MODEL
select *
from bronze_polished_model {{ env_var("DBT_LIMIT") }}

-- extra comment for github PR
