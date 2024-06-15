CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    commission DECIMAL(4, 2)
);


Select * from salesman


INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15), -- Print
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11), -- Print
(5006, 'Mc Lyon', 'Paris', 0.14), -- Print
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13); -- Print

-- Task 1
-- Find the average commision of a saleman from Paris

select Avg(commission) from salesman
where city like 'Paris';

--Task 2
--Find out if there are cities with only one salesman and list them | No nulls
--Clue: Having

Select  city , count(name) from salesman
where city is not  null
group by city
having count(name) = 1 ;



CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);


INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.6, '2012-04-25', 3002, 5001);

Select * from orders;

-- Task 3 - Sub-Query
-- Write a query to display all the orders from the orders table issued by the salesman 'Paul Adam'.
 
 select * from orders 
 where salesman_id = ( select )


-- Task 4
-- Write a query to display all the orders which values are greater than the average order value for 10th October 2012
select * from orders
where purch_amt > ( select avg(purch_amt) from orders where ord_date= '2012-10-10');




-- Task 5 (Challenging)
-- Write a query to find all orders with order amounts which are above-average amounts for their customers.
--corelated sub queries 

select * from orders as o
where o.purch_amt > (select AVG(purch_amt) from orders as i 
where i. customer_id = o.customer_id)

-- Task 6
-- Write a query to find all orders attributed to a salesman in 'Paris'
-- Clue: In operator

select * from orders
where salesman_id in ( select salesman_id from salesman where city = 'paris');






CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INT NULL,
    salesman_id INT
);
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007);

-- Task 7
-- Write a query to find the name and id of all salesmen who had more than one customer


select salesman_id,  name from salesman
where salesman_id in(select salesman_id from customer
group by salesman_id 
having count(salesman_id) > 1)