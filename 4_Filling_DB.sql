-- -------------------------------------------------------------------------------------------------
insert into skills (name) values ('is not defined');
insert into skills (name) values ('python'),('git'),('mysql'), ('matplotlib'), ('numpy'), ('pandas'), ('seaborn'), ('HTML'), ('CSS'), ('linux');
insert into skills (name) values ('keras');
insert into skills (name) values ('vertica'), ('clickhouse'), ('powerbi'), ('tableau'), ('статистика');
insert into skills (name) values ('etl');
insert ignore into skills (name) values ('etl');
insert ignore into skills (name) values	('mysql'), ('python'), ('redash'), ('powerbi'), ('tableau'), ('a/b-тестирование'), ('postgresql'), ('clickhouse'), ('apache airflow'),  ('amazon web services'), ('linux');
select * from skills;
-- -------------------------------------------------------------------------------------------------
insert into profs (name) values ('is not defined');
insert into profs (name) values ('Аналитик данных');
insert into profs (name) values ('Инженер радиоэлектронных систем');
insert into profs (name) values ('Разработчик в сфере нейронных сетей, машинного обучения и искусственного интеллекта');
select * from profs;
-- -------------------------------------------------------------------------------------------------
insert into skills_for_profs (skill_id, prof_id) values (2,1), (3,1), (4,1), (6,1), (7,1), (9,1), (10,1);
insert into skills_for_profs (skill_id, prof_id) values (2,3), (3,3), (5,3), (6,3), (7,3), (8,3), (11,3);
select * from skills_for_profs;
-- -------------------------------------------------------------------------------------------------
insert into education_inst (name) values ('is not defind'); 
insert into education_inst (name, link) values ('geekbrains', 'gb.ru'); 
insert into education_inst (name, link) values ('МГТУ им. Баумана', 'https://bmstu.ru/'); 
insert into education_inst (name, link) values ('Универсистет искусственного интеллекта', 'https://neural-university.ru/'); 
insert into education_inst (name, link) values ('Stepik', 'https://stepik.org/');
insert into education_inst (name, link) values ('Coursera', 'https://www.coursera.org/');
insert into education_inst (name, link) values ('Лекториум', 'https://www.lektorium.tv/');
select * from education_inst;
-- -------------------------------------------------------------------------------------------------
insert into status (status) values ('да'), ('нет'), ('в процессе'), ('записан, не просмотрен');
select * from status;
-- -------------------------------------------------------------------------------------------------
insert into courses (skill_name, name, link, is_viewed, date_of) 
	values ('python','Программирование на Python', 'https://stepik.org/course/67','да','2021:05:13');
insert into courses (skill_name, name, link) values 
	('python','Основы языка Python', 'https://gb.ru/chapters/6295'),
	('git','Git. Базовый курс', 'https://gb.ru/chapters/7831'),
	('is not defined','Основы программирования', 'https://gb.ru/chapters/5087'),
	('linux','Linux. Администрирование', 'https://youtu.be/CQ4YpkeG3mQ?list=PLrCZzMib1e9rx3HmaLQfLYb9ociIvYOY1');
insert into courses (skill_name, education_inst_name, name, link, is_viewed) 
	values ('pandas', 'Stepik', 'Обработка данных в Python. Pandas', 'https://stepik.org/lesson/409336/step/1?unit=398662', 'нет');
select * from courses;
-- -------------------------------------------------------------------------------------------------
-- truncate table litr;
insert into litr (skill_name, name, author) 
	values ('keras','Keras-документация', 'УИИ'),
    ('python','Изучаем Python', 'Марк Лутц');
insert into litr (skill_name, name, author, link) 
	values ('mysql','MySQL на примерах', 'Максим Кузнецов', 'https://books.google.ru/books?id=FsHInP6ismsC&printsec=frontcover&hl=ru#v=onepage&q&f=false'),
   ('python','Python для сетевых инженеров', 'Наталья Самойленко', 'https://pyneng.readthedocs.io/ru/latest/');
select * from litr;
-- -------------------------------------------------------------------------------------------------
insert into serts (name, skill_name, edu_inst_name) 
	values ('Основы языка python', 'python', 'geekbrains'),
	('Программирование на python', 'python', 'Stepik'),
	('Алгоритмы и структуры данных на Python', 'python', 'geekbrains'),
	('Git. Базовый курс', 'git', 'geekbrains'),
	('HTML/CSS', 'HTML', 'geekbrains'),
	('HTML/CSS', 'CSS', 'geekbrains'),
	('Linux. Рабочая станция', 'linux', 'geekbrains');

select * from serts;
-- -------------------------------------------------------------------------------------------------
-- truncate table diplomas;
insert into diplomas (name, prof_name, edu_inst_name, recieved_in) values ('Диплом с отличием. Инженер по специальности радиоэлектронные системы', 'инженер радиоэлектронных систем', 'МГТУ им. Баумана', '2009:07:01');
select * from diplomas;
-- -------------------------------------------------------------------------------------------------
-- truncate table jobs;
insert into jobs (name, description, link) 
	values ('Аналитик данных', 'Мы находимся в поиске аналитика данных в команду Ozon Marketplace, который поможет нам улучшать качество сервиса для продавцов нашей площадки, внедрять новые функции, менять процессы.

Что вам предстоит:

Погрузиться в детали работы маректплейса и e-commerce, работать с продакт-менеджерами разных направлений;

Выявлять и оценивать трудности, возникающие у продавцов на маркетплейсе;

Анализировать и оценивать эффект от запуска новых функций;

Обрабатывать большие объемы данных, выстраивая сквозную аналитику;

Определять ключевые показатели продукта, раскладывать их на составляющие, предлагать способы улучшения;

Анализировать поведение продавцов на площадке и в личном кабинете;

Выявлять потребности в аналитике и способствовать data-driven подходу в принятии решений.

Что мы ожидаем от вас:

Опыт работы аналитиком от 1 года;

Понимание продуктовых метрик;

Хорошее знание SQL (на уровне сложных запросов) и опыт работы с базами данных;

Желание и умение быстро разбираться в большом объеме данных, запутанных схемах и процессах;

Умение представлять и визуализировать данные так, чтобы они могли говорить сами за себя;

Умение программировать, желательно на python;

Знания математики и основ статистики;

Знание английского языка от уровня pre intermediate и выше.

Будет плюсом:

Опыт использования систем визуализации (PowerBI, Tableau);
Опыт проведения а/б тестов;
Опыт работы с колоночными хранилищами данных (vertica, clickhouse);
Понимание e-commerce бизнеса и устройства маркетплейсов.
Что мы предлагаем:

Динамичный и быстроразвивающийся бизнес, ресурсы, возможность сделать вместе сделать лучший продукт на рынке e-commerce;
Свободу действий в принятии решений;
Достойный уровень заработной платы;
Профессиональную команду, которой мы гордимся;
Возможность развиваться вместе с нашим бизнесом.', 
'https://hh.ru/vacancy/45563991?query=%D0%90%D0%BD%D0%B0%D0%BB%D0%B8%D1%82%D0%B8%D0%BA%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85');

insert into jobs (name, description, link, salary) 
	values ('Аналитик данных', 
'Что делать:
формировать запросы для оперативных метрик
автоматизировать и сопровождать запросы для стратегических метрик
выполнять отчеты по запросу
сопровождать отчеты сформированные по запросу
вести техническую работу по сопровождению отчетов для инвесторов (сопровождение запросов, сопровождение автоматизирующих скриптов)
собирать и предобрабатывать данные из боевых баз
донастраивать дата-пайплайны по факту изменений в боевой базе
готовить скрипты по автоматизации пайплайнов
Про тебя:
понимаешь основные этапы работы с данными (предобработка, EDA)
знаешь основные продуктовые метрики (юнит-экономика, активность пользователей, когортный анализ)
экономический бэкграунд (желательно)
SQL (запросы, вложенные запросы, оконные функции)
Python (pandas, numpy, scripts)
Работа с BI cистемами (желательно)
Знание принципов и систем для работы с ETL (Aitflow желательно)
Мы предлагаем:

фултайм удалёнку, гибкий график, совмещать нельзя;
стабильные официальные выплаты;
месяц отпуска и оплачиваемые больничные;
отсутствие трекинга часов и прочего экстрима.', 
'https://hh.ru/vacancy/45586993?query=%D0%B0%D0%BD%D0%B0%D0%BB%D0%B8%D1%82%D0%B8%D0%BA%20python%20sql', 100000);

insert into jobs (name, description, link, salary) 
values ('Аналитик данных', 
'Задачи:

анализ продукта (подготовка, проведение и анализ A/B тестов; продуктовых воронок; retention; когортный анализ);
маркетинговых активностей (эффективность различных каналов привлечения аудитории, push-уведомлений);
визуализация (графики, дашборды) и коммуникация результатов исследований;
глубокое изучение аудитории, поиск точек роста, различный ad-hoc анализ;
взаимодействие с другими отделами компании - маркетинг, продукт, клиентская и бэкенд-разработка.
Ожидания от кандидата:

Образование экономическое, математическое, техническое или финансовое;
Уверенное знание SQL, Python (numpy, pandas, seaborn/matplotlib, jupyterhub);
Опыт работы с BI-инструментами (Redash, PowerBI/Tableau), проектирования и построения дашбордов;
Знание продуктовой аналитики, основных бизнес/продуктовых метрик;
Опыт проверки статистических гипотез, анализа A/B тестов;
Интерес к анализу данных, желание развиваться в данной области;
Опыт работы с Airflow;
Знание Git;
Будет плюсом знание Clickhouse, Linux
Используемые технологии:

PostgreSQL, Clickhouse, Python, Apache Airflow, Amazon Web Services', 
'https://hh.ru/vacancy/45191212?query=%D0%B0%D0%BD%D0%B0%D0%BB%D0%B8%D1%82%D0%B8%D0%BA%20python%20sql%20tableau', 170000);
-- -------------------------------------------------------------------------------------------------
select * from jobs;

insert into skills_for_jobs (skill_name, job_id) values
	('mysql', 1), ('python', 1), ('powerbi', 1), ('vertica', 1), ('tableau', 1), ('clickhouse', 1), ('статистика', 1);
insert into skills_for_jobs (skill_name, job_id) values
	('mysql', 2), ('python', 2), ('etl', 2);
insert into skills_for_jobs (skill_name, job_id) values
	('mysql', 3), ('python', 3), ('redash', 3), ('powerbi', 3), ('tableau', 3), ('a/b-тестирование', 3), ('postgresql', 3), ('clickhouse', 3), ('apache airflow', 3),  ('amazon web services', 3), ('linux', 3);
    select * from skills_for_jobs;
