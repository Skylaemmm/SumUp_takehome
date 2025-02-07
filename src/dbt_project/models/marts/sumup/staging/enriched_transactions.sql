{{
	config(
		materialized = 'incremental',
		tags = ['sched_h_2', 'transactions'],
		indexes=[{'columns': ['txn_id'], 'unique': True }]
	)
}}

{% set run_setup %}
    {% if is_incremental() %}
    -- better to use etl_updated from the source so that we capture all updated rows
        and t.created_at >= (select dateadd(day, -1, max(t.created_at)) from {{ this }})
    {% endif %}

    {% if not is_incremental() %}
        and t.created_at >= current_date - interval '12 months'
    {% endif %}

    {% if is_dev_run() %}
        and t.created_at >= current_date - interval '1 months'
    {% endif %}
{% endset %}


select
    t.id as txn_id,
    t.device_id,
    d.type as device_type,
    t.product_name,
    t.product_sku,
    t.category_name,
    t.amount,
    t.status,
    t.created_at,
    t.happened_at,
    d.store_id,
    s.name as store_name,
    s.address as store_address,
    s.city as store_city,
    s.country as store_country,
    s.created_at as store_created_at,
    s.typology as store_typology,
    s.customer_id,
    sysdate as etl_updated
from {{ source('sumup', 'transactions') }} as t
inner join {{ source('sumup', 'device') }} as d on t.device_id = d.id
inner join {{ source('sumup', 'store') }} as s on d.store_id = s.id
where 1=1
{{run_setup}}