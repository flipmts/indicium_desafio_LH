with 
    category as (
        select
            productcategoryid
            , product_category
        from {{ref('stg_product_category')}}
    )

    , subcategory as (
        select
            subcategory.productsubcategoryid
            , subcategory.product_subcategory
            , subcategory.productcategoryid
            , category.product_category
        from {{ref('stg_product_subcategory')}} as subcategory
        left join category on category.productcategoryid = subcategory.productcategoryid
    )

    , product as (
        select
            product.productid
            , product.product_name
            , product.product_number
            , product.standard_cost
            , product.list_price
            , product.sell_start_date
            , product.sell_end_date
            , product.productsubcategoryid
            , subcategory.product_subcategory
            , subcategory.productcategoryid
            , subcategory.product_category
        from {{ref('stg_product')}} as product
        left join subcategory on subcategory.productsubcategoryid = product.productsubcategoryid
    )

    , dim_product as (
        select
            {{dbt_utils.generate_surrogate_key(['productid', 'product_number'])}} as sk_product
        , *
        from product
    )

select *
from dim_product