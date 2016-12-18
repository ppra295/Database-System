/* 1. List the title_name and book type of the books that are published earlier 
than all biography books. */

SELECT title_name , type
FROM titles
WHERE pubdate < '1999-10-01'; 

# 2.  List the title_name and book type of the books published by 'Abatis Publishers'

SELECT title_name , type, pub_name
FROM titles
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id AND
pub_name= 'Abatis Publishers' ;


# 3. Find the name(s) of the publisher(s) that have not published any book

SELECT pub_name
FROM titles, publishers
WHERE publishers.pub_id NOT IN (SELECT pub_id FROM titles);


# 4. Find the name(s) of the publisher(s) who have published the computer book.

SELECT pub_name, type 
FROM titles
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id AND
type = 'computer'; 

# 5. Find the name(s) of the author(s) that have authored more than one books.

SELECT concat_ws(' ' , au_lname, au_fname) AS 'Author Name' , authors.au_id
FROM Authors 
INNER JOIN  Title_authors
WHERE authors.au_id = title_authors.au_id
GROUP BY title_authors.au_id
HAVING COUNT(title_authors.au_id) > 1;


# 6. Find the name(s) of the publisher(s) who published the least expensive book.
select * from publishers;
select * from titles;

SELECT pub_name, price
FROM publishers 
INNER JOIN titles
ON titles.pub_id = publishers.pub_id
WHERE price = (SELECT 
MIN(price) 
FROM titles); 



# 7. Find the name(s) of the author(s) who wrote the book with the greatest number of pages.


SELECT pub_name, pages
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
WHERE pages = (SELECT
MAX(pages)
FROM titles);

# 8. Report the names of all authors and the title_name of the books (if any) they have authored.

SELECT concat(au_lname, au_fname) AS Author_Name, title_name
FROM authors
INNER JOIN title_authors
ON authors.au_id = title_authors.au_id
INNER JOIN titles
ON title_authors.title_id = titles.title_id
ORDER BY author_name;

# 9. Find the name of the publishers who have not published any book. (use out join)

SELECT pub_name 
FROM publishers
LEFT JOIN titles
ON publishers.pub_id = titles.pub_id
WHERE title_name IS NULL;


# 10. For each book title, list the tite_name, the publisher's name and the author's name


SELECT type, title_name , pub_name, concat(au_fname ,'  ', au_lname) AS Author_name
FROM titles, publishers, authors , title_authors
WHERE publishers.pub_id = titles.pub_id 
AND title_authors.au_id = authors.au_id 
AND titles.title_id= title_authors.title_id;



# 11. Find the name of publisher that published the book with the greatest royalty rate
 
 SELECT pub_name
 FROM publishers
 INNER JOIN titles ON publishers.pub_id =  titles.pub_id
 INNER JOIN royalties  ON titles.title_id =  royalties.title_id
 WHERE royalty_rate = (SELECT
 MAX(royalty_rate)
 FROM royalties);
 

# 12. Find the title name of the most expensive computer book, the name of its author and the publisher's name.

SELECT title_name, pub_name, concat( au_lname ,'  ', au_fname) As Author_name ,type
FROM publishers
INNER JOIN titles ON titles.pub_id = publishers.pub_id
INNER JOIN title_authors ON titles.title_id = title_authors.title_id
INNER JOIN authors ON  authors.au_id = title_authors.au_id
WHERE price = (SELECT
MAX(price) 
FROM titles);



# 13. List the books published in the last 4 years. Note that your query should remain 
# correct in the future, which means the number 2012 should not appear anywhere in the query.  

SELECT title_name
FROM titles
WHERE pubdate >= concat_ws(' ', YEAR(curdate()) - 4,
MONTH(curdate()), DAYOFMONTH(curdate()));

/* 14. List the author names in the form , period, space, , e.g. K. Hull. 
Order the results first by last name, then by first name. 
Only list those authors who have both a first name and a last name in the database.   */

SELECT concat_ws(' ', substring(au_lname, 1, 1), au_fname) AS Author_name
FROM authors
where au_fname like '_%'
ORDER BY au_lname, au_fname;


/* 15. List the following information of all authors: 
the first name, the position of the first occurrence of 'e' within the first name, 
the last name, the position of the first occurrence of 'ma' within the last name. Use proper column names.*/

SELECT au_fname, locate('e', au_fname) AS First_name, au_lname, locate('ma', au_lname) AS Last_name
FROM authors;
 
# 16. List the name(s) of the publisher(s) that published the book with the shortest title name.

SELECT pub_name, title_name
FROM titles
INNER JOIN publishers ON publishers.pub_id = titles.pub_id
WHERE length(title_name) = (SELECT
MIN(length(title_name))
FROM titles);



select * from titles;
select * from authors;
select* from title_authors;

# 17. For each author, list the author id, area code, and the phone number without the area code.
 
 SELECT au_lname, au_fname, au_id, 
 substring(phone, 1, 3) AS area_code,
 substring(phone,5,10) AS phone_number
 FROM authors;
 
 
