{% macro RetentionMacro() %}
    {% set query %}
        select Table_Schema, Table_Name, Retention_Period, Retention_Column from {{ ref('Retention_Policy_Details') }}
    {% endset %}
        
    {% set results = run_query(query) %}
    {% if execute %}
        {% set result = results.rows %}
        {% set result_list_Table_Schema = results.columns[0].values() %}
        {% set result_list_Table_Name = results.columns[1].values() %}
        {% set result_list_r_period = results.columns[2].values() %}
        {% set result_list_r_column = results.columns[3].values() %}
    {% endif %}

    {% for i in range(0,result | length) %}
        {% set qry %}
            delete from {{ result_list_Table_Schema[i]}}.{{result_list_Table_Name[i] }} 
            where {{result_list_r_column[i]}} <= dateadd(day,-{{ result_list_r_period[i] }},getdate())
        {% endset %}
        {% set final = run_query(qry) %}
    {% endfor %}

{% endmacro %}