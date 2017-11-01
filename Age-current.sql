/* Student (or employee) age in years at the current day
BASED ON: PERSONS (may be also used with APPLICATIONS)
NOTE: This is NOT "age at term". For "age at term" see Age-atTerm.sql
*/

use [Student_Records_copy]
go

select
CONVERT(int,ROUND(DATEDIFF(hour, p.BIRTHDATE ,GETDATE())/8766.0,0)) AS AgeYearsIntRound
from [PERSONS] as p