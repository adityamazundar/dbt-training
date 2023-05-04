
{{
    config(
        pre_hook = "{{ RetentionMacro() }}"
    )
}}
select 1 as test from dual
