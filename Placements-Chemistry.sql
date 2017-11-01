/*
BASED ON: rptSIS743_SSSPEvaluationDetails (as of September 28, 2017)

*/

use [Student_Records_copy];

select 
SR_STUDENT_TERMS.PERSON_ID,
SR_STUDENT_TERMS.TERM_ID,
SR_COURSE_VERSIONS.COURSE_DISCIPLINE_NBR as CHEM_P,
SR_COURSE_VERSIONS.COURSE_DIGITS as CHEM_DIGITS
from  SR_STUDENT_TERMS 
inner join
	(select PERSON_ID, max(SCORE_ID) AS SCORE_ID from SR_STUDENT_SCORES A inner join SR_TESTS B on A.TEST_ID = B.TEST_ID 
	where B.PLACEMENT_TYPE = 3 --in (28, 35, 60) chem
	AND A.TERM_APPLICABLE <= 20167 /* HERE */
	and A.TERM_EXPIRES >= 20167 /* HERE */
	and A.ACTIVE_STATUS > 0
	and A.COURSE_ID <> 0 -- no placement
	group by PERSON_ID) as AA 
on SR_STUDENT_TERMS.PERSON_ID = AA.PERSON_ID and SR_STUDENT_TERMS.TERM_ID = 20167 /* HERE */
inner join
	SR_STUDENT_SCORES 
on AA.SCORE_ID = SR_STUDENT_SCORES.SCORE_ID 
inner join
	(select COURSE_ID, MAX(VERSION_NBR) as VERSION_NBR from SR_COURSE_VERSIONS where APPROVAL_STATUS = 7 group by COURSE_ID) B 
on SR_STUDENT_SCORES.COURSE_ID = B.COURSE_ID 
inner join
	SR_COURSE_VERSIONS 
on B.COURSE_ID = SR_COURSE_VERSIONS.COURSE_ID AND B.VERSION_NBR = SR_COURSE_VERSIONS.VERSION_NBR 
order by AA.PERSON_ID
