
{{
    config(
        pre_hook = "{{ TestMacro() }}"
    )
}}
select 1 as test from dual
