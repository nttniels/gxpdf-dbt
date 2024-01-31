{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}

    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
    
        {% set s2 = custom_schema_name | trim -%}
        {% set schema = default_schema ~ '_' ~ s2 -%}

        {% if 'PUBLIC_' in schema -%}
            {{ schema | replace('PUBLIC_','') }}
        {%- else -%}
            {% if 'public_' in schema -%}
                {{ schema | replace('public_','') }}
            {%- else -%}
                {{ schema }}
            {%- endif -%}
        {%- endif -%}

    {%- endif -%}
	
{%- endmacro %}