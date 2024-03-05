with 
    cte_sales_order as (
        select
            fk_product
            , fk_customer
            , fk_salesperson
            , fk_credit_card
            , fk_territory
            , salesorderid
            , order_date
            , sales_status
            , purchase_order_number
            , subtotal
            , taxa_mt
            , freight
            , total_due
            , order_qty
            , unit_price
            , unit_price_discount
        from {{ref('int_sales_order')}}
    )

    , fct_sales_order as (
        select
            {{dbt_utils.generate_surrogate_key(['salesorderid', 'fk_product'])}} as sk_sales_order_product
            , {{dbt_utils.generate_surrogate_key(['salesorderid'])}} as sk_sales_order
            , *
        from cte_sales_order
    )

select *
from fct_sales_order