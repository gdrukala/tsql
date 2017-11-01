use [Student_Records_copy];

select
*
from
(
select
ROWID = row_number() over (partition by aaa.PersonId
                     order by aaa.PersonId, aaa.UNITS_PER_LOCATION desc, aaa.SECTIONS_PER_LOCATION desc, aaa.LOCATION_PRIORITY),
aaa.*
from
(

select 
aa.ClassLocation,
aa.PersonId,
case aa.ClassLocation when 0 then 1	--Santa Rosa Campus	SR
when 60	then 2 --Petaluma Campus	PET
when 65	then 2 --Petaluma Tech Academy	INACTIVE
when 6 then 3 --Online	OE
when 40	then 4 --Public Safety Training Center	PSTC
when 30	then 5 --College Farm	FARM
when 55	then 6 --Southwest Center	SWC
else 7 end as LOCATION_PRIORITY, -- OTHER - WHO CARES?
count(*) as SECTIONS_PER_LOCATION,
sum(aa.UNITS) as UNITS_PER_LOCATION

from

--
(
select
A.PERSON_ID as PersonId,
SR_SECTIONS.SECTION_ID as SectionID,
SR_COURSE_VERSIONS.COURSE_KEY as CourseKey,
SR_SECTIONS.ACCT_CLASS_LOCATION as ClassLocation,
SR_ENROLLMENTS.UNITS as Units

from (

	select SR_ENROLLMENTS.ENROLLMENT_ID,
	SR_ENROLLMENTS.PERSON_ID,
	SR_ENROLLMENTS.SECTION_ID,
	SR_ENROLLMENTS.DATE_CREATED,
	dbo.ufnGetSectionDateByType(SR_SECTIONS.SECTION_ID, 4) as DATE_CENSUS,
	ROWID = row_number() over (partition by SR_ENROLLMENTS.PERSON_ID,SR_SECTIONS.SECTION_ID
						 order by SR_ENROLLMENTS.DATE_CREATED desc)
	from SR_ENROLLMENTS 
	inner Join SR_SECTIONS on SR_ENROLLMENTS.SECTION_ID = SR_SECTIONS.SECTION_ID
	inner Join SR_COURSE_VERSIONS on SR_SECTIONS.COURSE_VERSION_ID = SR_COURSE_VERSIONS.COURSE_VERSION_ID  
	where 
		--SR_ENROLLMENTS.DATE_CREATED <= '09/11/2017' and                     /* modify the AS-OF-DATE here (if needed) */
		SR_SECTIONS.TERM_ID = 20177 and                                       /* Modify the TERM_ID here */
		SR_ENROLLMENTS.ADD_DROP_STATUS not in ('5','28') and
		COURSE_DISCIPLINE_NBR <> 'COUN 901'
) as A inner join
SR_ENROLLMENTS on A.ENROLLMENT_ID = SR_ENROLLMENTS.ENROLLMENT_ID 
inner join
SR_SECTIONS on SR_ENROLLMENTS.SECTION_ID = SR_SECTIONS.SECTION_ID 
inner join
SR_COURSE_VERSIONS on SR_SECTIONS.COURSE_VERSION_ID = SR_COURSE_VERSIONS.COURSE_VERSION_ID 
where 
a.ROWID=1
and (SR_ENROLLMENTS.ADD_DROP_STATUS in (1,2,6) or (SR_ENROLLMENTS.ADD_DROP_STATUS not in (1,2,6) and SR_ENROLLMENTS.DATE_TRANSACTION >= DATE_CENSUS))

) as aa
group by aa.PersonId, aa.ClassLocation
) as aaa
)as aaaa
where aaaa.ROWID=1
--and aaaa.ClassLocation=6
;

