select LEFT('NEHA',  1) as leftitem 
select RIGHT('NEHA',  1) as leftitem 
select UPPER('neha') as uppercase
select lower('NIKESHREDDY') as lowercase
select SUBSTRING ('nikeshreddy', 3, 8) as substring --we cannot give negative values, starts with one
select len('nikesh') as length
select LTRIM('      neha')
select RTRIM('neha      ')
select CONCAT('neha', ' super')--neha super
select REPLICATE('neha', 6) --nehanehanehanehanehaneha
select REPLACE('neha', 'eha', 'iha')-- niha
select REPLACE('neha', 3, 'iha')
select CHARINDEX( 'reddy','nikeshreddy',4) --7
select REVERSE('hehehehheh')
select ABS(-12) --+ve
select POWER(8,9)
select ROUND(70.8675765654, 5)--
select CEILING(56.7687)
select FLOOR(90.866) -- round off to below value
select GETDATE()
select DATEADD(day, 10, GETDATE())
select DATEPART(MONTH, GETDATE())--retrieves the part from the date
select DATEPART(DAY, GETDATE())
select DATEDIFF(DAY, '1986-02-21', '2024-06-13')
