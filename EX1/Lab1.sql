# Question 1:- List the Title, UPC and Genre of all CD titles. (Titles table) 
SELECT Title,UPC,Genre FROM titles;

# Question 2:- List the information of CD(s) produced by the artist whose ArtistID is 2. (Titles table)
SELECT 	* FROM Titles WHERE ArtistID = 2;

# Question 3:- List the First Name, Last Name, HomePhome and Email address of all members. (Members table)
SELECT FirstName, LastName, HomePhone, Email FROM Members;

# Question 4:- List the Member ID of all male members. (Members table)
SELECT MemberID FROM Members WHERE Gender = 'Male';

#Question 5:- List the Member ID and Country of all members in Canada. (Members table)
SELECT MemberID, Country FROM Members WHERE Country = "Canada";

