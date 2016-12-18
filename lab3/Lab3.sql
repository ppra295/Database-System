# 1 . Report the number of artists who entered in the same year  and the total number.

Select * from artists;

SELECT year(EntryDate) AS 'Year', COUNT(ArtistName) AS 'Count in Same Year' 
FROM Artists GROUP BY year(EntryDate) 
UNION SELECT 'Total', COUNT(EntryDate)
FROM Artists;



/* 2. For  title id 1, report  the title ID, track title, lengthseconds, the average lengthseconds for all tracks of title id 1 , 
and the difference value between the lengthseconds and the average value. */

SELECT TitleID,TrackTitle,LengthSeconds,(
SELECT AVG(LengthSeconds) 
FROM Tracks) AS Average, 
LengthSeconds - (
SELECT AVG(LengthSeconds) 
FROM Tracks) AS Difference 
FROM Tracks WHERE TitleID = 1;


# 3. Report the title name, number of tracks, and total time in minutes for each title.

select * from titles;
select * from tracks;

SELECT Tracktitle, COUNT(Tracknum) AS 'Number of Tracks', 
SUM(LengthSeconds)/60 AS 'Total Time' 
FROM tracks GROUP BY TrackTitle;

/* 4. For each artist list the artist name and the first and last name (together in one column) of every member associated
 with that artist followed on the next line by a count of the number of members associated with that artist. 
 Include all artists whether they have members or not.*/
 
SELECT ArtistName, CONCAT_WS(' ',FirstName,LastName) AS 'Name' FROM Members M
INNER  JOIN Xrefartistsmembers X
ON M.MemberID = X.MemberID
INNER JOIN Artists A
ON X.ArtistID = A.ArtistID
UNION
(
SELECT  ArtistName, COUNT(FirstName) FROM members M
INNER  JOIN Xrefartistsmembers X
ON M.MemberID = X.MemberID
INNER JOIN Artists A
ON X.ArtistID = A.ArtistID
GROUP BY  ArtistName );


# 5. List the artist id and the artist name of all artist who have members not in USA

SELECT  ArtistName, CONCAT_WS(' ', FirstName, LAStName) AS 'Name' FROM Members M
INNER JOIN Xrefartistsmembers X
ON M.MemberID = X.MemberID
INNER JOIN Artists A
ON X.ArtistID = A.ArtistID
WHERE M.Country != 'USA';


                               -------- DATA MANIPULATION-------




# 1. Add a new artist with the following information. Use a proper function to automatically get today's date.

INSERT INTO  Artists ,
VALUES (12,'November','New Orleans','LA','USA', 'www.november.com', curdate(), 'Directmail');

select * from artists;

#2. Populate Members2 the content of the Members table.

CREATE TABLE Members2 LIKE Members;
INSERT INTO Members2
SELECT * FROM members;

 /* 3. Lyric Music has decided to set up a web page for every artist who doesn't have a web site. 
The web address will be www.lyricmusic.com/ followed by the artistID. 
Fill this in for every artist record that doesn't already have a web site. */

SET SQL_SAFE_UPDATES = 0;
UPDATE Artists 
SET WebAddress = CONCAT('www.lyricmusic.com/', ArtistID)
WHERE WebAddress = 'www.lyricmusic.com/';

# 4. Delete all members who work for the artist 'Sonata' from Members2 table.

SET SQL_SAFE_UPDATES = 0;
DELETE FROM Members2 
WHERE MemberID=ANY(
SELECT MemberID 
FROM xrefartistsmembers 
WHERE ArtistID = ALL(
SELECT ArtistID 
FROM artists 
WHERE ArtistName='Sonata'));


/* 5.The area code for Columbus, Ohio has been changed from 277 to 899. 
Update the homephone and workphone numbers of all members in Members2 table accordingly. */

UPDATE Members2 SET HomePhONe = REPLACE(HomePhONe,'277','899'), 
WorkPhONe =  REPLACE(WorkPhONe,'277','899') 
WHERE City = 'columbus' OR Region = 'OH';