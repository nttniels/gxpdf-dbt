-- TARGET LAYER: BRONZE-POLISHED
{{ config(database=env_var("DBT_BRONZE_POL"), schema="SAP_S4H") }}


-- SOURCE TABLES FROM BRONZE-RAW
with bronze_raw_table as (select * from {{ source("sap_s4h", "equi") }}),

-- PREPARE DATA FOR USAGE IN SILVER
bronze_polished_model as (
    select
        equnr::string(18) as equipment_id,
        erdat::date as record_creation_date,
        ernam::string(12) as created_by, 
        herst::string(30) as manufacturer
        herld::string(3) as manufacturer_country
        hzein::string(30) as manufacturer_drawing_id
        serge::string(30) as manufacturer_serial_no
        typbz::string(20) as equipment_model_number
        baujj::string(4) as construction_year
        baumm::string(2) as construnction_month
        inbdt::date as startup_date
        objnr::string(22) as object_no
        _gxpdf_loaded_at::date row_load_date
    from bronze_raw_table
)

-- SELECT MODEL
select * from bronze_polished_model {{ env_var("DBT_LIMIT") }}

