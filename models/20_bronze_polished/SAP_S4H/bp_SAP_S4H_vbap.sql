-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("br_sap_s4h", "vbap") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (

    select 
        vbeln::string(10) as document_id,
        posnr::string(3) as item_id,
        matnr::string as material,
        matkl::string as material_group,
        kwmeng::number as quantity,
        meins::string(3) as quantity_unit,
        brgew::number as weight_brut,
        ntgew::number as weight_net,
        gewei::string(3) as weight_unit,
        werks::string(4) as plant,
        netpr::number as price_net,
        kpein::number as price_qty,
        kmein::string(3) as price_unit,
        datefromparts(
            substring(cpd_updat::string,0,4),
            substring(cpd_updat::string,5,2),
            substring(cpd_updat::string,7,2)
            )::date as first_date
    from bronze_raw_table

)

-- SELECT MODEL
select 
* from bronze_polished_model {{ env_var("DBT_LIMIT") }}