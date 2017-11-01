/* Student First Generation designation
BASED ON: SR_APPLICATIONS 
NOTE: the latest application record is selected from the database based on the DATE_LAST_UPDATE
*/

use [Student_Records_copy]
go


select
case when (ap.ED_LEVEL_PARENT_GUARDIAN_1 is null and ap.ED_LEVEL_PARENT_GUARDIAN_2 is null) then 'Unknown'	
	when (ap.ED_LEVEL_PARENT_GUARDIAN_1<=3 and ap.ED_LEVEL_PARENT_GUARDIAN_2 is null) then 'First Generation'
	when (ap.ED_LEVEL_PARENT_GUARDIAN_2<=3 and ap.ED_LEVEL_PARENT_GUARDIAN_1 is null) then 'First Generation'
	when (ap.ED_LEVEL_PARENT_GUARDIAN_1<=3 and ap.ED_LEVEL_PARENT_GUARDIAN_2 <=3) then 'First Generation'
	else 'NOT First Generation' 
	end as "First Gen Status"
from	

[SR_APPLICATIONS] as ap	
where ap.DATE_LAST_UPDATE = (select max(DATE_LAST_UPDATE) as LastUpdated from [SR_APPLICATIONS] where ACTIVE_STATUS=1 and PERSON_ID=ap.PERSON_ID group by PERSON_ID)