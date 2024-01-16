-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER"), schema="3NF") }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_vbak") }}),

silver_model as (

    select 
        bp1.*
    from bp1
    
)

select * from silver_model {{ env_var("DBT_LIMIT") }}
