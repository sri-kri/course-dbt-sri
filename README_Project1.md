How many users do we have?

q: select count(distinct user_id) from dbt_sk.stg_users;
a: 130

On average, how many orders do we receive per hour?

q: with summary_by_hour as (select extract(day from created_at) as date , extract(hour from created_at) as hour_of_day, count(order_id) as num_orders from dbt_sk.stg_orders where created_at is not null  group by 1,2 order by 1,2 asc) select round(avg(num_orders),0) from summary_by_hour;
a: 8 per hour

On average, how long does an order take from being placed to being delivered?

q: select round(avg(date_part('day', delivered_at - created_at))::numeric,0) as order_to_delivery from dbt_sk.stg_orders where created_at is not null and delivered_at is not null; 
a: 4 days 

How many users have only made one purchase? Two purchases? Three+ purchases?
 
q: with orders_per_user as (select user_id, count(order_id) as count_orders from dbt_sk.stg_orders where created_at is not null group by 1) select case when count_orders = 1 then '1 order'  when count_orders = 2 then '2 orders' else '3+ orders' end as count_of_orders_bucket, count(distinct user_id) as count_users from orders_per_user group by 1;
a: 
1 order: 25
2 orders: 25
3+ orders: 78

On average, how many unique sessions do we have per hour?

q: with orders_per_hour as (select extract(hour from created_at) as hour, count(distinct session_id) as count_sessions from dbt_sk.stg_events where created_at is not null group by 1 ) select round(avg(count_sessions), 0) as avg_sessions_per_hour from orders_per_hour;
a: 123