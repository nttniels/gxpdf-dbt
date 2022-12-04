with player as (
    select * from {{ source('fifa', 'player') }}
)

select 
    id as player_id
    , concat(player_first_name, ' ', player_last_name) as player_name
    , weight
    , height
    , city
    , birth_date
from player
