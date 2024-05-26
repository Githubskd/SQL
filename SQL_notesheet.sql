--SQL(STRUCTURED QUERY LANGUAGE)- It is a database management system.

--Database-  It is a collection of data stored in a format that can easily be accessed.

--Database are of two types

--1) Relational Database management system.
--Where it can save under tables
--RDBMS uses SQL, which helps in adding data, read data, update data.
--Popular RDBMS are Oracle, My SQL, My SQL server, Postgre SQL.

--2) No SQL 
--It is not a table based database.
--No SQL database are document based.
--Popular No SQL are Mongo DB, Redis, Cassandra etc.

-- Advantages of My SQL:-
-- Across Platform-> In any OS such as windows, macos, linux.
--Used with multiple Language(PHP,Python).
-- It is an opensource.
-- My SQL Database server is fast, reliable, SCALABLE and easy to use. # SCALABLE means it can use in small as well as big website such as FB.
--My SQl server works in client/sever or embedded system.

-- Datatype:-
--1)string, 2)numeric, 3) Date&time

--1)String datatypes--> String is a sequence of characters.
--CHAR(SIZE)-> 0-255, CHAR means Character
--VARCHAR(SIZE)-> 0-65535, VAR means Variable
--BINARY
--VARBINARY
--TINY TEXT 
--etc.

--CHAR V/S VARCHAR
--Programmer can use CHAR when the sizes of the column data entries are consistent where VARCHAR used where data entries change considerably.
--CHAR has a fixed size, but VARCHAR has a variable size.

--2) Numeric datatypes
--BIT-> 0-64
--INT
--TINY INT-> 0-255 --> It is used when you need to store very small non- negative integer values with a limited range.
-- FLOAT-> Here we can save it in decimal form.


--3)Date & time
-- DATE-> YYYY-MM-DD
--DATETIME--> YYYY-MM-DD  hh:mm:ss
--YEAR-> four digit format

--List of constraints in SQL

--CONSTRAINTS-> It means restriction on column of data tables.

--1)NOT NULL -> It means NO VALUE, if there will be blank in column it doesnt mean its a null value may be there will be ("  ")blank space.
--2)UNIQUE-> It means in a column there will be uniqueness in the values given , same input will not repeat twice.
--3)DEFAULT-> It means output we got is by default set in either/or scenario.
--4)CHECK -> It means user will give query to database to check and gives result accordingly.
--5)PRIMARY KEY -> It is a combination of both NOT NULL & UNIQUE. 
--If we want to join one table with another table , overthere we have to give such column which have uniqueness as primary key.
-- In a table only one primary key exist.
--6)FOREIGN KEY -> It comes to play when we need to join two or more tables simultaneously, but condition is data inserted in column having foreign key, MUST have there values in column having primary key.
-- It is an attribute or set of attribute that references to primary kry of dame table or another table(relation).
-- In a table there will be multiple foreign key.
--7)INDEX-> It requires to fetch data fast, eg. Physics book.

-- VARIOUS OPERATORS USED IN SQL->  =,>,<, >=,<=,<>OR!, BETWEEN, LIKE, IN

--# IN -->-The IN operator allows you to specify multiple values in a WHERE clause.
-----------The IN operator is a shorthand for multiple OR conditions.
--# LIKE -->-IT is used in a WHERE clause to search for a specified pattern in a column.
------------There are two wildcards often used in conjunction with the LIKE operator: 
----------The percent sign % represents zero, one, or multiple characters. The underscore sign _ represents one, single character.
--# BETWEEN -->- The SQL Between operator is used to test whether an expression is within a range of values.
----------This operator is inclusive, so it includes the start and end values of the range. 
----------The values can be of textual, numeric type, or dates. 
----------This operator can be used with SELECT, INSERT, UPDATE, and DELETE command.

---What is the difference between UNION and UNION ALL?
---The result set of UNION does not contain duplicate rows, while the result set of UNION ALL returns all the rows from both tables. 
---The execution time of UNION ALL is less than the execution time of UNION as it does not removes the duplicate rows.




SELECT * FROM INFORMATION_SCHEMA.TABLES;--- QUERY TO SHOW TABLES

SELECT * FROM INFORMATION_SCHEMA.COLUMNS;--- QUERYTO SHOW COLUMNS

UPDATE MENU SET DISH_TYP = 'STARTER' WHERE MID = 3;-- THIS IS THE WAY TO UPDATE COLUMN, BUT WE NEED TO UPADTE COLUMN AT ONCE, BUT HOW??



CREATE TABLE X (
ID INT ,
NAME VARCHAR(10)
 PRIMARY KEY (ID));

 CREATE TABLE Y( ID INT PRIMARY KEY, NAME VARCHAR (20));

 INSERT INTO X  (ID, NAME) VALUES (1,'A'),(2,'B'),(3,'C')
 ALTER TABLE X  MODIFY NAME VARCHAR (20);---???
 SELECT * FROM X;

 INSERT INTO X (ID, NAME) VALUES (NULL, 'D')-- PRIMARY KEY DOESNT ACCEPT NULL IN INT COLUMN
 INSERT INTO X (ID, NAME) VALUES ( ' ','Z')-- SPACE CONSIDER AS 0 IN INT COLUMN
 INSERT INTO X (ID, NAME) VALUES (9, '')-- BLANK SPACE SHOWS AS WE GIVE NO SPACE, SINGLE SPACE, DOUBLE SPACE
 INSERT INTO X (ID, NAME) VALUES (12, NULL)-- NULL INSERT INTO VARCHAR.


------------------------------------------------------------------------------------------------------------------------------------------------------------
USE BikeStores

SELECT * FROM production.brands -- BRAND_ID, BRAND_NAME ......................................................................
SELECT * FROM production.categories -- CATEGRY_ID, CATEGORY_NAME...............................................................
SELECT * FROM production.stocks --- STORE_ID, PRODUCT_ID,QUANTITY..............................................................
SELECT * FROM production.products -- PRODUCT_ID, PRODUCT_NAME, BRAND_ID, CATGORY_ID, MODEL_YEAR, LIST_PRICE....................
SELECT * FROM sales.customers-- CUSTOMER_ID, FIRST_NAME, LAST_NAME, PHONE, EMAIL, STREET, CITY, STATE, ZIP_CODE................
SELECT * FROM sales.order_items -- ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY, LIST_PRICE, DISCOUNT..................................
SELECT * FROM sales.orders--ORDER_ID,CUSTOMER_ID, ORDER_STATUS, ORDER_DATE, REQUIRED_DATE, SHIPPED_DATE, STORE_ID, STAFF_ID.....
SELECT * FROM sales.staffs-- STAFF_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE, ACTIVE, STORE_ID,MANAGER_ID........................
SELECT * FROM sales.stores--STORE_ID, STORE_NAME, PHONE, EMAIL, STREET,CITY, STATE, ZIP_CODE ..................................

USE BikeStores

SELECT MAX(ORDER_DATE) FROM SALES.ORDERS

SELECT SOI.PRODUCT_ID, SO.ORDER_ID, SO.ORDER_DATE, SOI.LIST_PRICE
FROM SALES.ORDERS SO
LEFT JOIN SALES.ORDER_ITEMS SOI ON SO.ORDER_ID = SOI.ORDER_ID
WHERE ORDER_DATE BETWEEN
(SELECT DATEADD(M,-2,MAX(ORDER_DATE)) FROM SALES.ORDERS )
AND
(SELECT DATEADD(M,-1,MAX(ORDER_DATE)) FROM SALES.ORDERS )

ORDER BY LIST_PRICE ASC


SELECT TOP(1) PRODUCT_ID, LIST_PRICE 
FROM

(SELECT TOP(2) PRODUCT_ID, LIST_PRICE
FROM sales.order_items
GROUP BY PRODUCT_ID, LIST_PRICE
ORDER BY LIST_PRICE DESC)A
ORDER BY LIST_PRICE ASC


SELECT  SUM(LIST_PRICE) FROM sales.order_items
GROUP BY ORDER_ID


USE BIKES



SELECT *
FROM (SELECT TOP(3)  SUM(list_price) TOTAL FROM sales.order_items GROUP BY order_id)A
WHERE
(SELECT TOP(3)SUM(TOTAL) TOTAL_1 FROM (SELECT  SUM(list_price) TOTAL FROM sales.order_items GROUP BY order_id)A)  >
(SELECT  SUM(list_price) TOTAL FROM sales.order_items
GROUP BY order_id)

SELECT TOP(1)TOTAL FROM
(SELECT TOP(3) SUM(list_price) TOTAL FROM sales.order_items GROUP BY order_id ORDER BY  TOTAL DESC)A
ORDER BY  TOTAL ASC


SELECT TOP(3) SUM(list_price) TOTAL FROM sales.order_items GROUP BY order_id ORDER BY  TOTAL DESC



SELECT  PC.category_name, A.* FROM
(
SELECT category_id, BRAND_ID, COUNT(brand_id) COUNT
FROM production.products
WHERE model_year = 2016
GROUP BY category_id, BRAND_ID
)A

JOIN production.categories PC ON A.category_id = PC.category_id
ORDER BY category_name
use BIKES

select * from production.products pp  outer join sales.staffs ss 

select sum(list_price) from

(SELECT product_id, list_price FROM sales.order_items
where list_price>=1500)a
where list_price >=2000

SELECT ITEM_ID,   COUNT (item_id)
FROM SALES.order_items
GROUP BY item_id


SELECT COUNT( DISTINCT (store_id))
FROM production.stocks

SELECT  category_id,(COUNT(DISTINCT ( brand_id)))
FROM production.products
GROUP BY category_id


SELECT brand_id , COUNT(DISTINCT category_id)
FROM production.products
GROUP BY brand_id



SELECT category_id , COUNT( DISTINCT brand_id)
FROM production.products

GROUP BY category_id

SELECT count(*) FROM (SELECT DISTINCT * FROM production.products) A

SELECT  count(DISTINCT(category_id)) FROM production.products


---REQUIREMENT COUNT --> It needs single entity

select count(category_id), category_id, brand_id
from production.products
group by  brand_id, category_id

select count (distinct(model_year))
from production.products

select DISTINCT(COUNT  (model_year))
from production.products

select count(distinct(*)) from sales.order_items ------- error, it doesnt mean that every values of all rows were same

select distinct(count(*)) from sales.order_items ------- returns unique value of count
select distinct(count(1)) from sales.order_items ------- returns unique value of count
select distinct(count(1515)) from sales.order_items ------- returns unique value of count

select count(*) from sales.order_items

SELECT  SUM(10) AS TEST from sales.order_items

select distinct(count(order_id, item_id)) from sales.order_items ------- error

select distinct(count (order_id)) a from sales.order_items ------- returns unique value of count of rows of  that column 

select count(distinct order_id) b from sales.order_items ------- returns count of unique value of the column 

select count(distinct order_id, item_id) b from sales.order_items ------- error???????????????

select distinct (*)from sales.order_items ------- error, it doesnt mean that every values of all rows were same

select count(*) from sales.order_items--- returns count of rows

select count(order_id) from sales.order_items----------- count of rows 

select count(order_id, item_id) from sales.order_items----------- error-The count function requires 1 argument(s).?????????

select distinct (order_id)from sales.order_items ------- returns distinct values of each row

select distinct order_id, item_id, product_id from sales.order_items ------- returns values on both columns levels





---	WHICH STAFF SHIPPED MAXIMUM BIKES OF BRAND 'ELECTRA'#######-----------------------------------------

SELECT COUNT(brand_id), brand_id FROM production.products 
GROUP BY brand_id


SELECT  SS.staff_id,SS.first_name,SS.last_name,  PB.BRAND_NAME, sum (soi.quantity) as count
FROM sales.orders SO
JOIN sales.order_items SOI ON SO.order_id =SOI.order_id
JOIN production.products PP ON SOI.product_id = PP.product_id
JOIN production.brands PB ON PP.brand_id =PB.brand_id
JOIN sales.staffs SS ON SO.staff_id = SS.staff_id
WHERE shipped_date IS NOT  NULL
GROUP BY  PB.BRAND_NAME,SS.first_name,SS.last_name,  SS.staff_id
HAVING brand_name = 'Electra'
order by SS.staff_id desc,count desc



--order by count desc, SS.staff_id desc--- those column run 1st which written besides order by , then next 
--------------------------------------------------------------------------------------------------------------------------------------------

---GIVE THE PRODUCT NAME OF MODEL YEAR 2018 HAVING LEAST SALES.------------------------------------------------
SELECT A.* FROM
(
SELECT SOI.product_id,PP.product_name, SUM(quantity) AS SALES
FROM sales.orders SO
LEFT JOIN sales.order_items SOI ON SO.order_id = SOI.order_id
LEFT JOIN production.products PP ON SOI.product_id = PP.product_id
WHERE YEAR(order_date) ='2018'
GROUP BY SOI.product_id,PP.product_name

) A
WHERE SALES = 1

ORDER BY SALES ASC---WE USE ORDER BY HERE TO CHECK MINIMUM QTY OF SALES FOR CERTAIN CUSTOMER, EITHER IT WILL BE 0 OR 1 OR 2 WE HAVE TO OBSERVE BY EXECUTING THE ORDER BY QUERY


--------------------------------------------------------------------------------------------------------------------------------------------------
---Vikrant: Find the customers who have placed orders in every category:
SELECT A. * 
FROM
(
SELECT SC.customer_id,SC.first_name, SC.last_name ,COUNT(DISTINCT(PP.category_id)) AS CAT_COUNT, count(SOI.order_id) AS ORDERS_COUNT
FROM sales.customers SC
LEFT JOIN  sales.orders SO ON SC.customer_id = SO.customer_id
LEFT JOIN sales.order_items SOI ON SO.order_id = SOI.order_id
LEFT JOIN production.products PP ON SOI.product_id= PP.product_id
LEFT JOIN production.categories PC ON PP.category_id = PC.category_id

GROUP BY SC.customer_id,SC.first_name, SC.last_name 

)A
WHERE CAT_COUNT = (SELECT COUNT(category_id) FROM production.categories)

--WHERE COUNT = (SELECT COUNT(*) FROM production.categories)

--WHERE COUNT = (SELECT COUNT(DISTINCT(category_id)) FROM production.categories)---USE FOR DISTINCT VALUES
-------------------------------------------------------------------------------------------------------------------------------------------------


--- Vikrant: List the top 3 customers who have made the highest number of orders in the last 6 months:


----SELECT * FROM sales.orders WHERE order_date >= (SELECT dateadd(m, -6, MAX(order_date)) FROM sales.orders)--- FOR CHECKING

SELECT  SO.customer_id, SO.order_date---------TOP(3) USE WHEN REQ
FROM sales.orders SO
JOIN sales.order_items SOI ON SO.order_id = SOI.order_id
WHERE order_date >= (SELECT dateadd(m, -6, MAX(order_date)) FROM sales.orders)
GROUP BY SO.customer_id, SO.order_date
ORDER BY SO.order_date DESC

SELECT  SO.customer_id, SO.order_date---------TOP(3) USE WHEN REQ
FROM sales.orders SO
JOIN sales.order_items SOI ON SO.order_id = SOI.order_id
WHERE order_date >= (SELECT dateadd(m, +6, MIN(order_date)) FROM sales.orders)
GROUP BY SO.customer_id, SO.order_date
ORDER BY SO.order_date DESC
--SELECT datetime_column > dateadd(m, -6, getdate() - datepart(d, getdate()) + 1)

--SELECT getdate()

--SELECT dateadd(m, -6, getdate() - datepart(d, getdate())

--SELECT dateadd(m, -6, getdate()) AS DATES

--SELECT MAX(order_date) -  FROM sales.orders datediff

--SELECT DATEDIFF(MAX(order_date),dateadd(m, -6, MAX(order_date)) FROM sales.orders

--SELECT * FROM sales.orders WHERE order_date >= (SELECT dateadd(m, -6, MAX(order_date)) FROM sales.orders)
------------------------------------------------------------------------------------------------------------------------------------------------------------

---Vikrant: Find the customers who have spent more than the average amount on orders:

---SOLUTION BY ME

SELECT A.* -- AVG(EXPENSE) AVG_EXPENSE ------------------QUERY WILL NOT RUN BECAUSE IN SUB QUERY, COLUMN IS AGGREGATED ON DIFFERENT SCENARIOS
FROM
(SELECT SC.customer_id, SC.FIRST_NAME, SC.LAST_NAME, SUM(SOI.quantity*SOI.list_price*(1-SOI.discount)) AS EXPENSE

FROM sales.orders SO JOIN sales.order_items SOI 
ON SO.order_id = SOI.order_id 
JOIN sales.customers SC
ON SO.customer_id = SC.customer_id
GROUP BY SC.customer_id,SC.FIRST_NAME, SC.LAST_NAME
)A
WHERE EXPENSE> (SELECT AVG(list_price * quantity * (1- discount)) FROM sales.order_items)
ORDER BY EXPENSE DESC
----------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM sales.order_items
-------------------------------------------------------------------------------------------------------------------------------------
--SOLUTION BY NITESH

SELECT A.*
FROM 
(SELECT so.customer_id, 
       SUM(soi.list_price * soi.quantity * (1-soi.discount)) AS Spent
FROM sales.order_items soi
LEFT JOIN sales.orders so
ON soi.order_id = so.order_id
GROUP BY so.customer_id
) A
WHERE Spent> (SELECT AVG(list_price * quantity * (1- discount)) FROM sales.order_items)-----QUERY WORKS ON CERTAIN COLUMN OF BASE TABLE
ORDER BY Spent DESC


-----------------------------------------------------------------------------------------------------------------------------------

---Vikrant:Find the customer who spent the most on orders:

SELECT  SC.FIRST_NAME,-- USE TOP(1) WHEN REQUIRED
        SC.LAST_NAME, 
		SUM(SOI.quantity*SOI.list_price*(1-SOI.discount)) AS EXPENSE

FROM sales.orders SO JOIN sales.order_items SOI 
ON SO.order_id = SOI.order_id 
JOIN sales.customers SC
ON SO.customer_id = SC.customer_id
GROUP BY SC.FIRST_NAME, SC.LAST_NAME
ORDER BY EXPENSE DESC
-------------------------------------------------------------------------------------------------------------------------------------------------
-- Vikrant: Calculate the total revenue generated from orders in the last month:

SELECT TOP(1) SO.ORDER_DATE, SUM(SOI.quantity*SOI.list_price*(1-SOI.discount)) AS REVENUE
FROM sales.orders SO JOIN sales.order_items SOI
ON SO.order_id = SOI.order_id

GROUP BY  SO.ORDER_DATE
ORDER BY SO.ORDER_DATE DESC
------------------------------------------------------------------------------------------------------------------------------------------------------
---WHICH STORE NEED TO  CLOSE , WHY?/GIVE SUM OF PRICE  OF THOSE BIKES WHICH  STORED IN 'BALDWIN STORE'------------------------------------------

SELECT D.STORE_ID,
       D.STORE_NAME,
	   SUM_PRODUCTIONS_QTY,
	   SUM_SALES_QTY,
	   QTY_ROLLING_PERCENT,
	   TOTAL_PRICE_PRODUCTION,
	   TOTAL_PRICE_SALES,
	   PRICE_PERCENTAGE
FROM
(
SELECT  store_id, 
        STORE_NAME, 
		SUM_PRODUCTIONS_QTY, 
		SUM_SALES_QTY,DIFF,
		(CAST (SUM_SALES_QTY AS DECIMAL) / SUM_PRODUCTIONS_QTY)*100 AS QTY_ROLLING_PERCENT--------SELECT CAST (COL 1 AS DECIMAL)/COL 2

FROM 
(
SELECT A.store_id,
       A.STORE_NAME,
       SUM_PRODUCTIONS_QTY,
	   SUM_SALES_QTY,
	   (SUM_PRODUCTIONS_QTY -SUM_SALES_QTY) AS DIFF
FROM
(SELECT  SS.store_id,
         SS.store_name, 
        SUM(PS.quantity) AS SUM_PRODUCTIONS_QTY
FROM production.stocks PS 
JOIN sales.stores SS
ON PS.store_id = SS.store_id
GROUP BY store_name,
         SS.store_id)A

JOIN

(SELECT SS.store_id,
        SS.store_name,
        SUM(SOI.quantity) as SUM_SALES_QTY
FROM sales.order_items SOI
LEFT JOIN sales.orders SO ON SOI.order_id = SO.order_id
LEFT JOIN sales.stores SS ON SO.store_id = SS.store_id
GROUP BY SS.store_name,
         SS.store_id)B

ON A.store_id =B.store_id )C
)D

JOIN

(
SELECT STORE_ID,
       STORE_NAME,
	   TOTAL_PRICE_PRODUCTION,
	   TOTAL_PRICE_SALES,
	   (CAST(TOTAL_PRICE_SALES AS DECIMAL)/TOTAL_PRICE_PRODUCTION)*100 AS PRICE_PERCENTAGE
FROM
(
SELECT A.STORE_ID,
       A.STORE_NAME,
	   A.TOTAL_PRICE_PRODUCTION,
	   B.TOTAL_PRICE_SALES,
       (A.TOTAL_PRICE_PRODUCTION - B.TOTAL_PRICE_SALES) AS DIFF
FROM
(SELECT SS.store_id,
        SS.store_name,
	    SUM(PS.quantity *PP. list_price)AS TOTAL_PRICE_PRODUCTION
FROM production.stocks PS
JOIN production.products PP
ON PS.product_id = PP.product_id
JOIN sales.stores SS 
ON PS.store_id = SS.store_id 
GROUP BY SS.store_id, 
         SS.store_name

)A

JOIN

(SELECT SS.STORE_ID,
		SS.STORE_NAME,
        SUM(SOI.quantity* SOI.list_price* (1-SOI.discount)) AS TOTAL_PRICE_SALES
FROM sales.order_items SOI
JOIN sales.orders SO
ON SOI.order_id = SO.order_id
JOIN sales.stores SS ON SO.store_id = SS.store_id
GROUP BY SS.store_id, 
         SS.store_name

)B

ON A.store_id = B.store_id
)C
)E

ON D.store_id =E.store_id
----------------------------------------------------------------------------------------------------------------------------

--GIVE THOSE CUSTOMER WHO ORDERS PRODUCT MORE THAN ONE TIME------------------------------------------------------------

SELECT sc.first_name, SC.last_name,  soi.product_id, count(soi.order_id)
FROM sales.order_items soi
join sales.orders so
on soi.order_id =so.order_id
join sales.customers sc
on so.customer_id = sc.customer_id
group by sc.first_name, SC.last_name,  soi.product_id
HAVING count(soi.product_id) >1

--------------------------------------------------------------------------------------------------------------------------

---CUSTOMER OF STATE 'NY' ORDERED LEAST WHICH BRAND OF PRODUCTS------------------------------------------------- 

SELECT  PB.brand_name, SUM(quantity) AS SUM -----USE TOP(1) WHEN REQUIRED
FROM sales.customers SC
LEFT JOIN sales.orders SO ON SC.customer_id = SO.customer_id
LEFT JOIN sales.order_items SOI ON SO.order_id = SOI.order_id
LEFT JOIN production.products PP ON SOI.product_id = PP.product_id
LEFT JOIN production.brands PB ON PP.brand_id = PB.brand_id
WHERE state ='NY' 
GROUP BY PB.brand_name
ORDER BY SUM ASC
--------------------------------------------------------------------------------------------------------------------------

--- WHICH CATEGORY OF BIKES HAVING LEAST STOCKS-----------------------------------------------------------------------


SELECT SUM(quantity) AS TOTAL_COUNT, CATEGORY_NAME
FROM production.stocks PS 
LEFT JOIN production.products PP ON PS.product_id = PP.product_id
LEFT JOIN  production.categories PC ON PP.category_id = PC.category_id

GROUP BY category_name
ORDER BY SUM(quantity) ASC
--------------------------------------------------------------------------------------------------------------------------------
----STORE WISE/MODEL YEAR WISE PRODUCT WITH MAX QUANTITY STORED-----------------------------------------------
SELECT STORE_NAME,
       TOTAL_QTY,
	   MODEL_YEAR
FROM
(SELECT STORE_NAME,
       TOTAL_QTY,
	   MODEL_YEAR,
       RANK() OVER(PARTITION BY MODEL_YEAR  ORDER BY  TOTAL_QTY DESC) AS RANK
FROM
(SELECT SS.store_id, 
       SS.store_name,
	   SUM(quantity)AS TOTAL_QTY,
	   PP.model_year

FROM production.stocks PS
JOIN sales.stores SS 
ON PS.store_id = SS.store_id
JOIN production.products PP
ON PS.product_id = PP.product_id

GROUP BY SS.store_id, 
         SS.store_name,
		 PP.model_year
 )A
 )B
WHERE RANK = 1

-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE WISE PRODUCT WITH MAX QUANTITY STORED ------------------------------
SELECT  SS.store_id,----TOP(1)
              SS.store_name,
			  SUM(quantity)AS TOTAL_QTY
FROM production.stocks PS
JOIN sales.stores SS 
ON PS.store_id = SS.store_id 
GROUP BY SS.store_id, 
         SS.store_name
ORDER BY TOTAL_QTY DESC


-------------------------------------------------------------------------------------------------------------------------------------------

--STAFF WHO SHIPPED MAXIMUM ON TIME---------------------------------------------------------------------------
SELECT TOP(1) first_name,  COUNT(*) AS TIMES
FROM
(SELECT  order_date,
	   required_date,
	   shipped_date,
       (CASE
	       WHEN shipped_date <= required_date
		   THEN 
		      'YES'
		   WHEN shipped_date IS NULL
		   THEN
		      'NO_DETAILS_FOUND'
           WHEN shipped_date > required_date
		   THEN 
		      'NO'
		   
		   END) AS SHIPMENT_ON_TIME_STATUS,
		
		SS.first_name 
FROM sales.orders SO
JOIN sales.customers SC ON SO.customer_id = SC.customer_id
JOIN sales.staffs SS ON SO.staff_id = SS.staff_id

WHERE (CASE
	       WHEN shipped_date <= required_date
		   THEN 
		      'YES'
		   WHEN shipped_date IS NULL
		   THEN
		      'NO_DETAILS_FOUND'
           WHEN shipped_date > required_date
		   THEN 
		      'NO'
		   
		   END) = 'YES')A

GROUP BY first_name
ORDER BY TIMES DESC
-------------------------------------------------------------------------------------------------------------------------------------

-------- MOST ACTIVE STAFF-------------- ACCORDING TO MAINTAINING CUSTOMER_ID--------------------------------------------------------

SELECT  COUNT(*)AS COUNT,SS.first_name,SS.last_name,SO. staff_id FROM sales.orders SO 
JOIN sales.staffs SS ON SO. staff_id = SS.staff_id GROUP BY SS.first_name,SS.last_name, SO. staff_id ORDER BY COUNT DESC
----------------------------------------------------------------------------------------------------------------------------------------------
------MOST ACTIVE STAFF ACCORDING TO MAINTAINING ORDERS----------------------------------------------------------------------------
SELECT SO.staff_id,SS.first_name,SS.last_name,COUNT(SO.order_id) TOTAL_STAFF_SALES
FROM sales.orders SO
LEFT JOIN sales.order_items SOI ON SO.order_id = SOI.order_id
LEFT JOIN sales.staffs SS ON SO.staff_id = SS.staff_id
GROUP BY SO.staff_id,SS.first_name,SS.last_name----------SOLUTION BY VIKRANT

----#SELECT  COUNT(SO.order_id)AS COUNT,SS.first_name,SS.last_name  FROM sales.orders SO JOIN sales.staffs SS ON SO. staff_id = SS.staff_id GROUP BY  SS.first_name,SS.last_name ORDER BY COUNT DESC

---------------------------------------------------------------------------------------------------------------------------------------------------------
--- CUSTOMER WHO ORDERS MAXIMUM TIME ALONG WITH BELONGS TO WHICH CITY.-----------------------------------------------------------

SELECT SC.first_name, 
       SC.last_name,
	   SUM(SOI.quantity) TOTAL_COUNT

FROM sales.orders  SO
LEFT JOIN sales.order_items SOI
ON SO.order_id = SOI.order_id
LEFT JOIN sales.customers SC
ON SO.customer_id =SC.customer_id

GROUP BY SO.customer_id,
       SC.first_name, 
       SC.last_name

ORDER BY TOTAL_COUNT DESC
         


SELECT  first_name,
        last_name,
		SUM(SOI.quantity) AS TOTAL_QTY
FROM sales.customers SC
LEFT JOIN  sales.orders SO 
ON SC.customer_id = SO.customer_id
LEFT JOIN sales.order_items SOI
ON SO.order_id =SOI.order_id
GROUP BY SO.customer_id , SC.first_name, SC.last_name
ORDER BY TOTAL_QTY DESC



SELECT * FROM sales.customers

--------------------------------------------------------------------------------------------------------------------------------------------------

---SHOW CITY NAME WITH ASC ORDER ACCORDING TO NAME WHERE CITY OF STATE TEXAS IS ALWAYS ON TOP.---------------------------

SELECT state,city
FROM sales.customers
GROUP BY state,city
ORDER BY 
(CASE 
WHEN state = 'TX' THEN 1 ELSE 0 END) ASC

SELECT COUNT(*), state FROM sales.customers
GROUP BY state

SELECT COUNT(*), city FROM sales.customers
GROUP BY city

---------------------------------------------------------------------------------------------------------------
--WHICH CATEGORY OF BIKES WITH BRAND NAME HAVING  LEAST ORDER COUNT

SELECT PC.category_name,
       PB. brand_name,
	   count(SOI.order_id) AS TOTAL_COUNT,
	   RANK() OVER(PARTITION BY PC.category_name  ORDER BY count(SOI.order_id)  DESC) Rank 
FROM sales.order_items SOI 
LEFT JOIN production.products PP ON SOI.product_id =PP.product_id
LEFT JOIN production.categories PC ON PP.category_id = PC.category_id
LEFT JOIN production.brands PB ON PP.brand_id = PB.brand_id

GROUP BY 
        PC.category_name,
       PB. brand_name

ORDER BY TOTAL_COUNT asc


SELECT * FROM sales.order_items -- ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY, LIST_PRICE, DISCOUNT

SELECT 
       pp.category_id,
	   pp.brand_id,
       SUM(quantity) AS Order_Count
FROM sales.order_items  so
LEFT JOIN production.products pp
ON so.product_id = pp.product_id
GROUP BY 
         pp.category_id,
	     pp.brand_id


SELECT * FROM production.products -- PRODUCT_ID, PRODUCT_NAME, BRAND_ID, CATGORY_ID, MODEL_YEAR, LIST_PRICE

SELECT * FROM production.brands
SELECT * FROM production.products
SELECT * FROM sales.order_items
SELECT * FROM sales.orders

--- WHICH PRODUCT GIVES MAXIMUM DISCOUNT
SELECT PP. product_name 
FROM production.products PP 
JOIN sales.order_items SOI ON PP.product_id = SOI.product_id
WHERE discount >= (SELECT MAX(DISCOUNT) FROM sales.order_items)
GROUP BY PP. product_name
---------------------------------------------------------------------------------------------------------------------------------------------

---WHICH MODEL HAVE MAX ORDERS FOR GIVEN BRANDS--------------------------------------------------------


SELECT * FROM sales.orders
SELECT * FROM sales.order_items
--SELECT SUM(quantity) AS SUM FROM sales.order_items
SELECT * FROM production.products
SELECT * FROM production.brands


SELECT  brand_name,
       model_year,
	   TOTAL_COUNT
FROM

(SELECT brand_name,
       model_year,
	   TOTAL_COUNT,
	   RANK() OVER(PARTITION BY brand_name  ORDER BY TOTAL_COUNT  DESC) Rank
FROM
(SELECT  PB.brand_name,
        PP.model_year,
		SUM(SOI.quantity) as TOTAL_COUNT
	    
FROM sales.order_items SOI
LEFT JOIN sales.orders SO ON SOI.order_id = SO.order_id
LEFT JOIN production.products PP ON  SOI.product_id = PP.product_id
LEFT JOIN production.brands PB ON  PP.brand_id = PB.brand_id

GROUP BY PP.model_year,
         PB.brand_name
)A 
		 )B
WHERE Rank =1
----------------------------------------------------------------------------------------------------


SELECT COUNT(*) AS TOTAL_COUNT,  model_year FROM
production.products
GROUP BY model_year


--- WHICH CITY PEOPLE HAVE MAXIMUM ORDERS------------------------------------------------------------------

SELECT CITY FROM
(SELECT TOP(1) SUM(SOI.quantity) AS COUNT,------------HOW TO WRITE QUERY , IF WE WANT TOP 1
       city
FROM sales.order_items SOI
LEFT JOIN sales.orders SO ON SOI.order_id = SO.order_id
LEFT JOIN sales.customers SC ON SO.customer_id = SC.customer_id

GROUP BY city
ORDER BY COUNT DESC)A

------------------------------------------------------------------------------------------------------------------------------
-- SHOW IF SHIPPED ON OR BEFORE REQUIRED DATE THEN 'YES; OTHER WISE 'NO' WITH CUSTOMER FULL NAME-----------------------------------------

SELECT SO.customer_id,
       CONCAT (SC.first_name,' ',SC.last_name ) AS FULL_NAME,
	   order_date,
	   required_date,
	   shipped_date,
       (CASE
	       WHEN shipped_date <= required_date
		   THEN 
		      'YES'
		   WHEN shipped_date IS NULL
		   THEN
		      'NO_DETAILS_FOUND'-------------------------NOT WORKING
           WHEN shipped_date > required_date
		   THEN 
		      'NO'
		   
		   END) AS SHIPMENT_ON_TIME_STATUS
FROM sales.orders SO
JOIN sales.customers SC ON SO.customer_id = SC.customer_id

--------------------------------------------------------------------------------------------------------------------------
SELECT * 
FROM sales.order_items SOI
JOIN production.products PP ON SOI.product_id =PP.product_id


-- CUSTOMER DETAILS WITH PRODUCT NAME-----------------------------------------------------------------------------------------------
--customer(customer details) -> order(ORDER_ID,CUSTOMER_ID)->order_items(order_id, product_id)->products(product name)

SELECT PP.product_name,
       SC.customer_id,
       SC.first_name, 
	   SC.last_name,
	   SC.email,
	   SC.street,
	   SC.city,
	   SC.state,
	   SC.zip_code

FROM sales.customers SC
LEFT JOIN sales.orders SO ON SC.customer_id = SO.customer_id
LEFT JOIN sales.order_items SOI ON SO.order_id = SOI.order_id
LEFT JOIN production.products PP ON SOI.product_id = PP.product_id

-------------------------------------------------------------------------------------------------------------------------------------

--- CUSTOMER NAME, PRODUCT NAME, COUNT OF ORDERS, PRICE, DISCOUNTED PRICE-------------------------------------------------------------


select sc.first_name,
       sc.last_name,
       pp.product_name,
	   count(so.order_id) as total_count,
	   SUM(soi.list_price) as Sales
from production.products pp
left join sales.order_items soi on pp.product_id =soi.product_id
left join sales.orders so on so.order_id = soi.order_id
left join sales.customers sc on  so.customer_id = sc.customer_id

group by  sc.first_name,
          sc.last_name,
       pp.product_name
ORDER BY  COUNT(SO.order_id) DESC   

SELECT SC.first_name,
       SC.last_name,
       PP.product_name, 
       COUNT(SO.order_id) AS Total_Order,
	   SUM(soi.list_price) as Sales
FROM sales.order_items SOI
LEFT JOIN sales.orders SO ON SOI.order_id = SO.order_id
LEFT JOIN sales.customers SC ON SO.customer_id = SC.customer_id
LEFT JOIN production.products PP ON SOI.product_id = PP.product_id
GROUP BY SC.first_name,
         SC.last_name,
         PP.product_name
ORDER BY COUNT(SO.order_id) DESC


SELECT SC.first_name,
       SC.last_name,
       PP.product_name, 
       COUNT(SO.order_id)AS COUNT,
	   SOI.list_price,
	   (SOI.list_price * SOI.discount) AS DISCOUNT,
	   (SOI.list_price- (SOI.list_price * SOI.discount)) AS DISCOUNTED_PRICE
FROM sales.order_items SOI
LEFT JOIN sales.orders SO ON SOI.order_id = SO.order_id
LEFT JOIN sales.customers SC ON SO.customer_id = SC.customer_id
LEFT JOIN production.products PP ON SOI.product_id = PP.product_id
GROUP BY SC.customer_id,
SC.first_name,
SC.last_name,
PP.product_name,SO.order_id, 
SOI.list_price, 
(SOI.list_price * SOI.discount),
(SOI.list_price- (SOI.list_price * SOI.discount))





select sc.first_name,sc. last_name 
from sales.customers sc
left join sales.orders so on sc.customer_id = so.customer_id
left 
group by sc.customer_id,sc.first_name,sc. last_name 


select count(distinct(customer_id)) from  sales.customers



SELECT  store_id, brand_name, MAX(total_count) AS TOTAL_STOCK FROM
(select  ss.store_id,  pb.brand_name, sum(ps.quantity) as total_count
from sales.stores ss
join production.stocks ps
on ss.store_id = ps.store_id
join production.products pp
on ps.product_id = pp.product_id
join production.brands pb
on pb.brand_id = pp.brand_id
group by  ss.store_id, pb.brand_name
) A
group by store_id, brand_name
----------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM production.stocks
SELECT * FROM production.brands
SELECT * FROM production.products
SELECT * FROM sales.customers
SELECT * FROM sales.orders
SELECT * FROM sales.order_items

-- BRAND NAME WITH MAX QTY ON RESPECTIVE STORE---------------------------------------------------------------------
use bikes
SELECT * FROM 
(SELECT store_name,
       brand_name,
	   Total_Stock, 
       RANK() OVER(PARTITION BY brand_name ORDER BY Total_Stock DESC) Rank
FROM 
(SELECT ss.store_name,
       pb.brand_name,
	   SUM(ps.quantity) AS Total_Stock
FROM production.stocks ps
LEFT JOIN production.products pp
ON ps.product_id = pp.product_id
LEFT JOIN sales.stores ss
ON ps.store_id = ss.store_id
LEFT JOIN production.brands pb
ON pp.brand_id = pb.brand_id
GROUP BY ss.store_name,
         pb.brand_name ) A
		 )B
WHERE RANK=1








