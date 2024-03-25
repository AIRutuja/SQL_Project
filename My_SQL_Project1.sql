

-- Here I have created 3 tables named as salespeople , customer , orders for solving multiple questions on it.


CREATE TABLE salespeople (
		snum INT NOT NULL,
		sname VARCHAR(30) NOT NULL ,
		city VARCHAR(30) NOT NULL,
		comm DECIMAL(4,2) NOT NULL,
		PRIMARY KEY(snum));

Insert into salespeople values (1001 , 'Peel' , 'London' , 0.12),
(1002 , 'Serres' ,'San Jose' , 0.13),
(1004 , 'Motika' , 'London' , 0.11),
(1007 , 'Rifkin' , 'Barcelona' , 0.15),
(1003 , 'Axel Rod ' ,'New York' , 0.10),
(1005 , 'Fran' , 'London' , 0.26);

select * from salespeople;

create table customer (
cnum INT NOT NULL ,
cname VARCHAR(30) NOT NULL,
city VARCHAR(30) NOT NULL,
rating int NOT NULL,
snum int NOT NULL,
PRIMARY KEY(cnum),
FOREIGN KEY(snum) REFERENCES salespeople(snum));

insert into customer values 
(2001, 'Hoffman' , 'London' , 100 , 1001),
(2002 , 'Giovanni' ,'Rome' , 200 , 1003),
(2003, 'Liu' , 'San Jose' , 200 , 1002),
(2004 , 'Grass' ,'Berlin' , 300 , 1002),
(2006 , 'Ciemens' ,'London' , 100 , 1001),
(2008 , 'Cisneros' ,'San Jose' ,300 , 1007),
(2007 , 'Pereira' , 'Rome' , 100 , 1004);

create table orders (
onum INT NOT NULL , 
amt DECIMAL(7,2) NOT NULL ,
odate Date NOT NULL , 
cnum INT NOT NULL , 
PRIMARY KEY (onum) , 
FOREIGN KEY (cnum) REFERENCES customer (cnum)
);

insert into orders values(3001 , 18.69 , '1996-03-10' ,2008),
(3003 , 767.19 , '1996-03-10' , 2001),
(3002 , 1900.10 , '1996-03-10' ,2007),
(3005 , 5160.45 , '1996-03-10' , 2003),
(3006 , 1098.16 , '1996-03-10' , 2008),
(3009 ,1713.23 , '1996-04-10' , 2002) ,
(3007  , 75.75 , '1996-04-10' , 2002),
(3008 , 4723.00 , '1996-05-10' , 2006),
(3010 ,1309.95 , '1996-06-10' ,2004),
(3011 , 9891.88 , '1996-06-10' , 2006);


select * from orders;
select * from salespeople;
select * from customer;

---------------------------------------------------------------------------------------

--    Queries
1. List all the columns of the Salespeople table.

select * from salespeople;

2. List all customers with a rating of 100.

select * from customer where rating = 100;

3. Find all records in the Customer table with NULL values in the city column.

select * from customer where city is NULL;

4. Find the largest order taken by each salesperson on each date.

select max(OD.amt) , OD.odate , SP.sname from orders as OD inner join customer as C on OD.cnum = C.cnum inner join salespeople as SP on 
C.snum = SP.snum group by OD.odate , SP.sname ;

5. Arrange the Orders table by descending customer number.

select * from customer ORDER BY cnum DESC;

6. Find which salespeople currently have orders in the Orders table.

select SL.sname , ORD.onum , ORD.amt , ORD.odate , ORD.cnum from orders as ORD inner join 
customer as CS on ORD.cnum = CS.cnum inner join salespeople as SL on  CS.snum = SL.snum ;

7. List names of all customers matched with the salespeople serving them.

select C.cname, SP.snum , SP.sname , SP.city , SP.comm from customer as C inner join salespeople as SP  on C.snum = SP.snum;

8. Find the names and numbers of all salespeople who had more than one customer.

select SP.snum , SP.sname from salespeople as SP where 1 < (SElect count(*) from customer 
where snum = SP.snum);

9. Count the orders of each of the salespeople and output the results in descending order.

select count(onum)  as 'No_of_Orders', SP.snum from orders as OD inner join customer as CS on 
OD.cnum = CS.cnum  inner join salespeople as SP on CS.snum = SP.snum group by SP.snum order by 
count(onum) DESC;

10. List the Customer table if and only if one or more of the customers in the Customer table are
located in San Jose.

select * from customer where city = 'San Jose';

11. Match salespeople to customers according to what city they lived in.

select * from salespeople as SP inner join customer as C on SP.snum =C.snum where SP.city = C.city;

12. Find the largest order taken by each salesperson.

select max(amt) as 'Largest_Order' , SP.snum , SP.sname from orders as OD inner join customer as CS on 
OD.cnum = CS.cnum  inner join salespeople as SP on CS.snum = SP.snum group by SP.snum , SP.sname;

13. Find customers in San Jose who have a rating above 200.

select * from customer where city = 'San Jose' and rating>200;

14. List the names and commissions of all salespeople in London.

select * from salespeople where city = 'London';

15. List all the orders of salesperson Motika from the Orders table.

select OD.onum , OD.amt , OD.odate , OD.cnum , SP.sname from orders as OD inner join customer as 
C on OD.cnum = C.cnum inner join salespeople as SP on SP.snum = C.snum where SP.sname = 'Motika';

16. Find all customers with orders on October 3.

select C.cnum , C.cname , C.city , C.rating , C.snum , OD.onum , OD.amt , OD.odate from customer 
as C inner join orders as OD on C.cnum = OD.cnum where OD.odate between '1996-03-01' and '1996-03-31';

17. Give the sums of the amounts from the Orders table, grouped by date, eliminating all those
dates where the SUM was not at least 2000.00 above the MAX amount.

select odate , sum(amt) from orders  o group by odate having sum(amt) >
(select max(amt) + 2000 from orders d where o.odate = d.odate);

18. Select all orders that had amounts that were greater than at least one of the orders from
October 6.

select * from orders where amt>any(select amt from orders where odate='1996-06-10');

19. Write a query that uses the EXISTS operator to extract all salespeople who have customers
with a rating of 300.

select S.snum , S.sname , S.city from salespeople as S where EXISTS 
( select C.rating from customer as C where S.snum = C.snum and
C.rating = 300);

select * from customer as CS where EXISTS 
( select * from salespeople as SP where SP.snum = CS.snum and
CS.rating = 300);


20. Find all pairs of customers having the same rating.

select * from customer order by rating;

21. Find all customers whose CNUM is 1000 above the SNUM of Serres.

select cnum , cname from customer as c where cnum>(select (snum+1000) from salespeople where sname = 'Serres');

22. Give the salespeople’s commissions as percentages instead of decimal numbers.

select comm*100 as 'commissions_in_percentage'  from salespeople;

23. Find the largest order taken by each salesperson on each date, eliminating those MAX orders
which are less than $3000.00 in value.

select max(amt), odate , SP.snum , SP.sname from orders as OD inner join customer as C on OD.cnum = C.cnum inner join salespeople as SP on C.snum = SP.snum
group by odate , SP.snum , SP.sname having max(amt)>(select max(amt) +3000 from orders OS where OD.odate = OS.odate);

24. List the largest orders for October 3, for each salesperson.

select max(amt) as Largest_Order, odate , SP.sname  from orders as OD inner join customer as C on OD.cnum = C.cnum inner join salespeople as SP 
on C.snum = SP.snum group by odate , SP.sname having odate between '1996-10-01' and '1996-10-31';

25. Find all customers located in cities where Serres (SNUM 1002) has customers.

select cnum , cname , city , rating from customer where city in (select city from salespeople where snum = 1002);

26. Select all customers with a rating above 200.00.

select * from customer where rating>200;

27. Count the number of salespeople currently listing orders in the Orders table.

select count(distinct C.snum) as 'No_of_salespeople' , SP.sname  from orders as OD inner join customer as C on OD.cnum = C.cnum inner join 
salespeople as SP on C.snum = SP.snum group by SP.sname;

28. Write a query that produces all customers serviced by salespeople with a commission above 12%. Output 
the customer’s name and the salesperson’s rate of commission.

select C.cname , SP.comm from customer as C inner join salespeople as SP on C.snum = SP.snum where SP.comm > 0.12 ;

29. Find salespeople who have multiple customers.

select count(snum) as No_of_Salespeople , snum from salespeople group by snum having count(snum)>1;

30. Find salespeople with customers located in their city.

select SP.sname , C.cname , SP.city  from salespeople as SP inner join customer as C on SP.snum = C.snum order by SP.city;

31. Find all salespeople whose name starts with ‘P’ and the fourth character is ‘l’.

select * from salespeople where sname like 'P__l%'

32. Write a query that uses a subquery to obtain all orders for the customer named Cisneros.
Assume you do not know his customer number.

select * from orders as OD inner join customer as C on OD.cnum = C.cnum inner join 
salespeople as SP on C.snum = SP.snum where C.cname  = 'Cisneros' ;

33. Find the largest orders for Serres and Rifkin.

select max(amt)  Largest_Order , SP.sname from orders as OD inner join customer as C on OD.cnum = C.cnum inner join 
salespeople as SP on C.snum = SP.snum group by SP.sname having SP.sname in ('Serres' , 'Rifkin');

34. Extract the Salespeople table in the following order : SNUM, SNAME, COMMISSION, CITY.

select snum as SNUM , sname as SNAME , comm as COMMISSION , city as CITY from salespeople;

35. Select all customers whose names fall in between ‘A’ and ‘G’ alphabetical range.

select * from customer where cname between 'A' and 'G' order by cname;

36. Select all the possible combinations of customers that you can assign.

select c.cname , s.sname from customer  c inner join salespeople s  on c.snum = s.snum;

37. Select all orders that are greater than the average for October 4.

select * from orders o where amt>(select avg(amt) from orders d where o.odate = d.odate ) and odate = '1996-10-04';

38. Write a select command using a corelated subquery that selects the names and numbers of all customers with ratings 
equal to the maximum for their city.

 select cname , cnum , rating from customer where rating in (select max(rating)from customer group by city);

39. Write a query that totals the orders for each day and places the results in descending order.

select sum(amt) as SUM_of_orders  , odate from orders group by odate order by  sum(amt) DESC;

40. Write a select command that produces the rating followed by the name of each customer in San Jose.

select rating , cname from customer where city = 'San Jose' ;

41. Find all orders with amounts smaller than any amount for a customer in San Jose.
select * from orders;  select * from customer;

select * from orders where amt < ANY (select amt from orders o , customer c where  
o.cnum = c.cnum and c.city = 'San Jose');

42. Find all orders with above average amounts for their customers

select onum from orders o where amt>(select avg(amt) from orders);

43. Write a query that selects the highest rating in each city.

select max(rating) Highest_rating , city from customer group by city;

44. Write a query that calculates the amount of the salesperson’s commission on each order by a
customer with a rating above 100.00.

select SP.sname , SP.comm*amt  "salesperson's_commission" , O.onum ,C.rating from salespeople as SP inner join customer as c 
on SP.snum = C.snum inner join orders as O on O.cnum = c.cnum where SP.snum
in(select C.snum from customer where rating > 100);

45. Count the customers with ratings above San Jose’s average.

select count(cnum) as Customer_Ratings from customer  where rating>(select 
avg(rating) from customer where city = 'San Jose');

46. Write a query that produces all pairs of salespeople with themselves as well as duplicate rows
with the order reversed.
select * from customer;
select * from salespeople;
select * from orders



47. Find all salespeople that are located in either Barcelona or London.

select * from salespeople where city = 'Barcelona' or city = 'London';

48. Find all salespeople with only one customer.

select * from salespeople where snum in (select distinct snum from customer t WHERE NOT EXISTS 
(select * from customer s where t.cnum = s.cnum AND t.cname <> s.cname));

49. Write a query that joins the Customer table to itself to find all pairs of customers served by a
single salesperson.

select c.cname from customer c , customer c2 where c.snum = c2.snum and c.cname!=c2.cname;


50. Write a query that will give you all orders for more than $1000.00

select * from orders where amt>1000.00;


51. Write a query that lists each order number followed by the name of the customer who made
that order.

select onum , cname from orders od inner join customer c on od.cnum = c.cnum ; 
OR
select o.onum , c.cname from orders o , customer c where o.cnum = c.cnum;


52. Write 2 queries that select all salespeople (by name and number) who have customers in their
cities who they do not service, one using a join and one a corelated subquery. Which solution
is more elegant?

select c.snum,s.snum from salespeople s,customer c where s.city=c.city group by 
c.snum,s.snum having c.snum!=s.snum;



53. Write a query that selects all customers whose ratings are equal to or greater than ANY (in the
SQL sense) of Serres’?

select cname from customer where rating >= ANY (select rating from customer
where snum =(select snum from salespeople where sname='Serres')); 

54. Write 2 queries that will produce all orders taken on October 3 or October 4.

select * from orders where odate = '1996-10-03' or odate = '1996-10-04';

55. Write a query that produces all pairs of orders by a given customer. Name that customer and
eliminate duplicates.
select * from customer; select * from orders; 

select c.cname,o.onum from customer c,orders o where c.cnum=o.cnum group by c.cname,o.onum;


56. Find only those customers whose ratings are higher than every customer in Rome.

select * from customer where rating  > (select max(rating) from customer where city = 'Rome');

57. Write a query on the Customers table whose output will exclude all customers with a rating <=
100.00, unless they are located in Rome.

select * from customer where rating>100.00 or city like 'Rome';


58. Find all rows from the Customers table for which the salesperson number is 1001.

select * from customer where snum like 1001;

59. Find the total amount in Orders for each salesperson for whom this total is greater than the
amount of the largest order in the table.
select * from orders;
select * from salespeople;

select sum(amt) Total_amount , s.sname from orders , salespeople s   group by s.sname having sum(amt)>(select max(amt) from orders);

60. Write a query that selects all orders save those with zeroes or NULLs in the amount field.

select * from orders where (amt is not NULL and amt<>0);