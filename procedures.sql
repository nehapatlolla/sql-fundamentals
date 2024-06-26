
CREATE TABLE Departments
(

    DepartmentID INT PRIMARY KEY,

    DepartmentName NVARCHAR(50)

);

-- Insert sample departments

INSERT INTO Departments
    (DepartmentID, DepartmentName)
VALUES

    (1, 'HR'),

    (2, 'IT'),

    (3, 'Finance'),

    (4, 'Marketing');

-- Create Employees table with a foreign key to Departments

CREATE TABLE Employees
(

    EmployeeID INT PRIMARY KEY,

    FirstName NVARCHAR(50),

    LastName NVARCHAR(50),

    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),

    Salary DECIMAL(18, 2),

    HireDate DATE

);

-- Insert sample employees

INSERT INTO Employees
    (EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate)
VALUES

    (1, 'John', 'Doe', 1, 50000, '2020-01-01'),

    (2, 'Jane', 'Smith', 2, 75000, '2021-03-15'),

    (3, 'Jim', 'Brown', 3, 60000, '2019-07-23'),

    (4, 'Jake', 'White', 4, 45000, '2022-05-30'),

    (5, 'Jill', 'Black', 2, 80000, '2023-02-11');

create table transfers
(
    EmployeeID int,
    OldDepartmentID int,
    NewDepartmentID int,
    TransferDate date
)

select *
from Departments
select *
from Employees

-- drop table Employees
-- drop table Departments
--drop table transfers
--Task - 1
--Check if the department exist first if no then error 'No such Department exists' if yes then commit the changes
-- go
-- create procedure spAddEmployee(
--     @EmployeeID int,
--     @FirstName varchar(40),
--     @LastName varchar(40),
--     @DepartmentID int,
--     @Salary bigint,
--     @HireDate varchar(40))
-- as
-- begin
--     begin transaction deptexists
--     select *
--     from Departments
--     where DepartmentID=@DepartmentID
--     commit transaction
-- end

-- exec spAddEmployee @DepartmentID=5

-- EXEC spAddEmployee @EmployeeID = 6, @FirstName = 'Anna', @LastName = 'Green', @DepartmentID = 1, @Salary = 55000, @HireDate = '2024-06-01';

go
alter Procedure spAddEmployee
    @EmployeeID Int,
    @FirstName nvarchar(60),
    @LastName nvarchar(60),
    @DepartmentID int,
    @Salary int,
    @HireDate date
As
Begin
    Begin TRANSACTION
    Begin Try
 --shield
  
        if not exists(select *
    from Departments
    where DepartmentID=@DepartmentID)
        THROW 5000, 'department is not present',1
-- shield
             insert into Employees
    values
        (@EmployeeID , @FirstName , @LastName, @DepartmentID,
            @Salary, @HireDate)
    commit transaction
    end TRY
  Begin CATCH
    -- print 'no such department exists'
    select ERROR_MESSAGE() as errormessage
    RAISERROR(@errormessage)
    rollback TRANSACTION
  End Catch
end
Go
EXEC spAddEmployee  6;


EXEC spAddEmployee 8,'Anna', 'Green',1,55000,'2024-06-01';
select *
from Employees;

select *
from Departments
where DepartmentID=5
commit transaction

-- Task 2
-- Create a Stored Procedure to Update Employee Information with Salary Validation, Department Validation
 
-- Make sure the salary should only increase in the range of 10% to 30% of their current salary 
go
create PROCEDURE UpdateEmployee
    @EmployeeID INT,
    @newFirstName NVARCHAR(50),
    @newLastName NVARCHAR(50),
    @newDepartmentID INT,
    @newSalary DECIMAL(18, 2)
As
Begin
    Begin Transaction;
    Begin Try
           if not exists(select *
    from Departments
    where DepartmentID=@newDepartmentID)
           THROW 5000, 'department is not present',1

    update employees
    set DepartmentID= @newDepartmentID
    where EmployeeID= @EmployeeID
 
    commit transaction

    Begin transaction
      declare @salary DECIMAL(18, 2)
      select @salary = salary
    from employees
    where EmployeeID = @EmployeeId
         if((@newSalary >(@salary * (1.10))) and (@newSalary <( @salary * (1.30))))
             update Employees
             set 
             Salary= @newSalary
             where EmployeeID = @EmployeeID
   ELSE
   throw 60000 , 'new salary must be within the 10 % to 30% of current salary', 1;
	 Commit Transaction;
	 End Try

	Begin Catch
		Rollback Transaction;
		print Concat('Error number is: ', Error_number());
		print Concat('Error message is: ', Error_message());
		print Concat('Error state is: ', Error_State());
	End Catch
End
 go
Select *
from Employees;
 go
EXEC UpdateEmployee @EmployeeID = 3, 
     @NewFirstName = 'James', 
    @NewLastName = 'Brown',
    @NewDepartmentID = 2, 
    @NewSalary = 65000;
GO

-- drop procedure UpdateEmployee

-- Task 3
-- Extending the logic of Task 2 also log the transfer that has happened incase of department change in Transfers table
 
-- Transfers (EmployeeID, OldDepartmentID, NewDepartmentID, TransferDate)
-- if they change the department then only i have to insert into the transfers table other wise No

GO

alter PROCEDURE UpdateEmployeeInfo1
    @EmployeeID INT,
    @NewFirstName NVARCHAR(50),
    @NewLastName NVARCHAR(50),
    @NewDepartmentID INT,
    @NewSalary DECIMAL(18, 2)
AS
BEGIN
    declare @newvar int
    set  @newvar= (select departmentID
    from Employees
    WHERE EmployeeID = @EmployeeID);
    BEGIN TRANSACTION;
    BEGIN TRY
      
       IF NOT EXISTS (SELECT *
    FROM Departments
    WHERE DepartmentID = @NewDepartmentID)
           THROW 60000, 'Department is not present!!!', 1;
    
       DECLARE @Salary DECIMAL(18, 2);
       SELECT @Salary = Salary
    FROM Employees
    WHERE EmployeeID = @EmployeeID;
       
        if((@newSalary >(@salary * (1.10))) and (@newSalary <( @salary * (1.30))))
        
       UPDATE Employees
       SET FirstName = @NewFirstName,
           LastName = @NewLastName,
           DepartmentID = @NewDepartmentID,
           Salary = @NewSalary
       WHERE EmployeeID = @EmployeeID;
     ELSE 
     THROW 60001, 'New salary must be within 10% to 30% of the current salary.', 1;
       IF( @NewDepartmentID != @newvar)
       BEGIN
        INSERT INTO Transfers
            (EmployeeID, OldDepartmentID, NewDepartmentID, TransferDate)
        VALUES
            (@EmployeeID, @newvar, @NewDepartmentID, GETDATE());
    END
       COMMIT TRANSACTION;
   END TRY
   BEGIN CATCH
       ROLLBACK TRANSACTION;
       PRINT CONCAT('Error number is: ', ERROR_NUMBER());
       PRINT CONCAT('Error message is: ', ERROR_MESSAGE());
       PRINT CONCAT('Error state is: ', ERROR_STATE());
   END CATCH
END;

EXEC UpdateEmployeeInfo1 @EmployeeID = 4, 
    @NewFirstName = 'James', 
    @NewLastName = 'Brown',
    @NewDepartmentID = 4, 
    @NewSalary = 135000


-- drop procedure UpdateEmployeeInfo
select *
from employees

select *
from transfers

-- Task 4
-- Reverting an Employee Transfer
 
-- `EXEC RevertLastTransfer @EmployeeID = 2`
go
alter procedure revertlasttransfers
    @EmployeeID INT
AS
BEGIN
    begin TRANSACTION
    begin TRY
       DECLARE @OldDepartmentID INT;
       DECLARE @NewDepartmentID INT;
       DECLARE @TransferDate DATETIME;

       SELECT TOP 1
        @OldDepartmentID= OldDepartmentID,
        @NewDepartmentID = NewDepartmentID,
        @TransferDate = TransferDate
    from transfers
    where employeeid= @EmployeeID
    ORDER BY TransferDate DESC;

       UPDATE Employees
       SET DepartmentID = @OldDepartmentID
       WHERE EmployeeID = @EmployeeID;
     
      delete from transfers
       WHERE EmployeeID = @EmployeeID and
        TransferDate = @TransferDate and
        OldDepartmentID = @OldDepartmentID and
        @NewDepartmentID= NewDepartmentID
       
      
   end TRY
   BEGIN CATCH
       ROLLBACK TRANSACTION;
       PRINT CONCAT('Error number is: ', ERROR_NUMBER());
       PRINT CONCAT('Error message is: ', ERROR_MESSAGE());
       PRINT CONCAT('Error state is: ', ERROR_STATE());
   END CATCH

    commit transaction
end
go
exec revertlasttransfers @EmployeeID=4
go


select *
from transfers





select coalesce(null, null, 'first', 'Hi') as firstnonnullvalue