/* Student Ethnicity
BASED ON: SR_STUDENTS (may be also used with APPLICATIONS)
*/

use [Student_Records_copy]
go

select
case when st.HISPANIC_FLAG=1 then 'Latino' else
	case when st.ETHNICITY in (10) then 'White'
	when st.ETHNICITY in (20, 21, 22, 23, 24, 25, 26, 27, 70) then 'Asian'
	when st.ETHNICITY in (30, 80) then 'African American'
	when st.ETHNICITY in (40, 41, 42, 43, 44) then 'Latino'
	when st.ETHNICITY in (50) then 'Native Americam'
	when st.ETHNICITY in (61, 62, 63, 64) then 'Pacific Islander'
	when st.ETHNICITY in (98) then 'Multi-Ethnic'
	else 'Unknown'
	end
end as EthnicityStr
from [SR_STUDENTS] as st