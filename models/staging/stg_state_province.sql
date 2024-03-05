with stg_state_province as (
    select
        stateprovinceid
        , territoryid
        , stateprovincecode as state_province_code
        , isonlystateprovinceflag as is_only_state_province_flag
        , name as state_province_name
    from {{ source('raw_data', 'stateprovince') }}
)
select *
from stg_state_province