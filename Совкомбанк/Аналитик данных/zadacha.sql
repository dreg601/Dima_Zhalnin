--ЗАДАНИЕ 1
-----------------------1 задача--------------------------

select a.id
from department a
join employee b on a.id=b.dep_id
group by a.id
having count(b.id)<= 5

-----------------------2 задача--------------------------

with chief as(select id, salary, actual_end_date
	 from employee e
  	 join salary s on s.emp_id=e.id
	 where e.id=e.chief_id
	 and actual_end_date = '31.08.2020')
select e.name, d.name
from employee e
join chief c on c.id=e.chief_id
join department d on d.id= e.dep_id
join salary s on s.emp_id = e.id
where s.salary>c.salary
and s.actual_end_date = '31.08.2020'

-----------------------3 задача--------------------------

select a.name
from  employee a
where  a. salary = ( select max(salary) from employee b
where  b.dep_id = a.dep_id);

-----------------------4 задача--------------------------

select d.name, sum(salary)
from employee as e
join department d on d.id=e.dep_id
join salary s on e.id=s.emp_id
join employee c on (e.chief_id = c.id and e.dep_id = c.dep_id)
where c.id is NULL
group by d.name;

--ЗАДАНИЕ 2

с процедурами слабо знаком, пользовался только пока учился в университете

CREATE PROCEDURE CREATE
    @n number,
    @m number,
    @val int
AS
    CREATE TABLE @n(@m)
    VALUES(@val)
END;


--ЗАДАНИЕ 3

Я не сталкивался с подобным ни разу.
Есть вариант, просто создать новое поле и сделать его PK. Легко и просто.

Второй вариант - также, создать новое поле и генерировать его на основе первых знаков (как я понял, в группе внешних ключей только числа)
по типу (substr(id1,1,2),substr(id2,1,2),substr(id3,1,2)) as PK

Вариант три, то что я часто видел на работе - создание партиций. То есть, создание отдельных папок. По сути, таблица остается одной, 
но она как бы разделяется на несколько файлов, по партициям. Можно указать дату, регион и так далее, смотря что нужно. Если есть три ключа - можно сделать три партиции.
