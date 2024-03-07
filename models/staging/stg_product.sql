with stg_product as (
    select
        productid
        , name as product_name
        , productnumber as product_number
        , standardcost as standard_cost
        , listprice as list_price
        , productsubcategoryid
        , parse_timestamp('%Y-%m-%d %H:%M:%E*S', sellstartdate) as sell_start_date
        , parse_timestamp('%Y-%m-%d %H:%M:%E*S', sellenddate) as sell_end_date
    from {{ source('raw_data', 'product') }}
)
select *
from stg_product