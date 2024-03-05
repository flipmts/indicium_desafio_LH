with stg_product_category as (
    select
        productcategoryid
        , name as product_category
    from {{ source('raw_data', 'productcategory') }}
)
select *
from stg_product_category