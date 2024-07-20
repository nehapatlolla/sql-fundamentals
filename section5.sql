CREATE TABLE books
(
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE authors
(
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    birth_year INT NOT NULL
);

CREATE TABLE sales
(
    sale_id INT PRIMARY KEY,
    book_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);


INSERT INTO authors
    (author_id, name, country, birth_year)
VALUES
    (1, 'George Orwell', 'UK', 1903),
    (2, 'J.K. Rowling', 'UK', 1965),
    (3, 'Mark Twain', 'USA', 1835),
    (4, 'Jane Austen', 'UK', 1775),
    (5, 'Ernest Hemingway', 'USA', 1899),
    (6, 'Neha reddy', 'USA', 2024)

;
-- drop table authors

INSERT INTO books
    (book_id, title, author_id, genre, price)
VALUES
    (1, '1984', 1, 'Dystopian', 15.99),
    (2, 'Harry Potter and the Philosophers Stone', 2, 'Fantasy', 20.00),
    (3, 'Adventures of Huckleberry Finn', 3, 'Fiction', 10.00),
    (4, 'Pride and Prejudice', 4, 'Romance', 12.00),
    (5, 'The Old Man and the Sea', 5, 'Fiction', 8.99),
    (6, 'Vampire diaries', 1, 'Fiction', 19.76),
    (7, 'True beauty', 2, 'Romance', 20.76)
;

INSERT INTO sales
    (sale_id, book_id, sale_date, quantity, total_amount)
VALUES
    (1, 1, '2024-01-15', 3, 47.97),
    (2, 2, '2024-02-10', 2, 40.00),
    (3, 3, '2024-03-05', 5, 50.00),
    (4, 4, '2024-04-20', 1, 12.00),
    (5, 5, '2024-05-25', 4, 35.96),
    (6, 6, '2024-06-27', 5, 98.89),
    (7, 7, '2024-01-27', 5, 103.8),
    (8, 8, '2024-01-27', 2, 36.9),
    (9, 9, '2024-02-23', 1, 12.67),
    (10, 10, '2024-04-27', 2, 25.54);




create table Ratings
(
    book_id int not NULL,
    Rating_id int not null PRIMARY key,
    Rating int not null,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
)

INSERT INTO Ratings
    (book_id, Rating_id, Rating)
VALUES
    (1, 1, 7),
    (2, 2, 8),
    (3, 3, 4),
    (4, 4, 6),
    (5, 5, 5),
    (6, 6, 9),
    (7, 7, 10);
insert into ratings
values(1, 8, 10),
    (5, 9, 9);

CREATE TABLE AuditLog
(

    AuditID INT IDENTITY(1,1) PRIMARY KEY,

    TableName NVARCHAR(50),

    Operation NVARCHAR(50),

    RecordID INT,

    OperationTime DATETIME

);

select *
from books
select *
from authors
select *
from sales
select *
from Ratings

-- drop table books
-- drop table authors
-- drop table sales
go
select *
from books
select *
from authors
select *
from sales
go
-- Section 5: Questions for Running Total and Running Average with OVER Clause

-- Running Total of Sales Amount by Book
-- Create a view that displays each sale for a book along with the running total of the sales amount using the OVER clause.
go
create view eachsaleforabook
as
    select sale_id,
        book_id,
        total_amount,
        sum(total_amount) over (order by book_id) as runningTotal
    from sales 
go
select *
from eachsaleforabook

-- Running Total
-- go
-- SELECT region,
--     product_type,
--     sales_amount as TotalSales,
--     SUM(sales_amount) over(order by sales_amount ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as CurrentTotal,
--     AVG(sales_amount) over(order by sales_amount ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as AVG_Sales
-- FROM sales_data

-- Running Total of Sales Quantity by Author
-- Create a view that displays each sale for an author along with the running total of the sales quantity using the OVER clause.
go
create view eachsaleforanauthor
AS
    select a.author_id,
        s.quantity,
        sum(s.quantity) over(order by a.author_id) as runningTotal
    from sales s
        join books b
        on b.book_id = s.book_id
        join authors a
        on a.author_id = b.author_id
    group by a.author_id, 
       s.quantity
GO
-- Running Total and Running Average of Sales Amount by Genre
-- Create a view that displays each sale for a genre along with both the running total and the running average of the sales amount using the OVER clause.

CREATE VIEW GenreSalesWithRunningTotalAndAverage
AS
    SELECT
        s.sale_id,
        b.genre,
        s.sale_date,
        s.total_amount,
        SUM(total_amount) OVER (PARTITION BY b.genre ORDER BY sale_date) AS running_total,
        AVG(total_amount) OVER (PARTITION BY b.genre ORDER BY sale_date) AS running_average
    FROM
        sales s
        join books b
        on b.book_id = s.book_id
        join authors a
        on a.author_id = b.author_id;
go
select *
from GenreSalesWithRunningTotalAndAverage

-- Section 6: Triggers
-- Trigger to Update Total Sales After Insert on Sales Table
--Create a trigger that updates the total sales for a book in the books table after a new record is inserted into the sales table.
go
ALTER TABLE books
ADD total_sales DECIMAL(10, 2) DEFAULT 0;

go
create trigger TX_updateTotal
on Sales 
after insert
AS 
Begin
    declare @totalSales decimal (10,2),
            @bookid int
    select @totalSales = sum(total_amount),
        @bookid = book_id
    from inserted
    group by book_id

    update books
    set total_sales = isnull(total_sales,0) + @totalSales
    where book_id = @bookid

end

insert into sales
values(12, 2, getdate(), 2, 65)

select *
from sales
select *
from books


-- Trigger to Log Deletions from the Sales Table
-- Create a trigger that logs deletions from the sales table into a sales_log table with the sale_id, book_id, and the delete_date.

create table sales_log
(
    sale_id int,
    book_id int,
    delete_date date

)
go

alter trigger TX_booktable
on sales
after delete 
as 
BEGIN
    insert into sales_log
        (sale_id, book_id, delete_date)
    select sale_id, book_id, getdate()
    from deleted
end
  delete from sales
  where book_id = 10

select *
from sales_log


-- Trigger to Prevent Negative Quantity on Update
-- Create a trigger that prevents updates to the sales table if the new quantity is negative.
GO
alter trigger PreventNegativeQuantity
on sales 
INSTEAD OF UPDATE 
AS
BEGIN
    if exists(select 1
    from inserted
    where quantity<0)
   throw 9000, 'quantity cannot be negative', 1
ELSE
   UPDATE sales
        SET quantity = i.quantity
        FROM sales s
        INNER JOIN inserted i ON s.sale_id = i.sale_id;

end
drop trigger PreventNegativeQuantity

insert into sales
values(13, 4, GETDATE(), -2, 24.00)
select *
from sales
delete from sales where sale_id = 13

