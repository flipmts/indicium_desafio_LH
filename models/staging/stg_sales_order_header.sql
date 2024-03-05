with stg_sales_order_header as (
  select
      salesorderid
      , parse_timestamp('%Y-%m-%d %H:%M:%E*S', orderdate) as order_date
      , status as sales_status
      , purchaseordernumber as purchase_order_number
      , customerid
      , salespersonid
      , territoryid
      , creditcardid
      , subtotal
      , taxamt as taxa_mt
      , freight
      , totaldue as total_due
   from {{ source('raw_data', 'salesorderheader') }}
)
select * 
from stg_sales_order_header