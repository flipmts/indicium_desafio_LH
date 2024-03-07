with
    salesperson as (
        select 
            sk_salesperson
            , businessentityid as salespersonid
            , full_name
        from {{ref('dim_salesperson')}}
    )

    , territory as (
        select 
            sk_territory
            , territoryid
            , territory_name
        from {{ref('dim_territory')}}
    )

    , sales_order as (
        select 
            sk_sales_order_product
            , fk_salesperson
            , fk_territory
            , order_qty
            , unit_price
        from {{ref('fct_sales_order')}}
    )

    , salesperson_territory as (
        select
            territory.territoryid
            , territory.territory_name
            , salesperson.salespersonid
            , salesperson.full_name
            , round(sum(sales_order.order_qty), 2) as total_products_amount
            , round(sum(sales_order.unit_price), 2) as total_salesperson_due
            , round(sum(sales_order.unit_price) / sum(sales_order.order_qty), 2) as average_order_value
        from sales_order
        left join salesperson on salesperson.sk_salesperson = sales_order.fk_salesperson
        left join territory on territory.sk_territory = sales_order.fk_territory
        where salesperson.sk_salesperson is not null
        group by territory.territory_name, salesperson.full_name, territory.territoryid, salesperson.salespersonid
    )

    , agg_salesperson_territory as (
        select
            {{dbt_utils.generate_surrogate_key(['territoryid', 'salespersonid'])}} as sk_salesperson_territory
            , *
        from salesperson_territory
    )

select * from agg_salesperson_territory