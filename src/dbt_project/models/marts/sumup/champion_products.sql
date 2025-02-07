{{
	config(
		materialized = 'materialized_view',
		on_configuration_change='apply',
		tags = ['reporting']
	)
}}

with total as (
    select
        product_name,
        sum(amount) as total_amount
    from {{ ref('enriched_transactions') }}
    where status = 'accepted'
    group by 1
),

total_rank as (
    select
        product_name,
        total_amount,
        rank() over (order by total_amount) as rank
    from total
)
select
    product_name,
    total_amount,
    rank
from total_rank
where rank <= 10