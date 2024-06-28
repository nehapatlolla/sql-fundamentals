

CREATE DATABASE eCommerceDB;

GO

-- Use the created database

USE eCommerceDB;

GO


-- Create Products table

CREATE TABLE Products
(

    ProductID INT PRIMARY KEY,

    ProductName NVARCHAR(100),

    Category NVARCHAR(50),

    Price DECIMAL(10, 2),

    Stock INT

);

GO

-- Create Orders table

CREATE TABLE Orders
(

    OrderID INT PRIMARY KEY,

    CustomerID INT,

    OrderDate DATETIME,

    TotalAmount DECIMAL(10, 2)

);

GO

-- Create Customers table

CREATE TABLE Customers
(

    CustomerID INT PRIMARY KEY,

    FirstName NVARCHAR(50),

    LastName NVARCHAR(50),

    Email NVARCHAR(100)

);

GO

-- Create Reviews table

CREATE TABLE Reviews
(

    ReviewID INT PRIMARY KEY,

    ProductID INT,

    CustomerID INT,

    Rating INT,

    ReviewText NVARCHAR(1000)

);

GO

-- Create Suppliers table

CREATE TABLE Suppliers
(

    SupplierID INT PRIMARY KEY,

    SupplierName NVARCHAR(100),

    ContactEmail NVARCHAR(100)

);

GO

-- Create Audit table to log changes for all tables

CREATE TABLE AuditLog
(

    AuditID INT IDENTITY(1,1) PRIMARY KEY,

    TableName NVARCHAR(50),

    Operation NVARCHAR(50),

    RecordID INT,

    OperationTime DATETIME

);

GO


-- Insert sample data into Products table

INSERT INTO Products
    (ProductID, ProductName, Category, Price, Stock)

VALUES

    (1, 'Laptop', 'Computers', 1200.00, 50),

    (2, 'Smartphone', 'Mobile Devices', 800.00, 200),

    (3, 'Tablet', 'Mobile Devices', 500.00, 100);

GO

-- Insert sample data into Orders table

INSERT INTO Orders
    (OrderID, CustomerID, OrderDate, TotalAmount)

VALUES

    (1, 1, '2024-06-01', 2000.00),

    (2, 2, '2024-06-15', 800.00);

GO

-- Insert sample data into Customers table

INSERT INTO Customers
    (CustomerID, FirstName, LastName, Email)

VALUES

    (1, 'John', 'Doe', 'john.doe@example.com'),

    (2, 'Jane', 'Smith', 'jane.smith@example.com');

GO

-- Insert sample data into Reviews table

INSERT INTO Reviews
    (ReviewID, ProductID, CustomerID, Rating, ReviewText)

VALUES

    (1, 1, 1, 5, 'Excellent laptop!'),

    (2, 2, 2, 4, 'Great smartphone.');

GO

-- Insert sample data into Suppliers table

INSERT INTO Suppliers
    (SupplierID, SupplierName, ContactEmail)

VALUES

    (1, 'TechSupplies Inc.', 'contact@techsupplies.com'),

    (2, 'MobileTech Co.', 'support@mobiletech.com');

GO

select *
from Products
select *
from Orders
select *
from Customers
select *
from Reviews
select *
from Suppliers

select *
from AuditLog
--products, insert, productid, getdate

insert into AuditLog
select 'products', 'insert', productid, getdate()
from inserted
--recently inserted
GO
create trigger trg_product_insert
on products -- sql listens to this table -- table
after INSERT -- when i should start the trigger, before/after (insert/delete/update) -- action
AS
BEGIN
    insert into AuditLog
    select 'products', 'insert', productid, getdate()
    from inserted---reaction
END

insert into Products
VALUES
    (4, 'Drone', 'Mobile Devices', 500.00, 100);


GO
create trigger trg_product_insert1
on Reviews -- sql listens to this table -- table
after INSERT -- when i should start the trigger, before/after (insert/delete/update) -- action
AS
BEGIN
    insert into AuditLog
    select 'reviews', 'insert', ReviewID, getdate()
    from inserted---reaction
END
-- drop trigger trg_product_insert1

insert into reviews
values(4, 2, 2, 4, 'not Great smartphone.');

-- Create trigger for updating stock levels in products table
-- Updating stock --> Insert in Auditlog | Operation: 'Update-Stock'
-- Note: Dont worry on the number of stocks

GO
create trigger trg_product_insert12
on Products -- sql listens to this table -- table
after Update  -- when i should start the trigger, before/after (insert/delete/update) -- action
AS
BEGIN
    if update(Stock)

insert into AuditLog
    select 'products', 'update', ProductID, getdate()
    from inserted---reaction
END

update Products
set Stock = 500
where productid =2
 
 drop trigger trg_product_insert12
-- Create Trigger for Price changes
-- When the price is reduced or increased it needs to be logged in PriceHistory table
-- PriceHistory columns - ID (PK),  ProductID, Oldprice, NewPrice, ChangeDate

GO
create trigger trg_product_insert123
on Products -- sql listens to this table -- table
after Update  -- when i should start the trigger, before/after (insert/delete/update) -- action
AS
BEGIN
    if update(price)

insert into AuditLog
    select 'products', 'update', ProductID, getdate()
    from inserted---reaction
END
update Products
set price = 500
where productid =4