use profinterest;

-- 1. получение списка навыковов, необходимых для возможности претендовать на вакансию 
-- (с определенным ID = 2 в примере) и отсутствующих в списке навыков, 
-- прохождение обучения по которым подтверждено сертификатом. 

select skill_name from 
	skills_for_jobs where 
    job_id = 2 and skill_name not in (select skill_name from serts);
 
-- 2. формирование списка навыков из числа востребованных у работодателей, 
-- не подтвержденных сертификатами о прохождении обучения, 
-- в порядке снижения частоты упоминаний в вакансиях

select skill_name from 
	(select skill_name, count(*) as freq from skills_for_jobs 
		group by skill_name order by freq desc) as popularity 
	where skill_name not in (select skill_name from serts);

-- 3. вывести навыки, необходимые для возможности 
-- претендовать на вакансию с максимальной зарплатой 

select skill_name from skills_for_jobs 
	where job_id = (select id from jobs where salary = (select MAX(salary) as max from jobs));

-- 4. Отобразить все вакансии, требуемые навыки которых на
-- >=15% покрываются имеюшимися сертификатами. 

select SECOND.ID ID_вакансии, FIRST.JOB_NAME, SECOND.SERT_COUNT / FIRST.SKILL_COUNT * 100 
'Процент изученных (подтвержденных сертификатом) навыков' from
(
select two.id ID, two.name JOB_NAME,  one.count SKILL_COUNT from
(select job_id, count(*) as count from (select * from skills_for_jobs) as qqq group by job_id) as one, 
(select id, name from jobs) as two
where (one.job_id = two.id) order by two.id
) as FIRST,
(
select ID, count(*) SERT_COUNT from
(select two.id ID, one.skill_name SKILL from
(select job_id, skill_name from (select * from skills_for_jobs) as qqq) as one, 
(select id, name from jobs) as two
where (one.job_id = two.id and one.skill_name in (select skill_name from serts))) as www group by ID order by ID
) as SECOND
where (FIRST.ID = SECOND.ID and SECOND.SERT_COUNT / FIRST.SKILL_COUNT * 100 > 15) order by SECOND.SERT_COUNT / FIRST.SKILL_COUNT * 100;

-- 5. Вывести все курсы, имеющиеся в БД по навыкам, присутствующим в вакансиях. В случае отсутствия 
-- требуемых курсов - отобразить это (NULL)

select distinct skill.skill_name Навык, webinar.name 'курсы и вебинары'
	from skills_for_jobs skill
    LEFT JOIN courses webinar on (skill.skill_name = webinar.skill_name);

-- 6. Вывести все материалы (названия литературы и названия курсов), имеющиеся в БД по навыкам, 
-- присутствующим в вакансиях. В случае отсутствия 
-- требуемых курсов - отобразить это (NULL)
 
select * from
(select skill.skill_name SKILL, literature.name Source
	from skills_for_jobs skill
    LEFT JOIN litr literature on (skill.skill_name = literature.skill_name)
UNION
	select distinct skill.skill_name Навык, webinar.name Материалы
	from skills_for_jobs skill
    LEFT JOIN courses webinar on (skill.skill_name = webinar.skill_name)) as cour
	order by Source desc;
    
-- --------------------------------------------------------------------------------------
-- представления
-- --------------------------------------------------------------------------------------

-- 1. вывести навыки, необходимые для возможности претендовать на вакансии с зарплатой выше средней

drop view if exists avg_salary;

create view avg_salary as
	select skill_name from skills_for_jobs 
    where job_id = (select id from jobs where salary > (select AVG(salary) as max from jobs));    

select * from avg_salary;

-- 2. Вывести всю литературу, имеющуюся в БД по навыкам, присутствующим в вакансиях

drop view if exists liter_for_jobs;

create view liter_for_jobs as
select distinct skill.skill_name Навык, literature.name Литература
	from skills_for_jobs skill
    LEFT JOIN litr literature on (skill.skill_name = literature.skill_name) order by literature.name desc; 

select * from liter_for_jobs;

-- --------------------------------------------------------------------------------------
-- процедуры
-- --------------------------------------------------------------------------------------

-- 1. Проверить есть ли в БД материалы по передаваемому в процедуру навыку и
-- если есть - вывести их, если нет - написать "материалы отсутствуют"

drop procedure if exists `skill_materials`;
    
delimiter |

create procedure `skill_materials` (IN skill TEXT)
begin 
	declare var1 TEXT;
    declare var2 TEXT;
    set var1 = (select skill_name from litr where skill_name = skill limit 1);
    set var2 = (select skill_name from courses where skill_name = skill limit 1);
	if var1 is not null or var2 is not null then 
    (select name as 'материалы', link from litr where skill_name = skill
union
	select name as 'материалы', link from courses where skill_name = skill);
    else select 'материалы отсутствуют';
    end if;
end|

delimiter ;

call skill_materials('mysql');

-- 2. Получение списка навыковов, необходимых для возможности 
-- претендовать на вакансию с задаваемым ID и отсутствующих в списке навыков, 
-- прохождение обучения по которым подтверждено сертификатом. 

drop procedure if exists `skills_list_for_job_id`;

delimiter //

create procedure `skills_list_for_job_id` (IN var INT)
begin 
	select skill_name from 
		skills_for_jobs where 
		job_id = var and skill_name not in (select skill_name from serts);
end//

delimiter ;

call skills_list_for_job_id(1);

-- --------------------------------------------------------------------------------------
-- триггеры
-- --------------------------------------------------------------------------------------
-- 1. при добавлении нового курса (вебинара) производить проверку: если дата его начала в будущем, то его статус просмотра "is_viewed" может быть равен только "нет"

DROP TRIGGER IF EXISTS check_status_with_date_before_insert;

DELIMITER //

CREATE TRIGGER check_status_with_date_before_insert BEFORE INSERT ON courses
FOR EACH ROW 
	BEGIN
		IF NEW.date_of >= current_date() and NEW.is_viewed != 'нет' THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Date_of or is_viewed is wrong';
		END IF;
	END//

DELIMITER ;

insert into courses (skill_name, name, link, is_viewed, date_of) 
	values ('keras','распознавание рукописных цифр базы MNIST', 'https://youtu.be/oCXh_GFMmOE','да','2021:08:13');
insert into courses (skill_name, name, link, is_viewed, date_of) 
	values ('keras','распознавание рукописных цифр базы MNIST', 'https://youtu.be/oCXh_GFMmOE','нет','2021:08:13');


