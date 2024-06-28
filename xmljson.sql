Create DATABASE JSON_Data;
Go
USE JSON_Data;
Go


CREATE TABLE Employees
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeInfo NVARCHAR(MAX)
    -- This column will store JSON data
);


INSERT INTO Employees
    (EmployeeInfo)
VALUES
    (N'{"name": "John Doe 😁", "age": 30, "skills": ["SQL", "C#"] }'),
    (N'{"name": "Jane Smith", "age": 25, "skills": ["JavaScript", "HTML"] }'),
    (N'{"name": "Jim Beam", "age": 40, "skills": ["Management", "SQL"] }');

SELECT *
from Employees

--task
-- Get all Users with age more than 30, with the all the details of that employee

SELECT * , JSON_VALUE(EmployeeInfo, '$.name') AS name,
    JSON_QUERY(EmployeeInfo, '$.skills') AS skills,
    JSON_VALUE(EmployeeInfo, '$.age') AS Age
from employees
where JSON_VALUE(EmployeeInfo, '$.age')> 30

-- JSON_Value - Scalar   && JSON_Query - non-scalar (Object & arrays)

DECLARE @jsonData NVARCHAR(MAX)
SET @jsonData = N'{
    "Books": [
        {"Title": "SQL Essentials", "Author": "John Doe"},
        {"Title": "Learning XML", "Author": "Jane Smith"}
    ],
    "sales": 4000
}'

SELECT Title, Author
FROM OPENJSON(@jsonData, '$.Books')
WITH (
    Title NVARCHAR(100),
    Author NVARCHAR(100)
)

DECLARE @jsonData NVARCHAR(MAX)
SET @jsonData = N'{
    "Books": [
        {"id": "12345", "Details": {"Title": "SQL Essentials", "Author": "John Doe"}},
        {"id": "67890", "Details": {"Title": "Learning XML", "Author": "Jane Smith"}}
    ]
}'

SELECT id, Title, Author
FROM OPENJSON(@jsonData, '$.Books')
WITH (
    id NVARCHAR(5),
    Title NVARCHAR(100) '$.Details.Title',
    Author NVARCHAR(100) '$.Details.Author'
)

 
go
DECLARE @jsonData NVARCHAR(MAX)
SET @jsonData = N'{
    "Books": [
        {"Title": "SQL Essentials", "Author": "John Doe"},
        {"Title": "Learning XML", "Author": "Jane Smith"}
    ],
    "sales": 4000
}'

SELECT Title, Author
FROM OPENJSON(@jsonData, '$.Books')
WITH (
    Title NVARCHAR(100),
    Author NVARCHAR(100)
)


DECLARE @jsonData NVARCHAR(MAX)
SET @jsonData = N'{
    "Books": [
        {"id": "12345", "Details": {"Title": "SQL Essentials", "Author": "John Doe"}},
        {"id": "67890", "Details": {"Title": "Learning XML", "Author": "Jane Smith"}}
    ]
}'

SELECT id, Title, Author
FROM OPENJSON(@jsonData, '$.Books')
WITH (
    id NVARCHAR(5),
    Title NVARCHAR(100) '$.Details.Title',
    Author NVARCHAR(100) '$.Details.Author'
)


-- JSON_VALUE -- return scalar values
DECLARE @jsonData NVARCHAR(MAX) = N'{"name": "John", "age": 30}'

SELECT JSON_VALUE(@jsonData, '$.name') AS Name,
    JSON_VALUE(@jsonData, '$.age') AS Age;


DECLARE @jsonData NVARCHAR(MAX) = N'{
    "employee": {"name": "John", "skills": ["SQL", "C#", "Azure"]}
}'
SELECT JSON_QUERY(@jsonData, '$.employee.skills') AS Skills;


-- JSON_Value - Scalar   && JSON_Query - non-scalar (Object & arrays)

Create DATABASE JSON_Data;
Go
USE JSON_Data;
Go
 
 

 
 