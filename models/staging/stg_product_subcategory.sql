with stg_product_subcategory as (
    select
        productsubcategoryid
        , productcategoryid
        , name as product_subcategory
    from {{ source('raw_data', 'productsubcategory') }}
)
select *
from stg_product_subcategory