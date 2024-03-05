with stg_store as (
    select
        businessentityid
        , name as store_name
        , salespersonid
    from {{ source('raw_data', 'store') }}
)
select *
from stg_store