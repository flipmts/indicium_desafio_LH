with stg_address as (
    select
        addressid
        , stateprovinceid
        , addressline1
        , addressline2
        , city
        , postalcode
        , spatiallocation as spatial_location
    from {{ source('raw_data', 'address') }}
)
select *
from stg_address