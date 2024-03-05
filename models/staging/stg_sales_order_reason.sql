with stg_sales_order_reason as (
    select
        salesorderid
        , salesreasonid
    from {{ source('raw_data', 'salesorderheadersalesreason') }}
)
select *
from stg_sales_order_reason