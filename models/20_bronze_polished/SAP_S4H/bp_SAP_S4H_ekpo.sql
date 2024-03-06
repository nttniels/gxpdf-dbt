-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("sap_s4h", "ekpo") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (

    select
        ebeln::string(10) as purchase_order,
        ebelp::string(5) as purchase_order_item,
        loekz::string(1) as deletion_indicator,
        matnr::string(40) as material_id,
        menge::number as purchase_order_quantity,
        meins::string(10) as quantity_unit,
        netpr::number as net_price,
        peinh::string(8) as price_unit,
        _gxpdf_loaded_at::timestamp_ntz as row_loaded_datetime
    from bronze_raw_table

)

-- SELECT MODEL
select *
from bronze_polished_model {{ env_var("DBT_LIMIT") }}
