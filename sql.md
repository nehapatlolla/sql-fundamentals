Database software is software that is designed to create databases and to store, manage, search, and extract the information contained within them.

The software also handles data storage, backup and reporting, multi-access control, and security.

# What is database?

- Database is a software which is used to store the data
- Cloud is preesnt in the data
- Cloud is renting pc
- Amazon leads $100 billion cloud market
- Netflix is using AWS

not cloud providers- google drive, one drive, drop box,

## Why we should not buy?

1. high initial cost
2. storage space
3. Ac
4. Power bill
5. maintenance
6. spare parts
7. generator
8.

## Disaster management

1. We wont keep our servers where disasters occur

2. Some disasters we cant avoid so we keep the back up.

3. keep the back up data where it is safe it might be the other country also

4. We cannot go and ask for backup in the other countries , so we use MNC's, Mncs can ask for backup or rent.

Windows and Mac!!! has the problem i.e we are paying the licensce fee, sql cannot be runned on linux

> Most used Os is Linux

- free
- open source - boat sink example, if boat has the hole , everyone die so it is their responsibility for all to solve the problem
- secure- fixes the bug
- smaller footprint - lesser ram you use, lesser money

distrose- alpine 256mb where as windows is 40gb

## Scaling

- Scaling, in simple terms, refers to the ability of a system, service, or application to handle an increasing amount of work or traffic as demand grows, without breaking or becoming slow or unstable.

- vertical scaling: More ram, CPU power,storage space, network bandwidth

- Vertical scaling involves adding more resources (such as upgrading hardware components) to an existing system to increase its capacity

- Horizontal: Adding more computers

- Horizontal scaling involves adding more instances or copies of a system to distribute the workload across multiple machines.

- Offices uses which ever is cheaper.

- The choice in the office between vertical and horizontal scaling depends on factors such as the nature of the workload, budget constraints, existing infrastructure, and scalability requirements.

### Autoscaling

Autoscaling solves this problem by `automatically adjusting the number of servers  or resources` allocated to your website based on real-time demand. When traffic increases, autoscaling automatically adds more servers or resources to handle the load. And when traffic decreases, it removes unnecessary servers or resources to save costs.

when load is mre than 80 % aws decides to add an other pc

### how will you go bankrupt, if autoscaling is on?

DDoS Attack:

Identify ddos:

1. filtering
2. captcha
3. ip address filtering

Divert the flow

when the slow attacks happen, server always does request time out, set the time limit

## Database why?

Ram is temporary , volatile

Hard disk is permanent , slow

If people are demanding the data more keep the copy in the ram.

In that case reading speed increases.

If we open the game, it loads because, it copies the data from the hard disk to ram.

Bottleneck is HDD (Hard disk)

Instead of the HDD people are using the SSD because hdd is slow.

![alt text](image.png)

1. frequently asked it will have it in the ram
2. Querying becomes easier
3. CRUD : easy
4. Backups are inbuilt
5. Undo- easily(time limit)
6. performance

## SQL vs NO SQL

| Relational (Tables with Rows and Columns)            | Columns) Various (Document, Key-Value, Columnar, Graph, etc.)                    |
| ---------------------------------------------------- | -------------------------------------------------------------------------------- | --- |
| Complex Queries, Transactions, Structured Data       | High Volume, High Velocity, Unstructured or Semi-Structured Data                 |
| tabular format                                       | no tables                                                                        |     |
| MySQL, PostgreSQL, SQL Server                        | MongoDB, Cassandra, Redis, Couchbase                                             |
| ACID (Atomicity, Consistency, Isolation, Durability) | Eventual Consistency (May sacrifice consistency for performance and scalability) |

|

![alt text](image-1.png)

![alt text](image-8.png)

![alt text](image-9.png)
![alt text](image-10.png)
![alt text](image-11.png)
![alt text](image-12.png)

> " % "----->

> "\_" ------>

> "="------>

> "LIKE"------>
> "distinct"------> duplicate rows will be identified

### Why we should not use duplicate values in tables and why use joins?

> Inconsistency in data, one is updated and one is not updated, when sql crashes

> Avoid the anomaly

> Storage

## Keys

- Primary key

> Unique values

> cannot be null

> only one primary key in a table, no other columns can be the primary key

- Foreign key

> A foreign key in a database is a column or set of columns in one table that references the primary key in another table. It establishes a relationship between the two tables.

### Normalization

In a database, normalization involves organizing data into separate tables, each focusing on a specific type of information. This reduces redundancy and ensures that each piece of data is stored in one place only, making it easier to manage and preventing errors, reduce anamolies, increase the safety.

> SAFETY

reduce the anomaly

We wont mess up the data

#### 1NF

![alt text](image-14.png)

![alt text](image-15.png)

composite key--> combining two colimns to make it a primary key

#### 2NF

![alt text](image-16.png)

data is not safe here, its inconsistant,
it becomes updation anomaly

Avoiding this problem

![alt text](image-17.png)

Deletion Anomaly:
If we want to remove two columns of trev other two

Each non key attribute must be dependent on the `entire` primary key in the 2NF

it should be in first normal form and second normal form

#### 3NF

lesser updates more safer data

![alt text](image-18.png)

there shouldnot be any dependency between the non key attributes

## JOINS

![alt text](image-19.png)

we always compare primary key to foreign key in joins

To view the result we need to join.

Every position, every place, in question if they ask every use `group by`

when ever we want to drill down to the next session we use group by

###### Aggregation = visualization purposes

> **Where and Having** difference is we cannot use Where after group by function, so we use the having function.

### Data types

> integer

> boolean

> float

> double

> real

> character(num_chars)-- Fixed length, padded with spaces if needed.

> varchar(num_chars)-- Variable length, more space-efficient for shorter strings.

> text--Variable length without maximum limit, suitable for longer strings., paragraphs

> date

> datetime

> blob-- to store large binary data, such as images, videos, audio files, and other multimedia objects. never store in blob store in file system.

1. INT (Integer):

- Storage: Typically occupies 4 bytes (32 bits) of storage space.
- Range: The range of values for an INT is from -2,147,483,648 to 2,147,483,647.
- Commonly used for storing integers within a moderate range.

2. SMALLINT (Small Integer):

- Storage: Typically occupies 2 bytes (16 bits) of storage space.
- Range: The range of values for a SMALLINT is from -32,768 to 32,767.
- Used when you know that the values stored in the column will be within a smaller range compared to INT.

3. BIGINT (Big Integer):

- Storage: Typically occupies 8 bytes (64 bits) of storage space.
- Range: The range of values for a BIGINT is from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807.
- Used when you need to store very large integer values that exceed the range of INT.

1. VARCHAR:

- Stands for "Variable Character."
- Stores character data using the database's default character encoding, which is typically a single-byte character set such as ASCII or UTF-8.
- Suitable for storing non-Unicode character data when the application or database primarily deals with single-byte character sets.

2. NVARCHAR:

- Stands for "Variable Character."
- Stores Unicode character data using the UTF-16 encoding, which allows it to support a wider range of characters including international characters, symbols, and emojis.
- Useful when you need to store data in multiple languages or when working with applications that require Unicode support.

1. decimal , float

depricated- outdated

![alt text](image-35.png)

### constraints

1. Primary key

- uniquely identifies each record in a table
- not null
- only be one primary key constraint per table.

2. Auto increment - You dont to give an id , automatically increases the next row, in sql server we use identity(1,1)

3. unique

4. Not null

5. Foreign key- even if foreign key constraint is not there we can join tables why foreign key??

first delete the foreign key and then you can delete the primary key
when you want to insert a new row in the table, first insert in a primary key, foreign key helps to solve the error which has occured when the insertion happens

increasing the data safety

![new](image-34.png)

## multi level groupy

## set operstions in grouping

1. Union all doesnt know what columns it is combining it just combines the columns,
2. grouping sets combines all the group by in multiple queries. when we tnt these particular combinations we use grouping sets

## cube vs rollup

![alt text](image-36.png)

- # cube

- it is diff from the roll up in a way that, it groups by region first and then second it groups by the product_type, and then it takes the combine values
  and in grouping sets it gives the grand total , sum of the all rows

- 2^ n combinations if n= no of columns
- ## rollup

- rollup groups by first as one column and then it groups by the both other columns
- here first time it groups by the region and then region, product_type, null

- if you give the n columns it gives the n+1 columns

## Rank

- Rank

> ```sql
> RANK ( ) OVER ( [ partition_by_clause ] order_by_clause )
> ```

- Row_number
  highest because even if the rank is skipping if the last rank is repeating the row number is highest

- Dense

> This function returns the rank of each row within a result set partition, with no gaps in the ranking values. The rank of a specific row is one plus the number of distinct rank values that come before that specific row.

```sql
DENSE_RANK() over ([partition by '   ' order by '     '])
```

- Ntile

## Why design

- to bring everyone on same page( developers)
- idea
- multiple variants of the same design

## Er diagrams

| TransactionID | Date | ProductName | Category | Price | StoreName | City | Country |

|---------------|------------|-------------|-----------|-------|-----------|------------|---------|

| 1 | 2024-04-01 | Laptop | Electronics | 1200 | TechWorld | San Francisco | USA |

| 2 | 2024-04-01 | Smartphone | Electronics | 800 | TechWorld | San Francisco | USA |

| 3 | 2024-04-02 | Jeans | Apparel | 40 | FashionFiesta | New York | USA |

![alt text](image-37.png)

![alt text](image-40.png)

![alt text](image-38.png)

![alt text](image-39.png)

## XML

![alt text](image-42.png)

## JSON

There is no attribute in json

![alt text](image-43.png)

![alt text](image-44.png)

![alt text](image-45.png)

candidate key-- capability to become the primary key

alternate key-- which can be the next primary key

Super key-- primary key + any other alternate key is the super key

![alt text](image-46.png)

### user defined in functions

declaring in the sql

```sql
declare @movieid int;
set movieid=3;

declare @movieid int = 5
```

## views

- virtual tables
- view helps in readability

- 1. complex statement - create view- Easily readability
- 2. Abstraction- users can easily use who dont know what are multiple joins we can create views and give it to them as views to understand
- 3. security-- some confidential columns are hidden and those cannot be accesed directly by the user , so we give the views which doesn't contain any hidden data and have access to only the view.

## functions

In functions we can modify only which are declared inside the function

### scalar functions

> where can i use the scalar functions?
> Ans: Wherever we use the aggregation function , we can give the column name, or the values

- @ says it is a variable

- Scalar functions can be used almost anywhere in T-SQL statements.
- Scalar functions accept one or more parameters but return only one -value, therefore, they must include a RETURN statement.
- Scalar functions can use logic such as IF blocks or WHILE loops.
- Scalar functions cannot update data. They can access data but this is not a good practice.
- Scalar functions can call other functions.

### inline table valued functions

- TVFs can be used after the FROM clause in the SELECT statements so that we can use them just like a table in the queries.

> Points to Remember:

1. We specify TABLE as the Return Type instead of any scalar data type.

2. The function body is not closed between BEGIN and END blocks. This is because the function is going to return a single select statement.

3. The structure of the Table that is going to be returned is determined by the select statement used in the function.

### Multi-statement table value function

1. function requires begin and the end statements
2. to solve the complex queries we use the mtvfs
3.

## stored procedures

## indexes

![alt text](image-47.png)

1. clustered index
2. Non clustered index

Clustered index is by default primary key and specifies the row order,

insertion happens more in Gpay, Stock market

Sql is neutral, both reading and retrieving

Indexing is a way to increase the speed

I/O cost is reduced by indexing

## ACID

- Atomicity--failure happens during the transaction rolls back to the start
- consistency-- cannot have the ghost data
- Isolation-- blocking a particular row when a person is trying to book a seat

- Durability-- it is permanently saved, if failure happens after the transaction, restarting the computer should get back all the data, No missing of the data should occur.

![alt text](image-48.png)

user defined datatypes
![alt text](image-49.png)
procedure can also return something

## stored procedures

- when you write a query and you want to use in the multiple places
- reduces the network traffic
- can be easily modified
- security
- performance
- reusable

## difference between views, functions and stored procedures

## Triggers

One action should trigger an other ation

Any kind of combinations in the one table if we do that should insert a log into the new correspnding table

Any update delete etc
![alt text](image-50.png)
![alt text](image-51.png)

inserted, deleted tables are availale in triggers, but cannot use them any where

## Recap

- cannot have order by inside th eviews becoz we want to select entire thing from the view, order of the table determined by clustered index, not by order

- what happens if we have update command in view? it is copy by reference, yes it gets updated in the main table but why?
  there could be multiple tables underlying, and it updates different thing not the expected one and it is wrong.

- if the coulmn is not menitoned in the group by which is at the aggregate functoion it errors out becoz it dosnt know wht to group by at that condition

- Grouping sets-
- union all doesnt see whether the data is ordered or not

- **rollup** and **cube** are shortforms of the grouping sets

- Row_number
  highest because even if the rank is skipping if the last rank is repeating the row number is highest

- GROUP BY: Aggregates rows based on common attribute values, typically used with aggregate functions like SUM, COUNT, etc., to summarize data across groups.

- PARTITION BY: Divides the result set into partitions to which an analytic function is applied separately, allowing for ranking, row numbering, and other operations within each partition independently.
