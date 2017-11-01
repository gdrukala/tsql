/* concatenate the course keys per person id for courses taken during a Term
NOTE: a tem table should be used here for simplicity (otherwise the code becomes large and hard to understand)
NOTE: ignore any "Cannot drop the table '#TempTable', because it does not exist or you do not have permission" error messages.
If seeing the error message, switch back to "Results" tab.
*/

use [Student_Records_copy]
go

/* drop the temp table in case it was created 
*/
drop table #TempTable
go

/* select into temp table
*/

select
a.PERSON_ID,
b.TERM_ID,
a.UNITS, 
c.COURSE_KEY
into #TempTable
from [SR_ENROLLMENTS] as a
left join [SR_SECTIONS] as b on a.SECTION_ID=b.SECTION_ID
left join [SR_COURSE_VERSIONS] as c on b.COURSE_VERSION_ID=c.COURSE_VERSION_ID
go

/* now, finally, concatenate the results
*/
select PERSON_ID, 
max(TERM_ID) as TERM_ID, 
sum(UNITS) as UNITS, 
Courses = stuff((select N' ' + COURSE_KEY from #TempTable as t2 where t2.PERSON_ID=t1.PERSON_ID order by COURSE_KEY for XML PATH (N'')), 1, 2, N'') 
from #TempTable as t1 
group by PERSON_ID
go