Задание 1: Необходимо удалить дублирующие по значению записи из таблицы TBL, оставив только
уникальные значения, т.е. результат в таблице TBL должен выглядеть следующим образом:

delete from public.tbl
where fld not in(select distinct fld from tbl);

Задание 2: Необходимо для каждой проводки в таблице CARRY рассчитать соответствующую Сумму в рублях
(Сумма в валюте*Ближайший по дате курс валюты)
	
select a.data, a.val, sum_val, sum_val*rate as convert_val
from public.carry a
join currency_rate b on a.val=b.val and a.data>=b.data
group by a.data, b.data, a.val, sum_val, convert_val
having (b.data-a.data)=min(b.data-a.data);

Задание 3: Необходимо вывести все сочетания сотрудников, когда оклад руководителя (необязательно
непосредственного) меньше чем оклад сотрудника.

with recursive employee_1(id, id_ruk, zp) as (
	select id, id_ruk, zp 
	from employee
	where id_ruk is not null
	union
	select e.id, e.id_ruk, e.zp
	from employee_1 e_1, employee e 
	where e_1.id=e.id_ruk
)

select * from  employee_1;

Задание 4 Необходимо в одном запросе вывести все диапазоны, внутри которых значение поля fld
непрерывно (по значению)

with 
b as(
	select fld, fld - row_number() over(order by fld) AS diff
	from tbl
	)

select min(fld) as fld_from, max(fld) as fld_to
from b
group by diff
order by fld_from;

Задание 5: Напишите SQL-запрос, чтобы найти сотрудников, которые получают три самые высокие зарплаты в
каждом отделе.

with a as(
select department_name, name, salary, row_number() over(partition by department_name order by salary desc) as rang_zp
from salary a
join department b on a.department_id=b.department_id)

select * from a where rang_zp<=3;

Задание 6: Написать код, который будет возвращать список всех id, подходящих под определение вставки
задним числом.

select id
FROM (select id, timestamp, 
	max(timestamp) 
	over(
	order by id rows between UNBOUNDED PRECEDING and 1 PRECEDING) as min_date
	from table_date
	) as tabl
where timestamp<min_date;
