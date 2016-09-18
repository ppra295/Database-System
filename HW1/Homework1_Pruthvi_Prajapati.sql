# 1. View the table Publishers and design the queries:
	
# i:-List all the information in the table.
    
SELECT * FROM Publishers; 
    
# ii:-List the name of all the publishers in the table.
  
SELECT Pub_name FROM Publishers;
  
# iii:-List the all the information of publishers that are in California. 

SELECT * FROM Publishers
WHERE State = 'CA';

# 2. View the table Titles and design the queries

# i:-List all the titles whose type is history.

SELECT * FROM Titles
WHERE Type = 'history';

# ii:-List the title name, sales and publication date of all the titles whose pub_id is 'P01'.

SELECT Title_name, Sales, Pubdate From Titles
WHERE Pub_id = 'P01';

# 3. General

# i:-List the title id and title name of all books whose type are psychology and are at least 300 pages long.

SELECT Title_id, Title_name FROM Titles
WHERE type = 'psychology' AND Pages >=300;

# ii:-List the title name of all books with 'my' anywhere in the title name.

SELECT Title_name FROM Titles
WHERE Title_name LIKE '%my%';

# iii:-List the name of all history books that are published in 1999.

SELECT Title_name FROM Titles
WHERE type ='History' AND  (pubdate like '%1999%'); 


# iv:-List the first name, last name and zip code of all authors whose second leftmost digit of zip code is '4'.
     #The format of output is: First Name Last Name Zip Code
     
SELECT au_fname AS First_Name, au_lname AS Last_Name, Zip AS Zip_Code FROM authors
WHERE zip LIKE '_4%';


# v:-List the city and the state of all authors without duplicates.

SELECT DISTINCT city , State FROM Authors;

# 4. Aggregation & Joins
select * FROM Titles;

# i:-List the number of books, the minimum price, maximum price and the average sales of history books.
      # The format of output is: Number Min Price Max Price Average Sale
SELECT Count(type) AS Number, Min(price) AS Min_price, Max(price) AS Max_price , Avg(sales) AS Average_sale
FROM titles WHERE type= 'history';

# ii:-List the number of books and the average number of pages published by pub_id 01.

SELECT Count(Type) AS Count_Type , Avg(Pages) AS Average_Pages FROM Titles
WHERE Pub_id LIKE '%01%';

# iii:-List the number of books and the total sales of the books with price greater than $15.

SELECT Count(Type) AS Number, Sum(Sales) AS Total_Sales FROM Titles
WHERE Price > '15';

/* iv:-For each book type, list the the number of books and the average price. 
     Sort the results by the number of books.*/

SELECT Type, Count(*) AS Number_Books, Avg(price) AS Average_Price  FROM Titles
GROUP BY  type ORDER BY Number_Books;

/* v:-For each book type, list the book type and the average number of pages in the books with price greater than $10 in each category, 
 excluding the types where the average number of pages is less than 200. Sort the results by the average number of pages. */
 
 SELECT DISTINCT type, Avg(pages) AS Avarage_Pages FROM Titles
 WHERE Price >'10%'
 GROUP BY type HAVING Avg(pages) > 200 ORDER BY Avg(pages);
 