{{
	config(
		materialized = 'materialized_view',
		on_configuration_change='apply',
		tags = ['reporting']
	)
}}

with txns as (
    select
        store_name,
        created_at,
        happened_at,
        row_number()
            over (
                partition by store_name
                order by happened_at
            )
        as rn
    from { ref('stg_transactions') }}
),

base as (
    select
        *,
        extract(
            second from age(created_at, happened_at)
        ) as timediff
    from txns
    where rn <= 5
)

select
    store_name,
    avg(timediff) as average_time,
    sysdate as etl_updated
from base
group by 1
