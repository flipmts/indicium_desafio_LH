with stg_sales_territory as (
    select
        territoryid
        , name as territory_name
        , countryregioncode as contry_region_code
        , 'group' as territory_group
    from {{ source('raw_data', 'salesterritory') }}
)
select *
from stg_sales_territory