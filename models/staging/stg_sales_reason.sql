with stg_sales_reason as (
    select
        salesreasonid
        , name as sales_reason
        , reasontype as reason_type
    from {{ source('raw_data', 'salesreason') }}
)
select *
from stg_sales_reason