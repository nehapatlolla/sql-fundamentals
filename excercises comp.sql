--Exercise 1: Employee Full Name and Department
--Scenario: Create a list of employees with their full names in uppercase and their department names. Ensure the full name is in uppercase and the department name is in lowercase.
create table Employees1(EmployeeID int, FirstName varchar(40),  LastName varchar(40), DepartmentID int)
insert into Employees1 (EmployeeID, FirstName, LastName, DepartmentID)
values 
(1, 'john', 'Doe', 101),
(2, 'Jane',	'Smith',102 ),
(3, 'Alice', 'Johnson', 103
);

create table Departments ( DepartmentID int,DepartmentName varchar(40))
insert into Departments values (101,'Sales'),(102, 'Engineering'), (103, 'Marketing');
select * from Departments;

select EmployeeID, UPPER(concat(FirstName, LastName)) as FullName, DepartmentName from Employees1
join Departments 
on Departments.DepartmentID=Employees1.DepartmentID ;

--Exercise 2: Product Description Analysis
-- Scenario: Find the products where the description length is more than 15 characters. Additionally, reverse the product descriptions and show the first 10 characters of the reversed description.

create table Products 
(ProductID int,	ProductName varchar(40),ProductDescription varchar(40))
insert into Products values
(101,	'Widget A',	'A standard widget'),
(102,	'Gadget B',	'A fancy new gadget'),
(103,	'Thingamajig',	'A very useful tool');
select ProductID, ProductName , len(ProductDescription) as DescriptionLength ,  REVERSE(ProductName)  as ReversedDescription from Products


--Exercise 3: Sales Analysis by Customer and Year
--Scenario: Write a query to display the total sales amount for each customer for each year. Additionally, include the customer's name with trailing spaces removed and format the total sales amount to two decimal places.