drop database if exists profinterest;

create database profinterest;

use profinterest;

SET FOREIGN_KEY_CHECKS = 0; 
SET FOREIGN_KEY_CHECKS = 1; 

-- таблицы:
-- 1. навыки (skills)
-- 2. профессии (profs)
-- 3. навыки для профессий (skills_for_profs)
-- 4. образовательные учреждения (education_inst)
-- 5. статус ознакомления с источником (книга, вебинар, курсы) (status) // да, нет, в процессе, записан-не просмотрен
-- 6. вебинары, курсы (courses)
-- 7. книги, статьи (litr)
-- 8. сертификаты (sert)
-- 9. дипломы  (diplomas)
-- 10. вакансии (jobs)
-- 11. навыки для вакансии (skills_for_jobs)

drop table if exists skills;
create table skills(
	id serial primary key,
    name varchar(500) not null unique,
    description varchar(500)
);


drop table if exists profs;
create table profs(
	id serial primary key,
    name varchar(700) not null unique,
    description tinytext 
);

drop table if exists skills_for_profs;
create table skills_for_profs(
	skill_id bigint unsigned not null,
    prof_id bigint unsigned not null,
    primary key (skill_id, prof_id),
    index skills_for_profs_skills_idx (skill_id),
    index skills_for_profs_profs_idx (prof_id),
    foreign key (skill_id) references skills(id),
    foreign key (prof_id) references profs(id)
);

drop table if exists education_inst;
create table education_inst(
	id serial primary key,
    name varchar(500) not null unique,
    link TINYTEXT
);

drop table if exists status;
create table status(
	id tinyint unsigned not null auto_increment unique,
    status varchar(30) not null primary key
);

drop table if exists courses;
create table courses(
	skill_name varchar(500) not null default 'is not defined',
    education_inst_name varchar(500) not null default 'is not defind',
    name varchar(50) not null,
    link TINYTEXT not null,
    is_viewed varchar(30) not null default 'записан, не просмотрен',
    date_of TIMESTAMP default 20000101,
    foreign key (skill_name) references skills(name),
    foreign key (education_inst_name) references education_inst(name),
    foreign key (is_viewed) references status(status)
);

drop table if exists litr;
create table litr(
	skill_name varchar(500) not null default 'is not defined',
    name varchar(50) not null,
    author varchar(50) not null,
    year_pub year default 2000, 
    link TINYTEXT,
    is_read varchar(10) not null default 'в процессе',
    foreign key (is_read) references status(status),    
    foreign key (skill_name) references skills(name),
    constraint author_name unique (author, name)
);

drop table if exists serts;
create table serts(
id serial primary key,
name varchar(500) not null,
skill_name varchar(500) not null,
edu_inst_name varchar(500) not null,
description varchar(500),
link TINYTEXT,
recieved_in TIMESTAMP default current_timestamp,
foreign key (skill_name) references skills(name),
foreign key (edu_inst_name) references education_inst(name)
);

drop table if exists diplomas;
create table diplomas(
id serial primary key,
name varchar(500) not null,
prof_name varchar(500) not null,
edu_inst_name varchar(500) not null,
description varchar(500),
link TINYTEXT,
recieved_in TIMESTAMP default current_timestamp,
foreign key (prof_name) references profs(name),
foreign key (edu_inst_name) references education_inst(name)
);

drop table if exists jobs;
create table jobs(
id serial,
name varchar(500) not null,
primary key (link(500)),
description TEXT,
salary int unsigned,
link TEXT
);

drop table if exists skills_for_jobs;
create table skills_for_jobs(
	skill_name varchar(500) not null,
    job_id bigint unsigned not null,
    primary key (skill_name, job_id),
    index skills_for_jobs_skills_idx (skill_name),
    index skills_for_jobs_jobs_idx (job_id),
    foreign key (skill_name) references skills(name),
    foreign key (job_id) references jobs(id)
);   