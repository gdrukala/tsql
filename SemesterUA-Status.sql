/* student status with regard to the units taken and credit/non-credit 
* BASED ON: SR_STUDENT_TERMS
*/

use [Student_Records_copy]
go

select
case when st.CR_NC_STATUS=1 then
	case when st.SEMESTER_UA>=12 then 'Only Credit-Full-Time'
	else 'Only Credit Part-Time'
	end
	when st.CR_NC_STATUS=2 then
	case when st.SEMESTER_UA>=12 then 'CR/NC-Full-Time'
	else 'CR/NC Part-Time'
	end
else 'Non-Credit'
end as "Semester UA status"
from [SR_STUDENT_TERMS] as st