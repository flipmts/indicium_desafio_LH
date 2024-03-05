with
    dim_date as (
        {{ dbt_date.get_date_dimension("2010-01-01", "2015-12-31") }}
    )

    select *
    from dim_date