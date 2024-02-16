{% macro generate_source(database_name, schema_name) %}

-- BUILD SQL
{% set sql %}
    with
    "columns1" as (
        select
            '- name: ' || lower(column_name) || '\n            description: "'|| lower(ifnull(comment,'')) || '"' as column_statement,
            table_name,
            column_name
        from {{ database_name }}.information_schema.columns
        where table_schema = '{{ schema_name | upper }}'
    ),
    "tables1" as (
        select 
        table_name as table_name2,
        ifnull(comment,'') as table_comment
        from {{ database_name }}.information_schema.tables
        where table_schema = '{{ schema_name | upper }}'
    ),
    tables as (
        select
        table_name,
        table_comment,
        '\n\n      - name: "' || lower(table_name) || '"\n        description: "' || table_comment  || '"\n        columns:' || listagg('\n          ' || column_statement || '\n') within group ( order by column_name ) as table_desc
        from "columns1" left join "tables1" on "columns1".table_name = "tables1".table_name2
        group by table_name, table_comment
    )

    select listagg(table_desc) within group ( order by table_name )
    from tables;

{% endset %}

-- QUERY
{%- call statement('generator', fetch_result=True) -%}
{{ sql }}
{%- endcall -%}

{%- set states=load_result('generator') -%}
{%- set states_data=states['data'] -%}
{%- set states_status=states['response'] -%}


-- BUILD YAML
{% set sources_yaml=[] %}
{% do sources_yaml.append('  ') %}
{% do sources_yaml.append('  ') %}
{% do sources_yaml.append('  - name: br_' ~ schema_name | lower) %}
{% do sources_yaml.append('    description: ""' ) %}
{% do sources_yaml.append('    database: ' ~ database_name | lower) %}

{% for states_entry in states_data -%}
    {% for table_entry in states_entry -%}
        {% do sources_yaml.append('    tables:' ~ table_entry ) %}
    {% endfor %}
{% endfor %}

{% do sources_yaml.append('  ') %}
{% do sources_yaml.append('  ') %}

-- RETURN
{% if execute %}
{% set joined = sources_yaml | join ('\n') %}
{{ log(joined, info=True) }}
{% do return(joined) %}

{% endif %}



{% endmacro %}