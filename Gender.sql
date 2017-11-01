/* Student Gender
* BASED ON: PERSONS (may be used with APPLICATION, and other tables where gender is a numerical field
*/

use [Student_Records_copy]
go

select
case when p.GENDER=1 then 'Male'
when p.GENDER=2 then 'Female'
else 'Other/Unknown'
end as Gender
from [PERSONS] as p