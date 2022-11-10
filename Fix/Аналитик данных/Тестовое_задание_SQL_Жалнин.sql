with
task_time as
(
	select distinct user_id, sum(finish_date - start_date) over(partition by user_id) as total_time, avg(finish_date - start_date) over(partition by user_id) as avg_time
	from user_task
	where finish_date between(date_trunc('month', current_date)) and (current_date-1)	
),
project as 
(
	select user_id,	count(project_name) as project_count,	
	string_agg(
	project_name || ' ' || reward_rub, '; '
	order by project_name) as extended_info
	from user_task
	where finish_date between(date_trunc('month', current_date)) and (current_date-1)
	group by user_id
),
reward as 
(
	select distinct user_id, sum(reward_rub) over(partition by user_id) as total_reward
	from user_task
	where finish_date between(date_trunc('month', current_date)) and (current_date-1)
),
current_tasks as 
(
	select user_id, count(task_id) as current_task_count
	from user_task
	where finish_date = NULL and start_date between(date_trunc('month', current_date)) and (current_date-1)
	group by user_id
),
complited_tasks as 
(
	select user_id, count(task_id) as count_complited
	from user_task
	where finish_date between(date_trunc('month', current_date)) and (current_date-1)
	group by user_id
)

select distinct u.user_id, login, email, 
count_complited,  
total_time, 
avg_time, 
project_count, 
total_reward,
extended_info,
background_color,
current_task_count
from "user" u
left join user_settings us on us.user_id=u.user_id
left join task_time tt on tt.user_id=u.user_id
left join reward r on r.user_id=u.user_id
left join project p on p.user_id=u.user_id
left join current_tasks cur_t on cur_t.user_id=u.user_id
left join complited_tasks com_t on com_t.user_id=u.user_id
order by u.user_id