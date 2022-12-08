{{
    config(
        materialized='table'
    )
}}

with player as (
    select * from {{ source('fifa', 'player') }}
)

select 
    id as player_id
    , affiliation_id
    , concat(player_first_name, ' ', player_last_name) as player_name
    , weight
    , height
    , city
    , birth_date
    -- obtain age at 2018 world cup start
    , datediff(year,birth_date,'2018-06-14') as age
from player
