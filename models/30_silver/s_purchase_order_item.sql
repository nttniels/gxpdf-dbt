-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER")) }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_ekpo") }}),

silver_model as (

    select *
    from bp1

)

select *
from silver_model {{ env_var("DBT_LIMIT") }}
