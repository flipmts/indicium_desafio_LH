with 
    person as (
        select
            businessentityid
            , person_type
            , first_name
            , middle_name
            , last_name
            , suffix
        from{{ref('stg_person')}}
    )

    , store as (
        select
            businessentityid
            , store_name
        ,    salespersonid
        from {{ref('stg_store')}}
    )

    , email_address as (
        select
            businessentityid
            , email_address
        from{{ref('stg_email_address')}}
    )

    , customer as (
        select
            customerid
            , personid
            , storeid
            , territoryid
        from{{ref('stg_customer')}}
    )

    , cte_customer as (
        select
            customer.customerid
            , customer.personid
            , person.person_type
            , case
                when person.person_type = 'SC' then 'Contato Loja'
                when person.person_type = 'IN' then 'Pessoa Física'
                when person.person_type = 'SP' then 'Vendedor'
                when person.person_type = 'EM' then 'Funcionário (não venda)'
                when person.person_type = 'VC' then 'Contato do Fornecedor'
                when person.person_type = 'GC' then 'Contato Geral'
            end as person_type_description
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
            , email_address.email_address
            , customer.storeid
            , store.store_name
            , customer.territoryid
        from customer
        left join person on customer.personid = person.businessentityid
        left join email_address on person.businessentityid = email_address.businessentityid
        left join store on store.storeid = customer.storeid
    )
select *
from cte_customer