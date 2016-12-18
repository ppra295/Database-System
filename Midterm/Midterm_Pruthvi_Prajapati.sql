# 1. List the TitleID, Track Title of all tracks whose Track Number is 3 and are at least 250 seconds long.

select * from titles;
select * from tracks;

select TitleID, Tracktitle , LengthSeconds
from Tracks
where TrackNum = 3 and LengthSeconds >=250;

# 2. List the Title and Genre and UPC of all Titles whose second leftmost digit of UPC is '2'.

Select * from titles;

select Title, Genre, UPC from Titles
where UPC like '_2%';

# 3. List the number of tracks and the average length under title id 4.

select * from Tracks;

select TitleID , Count(TrackTitle) as NumberOfTracks, Avg(LengthSeconds) from Tracks
where TitleID = 4;



# 4. Find the name(s) of the artist(s) that have more than one members connected through XresArtistsMembers to him/her.
select * from artists;
select * from xrefartistsmembers;
select * from members;

select ArtistName from Artists A
inner join Xrefartistsmembers X on A.ArtistID =  X.ArtistID
inner join Members M on X.MemberID = M.MemberID
where X.RespParty = 1;


/*5. List the following information of all members: the first name, 
#the position of the first occurrence of 'e' within the first name, the last name,
the position of the first occurrence of 'ar' within the last name. Use proper column names.*/

select* FROM members;

select FirstName , locate( 'e', FirstName) as Firstname , lastname, locate( 'e', LastName) as lastname , LastName, locate('ma', lastname) AS last_name
from members;

# 6. Find the track title of the longest track, the CD title of it and the artist's name.

select * from titles;
select * from tracks;
select * from artists;

select max(lengthseconds), tracktitle , artistname from (tracks Tr
inner join titles T on Tr.TitleID = T.TitleID) 
inner join artists A on T.ArtistID = A.ArtistID 
having max(lengthseconds);

# 7. List the artist name of all artists with ' ' anywhere in the artist's name.
select * from artists;
select artistName from artists 
having locate( ' ' , ArtistName);

# 8. List the number of tracks and the total length of the tracks with length longer than 3 minutes.
select * from tracks;

select count( TrackTitle) AS NumberOfTracks , sum(lengthSeconds) from tracks 
having sum( LengthSeconds/60 ) > 3;

# 9. For each member, list the member id, area code, and the phone number without the area code.

select * from members;

select MemberID ,
substring(HomePhone, 1, 3) as area_code,
substring(Homephone,5,10) as phone_number
from members
group by MemberID;

/* 10. List the member names in the form `{first initial}{period}{space}{last name}`, e.g. R. Alvarez. 
Order the results first by last name, then by first name.
 Only list those member who have both a first name and a last name in the database.   */
select *  from members;

select concat_ws(' ', substring(FirstName, 1, 1), lastName) as Member_Name
from members
where FirstName like '_%'
order by Lastname, FirstName;


/*11. List the author name as '{FirstName}{space}{LastName}' (e.g. Eric Liao) and
 address of any authors. Rename the attributes name, address as Author Name, Street Address. */
 
select * from authors;

select concat(au_fname , ' ' , au_lname) as Author_Name, address as Street_Address
from authors;

#12. Report author id and the number of titles for each authors

select * from authors;
select * from title_authors;
select * from titles;

select au_id, count(title_name) as NumberOfTitles
from authors A
inner join title_authors TA
using (au_id)
inner join titles T
using (title_id)
group by  A.au_id;

#13. List all the information of titles that do not have a price.

select * from titles
where price is null;

#14. Report the number of Authors who are in CA.

select * from authors;

select state , count(*)as NumberOfAuthors from authors
where state = 'CA';

#15. Report the type, average, smallest and largest price for each type with average price greater than 20. Use proper column alias.

select * from titles;

select type, avg(price) as Average_Price, min(price) as Smallest_Price, max(price) as largest_price from titles
group by type
having avg(price) > 20;

#16. List the title name, type and pages of the longest book (count in pages) without using max(). (Hint: use a subquery and ALL)

select title_name, type, pages
from titles T1
where pages > ALL(
select pages
from titles T2
where T1.pages <> T2.pages ) and pages is not null;

#17. List unique name of publisher from California (CA) and their authors.

select * from publishers;
select * from authors;

select  distinct pub_name, au_fname, au_lname
from publishers P
inner join  authors A
on P.state = A.state
where P.state = 'CA';

#18. Report all the unique types from the titles table. Capitalize the first letter of each and the rest of the letters should be lower case.

select * from titles;

select distinct(concat(upper(LEFT(type,1)),lower(SUBSTRING(type,2)))) as Type
from Titles;

#19. Report the publisher name and the last word of each publisher name. Hint: the last word is the part that follows the space.

select * from publishers;
 
select pub_name, substring_index(pub_name,' ',-1) as Publisher_Name
from publishers;

#20. List the names of books published by the 'Tenterhooks Press'

select * from publishers;
select  * from titles;

select title_name as  Books
from Titles T
inner join publishers P
on T.pub_id = P.pub_id
where pub_name = 'Tenterhooks Press';


 