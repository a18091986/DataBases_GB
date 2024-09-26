1. ������� ��������, ������� ������ ���� ������� � ����� �������������, �����, ��� ������� ������������ ���������� ����� ���������. (������ ����� ������������ � ����� id).
id = 6
~~~~~~~~~~~~~~~~~~~~~~~~~

select * from users 
	where id = (select from_user_id from messages where to_user_id = 6 
	GROUP by from_user_id order by count(*) desc limit 1);

~~~~~~~~~~~~~~~~~~~~~~~~~

-- ������������ ������� ������ ������������ 6 �� ����� ��� ������

~~~~~~~~~~~~~~~~~~~~
select from_user_id from messages
	where to_user_id = 6 
	and 
	from_user_id in (select id from users where id in 
	(select from_user_id from friend_requests WHERE request_type = 1 and to_user_id = 6)) 
	group by from_user_id order by count(*) desc limit 1;
~~~~~~~~~~~~~~~~~~~

-- 2. ���������� ����� ���������� ������ �� �����, ������� �������� ������������ ������ 18 ���.

~~~~~~~~~~~~~~~~~~~~~~
select count(*) from likes_to_posts 
	where to_post_id in (select id from posts where user_id in 
	(select user_id from profiles where (TO_DAYS(now()) - to_days(birthday))/365.25 < 18))
~~~~~~~~~~~~~~~~~~~~~

-- 3. ����������, ��� ������ �������� ������ (�����) - ������� ��� �������?

~~~~~~~~~~~~~~~
select CASE 
	when ((select count(*) from likes_to_posts where from_user_id in (select user_id from profiles where gender = 'm')) =
	(SELECT count(*) from likes_to_posts where from_user_id in (select user_id from profiles where gender = 'f'))) THEN '�������'
	when ((select count(*) from likes_to_posts where from_user_id in (select user_id from profiles where gender = 'm')) >
	(SELECT count(*) from likes_to_posts where from_user_id in (select user_id from profiles where gender = 'f'))) THEN '������ ������ � ������'
	when ((select count(*) from likes_to_posts where from_user_id in (select user_id from profiles where gender = 'm')) <
	(SELECT count(*) from likes_to_posts where from_user_id in (select user_id from profiles where gender = 'f'))) THEN '������ ������ � ������'
END as '� ���� ������ ������ � ������ (�/�)?';
~~~~~~~~~~~~~~

-- 4.(�� �������) ����� ������������, ������� ��������� ���������� ���������� � ������������� ���������� ���� (���, ��� ������� ������ ����� ���������, �������� ������ ����� ������ � ������, ...).

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
select * from profiles where user_id = 
(select user_ from
(select one.oneCount + two.twoCount as summa, one.from_user_id as user_ from
((select from_user_id ,count(*) as oneCount from messages group by from_user_id order by from_user_id) as one, 
(select from_user_id ,count(*) as twoCount from friend_requests group by from_user_id order by from_user_id) as two)
where one.from_user_id = two.from_user_id
ORDER by summa
limit 1) as q)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
