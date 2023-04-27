{{
    config(
        materialized='table'
    )
}}

select 'DBT_AM' as Table_Schema,
'RAW_ORDERS' as Table_Name,
'180' as Retention_Period,
'O_ORDERDATE' as Retention_Column 
