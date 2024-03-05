with stg_credit_card as (
    select
        creditcardid
        , cardtype
    from {{ source('raw_data', 'creditcard') }}
)
select *
from stg_credit_card