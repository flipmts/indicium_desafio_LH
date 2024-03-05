with stg_salesperson as (
    select
        businessentityid
        , salesquota as sales_quota
        , bonus
        , commissionpct as commission_pct
    from {{ source('raw_data', 'salesperson') }}
)
select *
from stg_salesperson