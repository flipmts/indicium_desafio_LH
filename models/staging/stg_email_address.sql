with stg_email_address as (
    select
        businessentityid
        , emailaddressid
        , emailaddress as email_address
    from {{ source('raw_data', 'emailaddress') }}
)
select *
from stg_email_address