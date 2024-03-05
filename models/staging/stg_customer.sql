with stg_customer as (
    select
        customerid
        , personid
        , storeid
        , territoryid
    from {{ source('raw_data', 'customer') }}
)
select *
from stg_customer