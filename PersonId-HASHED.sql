/* Hashed (i.e. hidden) PersonId
BASED ON: any table where there is a PERSON_ID or any other ID (SSID, etc.)
NOTE: this hashed PERSON_ID may be used for comparisons, e.g. hashbytes('MD2', p.PERSON_ID)=hashbytes('MD2', other.PERSON_ID). Hashing is a one-to-one function.

DO NOT USE UNHASHED PERSON_ID in TABLEAU VISUALIZATIONS. ALWAYS USE HASH WHEN PUTTING PERSON_ID's ON ANY OUTSIDE SERVER !
*/
use [Student_records_copy]
go

select
hashbytes('MD2', p.PERSON_ID) as PersonIdHidden
from [PERSONS] as p