use [Student_Records_copy];

select 
app.NAME_FIRST + ' ' + app.NAME_LAST as Name,
case when app.PHONE_NUMBER <> '' then '1' + REPLACE(REPLACE(REPLACE(REPLACE( ISNULL( app.PHONE_NUMBER, '' ), '(', '' ), ' ', ''), ')', ''), '-', '') end as CleanPhoneNumber,
case when app.PHONE_NUMBER_2 <> '' then '1' + REPLACE(REPLACE(REPLACE(REPLACE( ISNULL( app.PHONE_NUMBER_2, '' ), '(', '' ), ' ', ''), ')', ''), '-', '') end as CleanPhoneNumber2
from
[SR_APPLICATIONS] as app