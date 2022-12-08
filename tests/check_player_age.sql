{{
    config(
        error_if = '>10'
        , warn_if = '>0'
    )
}}

select 
    *
from {{ ref('stg_player') }}
where age <19 or age>36