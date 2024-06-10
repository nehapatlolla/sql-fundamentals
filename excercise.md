1. Find the title of each film

```sql
SELECT title FROM movies;
```

2. Find the director of each film

```sql
SELECT director FROM movies;
```

3. Find the title and director of each film ✓

```sql
SELECT title , director  FROM movies;
```

4. Find the title and year of each film

```sql
SELECT title , year  FROM movies;
SELECT * FROM movies;
```

5. Find all the information about each film

```sql

SELECT * FROM movies;
```

![alt text](image-3.png)

Excercise 2

1.Find the movie with a row id of 6

```sql
SELECT * FROM movies
where id =6;
```

2.  Find the movies released in the years between 2000 and 2010

```sql
 SELECT * FROM movies
where year between 2000 and 2010;
```

3.Find the movies not released in the years between 2000 and 2010

```sql
SELECT * FROM movies
where year not between 2000 and 2010;
```

4.Find the first 5 Pixar movies and their release year

```sql
SELECT title, year FROM movies
WHERE year <= 2003;
```

![alt text](image-4.png)

1.Find all the Toy Story movies

```sql
SELECT title FROM movies where title LIKE "Toy Story%";
```

2. Find all the movies directed by John Lasseter

```sql
SELECT title FROM movies where director LIKE "john lasseter";
```

3. Find all the movies (and director) not directed by John Lasseter

```sql
SELECT title, director FROM movies where director not LIKE "john lasseter";
```

4. Find all the WALL-\* movies

```sql
select title from movies where title LIKE "WALL-%"
```

![alt text](image-5.png)
