select matnr from {{ source('SAP_S4H_LSD200', 'mara') }}