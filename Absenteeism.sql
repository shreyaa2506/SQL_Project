select * from absenteeism_at_work;
select * from compensation;
select * from reason;

-- create join
select * from absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join reasons r
on a.Reason_for_absence = r.Number;
;

-- find the healthiest employees for the bonus
select * from absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 and
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from absenteeism_at_work)
;

-- compensation rate increase for non-smokers (Budget = $9,83,221 so 0.68 increase per hour / $1414.4 per year)
select count(*) as nonsmokers from absenteeism_at_work
where social_smoker = 0;

-- optimize this query
select a.ID, 
r.Reason,
Month_of_absence, Body_mass_index,
CASE WHEN Body_mass_index < 18.5 then 'Underweight'
WHEN Body_mass_index between 18.5 and 25 then 'Healthy weight'
WHEN Body_mass_index between 25 and 30 then 'Over weight'
WHEN Body_mass_index > 18.5 then 'Obese'
else 'Unknown' end as BMI_Category,

CASE WHEN Month_of_absence IN (12,1,2) Then 'Winter'
	 WHEN Month_of_absence IN (3,4,5) Then 'Spring'
	 WHEN Month_of_absence IN (6,7,8) Then 'Summer'
	 WHEN Month_of_absence IN (9,10,11) Then 'Fall'
	 ELSE 'Unkown' END as Season_Names

from absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join reasons r
on a.Reason_for_absence = r.Number;


