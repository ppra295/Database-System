# 1. Report the names of all artists that came from e-mail that have not recorded a title.
# Use JOIN to answer this question.

SELECT ArtistName FROM Artists 
LEFT JOIN titles ON Artists.ArtistID=Titles.ArtistID 
WHERE LeadSource = 'email' AND Title IS NULL;



SELECT * From members;
# 2. Each member is given his or her salesperson as a primary contact name and also the name of that salesperson's supervisor as a secondary contact name. Produce a list of member names and the primary and secondary contacts for each.

SELECT M.FirstName AS 'Member_FirstName' ,M.LastName AS 'Member_LastName', 
S.SalesID, S.FirstName AS 'Primary FirstName',s.LastName AS 'Primary LastName' ,
sup.FirstName, sup.LastName AS 'Secondary LastName'
FROM Salespeople S
JOIN Members M
ON S.SalesID = M.SalesID
JOIN Salespeople Sup
ON S.Supervisor = Sup.SalesID;


# 3. List the names of members in the 'Highlander'.

SELECT Members.LastName, Members.FirstName
FROM Members
INNER JOIN XRefArtistsMembers
ON Members.MemberID = XRefArtistsMembers.MemberID
INNER JOIN Artists
ON Artists.ArtistID = XRefArtistsMembers.ArtistID
WHERE ArtistName = 'Highlander';


/* 4. List each title from the Title table along with the name of the studio where it was recorded, 
the name of the artist, and the number of tracks on the title. */

SELECT title,StudioName,ArtistName,COUNT(TrackNum) 
FROM (Titles INNER JOIN Studios ON Titles.StudioID=Studios.StudioID)
INNER JOIN Artists ON (titles.ArtistID=Artists.ArtistID) 
INNER JOIN tracks ON (titles.TitleID=tracks.TitleID) GROUP BY Title;

# 5. List all genres from the Genre table that are not represented in the Titles table 

SELECT Genre.Genre FROM titles 
RIGHT JOIN Genre ON titles.genre = genre.genre 
WHERE titles.genre IS NULL;

/*6. List every genre from the Genre table and the names of any titles in that genre if any. 
For any genres without titles, display 'No Titles' in  the Title column. */


SELECT genre.Genre ,ifnull(titles.title, 'No title') AS title 
FROM genre LEFT JOIN titles ON genre.Genre = titles.genre;

# 7. Report the studio name and the last name of each studio contact. 
#Hint: the last name is the part that follows the space.

SELECT StudioName, SUBSTRING(Contact, Locate(' ', Contact) + 1) AS 'Last Name' 
FROM Studios;


# 8. Report the longest track title.

SELECT TrackTitle 
FROM Tracks
WHERE length(TrackTitle) = (SELECT MAX(length(TrackTitle)) FROM Tracks);

# 9. Redo Q6 using CASE.

SELECT Genre.Genre,Title,
CASE Titles.Title
WHEN isnull(Title) THEN'No title'
END AS Titles
FROM Genre LEFT JOIN Titles ON Genre.Genre = Titles.Genre;


# 10.Report the artist name and the age in years of the responsible member for each artist at the time of that artist's entry date.        
SELECT ArtistName , (TO_DAYS(CURDATE())- TO_DAYS(Birthday))/365 AS Age
FROM Artists A, XRefArtistsMembers X, Members M 
WHERE A.ArtistId= X.ArtistId and X.MemberID = M.MemberID AND X.RespParty= 1;