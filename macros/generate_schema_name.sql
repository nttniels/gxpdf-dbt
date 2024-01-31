
-- remove schema prefixes for quality and production environment

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    -- remove schema prefixes if required by environment
    {%- if env_var('DBT_DEFAULT_SCHEMA') == 'OFF' -%}
        {%- if custom_schema_name is none -%}
            -- return no default schema name
        {%- else -%}
            -- only return custom schema name
            {{ custom_schema_name | trim }}
        {%- endif -%}

    -- default macro
    {%- else -%}
        {%- if custom_schema_name is none -%}
            -- return no default schema name
            {{ default_schema }}
        {%- else -%}
            -- only return custom schema name
            {{ default_schema }}_{{ custom_schema_name | trim }}
        {%- endif -%}
    {%- endif -%}
    
{%- endmacro %}