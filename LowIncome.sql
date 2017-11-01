/*
BASED ON: rptSIS743_SSSPEvaluationDetails (as of September 28, 2017)

*/


use [Student_Records_copy];

--LOW INCOME
-- Let's set BOG WAIVER flag

--SET LOW_INCOME = 1
select *
from [SR_STUDENT_TERMS] as te 
inner join
SR_TERMS as st on st.TERM_ID = 20157 /* HERE */
inner join
SR_BOGW_INFO as bi on te.PERSON_ID = bi.PERSON_ID and bi.WAIVER_TYPE <> 0 and bi.ACTIVE_STATUS > 0
inner join
(select distinct PERSON_ID, TERM_ID from FA_TRANSACTIONS as ft where ft.ACTIVE_STATUS > 0 and ft.ACCOUNT_CODE = '20') B on B.PERSON_ID = bi.PERSON_ID and B.TERM_ID = st.TERM_ID 
where bi.FISCAL_YEAR_ID = st.FISCAL_YEAR_ID AND bi.WAIVER_TYPE IN ('1','2','3','5')
;