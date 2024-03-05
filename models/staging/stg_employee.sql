with stg_employee as (
    select
        businessentityid
        , nationalidnumber
        , jobtitle as job_title
    from {{ source('raw_data', 'employee') }}
)
select *
from stg_employee