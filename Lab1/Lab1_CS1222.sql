# Question 1:- List the first name, last name, and region of all members from Virginia who either have a work phone or an email address.
SELECT FirstName, LastName, Region
FROM Members
WHERE Region='VA' and ( WorkPhone !='null' or Email !='null');

# Question 2:- List the artist name and web address of any artists who has a web address. Rename the attributes artistname, webaddress as Artist Name, Web Address.
SELECT ArtistName AS 'Artist Name', WebAddress AS 'Web Aaddress'
FROM Artists
WHERE WebAddress != 'null';

#Question 3:- List the TitleID, TrackNum, and TrackTitle of all tracks with 'Song' at the beginning of the TrackTitle 
SELECT TitleID, TrackNum, TrackTitle 
FROM Tracks WHERE TrackTitle  LIKE 'SONG%';

#Question 4:- Report the total time in minutes of all tracks with length greater than 150.
SELECT SUM(LengthSeconds/60)  AS 'Total Minutes'
FROM Tracks WHERE LengthSeconds > 150;

#Question 5:- List the number of tracks, total length in seconds and the average length in seconds of  all tracks with titleID 4.
SELECT COUNT(TitleID) AS TitleCount, 
SUM(LengthSeconds) AS TotalSeconds,
AVG(LengthSeconds) AS AverageLength 
FROM Tracks GROUP BY TitleID Having TitleID = 4;

#Question 6:- Report the number of male members who are in US.
SELECT COUNT(Gender) AS 'Male Members' 
FROM Members WHERE Gender = 'M';

#Question 7:- Report the number of members by state and gender. Sort the results by the region
SELECT  Region AS State, Gender , COUNT(FirstName) AS PeopleCount 
FROM Members Group by Region, Gender Order by region;

#Question 8:- For each kind of LeadSource, report the number of artists who came in to the system through that lead source, the earliest EntryDate, and the most recent EntryDate.
SELECT LeadSource, COUNT(ArtistName), 
MIN(EntryDate) AS EarliestJoined, 
MAX(EntryDate) AS RecentlyJoined 
FROM Artists Group By LeadSource;

#Question 9:- Report the titleid, average, shortest and longest track length in minutes of all tracks for each titleid with average length greater than 300. Use proper column alias.
SELECT TitleID, AVG(LengthSeconds/60) AS AverageLength , 
Min(LengthSeconds/60) AS ShortestTrack, 
Max(LengthSeconds/60) AS LongestTrack 
FROM Tracks Group By TitleId Having AVG(LengthSeconds) > 300;

#Qeustion 10:- Report the TitleID and number of tracks for any TitleID with fewer than nine tracks.
SELECT TitleID, COUNT(TrackTitle) AS 'Number of Tracks' 
FROM Tracks Group by TitleId Having Count(Tracktitle) < 9;