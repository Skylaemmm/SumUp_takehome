{{
	config(
		materialized = 'materialized_view',
		on_configuration_change='apply',
		tags = ['reporting']
	)
}}

select
    store_typology,
    store_country,
    avg(amount) as average_amount,
    sysdate as etl_updated
from {{ ref('stg_transactions') }}
where t.status = 'accepted'
group by 1, 2
order by 1, 2
