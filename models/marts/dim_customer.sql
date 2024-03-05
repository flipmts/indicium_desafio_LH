with cte_customer as (
    select
            customerid
            , personid
            , person_type
            , person_type_description
            , first_name
            , middle_name
            , last_name
            , suffix
            , full_name
            , email_address
        from{{ref('int_customer')}}
)
    , dim_customer as (
        select
            {{dbt_utils.generate_surrogate_key(['customerid', 'personid', 'full_name'])}} as sk_customer
        , *
        from cte_customer
    )

select *
from dim_customer