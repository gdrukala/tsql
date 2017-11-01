/* Student age at Term 
BASED ON - see below for an example using the ENROLLMENTS table joined with other tables
NOTE: this is the age of the student at the TERM in which they were enrolled. This is NOT the age at the current date. 
The same students will show up with different ages if multiple terms are requested.
*/

use [Student_Records_copy]
go

select
en.PERSON_ID as PersonID,
((s.TERM_ID/10)- YEAR(p.BIRTHDATE)) as AgeAtTerm
from
[SR_ENROLLMENTS] as en
left join [SR_SECTIONS] as s	
on en.SECTION_ID = s.SECTION_ID	
	
left join [SR_COURSE_VERSIONS] as cv	
on s.COURSE_VERSION_ID = cv.COURSE_VERSION_ID	
	
left join [PERSONS] as p	
on en.PERSON_ID = p.PERSON_ID	

where s.TERM_ID in (20157, 20167, 20177)

order by en.PERSON_ID
