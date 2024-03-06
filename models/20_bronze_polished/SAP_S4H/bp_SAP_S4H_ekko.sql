-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("sap_s4h", "ekko") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (

    select
        ebeln::string(10) as purchase_order,
        bukrs::string(10) as company_code,
        bstyp::string(1) as purchase_doc_category,
        bsart::string(4) as purchase_doc_type,
        loekz::string(1) as deletion_indicator,
        statu::string(1) as status_document,
        ekorg::string(4) as purchase_organsation,
        ekgrp::string(10) as purchase_group,
        lifnr::string(10) as vendor_nr,
        _GXPDF_LOADED_AT::timestamp_ntz as row_loaded_datetime,
        DATE(aedat, 'YYYYMMDD') as creation_date,
        TO_TIMESTAMP(lastchangedatetime::string, 'yyyymmddhhmiss.ff')
            as last_change_datetime
    from bronze_raw_table

)

-- SELECT MODEL
select *
from bronze_polished_model {{ env_var("DBT_LIMIT") }}
