with 
    person as (
    select
        businessentityid
        , first_name
        , middle_name
        , last_name
        , suffix
    from{{ref('stg_person')}}
    )

    , employee as (
        select
            businessentityid
            , nationalidnumber
            , job_title
        from{{ref('stg_employee')}}
    )

    , salesperson as (
        select
            businessentityid
            , sales_quota
            , bonus
            , commission_pct
            , sales_ytd
            , sales_last_year
        from{{ref('stg_salesperson')}}
    )

    , cte_salesperson as (
        select
            salesperson.businessentityid
            , salesperson.sales_quota
            , salesperson.bonus
            , salesperson.commission_pct
            , employee.job_title
            , person.first_name
            , person.middle_name
            , person.last_name
            , person.suffix
            , concat(
                person.first_name
                , ' '
                , coalesce(person.middle_name, '')
                , ' '
                , person.last_name
                , ' '
                , coalesce(person.suffix, '')
            ) as full_name
            from salesperson
            left join employee on salesperson.businessentityid = employee.businessentityid
            left join person on employee.businessentityid = person.businessentityid
    )

select *
from cte_salesperson