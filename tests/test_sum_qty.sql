with
    validation as(
        select sum(order_qty) as sum_qty
        from {{ref ('fct_sales_order')}}
        where order_date between '2013-01-01' and '2013-12-31'
    )

select * from validation where sum_qty != 131788