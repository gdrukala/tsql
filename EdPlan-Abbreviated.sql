
/*
BASED ON: rptSIS743_SSSPEvaluationDetails (as of September 28, 2017)

*/
use [Student_Records_copy];

--Get all latest Ed plans: Abbreviated
select A.PERSON_ID
,SR_ACADEMIC_PLANS.ABBREVIATED_COMPREHENSIVE 
,SR_ACADEMIC_PLANS.ACADEMIC_PLAN_TYPE
,SR_ACADEMIC_PLANS.EDUCATIONAL_GOAL as EDUCATIONAL_GOAL_EP
,SR_ACADEMIC_PLANS.PROGRAM_OF_STUDY_ID as PROGRAM_OF_STUDY_ID_EP
,SR_ACADEMIC_PLANS.CURRENT_PLAN

from (
-- This next select will give me THE LATEST academic plan for the term that actually have courses associated with the term
select distinct SR_ACADEMIC_PLANS.PERSON_ID, max(SR_ACADEMIC_PLANS.ACADEMIC_PLAN_ID) as ACADEMIC_PLAN_ID
from SR_STUDENT_TERMS
Inner Join SR_ACADEMIC_PLANS on SR_STUDENT_TERMS.PERSON_ID = SR_ACADEMIC_PLANS.PERSON_ID
inner join SR_ACADEMIC_PLAN_TERMS on SR_ACADEMIC_PLAN_TERMS.ACADEMIC_PLAN_ID = SR_ACADEMIC_PLANS.ACADEMIC_PLAN_ID
Inner Join SR_ACADEMIC_PLAN_ENTRIES on SR_ACADEMIC_PLAN_TERMS.ACADEMIC_PLAN_TERM_ID = SR_ACADEMIC_PLAN_ENTRIES.ACADEMIC_PLAN_TERM_ID
--Per Li(4/4/17): Once a student receives an ed plan, it should not expire (of course they can modify it). The proposed programming change can give us a more accurate picture of who really don’t have any ed plans at all
where /*SR_ACADEMIC_PLAN_TERMS.TERM_ID = @TermID and*/ SR_ACADEMIC_PLANS.ABBREVIATED_COMPREHENSIVE = 1
and SR_STUDENT_TERMS.TERM_ID = 20177
group by SR_ACADEMIC_PLANS.PERSON_ID ) A inner join
--This gets ed plan data
SR_ACADEMIC_PLANS on A.ACADEMIC_PLAN_ID = SR_ACADEMIC_PLANS.ACADEMIC_PLAN_ID 
order by A.PERSON_ID, A.ACADEMIC_PLAN_ID
;
