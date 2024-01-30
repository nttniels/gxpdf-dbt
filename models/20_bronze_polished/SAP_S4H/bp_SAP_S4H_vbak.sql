-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("br_sap_s4h", "vbak") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (
    select 
        vbeln::string(10) as document_id,
        case when netwr::number > 5000 then 5000 else netwr::number end as net_value,
        waerk::string(3) as currency,
        vkorg::string(4) as sales_organization,
        vtweg::string(2) as disctribution_channel,
        ernam::string as created_by,
        erdat::date as created_on
    from bronze_raw_table
)

-- SELECT MODEL
select *
from bronze_polished_model {{ env_var("DBT_LIMIT") }}