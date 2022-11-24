Задание 1 Показать всех работников из компании Alfa c заработной платой более 50.000


with zp as (select distinct Rank
from Rank
where Salary>=50.000
)

Select Employee_name 
from Employee a 
join Company b on b.ID=a.Company_id
join zp c on c.Rank=a.Rank
where Company_name = 'Alfa';

Задание 2 Показать Компанию и Имя сотрудника с самым высокооплачиваемым сотрудником


with zp as (select max(Salary) as max_zp
from Rank
)

Select Employee_name, Company_name
from Employee a 
join Company b on b.ID=a.Company_id
where a.Rank =(select Rank where Salary=max_zp);

Задание 3 Показать работников, которые работают более чем на одну компанию


Select Employee_name
from Employee a
group by Employee_name
having count(Company_id)>1;

Задание 4 Показать компанию в которой нету ни одного работника (если такая существует)


Select Company_name
from Company a
left join Employee b on a.ID=b.Company_id 
where Company_id is null;

Задание 5 Показать компанию с самым большим количеством работников

with max_emp as (
    select Employee_name, count(Company_id) as comp
    from Employee
    group by 1)

SELECT Employee_name
from max_emp
where  comp=(select max(comp) from max_tasks);