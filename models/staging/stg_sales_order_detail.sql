with stg_sales_order_detail as (
    select
        salesorderdetailid
        , salesorderid
        , orderqty as order_qty
        , productid
        , unitprice as unit_price
        , unitpricediscount as unit_price_discount
    from {{ source('raw_data', 'salesorderdetail') }}
)
select *
from stg_sales_order_detail