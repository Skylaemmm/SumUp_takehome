{{
	config(
		materialized = 'materialized_view',
		on_configuration_change='apply',
		tags = ['reporting']
	)
}}

with total as (
    select
        store_id,
        store_name,
        sum(amount) as total_amount
    from {{ ref('stg_transactions') }}
    where status = 'accepted'
    group by 1,2
),

total_rank as (
    select
        store_id,
        store_name,
        total_amount,
        rank() over (order by total_amount) as rank
    from total
)
select
    store_id,
    store_name,
    total_amount,
    rank,
    sysdate as etl_updated
from total_rank
where rank <= 10