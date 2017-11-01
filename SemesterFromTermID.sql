/* Semester from TERM_ID
BASED ON: any table with TERM_ID
*/

use [Student_Records_copy]
go

select
case when (st.TERM_ID%10)=3 then 'Spring'	
when (st.TERM_ID%10)=5 then 'Summer'	
when (st.TERM_ID%10)=7 then 'Fall'	
end as Semester
from [SR_STUDENT_TERMS] as st