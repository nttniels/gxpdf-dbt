
select 
    matnr as number,
    spras as string(1),
    maktx as string(40),
    maktg as string(40)
    primary key (matnr, spras)
from {{ source('SAP_S4H_LSD200', 'makt') }}