{% macro TestMacro() %}
    {% set query %}
        select Retention_Period, Retention_Column from {{ ref('Retention_Policy_Details') }}
    {% endset %}
        
    {% set results = run_query(query) %}
    {% if execute %}
    {# RETURN THE FIRST column #} {% set result_List = results.columns [0].values() %}
    {% else %}
        {% set result_List = [] %}
    {% endif %}

    {% for res in result_List %}
    {% set qry %}
    select {{res}} from dual
    {% endset %}
    {% set results = run_query(qry) %}
    {% endfor %}

    {% for r in result_List %}
    {% set qry %}
        insert into ANALYTICS.DBT_AM.Retention_Policy_Details (Retention_Period)
        select {{r}} from dual
    {% endset %}

    {% set results = run_query(qry) %}
    {% endfor %} 

{% endmacro %}