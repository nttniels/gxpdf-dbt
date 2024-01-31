{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema | replace('PUBLIC_','') }}
    {%- else -%}

        {% set s1 = default_schema %}
        {% set s2 = custom_schema_name | trim %}
        {% set s3 = s1 ~ '_' ~ s2 %}

        {% if 'PUBLIC_' in s3 -%}
            {{ s3 | replace('PUBLIC_','') }}
        {%- else -%}
            {{ s3 }}
        {%- endif -%}

    {%- endif -%}
	
{%- endmacro %}