-- query 1
select avg(to_timestamp("completedDate", 'YYY-MM-DDThh24:mi:ss') - to_timestamp("startDate", 'YYY-MM-DDThh24:mi:ss')) as "avg_complete_course_duration" from "certificate";
-- query 2
select avg(to_timestamp("completedDate", 'YYY-MM-DDThh24:mi:ss') - to_timestamp("startDate", 'YYY-MM-DDThh24:mi:ss')) as "avg_complete_course_duration", course from "certificate" group by course;

--query 3
select avg(to_timestamp("completedDate", 'YYY-MM-DDThh24:mi:ss') - to_timestamp("startDate", 'YYY-MM-DDThh24:mi:ss')) as "avg_complete_course_duration", course, "user" from "certificate" group by course, "user";

--query 4
select case when asc_rank=1 then 'fastest'
else 'slowest' end as user_speed, complete_course_duration, course, id, email, "firstName", "lastName" from
(select rank() over(partition by course order by to_timestamp("completedDate", 'YYY-MM-DDThh24:mi:ss') - to_timestamp("startDate", 'YYY-MM-DDThh24:mi:ss')) as asc_rank, rank() over(partition by course order by to_timestamp("completedDate", 'YYY-MM-DDThh24:mi:ss') - to_timestamp("startDate", 'YYY-MM-DDThh24:mi:ss') desc) as desc_rank, to_timestamp("completedDate", 'YYY-MM-DDThh24:mi:ss') - to_timestamp("startDate", 'YYY-MM-DDThh24:mi:ss') as complete_course_duration, course, "id", "email", "firstName", "lastName"
from "certificate" left join "user" on "certificate"."user"="user".id) as sub_query
where asc_rank=1 or desc_rank=1;


-- query 5
select "user", count(*) as "amount_of_certificates" from certificate group by "user";
