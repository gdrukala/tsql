/* Student Addresses by Enrollment Term
BASED ON: ADDRESSES and PERSONS (for the name) and SR_STUDENT_TERMS (for the term active)
NOTE: remove the SR_STUDENT_TERMS to get all the addresses (or use a differnt criterion for student selection)
This code may also be used for employees - if you remove the SR_STUDENT_TERMS.
*/

use [Student_Records_copy];

select
ad.PERSON_ID as PersonId,
a.NAME as Name,
ad.STREET + ad.STREET_2 as Street,
ad.CITY as City,
ad.STATE as State,
left(ad.ZIP_CODE, 5) as ZipCode

from 
(
	select ADDRESSES.ADDRESS_ID
		,PERSONS.NAME_FIRST + ' ' + PERSONS.NAME_MI + ' ' + PERSONS.NAME_LAST as NAME
		,ROWID = row_number() over (partition by ADDRESSES.PERSON_ID
			order by ADDRESSES.ADDRESS_TYPE, ADDRESSES.DATE_LAST_UPDATE desc )
		from ADDRESSES
		inner join SR_STUDENT_TERMS on ADDRESSES.PERSON_ID = SR_STUDENT_TERMS.PERSON_ID 
		inner join PERSONS on ADDRESSES.PERSON_ID = PERSONS.PERSON_ID
		where SR_STUDENT_TERMS.TERM_ID = 20177                            /* Change the enrollemnt term here !!! */
			and ADDRESSES.ACTIVE_STATUS > 0 
) as a 
inner join ADDRESSES as ad on a.ADDRESS_ID = ad.ADDRESS_ID 
where a.ROWID = 1


