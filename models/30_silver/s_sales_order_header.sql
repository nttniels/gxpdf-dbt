-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER")) }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_vbak") }}),

silver_model as (

    select 
        bp1.document_id,
        bp1.net_value,
        bp1.currency,
        bp1.sales_organization,
        bp1.disctribution_channel,
        bp1.created_by,
        bp1.created_on
    from bp1
    
)

select *
from silver_model {{ env_var("DBT_LIMIT") }}
