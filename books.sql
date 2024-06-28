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
    (5, 'Ernest Hemingway', 'USA', 1899)

;



INSERT INTO books
    (book_id, title, author_id, genre, price)
VALUES
    (1, '1984', 1, 'Dystopian', 15.99),
    (2, 'Harry Potter and the Philosophers Stone', 2, 'Fantasy', 20.00),
    (3, 'Adventures of Huckleberry Finn', 3, 'Fiction', 10.00),
    (4, 'Pride and Prejudice', 4, 'Romance', 12.00),
    (5, 'The Old Man and the Sea', 5, 'Fiction', 8.99),
    (6, 'Vampire diaries', 1, 'Fiction', 19.76);

INSERT INTO sales
    (sale_id, book_id, sale_date, quantity, total_amount)
VALUES
    (1, 1, '2024-01-15', 3, 47.97),
    (2, 2, '2024-02-10', 2, 40.00),
    (3, 3, '2024-03-05', 5, 50.00),
    (4, 4, '2024-04-20', 1, 12.00),
    (5, 5, '2024-05-25', 4, 35.96),
    (6, 6, '2024-06-27', 7, 98.89),
    (7, 7, '2024-01-27', 8, 34.89);


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


-- Task 1
-- Write a query to display authors who have written books in multiple genres and group the results by author name.
select a.name, count(distinct b.genre) as generess
from authors a
    join books b
    on b.author_id = a.author_id
group by a.name
having count(distinct b.genre)>1

-- Task 2
-- Write a query to find the books that have the highest sale total for each genre and group the results by genre.
with
    cte
    as

    (
        select title, genre, rank() over (partition by genre order by total_amount  desc)  as total
        from sales s
            join books b
            on s.book_id= b.book_id
    )
select *
from cte
where total = 1
order by total desc

-- Task 3
-- Write a query to find the average price of books for each author and group the results by author name, only including authors whose average book price is higher than the overall average book price.

select name, avg(price) as average
from books b
    join authors a
    on a.author_id = b.author_id
group by name
having avg(price) > (select avg(price )
from books)
order by average desc

-- Task 4
-- Write a query to find authors who have sold more books than the average number of books sold per author and group the results by country.
with
    cte
    as
    (
        select b.book_id, b.title, a.author_id, s.sale_id , sum(s.quantity) as sum
        from books b
            join authors a
            on a.author_id = b.author_id
            join sales s
            on s.book_id = b.book_id
        group by b.book_id, b.title, a.author_id,  a. name, s.sale_id
    )
select *
from cte
where sum > (select avg(s.quantity) as average
from sales s)

-- Task 5
-- Write a query to find the top 2 highest-priced books and the total quantity sold for each, grouped by book title.

with
    cte1
    as
    (
        select
            b.price , s.quantity , b.title, rank() over (order by b.price desc )  as tops
        from books b
            join sales s
            on s.book_id = b.book_id
    )
select *
from cte1
where tops <=2


-- Task 6
-- Write a query to display authors whose birth year is earlier than the average birth year of authors from their country and rank them within their country.
with
    cte7
    as
    (
        select country,
            birth_year,
            rank() over (partition by country order by birth_year ) as rank
        from authors a
        where birth_year < 
                  (select avg(birth_year) as avgOfAuthors
        from authors a1
        where a.country = a1.country
        group  by country
                  )
    )
select *
from cte7
where rank <=2

-- Task 7
-- Write a query to find the authors who have written books in both 'Fiction' and 'Romance' genres and group the results by author name.

    SELECT a.name AS author_name
    FROM authors a
        JOIN books b ON a.author_id = b.author_id
    WHERE b.genre = 'Fiction'
INTERSECT
    SELECT a.name AS author_name
    FROM authors a
        JOIN books b ON a.author_id = b.author_id
    WHERE b.genre = 'Romance'
ORDER BY author_name;


-- Task 8
-- Write a query to find authors who have never written a book in the 'Fantasy' genre and group the results by country.

select a.name, a.author_id, b.title , b.genre
from authors a
    join books b
    on b.author_id = a.author_id
where b.genre not like 'fantasy'
-- group by country

-- Task 9
-- Write a query to find the books that have been sold in both January and February 2024 and group the results by book title.



    select b. book_id, title , datepart(month, s.sale_date) as month
    from books b
        join sales s
        on s.book_id = b.book_id
    group by b. book_id, title ,datepart(month, s.sale_date)
    having datepart(month, s.sale_date) =1
intersect
    select b. book_id, title , datepart(month, s.sale_date) as month
    from books b
        join sales s
        on s.book_id = b.book_id
    group by b. book_id, title ,datepart(month, s.sale_date)
    having datepart(month, s.sale_date) =2




-- Task 10
-- Write a query to display the authors whose average book price is higher than every book price in the 'Fiction' genre and group the results by author name.

with
    cte
    as
    (
        select a.name , avg(price) as prices
        from books b
            join authors a
            on a.author_id = b.author_id
        group by a.name
    )
select *
from cte
where prices >
All(
select price
from books
where genre = 'fiction')



select *
from books
select *
from authors
select *
from sales

-- Section 2: Questions
-- Task 1: Stored Procedure for Total Sales by Author
-- Create a stored procedure to get the total sales amount for a specific author and write a query to call the procedure for 'J.K. Rowling'.
go
create proc TotalSalesByAuthor
    @name varchar(50)
AS
begin
    select a.author_id, a.name, sum(total_amount) as total
    from sales s
        join books b
        ON b.author_id = s.book_id
        join authors a
        on a.author_id = b.book_id
    where a.name = @name
    GROUP BY a.author_id, a.name
end
go
exec TotalSalesByAuthor @name = 'J.K. Rowling'

-- Task 2: Function to Calculate Total Quantity Sold for a Book
-- Create a function to calculate the total quantity sold for a given book title and write a query to use this function for '1984'.
go
create function dbo.TotalQuantitySold(
    @title varchar(50)
)
returns table
AS
RETURN(
  select b.book_id, b.title, sum(s.quantity) as total
from sales s
    join books b
    ON b.book_id = s.book_id
where b.title = @title
GROUP BY b.book_id, b.title
    );

go

select *
from dbo.TotalQuantitySold ('1984')

-- Task 3: View for Best-Selling Books
-- Create a view to show the best-selling books (those with total sales amount above $30) and write a query to select from this view.

go
create view viewBestSellingBooks
as
    select b.book_id, b.title, sum(s.total_amount) as total
    from sales s
        join books b
        ON b.book_id = s.book_id
    GROUP BY b.book_id, b.title
    having sum(s.total_amount) > 30
go

select *
from viewBestSellingBooks
Go

-- Task 4: Stored Procedure for Average Book Price by Author
-- Create a stored procedure to get the average price of books for a specific author and write a query to call the procedure for 'Mark Twain'.

create proc AverageBookPricebyAuthor
    @authname varchar(50)
AS
BEGIN
    select b.title, avg(price)
    from books b
        join authors a
        on a.author_id = b.author_id
    where name= @authname
    group by name, b.title
END
exec AverageBookPricebyAuthor @authname= 'Mark Twain'

-- Task 5: Function to Calculate Total Sales in a Month
-- Create a function to calculate the total sales amount in a given month and year, and write a query to use this function for January 2024.
go
create function CalculateTotalSalesinaMonth(
    @month varchar(50), @year int
)
RETURNS TABLE
AS
return 
(
    select sum(total_amount) as total
from sales
where DATENAME(month, sale_date) = @month and year(sale_date) = @year
)
GO
select *
from CalculateTotalSalesinaMonth('January', 2024)
GO

-- Task 6: View for Authors with Multiple Genres
-- Create a view to show authors who have written books in multiple genres and write a query to select from this view.
go
create view AuthorswithMultipleGenres
AS
    select a.author_id, a.name , count(distinct genre) as Multiplegenres
    from authors a
        join books b
        on b.author_id = a.author_id
    group by a.author_id, a.name
    having  count(distinct genre) >1
go
select *
from AuthorswithMultipleGenres

-- Task 7: Ranking Authors by Total Sales
-- Write a query to rank authors by their total sales amount and display the top 3 authors.
go
with
    cte4
    as
    (
        select a.name,
            rank() over(order by sum(total_amount) desc) as rank
        from sales s
            join books b
            on b.book_id = s.book_id
            join authors a
            on a.author_id = b.author_id
        group by a.author_id, a.name
    )
select name, rank
from cte4
where rank <=3

-- Task 8: Stored Procedure for Top-Selling Book in a Genre
-- Create a stored procedure to get the top-selling book in a specific genre and write a query to call the procedure for 'Fantasy'.
go
create proc TopSellingBookinaGenre
    @genre varchar(50)
AS
BEGIN
    with
        cte5
        AS
        (
            select b.title, b.genre,
                rank() over(partition by b.genre order by s.quantity desc) as rank
            from sales s
                join books b
                on b.book_id = s.book_id
                join authors a
                on a.author_id = b.author_id
            group by b.title, b.genre, s.quantity
        )
    select title, rank  , genre
    from cte5
    where rank <2
END
exec TopSellingBookinaGenre @genre = 'Fantasy'

-- Task 9: Function to Calculate Average Sales Per Genre
-- Create a function to calculate the average sales amount for books in a given genre and write a query to use this function for 'Romance'.
go
create function CalculateAverageSalesPerGenre
(
    @genre varchar(50)
)
returns table 
AS
RETURN
(
    select genre, avg(total_amount) as average
from sales s
    join books b
    on b.book_id = s.book_id
where genre= @genre
group by genre

)
go
select *
from CalculateAverageSalesPerGenre ('Romance')

-- Section 3: Stored Procedures with Transactions and Validations

-- Add New Book and Update Author's Average Price
-- Create a stored procedure that adds a new book and updates the average price of books for the author. Ensure the price is positive, use transactions to ensure data integrity, and return the new average price.
go
create proc AddNewBookUpdateAuthorAveragePrice
@newaverage INT,
@newbookid int,
@ 
AS
BEGIN
    BEGIN TRANSACTION
    insert into books
    select @new
end
TRANSACTION
END




-- Delete Book and Update Author's Total Sales
-- Create a stored procedure that deletes a book and updates the author's total sales. Ensure the book exists, use transactions to ensure data integrity, and return the new total sales for the author.

-- Transfer Book Sales to Another Book
-- Create a stored procedure that transfers sales from one book to another and updates the total sales for both books. Ensure both books exist, use transactions to ensure data integrity, and return the new total sales for both books.

-- Add Sale and Update Book Quantity
-- Create a stored procedure that adds a sale and updates the total quantity sold for the book. Ensure the quantity is positive, use transactions to ensure data integrity, and return the new total quantity sold for the book.

-- Update Book Price and Recalculate Author's Average Price
-- Create a stored procedure that updates the price of a book and recalculates the average price of books for the author. Ensure the price is positive, use transactions to ensure data integrity, and return the new average price.







-- Section 4: Advanced SQL Concepts

-- Inline Table-Valued Function (iTVF)
-- Create an inline table-valued function that returns the total sales amount for each book and use it in a query to display the results.
go
create function totalsalesamountforeachbook
(
    @book_id varchar(50) 
)
returns TABLE
as 
return 
(
    select b.title, s.total_amount
from sales s
    join books b
    on b.book_id = s.book_id
where b.title = @title
  
)
go
select *
from totalsalesamountforeachbook('1984')

-- Multi-Statement Table-Valued Function (MTVF)
-- Create a multi-statement table-valued function that returns the total quantity sold for each genre and use it in a query to display the results.
go
create function totalquantitysoldforeachgenre (
@genre varchar(50)

)
returns @new TABLE
(genre varchar(50),
    total int)
AS
BEGIN
    insert  @new
    select b.genre, sum(s.quantity)as total
    from sales s
        join books b
        on b.book_id = s.book_id
    where b.genre = @genre
    group by b.genre
    return
end
go
select *
from totalquantitysoldforeachgenre('Fiction')

-- Scalar Function
-- Create a scalar function that returns the average price of books for a given author and use it in a query to display the average price for 'Jane Austen'.
go
create  function dbo.averagepriceofbooks(
    @authname varchar(50)
)
returns  decimal(10,2) 
AS

begin

    declare @new11 decimal(10,2)

    select @new11= avg(b.price)
    from books b
        join authors a
        on a.author_id = b.author_id
    where a.name = @authname;
    return @new11
end
go
SELECT dbo.averagepriceofbooks('Jane Austen') AS AveragePrice;
-- Stored Procedure for Books with Minimum Sales
-- Create a stored procedure that returns books with total sales above a specified amount and use it to display books with total sales above $40.
go
create proc BookswithMinimumSales

    @amount DECIMAL(10, 2)
AS
BEGIN
    select total_amount
    from sales s
        join books b
        on b.book_id = s.book_id
    where  total_amount > @amount
END
exec BookswithMinimumSales @amount =40.00

-- Indexing for Performance Improvement
-- Create an index on the sales table to improve query performance for queries filtering by book_id.

create NONCLUSTERED INDEX ix_newBookID
on sales (book_id);

-- Export Data as XML
-- Write a query to export the authors and their books as XML.

select a.author_id  , a.name, (select b.title as book1
    from books b
    where b.author_id = a.author_id
    for xml path('new')) as bookksss
from authors a
    join books b
    on b.author_id = a.author_id

for xml path('Content'), root('Authors')

    -- Export Data as JSON
    -- Write a query to export the authors and their books as JSON.
    select a.author_id , a.name, (select b.title as book1
        from books b
        where b.author_id = a.author_id
        for xml path('new'), type)
    from authors a
        join books b
        on b.author_id = a.author_id
    for json path



-- Scalar Function for Total Sales in a Year
-- Create a scalar function that returns the total sales amount in a given year and use it in a query to display the total sales for 2024.

go
        create function dbo.SalesinaYear(
    @year int 
)
returns decimal(10,2)
as 
BEGIN
            declare @new2 decimal(10,2)
            select @new2 = sum(total_amount)
            from sales
            where year (sale_date) = @year
            group by year (sale_date)
            return @new2
        END
go
        select dbo.SalesinaYear(2024)

-- Stored Procedure for Genre Sales Report
-- Create a stored procedure that returns a sales report for a specific genre, including total sales and average sales, and use it to display the report for 'Fiction'.
GO
        create proc GenreSalesReport
            @genre varchar(50)
        AS
        BEGIN
            select b.genre,
                sum(s.total_amount) as totalsales,
                avg(s.total_amount) as average
            from sales s
                join books b
                on b.book_id = s.book_id
            where genre = @genre
            group by genre
        END
        exec GenreSalesReport @genre ='Fiction'

        -- Ranking Books by Average Rating (assuming a ratings table)
        -- Write a query to rank books by their average rating and display the top 3 books. Assume a ratings table with book_id and rating columns.

        select *
        from Ratings
go
        with
            cte9
            as

            (
                select b.title, rank() over ( order by avg(rating)  desc ) as rank
                from Ratings r
                    join books b
                    on b.book_id = r.book_id
                group by b.book_id, b.title
            )
        select *
        from cte9
        where rank<4
go


        -- Section 5: Questions for Running Total and Running Average with OVER Clause

        -- Running Total of Sales Amount by Book
        -- Create a view that displays each sale for a book along with the running total of the sales amount using the OVER clause.

        select


        -- Running Total
        SELECT region,
            product_type,
            sales_amount as TotalSales,
            SUM(sales_amount) over(order by sales_amount ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as CurrentTotal,
            AVG(sales_amount) over(order by sales_amount ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as AVG_Sales
        FROM sales_data

-- Running Total of Sales Quantity by Author
-- Create a view that displays each sale for an author along with the running total of the sales quantity using the OVER clause.

-- Running Total and Running Average of Sales Amount by Genre
-- Create a view that displays each sale for a genre along with both the running total and the running average of the sales amount using the OVER clause.
