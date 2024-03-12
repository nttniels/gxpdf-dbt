-- TARGET LAYER: SILVER
{{ config(database=env_var("DBT_SILVER")) }}


-- SELECTED FIELDS FROM BRONZE-POLISHED
with
bp1 as (select * from {{ ref("bp_SAP_S4H_ekko") }}),

silver_model as (

    select
        bp1.purchase_order,
        bp1.company_code,
        bp1.purchase_doc_category,
        bp1.purchase_doc_type,
        bp1.deletion_indicator,
        bp1.status_document,
        bp1.purchase_organsation,
        bp1.purchase_group,
        bp1.vendor_nr,
        bp1.row_loaded_datetime,
        bp1.creation_date,
        bp1.last_change_datetime
    from bp1
    where bp1.company_code = '1710'

)

select *
from silver_model {{ env_var("DBT_LIMIT") }}
