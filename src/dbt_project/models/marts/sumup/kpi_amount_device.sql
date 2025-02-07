{{
	config(
		materialized = 'materialized_view',
		on_configuration_change='apply',
		tags = ['reporting']
	)
}}

select
    device_type,
    sum(amount) as amount_per_device,
    sum(sum(amount)) over () as total_amount,
    100.0 *  sum(amount) / sum(sum(amount)) over () as percentage
from {{ ref('enriched_transactions') }}
where status = 'accepted'
group by 1
