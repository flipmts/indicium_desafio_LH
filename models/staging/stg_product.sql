with stg_product as (
    select
        productid
        , name as product_name
        , productnumber as product_number
        , standardcost as standard_cost
        , listprice as list_price
        , productsubcategoryid
        , sellstartdate as sell_start_date
        , sellenddate as sell_end_date
        , discontinueddate as discontinued_date
    from {{ source('raw_data', 'product') }}
)
select *
from stg_product