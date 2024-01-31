
-- remove schema prefixes for quality and production environment

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    
    {%- if default_schema.name == 'custom_schemas_defined_in_code' -%}
        {%- if custom_schema_name is none -%}
            -- return no default schema name
            {{ 'checkSchemaMacro' | trim }}
        {%- else -%}
            -- only return custom schema name
            {{ custom_schema_name | trim }}
        {%- endif -%}
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