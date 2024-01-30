-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER"), schema="3NF") }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_vbap") }}),

silver_model as (
    
    select 
        bp1.document_id,
        bp1.item_id,
        bp1.material,
        bp1.material_group,
        bp1.quantity,
        bp1.quantity_unit,
        bp1.weight_brut,
        bp1.weight_net,
        bp1.weight_unit,
        bp1.plant,
        bp1.price_net,
        bp1.price_qty,
        bp1.price_unit,
        bp1.first_date
    from bp1

)

select *
from silver_model {{ env_var("DBT_LIMIT") }}
