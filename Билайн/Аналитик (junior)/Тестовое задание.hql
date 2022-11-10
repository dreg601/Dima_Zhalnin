set hivevar:SCHEME = stg.;
set hivevar:NAME = zhds_;
set hivevar:TASK = 46;

drop table ${SCHEME}${NAME}${TASK}_clients purge;
create EXTERNAL table ${SCHEME}${NAME}${TASK}_clients
(time_key string,
client_id_tech string,
combo_ind string
client_id_serv string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\;'
STORED AS TEXTFILE;

drop table ${SCHEME}${NAME}${TASK}_clients_12m purge;
create table ${SCHEME}${NAME}${TASK}_clients_12m as
SELECT *
from ${SCHEME}${NAME}${TASK}_clients as a
WHERE time_key>= '2021-08-01';

drop table ${SCHEME}${NAME}${TASK}_clients_4m purge;
create table ${SCHEME}${NAME}${TASK}_clients_4m as
SELECT *
from ${SCHEME}${NAME}${TASK}_clients as a
WHERE time_key>= '2022-04-01';

drop table ${SCHEME}${NAME}${TASK}_clients_12m_1 purge;
WITH unique as (
	SELECT DISTINCT client_id_serv, time_key, combo_ind, client_id_serv
	from ${SCHEME}${NAME}${TASK}_clients_12m )
create L table ${SCHEME}${NAME}${TASK}_clients_12m_1 as
SELECT *
from ${SCHEME}${NAME}${TASK}_clients_12m a
JOIN unique b on a.client_id_serv=b.client_id_serv and a.time_key=b.time_key

Логика тут такая, нужно найти НЕ уникальные значения и вывести их (тех, кто продлял контракт или покупал новую услугу). Это нужно провести за разные периоды (1, 4 и 12 месяцев).
Это я не смог реализовать через пандас, не понимаю как сделать.
Вообще, я не совсем понял последнее задание и хочу понять, а как правильно и что вообще нужно было сделать?
