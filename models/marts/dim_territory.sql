with 
    territory as (
        select
            territoryid
            , territory_name
            , contry_region_code
            , territory_group
        from {{ref('stg_sales_territory')}}
    )

    , dim_territory as (
        select
            {{dbt_utils.generate_surrogate_key(['territoryid', 'contry_region_code'])}} as sk_territory
            , *
        from territory
    )

    select *
    from dim_territory