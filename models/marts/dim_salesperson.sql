with cte_salesperson as (
    select
        businessentityid
        , sales_quota
        , bonus
        , commission_pct
        , job_title
        , first_name
        , middle_name
        , last_name
        , suffix
        , full_name
    from{{ref("int_salesperson")}}
)

    , dim_salesperson as (
        select
            {{dbt_utils.generate_surrogate_key(['businessentityid', 'job_title', 'full_name'])}} as sk_salesperson
            , *
        from cte_salesperson
    )

select *
from dim_salesperson