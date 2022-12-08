with stg_player as (
    select * from {{ ref('stg_player') }}
)
, stg_team as (
    select * from {{ ref('stg_team') }}
)
, final as (
    select 
        stg_player.player_id
        , stg_player.affiliation_id
        , stg_player.player_name
        , stg_player.weight
        , stg_player.height
        , stg_player.city
        , stg_player.birth_date
        , stg_player.age
        , stg_team.team_name
        , stg_team.country_code
    from stg_player
    left join stg_team on stg_player.affiliation_id = stg_team.affiliation_id
)

select * from final