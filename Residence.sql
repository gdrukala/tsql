/* Student Residence 
BASED ON SR_STUDENTS (also APPLICATIONS)
*/

use [Student_Records_copy]
go

select
case when st.RESIDENCE_CODE/10000 = 8 then 'Foreign'
when st.RESIDENCE_CODE/10000 = 9 then 'Unknown'
when st.RESIDENCE_CODE/10000 = 6 then 'Out of State'
when st.RESIDENCE_CODE/10000 = 5 then 'In State'
else 'Unknown' end as Residence
from 
[SR_STUDENTS] as st