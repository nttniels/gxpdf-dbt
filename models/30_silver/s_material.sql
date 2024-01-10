-- LAYER: SILVER
{{ config(database=env_var("DBT_SILVER"), schema="3NF") }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
    polished_model as (select * from {{ ref("SAP_S4H_material") }}),

    silver_model as (select * from polished_model)

select *
from silver_model {{ env_var("DBT_LIMIT") }}