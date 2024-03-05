with 
    order_reason as (
        select
            salesorderid
            , salesreasonid
        from {{ref('stg_sales_order_reason')}}
    )

    , reason as (
        select
            reason.salesreasonid
            , reason.sales_reason
            , reason.reason_type
            , order_reason.salesorderid
        from {{ref('stg_sales_reason')}} as reason
        left join order_reason on order_reason.salesreasonid = reason.salesreasonid

)
    , dim_reason as (
        select
            {{dbt_utils.generate_surrogate_key(['salesreasonid', 'salesorderid'])}} as sk_reason
            , {{dbt_utils.generate_surrogate_key(['salesorderid'])}} as fk_order
            , *
        from reason
    )

select *
from dim_reason