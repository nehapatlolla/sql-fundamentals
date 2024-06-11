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
> "LIKE" ------>
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
