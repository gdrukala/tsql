/* Student High School name
BASED ON: SR_STUDENTS (may be also used with SR_APPLICATIONS, etc)
NOTE: there are two functions here LOCAL_HS_CODE_DESC only lists names of local - public HS's in the District - and it has "null" for all other high schools.
ALL_HS_CODE_DESC lists all high schools (including private) or states (or "foreign") for the  out of state high schools
NOTE: this code runs a stored procedure for each student record so it may take a considerable time to execute. Be patient!
*/

use [Student_Records_copy]
go

select
dbo.ufnItemPartValueDesc('HS_CODE', '3', st.HS_CODE) as LOCAL_HS_CODE_DESC,
dbo.ufnItemPartValueDesc('HS_CODE', '0', st.HS_CODE) as ALL_HS_CODE_DESC
from
[SR_STUDENTS] as st