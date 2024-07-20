#### Schemas
create database test
use test
CREATE TABLE artists
(
    artist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    birth_year INT NOT NULL
);

CREATE TABLE artworks
(
    artwork_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    artist_id INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE sales
(
    sale_id INT PRIMARY KEY,
    artwork_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artworks(artwork_id)
);

INSERT INTO artists
    (artist_id, name, country, birth_year)
VALUES
    (1, 'Vincent van Gogh', 'Netherlands', 1853),
    (2, 'Pablo Picasso', 'Spain', 1881),
    (3, 'Leonardo da Vinci', 'Italy', 1452),
    (4, 'Claude Monet', 'France', 1840),
    (5, 'Salvador Dalí', 'Spain', 1904);

INSERT INTO artworks
    (artwork_id, title, artist_id, genre, price)
VALUES
    (1, 'Starry Night', 1, 'Post-Impressionism', 1000000.00),
    (2, 'Guernica', 2, 'Cubism', 2000000.00),
    (3, 'Mona Lisa', 3, 'Renaissance', 3000000.00),
    (4, 'Water Lilies', 4, 'Impressionism', 500000.00),
    (5, 'The Persistence of Memory', 5, 'Surrealism', 1500000.00);

(6, 'hey', 1, 'Post-Impressionism', 2500000.00),
(7, 'hello1', 2, 'Renaissance', 3500000.00)
INSERT INTO artworks
    (artwork_id, title, artist_id, genre, price)
VALUES
    (8, 'secreteray kim', 2, 'Surrealism', 4100000.00)
INSERT INTO sales
    (sale_id, artwork_id, sale_date, quantity, total_amount)
VALUES
    (1, 1, '2024-01-15', 1, 1000000.00),
    (2, 2, '2024-02-10', 1, 2000000.00),
    (3, 3, '2024-03-05', 1, 3000000.00),
    (4, 4, '2024-04-20', 2, 1000000.00),

    (5, 5, '2024-04-20', 2, 1000000.00)
,
INSERT INTO sales
    (sale_id, artwork_id, sale_date, quantity, total_amount)
VALUES
    (6, 7, '2024-04-20', 2, 3100000.00)

select *
from artists
select *
from artworks
select *
from sales

-- ### Section 1: 1 mark each

-- 1. Write a query to calculate the price of 'Starry Night' plus 10% tax.
select price + 1.10
from artworks
where title ='Starry Night'



-- 2. Write a query to display the artist names in uppercase.
select name, upper (name) as upper_cased_names
from artists


-- 3. Write a query to extract the year from the sale date of 'Guernica'.
select year(sale_date )
from sales s
    join artworks a
    on a.artwork_id = s.artwork_id
where a.title  = 'Guernica'


-- 4. Write a query to find the total amount of sales for the artwork 'Mona Lisa'.

select s.total_amount
from sales s
    join artworks a
    on a.artwork_id = s.artwork_id
where a.artwork_id = 3

-- ### Section 2: 2 marks each

-- 5. Write a query to find the artists who have sold more artworks than the average number of artworks sold per artist.

with
    cte
    as
    (
        select sum(s.quantity) as total
        from sales s
            join artworks a
            on a.artwork_id = s.artwork_id
            join artists a1
            on a1.artist_id= a.artist_id
        group by a1.artist_id
    )
select *
from cte
where total > (select avg(s.quantity) as average
from sales s
    join artworks a
    on a.artwork_id = s.artwork_id
    join artists a1
    on a1.artist_id= a.artist_id
group by a1.artist_id)



-- 6. Write a query to display artists whose birth year is earlier than the average birth year of artists from their country.

with
    cte7
    as
    (
        select country,
            birth_year,
            rank() over (partition by country order by birth_year ) as rank
        from artists a
        where birth_year < 
                  (
select avg(birth_year) as avgOfArtists
        from artists a1
        where a.country = a1.country
        group  by country
                  )
    )
select *
from cte7
where rank <=2


-- 7. Write a query to create a non-clustered index on the `sales` table to improve query performance for queries filtering by `artwork_id`.
create NONCLUSTERED index IX_salestable
on sales (artwork_id)

-- 8. Write a query to display artists who have artworks in multiple genres.

select artist_id, count( distinct genre ) as count
from artworks
group by artist_id
having count(distinct genre )> 1
-- 9. Write a query to rank artists by their total sales amount and display the top 3 artists.

with
    cte2
    as
    (
        select a.artist_id,
            rank() over (order by total_amount desc) as total_sales_amount
        from sales s
            join artworks a
            on a.artwork_id = s.artwork_id
            join artists a1
            on a1.artist_id= a.artist_id
        group by a.artist_id, total_amount
    )
select *
from cte2
where total_sales_amount <=3

-- 10. Write a query to find the artists who have created artworks in both 'Cubism' and 'Surrealism' genres.
    select a.artist_id, a.name
    from artists a
        join artworks a1
        on a.artist_id = a1.artist_id
    where a1.genre =  'Cubism'
intersect
    select a.artist_id, a.name
    from artists a
        join artworks a1
        on a.artist_id = a1.artist_id
    where a1.genre =  'Surrealism'

-- 11. Write a query to find the top 2 highest-priced artworks and the total quantity sold for each.
with
    cte4
    as
    (
        select a.artwork_id,
            rank() over(order by price desc) as highest_price,
            s.quantity
        from artworks a
            join sales  s
            on s.artwork_id = a.artwork_id
        group by a.artwork_id,price , s.quantity
    )
select *
from cte4
where highest_price<=2

-- 12. Write a query to find the average price of artworks for each artist.

select artist_id,
    avg(price ) as average
from artworks
group by artist_id


-- 13. Write a query to find the artworks that have the highest sale total for each genre.
go
with
    cte3
    as
    (
        select a.genre, sum(total_amount) as total,
            rank () over (order by sum(total_amount) desc) as top1
        from sales s
            join artworks a
            on a.artwork_id = s.artwork_id
            join artists a1
            on a1.artist_id = a.artist_id
        group by a.genre
    )

select *
from cte3
where top1 < 2

-- 14. Write a query to find the artworks that have been sold in both January and February 2024.
    select a.artwork_id , a.title
    from artworks a
        join sales s
        on s.artwork_id = a.artwork_id
    where datepart(month, s.sale_date) = 1 and year(s.sale_date) = 2024
intersect
    select a.artwork_id , a.title
    from artworks a
        join sales s
        on s.artwork_id = a.artwork_id
    where datepart(month, s.sale_date) = 2 and year(s.sale_date) = 2024



-- 15. Write a query to display the artists whose average artwork price is higher than every artwork price in the 'Renaissance' genre.
with
    cte5
    as
    
    (
        select artist_id, avg(price) as average
        from artworks
        group by artist_id
    )
select *
from cte5
where average
> all(
select price
from artworks
where genre = 'Renaissance')



-- ### Section 3: 3 Marks Questions

-- 16. Write a query to create a view that shows artists who have created artworks in multiple genres.

go
create view CreatedArtworksMultipleGenres
as

    select artist_id, count( distinct genre ) as count
    from artworks
    group by artist_id
    having count(distinct genre )> 1
go
select *
from CreatedArtworksMultipleGenres

-- 17. Write a query to find artworks that have a higher price than the average price of artworks by the same artist.
select artwork_id, price
from artworks

where price >
 (select avg(price ) as average
from artworks
group by artist_id)

-- 18. Write a query to find the average price of artworks for each artist and only include artists whose average artwork price is higher than the overall average artwork price.

with
    cte6
    as
    
    (
        select avg(price )as average
        from artworks
        group by artist_id
    )
select *
from cte6
where average > (
select avg(price )
from artworks)

-- ### Section 4: 4 Marks Questions
select *
from artists
select *
from artworks
select *
from sales
-- 19. Write a query to export the artists and their artworks into XML format.

select a.name, a.artist_id  , (select a2.artwork_id, a2.title
    from artworks a2
    where a2.artist_id = a.artist_id
    for xml path, type)
from artworks a1
    join artists a
    on a.artist_id = a1.artist_id
for xml path('Artworks') , root('artist')
    -- 20. Write a query to convert the artists and their artworks into JSON format.

    select a1.artwork_id, a.name, a.artist_id  , json_query((select a2.title
        from artworks a2
        where a2.artist_id = a.artist_id
        for json path) ) as artists
    from artworks a1
        join artists a
        on a.artist_id = a1.artist_id
    for json path('Artworks')
-- ### Section 5: 5 Marks Questions

-- 21. Create a multi-statement table-valued function (MTVF) to return the total quantity sold for each genre and use it in a query to display the results.
go
        create function totalquantitysoldforeachgenre(
    @genre varchar(50)
)
returns @new table 

(genre1 varchar(50),
            totalQuantitysold int)
AS
BEGIN
            insert into @new
            select a.genre, sum(s.quantity) as total
            from sales s
                join artworks a
                on 
  a.artwork_id = s.artwork_id
            where a.genre = @genre
            group by a.genre
            RETURN
        END
go
        select *
        from totalquantitysoldforeachgenre('Renaissance')



        -- 22. Create a scalar function to calculate the average sales amount for artworks in a given genre and write a query to use this function for 'Impressionism'.


        create function dbo.averagesalesamountforartworks (@genre varchar(50))
returns decimal (10,2)
AS
RETURN
 (
        declare @new decimal(10,2)
        select @new =avg(s.total_amount)
        from sales s
            join artworks a
            on a.artwork_id = s.artwork_id
        where genre = @genre
        return @new

        )
        Select dbo.averagesalesamountforartworks('Impressionism')

        -- 23. Write a query to create an NTILE distribution of artists based on their total sales, divided into 4 tiles.

        -- 24. Create a trigger to log changes to the `artworks` table into an `artworks_log` table, capturing the `artwork_id`, `title`, and a change description.
        create table artworks_log
        (
            artwork_id int ,
            title varchar(50)
        )
        create trigger tx_logchanges
on artworks
after insert
        begin
            declare @totalSales decimal (10,2),
            @bookid int
            select @totalSales = sum(total_amount),
                @bookid = book_id
            from inserted
            group by book_id
            update artworks 
   set artwork_id = 9,
   title = 'harrypotter'
   where artwork_id = 8
        END

        create trigger TX_updateTotal
on artworks 
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

-- 25. Create a stored procedure to add a new sale and update the total sales for the artwork. Ensure the quantity is positive, and use transactions to maintain data integrity.
go
        create  procedure  addanewsaleandupdatethetotalsale
            @sale_id int,
            @artwork_id int,
            @sale_date date,
            @newquantity int,
            @total_amount decimal(10,2)
        AS
        BEGIN
            BEGIN TRY 
  begin transaction
  if @newquantity < 0 
  Throw 60000, 'quantity cannot be negative', 1

  INSERT INTO sales
                (sale_id, artwork_id, sale_date, quantity, total_amount)
            VALUES
                (@sale_id , @artwork_id , @sale_date , @newquantity , @total_amount)

  update sales 
  set quantity = quantity +@newquantity
  where artwork_id = @artwork_id

  commit transaction
  select quantity
            from sales
            where  artwork_id = @artwork_id

  End TRY
  Begin catch 
   Rollback;
    print concat ('the error number is' , Error_number())
    print concat ('the error message is' , ERROR_MESSAGE())
    print concat ('the error state is' , ERROR_STATE())
  END CATCH
        END
go
        exec addanewsaleandupdatethetotalsale @sale_id = 9,
                                      @artwork_id = 1,
                                      @sale_date = '2024-03-05',
                                      @newquantity = 2,
                                      @total_amount = 5000000


-- ### Normalization (5 Marks)

-- 26. **Question:**
--     Given the denormalized table `ecommerce_data` with sample data:

-- | id  | customer_name | customer_email      | product_name | product_category | product_price | order_date | order_quantity | order_total_amount |
-- | --- | ------------- | ------------------- | ------------ | ---------------- | ------------- | ---------- | -------------- | ------------------ |
-- | 1   | Alice Johnson | alice@example.com   | Laptop       | Electronics      | 1200.00       | 2023-01-10 | 1              | 1200.00            |
-- | 2   | Bob Smith     | bob@example.com     | Smartphone   | Electronics      | 800.00        | 2023-01-15 | 2              | 1600.00            |
-- | 3   | Alice Johnson | alice@example.com   | Headphones   | Accessories      | 150.00        | 2023-01-20 | 2              | 300.00             |
-- | 4   | Charlie Brown | charlie@example.com | Desk Chair   | Furniture        | 200.00        | 2023-02-10 | 1              | 200.00             |

-- Normalize this table into 3NF (Third Normal Form). Specify all primary keys, foreign key constraints, unique constraints, not null constraints, and check constraints.

-- ### ER Diagram (5 Marks)

-- 27. Using the normalized tables from Question 26, create an ER diagram. Include the entities, relationships, primary keys, foreign keys, unique constraints, not null constraints, and check constraints. Indicate the associations using proper ER diagram notation.

-- Normalize this table into 3NF (Third Normal Form). Specify all primary keys, foreign key constraints, unique constraints, not null constraints, and check constraints.

-- Not Null
-- customer_name
-- customer_email
-- product_name
-- product_category
-- product_price
-- order_date
-- order_quantity
-- order_total_amount
-- Unique
-- customer_email
-- product_name, products.product_category (combined)
-- Check
-- product_price >= 0
-- order_quantity > 0
-- order_total_amount >= 0
-- ER Diagram (5 Marks)
-- Using the normalized tables from Question 26, create an ER diagram. Include the entities, relationships, primary keys, foreign keys, unique constraints, not null constraints, and check constraints. Indicate the associations using proper ER diagram notation.

