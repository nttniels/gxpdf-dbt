-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER"), schema="3NF") }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
mara as (select * from {{ ref("bp_SAP_S4H_mara") }}),
makt as (select * from {{ ref("bp_SAP_S4H_makt") }}),

silver_model as (
    select 
        mara.*,
        makt.lang,
        makt.description
    from mara
    left join makt on mara.material = makt.material
)

select * from silver_model {{ env_var("DBT_LIMIT") }}
