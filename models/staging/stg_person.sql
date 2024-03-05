with stg_person as (
    select
        businessentityid
        , persontype as person_type
        , firstname as first_name
        , middlename as middle_name
        , lastname as last_name
        , suffix
    from {{ source('raw_data', 'person') }}
)
select *
from stg_person