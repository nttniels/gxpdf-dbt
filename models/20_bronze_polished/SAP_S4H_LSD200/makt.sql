
select 
    -- matnr as number,
    -- spras as string,
    -- maktx as string,
    -- maktg as string
    *
from {{ source('SAP_S4H_LSD200', 'makt') }}