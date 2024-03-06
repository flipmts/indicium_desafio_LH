with 
   dim_product as (
      select
         sk_product
         , productid
      from {{ref('dim_product')}}
   )

   , dim_customer as (
      select
         sk_customer
         , customerid
      from {{ref('dim_customer')}}
   )

   , dim_salesperson as (
      select
         sk_salesperson
         , businessentityid
      from {{ref('dim_salesperson')}}
   )

   , dim_credit_card as (
      select
         sk_credit_card
         , creditcardid
      from {{ref('dim_credit_card')}}
   )

   , dim_territory as (
      select
         sk_territory
         , territoryid
      from {{ref('dim_territory')}}
   )

   , order_detail as (
      select
         salesorderdetailid
         , salesorderid
         , order_qty
         , productid
         , unit_price
         , unit_price_discount
         , ((unit_price - unit_price_discount) * order_qty) as unit_subtotal
      from {{ref('stg_sales_order_detail')}}
   )
   
   , order_header as (
   select
         salesorderid
         , order_date
         , case
         when sales_status = 1 then 'Em processo'
         when sales_status = 2 then 'Aprovado'
         when sales_status = 3 then 'Pedido em espera'
         when sales_status = 4 then 'Rejeitado'
         when sales_status = 5 then 'Enviado'
         when sales_status = 6 then 'Cancelado'
         end as sales_status
         , purchase_order_number
         , customerid
         , salespersonid
         , territoryid
         , creditcardid
         , subtotal
         , taxa_mt
         , freight
         , total_due
      from {{ref('stg_sales_order_header')}}
   )

   , cte_sales_order as (
      select
         order_header.salesorderid
         , order_header.order_date
         , order_header.sales_status
         , order_header.purchase_order_number
         , order_header.subtotal
         , order_header.taxa_mt
         , order_header.freight
         , order_header.total_due
         , order_detail.order_qty
         , order_detail.unit_price
         , order_detail.unit_price_discount
         , order_detail.unit_subtotal
         , dim_product.sk_product as fk_product
         , dim_customer.sk_customer as fk_customer
         , dim_salesperson.sk_salesperson as fk_salesperson
         , dim_credit_card.sk_credit_card as fk_credit_card
         , dim_territory.sk_territory as fk_territory
      from order_header
      left join order_detail on order_detail.salesorderid = order_header.salesorderid
      left join dim_product on dim_product.productid = order_detail.productid
      left join dim_customer on dim_customer.customerid = order_header.customerid
      left join dim_salesperson on dim_salesperson.businessentityid = order_header.salespersonid
      left join dim_credit_card on dim_credit_card.creditcardid = order_header.creditcardid
      left join dim_territory on dim_territory.territoryid = order_header.territoryid
   )
   
select * 
from cte_sales_order