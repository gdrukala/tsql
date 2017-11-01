/* Date of the 1st Census by Section (and course information)
BASED ON: SR_SECTIONS and SR_COURSE_VERSIONS
*/

use [Student_Records_copy];

select 
dbo.ufnGetSectionDateByType(se.SECTION_ID, 4)as DATE_CENSUS,
*
from 
[SR_SECTIONS] as se
left join [SR_COURSE_VERSIONS] as cv
on se.COURSE_VERSION_ID = cv.COURSE_VERSION_ID
where se.TERM_ID = 20177                      /* Modify the TERM_ID here */