/*
BASED ON: rptSIS743_SSSPEvaluationDetails (as of September 28, 2017)

*/

use [Student_Records_copy];

select 
SR_STUDENT_TERMS.PERSON_ID, /* hash this if using in Tableau */
SR_STUDENT_TERMS.TERM_STATUS,
20177 as TERM_ID, /* HERE */
SR_STUDENT_TERMS.ENROLL_STATUS, 
SR_STUDENT_TERMS.EDUC_GOAL, 
case when SR_STUDENT_TERMS.MATRIC_GOAL in (13,99) and SR_STUDENT_TERMS.EDUC_GOAL <> 99 then SR_STUDENT_TERMS.EDUC_GOAL else SR_STUDENT_TERMS.MATRIC_GOAL end as MATRIC_GOAL,
SR_STUDENT_TERMS.PROGRAM_OF_STUDY_ID, 
SR_STUDENT_TERMS.MAJOR_CERT_ID,
SR_MAJORS_CERTIFICATES.MAJOR_CERT_CODE,
B.ORIENT_270, 
case when D.PERSON_ID is not null or b.ORIENT_OL > 0 then 1 end as ORIENT_OL,
case when C.PERSON_ID is not null then 1 end as ORIENT_P,
case when  B.ORIENT_270 is null and B.ORIENT_OL is null and D.PERSON_ID is null and C.PERSON_ID is null then 0 else 1 end as ORIENTATION

from SR_STUDENT_TERMS 
inner join (select PERSON_ID, sum(SEMESTER_UC_DA) as LOCAL_DA_UNITS from SR_STUDENT_TERMS where TERM_ID <= 20177 /* HERE */ group by PERSON_ID ) A on SR_STUDENT_TERMS.PERSON_ID = A.PERSON_ID 
left join SR_MAJORS_CERTIFICATES on SR_MAJORS_CERTIFICATES.MAJOR_CERT_ID = SR_STUDENT_TERMS.MAJOR_CERT_ID 
left join (select SR_ENROLLMENTS.PERSON_ID,
	sum(case when SR_COURSE_VERSIONS.COURSE_KEY = 'COUN270' then 1 else 0 end) as ORIENT_270,
	sum(case when SR_COURSE_VERSIONS.COURSE_KEY = 'COUN901' then 1 else 0 end) as ORIENT_OL
	from SR_ENROLLMENTS inner join
	SR_SECTIONS on SR_ENROLLMENTS .SECTION_ID = SR_SECTIONS.SECTION_ID and SR_ENROLLMENTS.ACTIVE_STATUS > 0 and SR_ENROLLMENTS.ADD_DROP_STATUS in (1,2,5,6) inner join
	SR_COURSE_VERSIONS on SR_SECTIONS.COURSE_VERSION_ID = SR_COURSE_VERSIONS.COURSE_VERSION_ID and SR_COURSE_VERSIONS.COURSE_KEY in('COUN270','COUN901')
	where SR_SECTIONS.TERM_ID <= 20177 /* HERE */ group by SR_ENROLLMENTS.PERSON_ID) B on SR_STUDENT_TERMS.PERSON_ID = B.PERSON_ID 

left join (select distinct SR_MATRIC_ACTIVITY.PERSON_ID
	from SR_MATRIC_ACTIVITY inner join
	SR_MATRIC_COMPLETIONS on SR_MATRIC_ACTIVITY.COMPLETION_ID = SR_MATRIC_COMPLETIONS.COMPLETION_ID
	where SR_MATRIC_ACTIVITY.TERM_APPLICABLE <= 20177 /* HERE */ and SR_MATRIC_COMPLETIONS.MATRIC_COMPONENT = 1
	and SR_MATRIC_COMPLETIONS.COMPLETION_CODE <> 1008) C on SR_STUDENT_TERMS.PERSON_ID = C.PERSON_ID 

left join (Select distinct SR_MATRIC_ACTIVITY.PERSON_ID
	from SR_MATRIC_ACTIVITY inner join
	SR_MATRIC_COMPLETIONS on SR_MATRIC_ACTIVITY.COMPLETION_ID = SR_MATRIC_COMPLETIONS.COMPLETION_ID
	where SR_MATRIC_ACTIVITY.TERM_APPLICABLE <= 20177 /* HERE */ and SR_MATRIC_COMPLETIONS.MATRIC_COMPONENT = 1
	and SR_MATRIC_COMPLETIONS.COMPLETION_CODE = 1008) D on SR_STUDENT_TERMS.PERSON_ID = D.PERSON_ID 

where SR_STUDENT_TERMS.TERM_ID = 20177 /* HERE */
and SR_STUDENT_TERMS.ACTIVE_STATUS = 1
order by SR_STUDENT_TERMS.PERSON_ID
;