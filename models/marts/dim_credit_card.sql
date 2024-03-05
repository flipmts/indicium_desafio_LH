with 
    credit_card as (
    select
        creditcardid
        , cardtype
    from {{ref('stg_credit_card')}}
    )

    , dim_credit_card as (
        select
            {{dbt_utils.generate_surrogate_key(['creditcardid', 'cardtype'])}} as sk_credit_card
            , *
            from credit_card
    )

select *
from dim_credit_card