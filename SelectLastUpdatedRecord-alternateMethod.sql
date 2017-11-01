/* Another way to select the last updated rows (per PERSON_ID) from tables like SR_APPLICATIONS.
If you remove the outside select, you will get a list of updates ordered per PERSON_ID, which may be useful as well.
*/

use [Student_Records_copy]
go

select
*
from
(
select
row_number() over (partition by ap.PERSON_ID order by ap.DATE_LAST_UPDATE desc) as rn,
*
from
[SR_APPLICATIONS] as ap
) as inside
where inside.rn=1
