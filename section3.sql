select *
from books
select *
from authors
select *
from sales

-- Section 3: Stored Procedures with Transactions and Validations

-- Add New Book and Update Author's Average Price
-- Create a stored procedure that adds a new book and updates the average price of books for the author. Ensure the price is positive, use transactions to ensure data integrity, and return the new average price.

go
alter PROCEDURE AddNewBookUpdateAuthorAveragePrice1
    @book_id INT,
    @title VARCHAR(50),
    @authorid INT,
    @genre VARCHAR(50),
    @price DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        IF @price <= 0
        BEGIN
            THROW 60000, 'Price must be positive', 1;
        END
        
        BEGIN TRANSACTION;

        INSERT INTO books
        (book_id, title, author_id, genre, price)
    VALUES
        (@book_id, @title, @authorid, @genre, @price);

        -- Calculate new average price
        DECLARE @average_price DECIMAL(10, 2);
        SELECT @average_price = AVG(price)
    FROM books
    where author_id = @authorid
      

        COMMIT TRANSACTION;

        SELECT @average_price AS average_price; -- Return the new average price
    END
    TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT CONCAT('Error number is: ', ERROR_NUMBER());
    PRINT CONCAT('Error message is: ', ERROR_MESSAGE());
    PRINT CONCAT('Error state is: ', ERROR_STATE());
    END CATCH
END

EXEC AddNewBookUpdateAuthorAveragePrice1
         @book_id = 10,
    @title = 'Game of Thrones',
    @authorid = 6,
    @genre = 'Fiction',
    @price = 12.67;


select avg(price)
from books
-- Delete Book and Update Author's Total Sales
-- Create a stored procedure that deletes a book and updates the author's total sales. 
--Ensure the book exists, use transactions to ensure data integrity, and return the new total sales for the author.


go
CREATE PROC deletesABookUpdatesAuthorsTotal
    @bookid int
AS
Begin
    begin TRY
    begin TRANSACTION
   if not exists(select @bookid
    from books)
   BEGIN
      throw 60000, 'book is not found to delete', 1
   END
   delete from books
   where book_id = @bookid
commit TRANSACTION
   select sum(total_amount) as total
    from sales s
        join books b
        on b.book_id = s.book_id
        join authors a
        on a.author_id = b.author_id
  end
    TRY
  BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT CONCAT('Error number is: ', ERROR_NUMBER());
    PRINT CONCAT('Error message is: ', ERROR_MESSAGE());
    PRINT CONCAT('Error state is: ', ERROR_STATE());
    END CATCH

end
go

exec deletesABookUpdatesAuthorsTotal @bookid = 10

select *
from books
-- Transfer Book Sales to Another Book
-- Create a stored procedure that transfers sales from one book to another and updates the total sales for both books. 
--Ensure both books exist, use transactions to ensure data integrity, and return the new total sales for both books.

go
create proc TransferBookSalestoAnotherBook
    @bookid1 INT,
    @bookid2 int
AS
BEGIN

    declare @book1TotalSales decimal(10,2)
    declare @book2TotalSales decimal(10,2)
    BEGIN TRY
    begin transaction
    if not exists (select @bookid1, @bookid2
    from books)
    BEGIN
    throw 2000, 'book not found', 1
    END 

    select @book1TotalSales = total_sales
    from books
    where book_id = @bookid1

    select @book2TotalSales = total_sales
    from books
    where book_id = @bookid2

    update books 
    set Total_Sales = total_sales+ @book1TotalSales
    where book_id = @bookid2
   
   commit TRANSACTION 
   select book_id, total_sales
    from Books
    where book_id in (@bookid1, @bookid2)
  end
    TRY
  begin CATCH
    ROLLBACK TRANSACTION;
    print concat ('error number is' , Error_number());
    print concat ('error message is' , ERROR_MESSAGE());
    print concat ('error state is' , ERROR_STATE());
    end CATCH
end

exec TransferBookSalestoAnotherBook @bookid1 =4, @bookid2 =2

-- Add Sale and Update Book Quantity
-- Create a stored procedure that adds a sale and updates the total quantity sold for the book. Ensure the quantity is positive, use transactions to ensure data integrity, and return the new total quantity sold for the book.
select *
from sales

-- Alter table sales 
--    add Total_sales int default 0

--    ALTER TABLE sales
-- DROP COLUMN Total_sales;
-- ALTER TABLE sales
-- DROP CONSTRAINT DF__sales__Total_sal__5535A963;


go
create proc AddSaleandUpdateBookQuantity
    @saleid int ,
    @bookid int ,
    @saledate date ,
    @quantity int,
    @totalAmount decimal(10,2)
AS
BEGIN

    DECLARE @newTotalSales int
    BEGIN TRY 
      begin TRANSACTION
        if @quantity <=0 
          BEGIN
            throw 60000, 'quantity cannot be negative',1
          END
    insert into sales
        (sale_id, book_id, sale_date, quantity, total_amount)
    values
        ( @saleid, @bookid, @saledate, @quantity, @totalAmount)

    update sales 
    set quantity = quantity+@quantity
    where book_id = @bookid
    commit TRANSACTION 

    

    select @newTotalSales = quantity
    from sales
    where book_id = @bookid 

    select @newTotalSales as newtotalquantity

    END
    TRY
    begin CATCH
    ROLLBACK;
    END Catch
END
-- drop procedure AddSaleandUpdateBookQuantity
exec AddSaleandUpdateBookQuantity 
    @saleid = 14 ,
    @bookid = 4 ,
    @saledate = '2024-06-01',
    @quantity = 1,
    @totalAmount =20


-- delete from sales 
-- where sale_id = 14
select *
from sales
select *
from Books



-- Update Book Price and Recalculate Author's Average Price
-- Create a stored procedure that updates the price of a book and recalculates the average price of books for the author. Ensure the price is positive, use transactions to ensure data integrity, and return the new average price.


go
alter proc RecalculateAuthorsAveragePrice
    @bookid int ,
    @bookprice decimal(10,2),
    @authorid int
AS 
BEGIN
    BEGIN try 
      BEGIN TRANSACTION 
         if @bookprice < = 0
           BEGIN
             throw 20000, 'price cannot be negative', 1
           END
         ELSE
          update Books 
          set price = @bookprice 
          where author_id = @authorid
      commit TRANSACTION
      declare @AuthorAverage decimal(10,2)
  
      select @AuthorAverage=  avg(price)
    from books
    where author_id = @authorid
     
      select @AuthorAverage as newaverage
    END
    TRY
    begin CATCH
    ROLLBACK;
    END CATCH
END

exec RecalculateAuthorsAveragePrice @bookid = 2,
                                     @bookprice = 35.00,
                                     @authorid =2