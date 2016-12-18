# 1. Create table TitleSales containing TitleID, Sales (float type), SalesID
CREATE TABLE TitleSales(
TitleID INT,
Sales FLOAT,
SalesId SMALLINT NOT NULL );

# 2. Change TitleSales table from question 1 to have foreign key of SalesID to SalesPeople table and 
#foreign key of TitleID Titles table
ALTER TABLE titles
ADD CONSTRAINT pk_titles 
PRIMARY KEY (TitleID);
ALTER TABLE salespeople
ADD CONSTRAINT pk_salespeople
 PRIMARY KEY (SalesID);
ALTER TABLE TitleSales
ADD CONSTRAINT fk_salespeople 
FOREIGN KEY (SalesID)
REFERENCES salespeople (SalesID),
ADD CONSTRAINT fk_titles 
FOREIGN KEY (TitleID)
REFERENCES titles (TitleID);

# 3. Add index to TitleID and SalesID to TitleSales table
CREATE INDEX ix_titlesales 
ON titlesales(TitleID, SalesId);

# 4. Add a random sale values to TitleSales table of TitleID 1 and SalesID 2 and TitleID 3 and SalesID 3
INSERT INTO titlesales (TitleID,Sales,SalesID) 
VALUES (1,rand(),2),(3,rand(),3);

# 5. TitleID 1 is now being requested to be take down. You have to remove this TitleID 1 from Titles table
DELETE  FROM titlesales 
WHERE TitleID =1;
DELETE FROM titles 
WHERE TitleID =1;

# 6. Create WebTitleSales table containing TitleID, Sales, WebAddress (with TitleID being foreign key to Titles table)
CREATE TABLE WebTitleSales(
TitleID INT NOT NULL,
Sales FLOAT NOT NULL,
WebAddress VARCHAR(255) NULL,
CONSTRAINT fk_titles_webtitlesales
FOREIGN KEY(TitleId)
REFERENCES titles(TitleId));

# 7. For every title in Titles, add them to WebTitleSales table with same TitleID, random sales, and
# WebAddress being www.{title (replace spaces with "_" (underline))}.lyrics.com

INSERT INTO WebTitleSales (TitleID,WebAddress,Sales) 
SELECT TitleID,
CONCAT('www.',REPLACE(title,' ','_'),'lyrics.com'),RAND() 
FROM titles;

# 8. Add unique constraint to WebAddress in WebTitleSales table
ALTER TABLE webtitlesales
ADD CONSTRAINT un_webAddress 
UNIQUE (WebAddress);

# 9. TitleID 3 is now also being requested to take down. You have to remove TitleID 3 from Titles table.
DELETE FROM titlesales 
WHERE TitleID =3 ;
DELETE FROM webtitlesales 
WHERE TitleID =3 ;
DELETE FROM titles 
WHERE TitleID = 3 ;

# 10. Create a view called TitleTotalSales containing TitleID, Sales, SalesType 
#(being either personal or web), Identifier (either SalesID or WebAddress).
CREATE VIEW TitleTotalSales 
AS SELECT TitleId,Sales,"Web",WebAddress 
FROM webtitlesales
UNION
SELECT TitleId,Sales,"Person",SalesId 
FROM TitleSales;