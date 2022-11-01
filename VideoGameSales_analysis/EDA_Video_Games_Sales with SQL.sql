
----In this project we are going to analyse the sales data of video games

----This dataset contains a list of video games with sales greater than 100,000 copies
----columns including:

---# Rank - Ranking of overall sales

---# Name - The games name

---# Platform - Platform of the games release (i.e. PC,PS4, etc.)

---# Year - Year of the game's release

---# Genre - Genre of the game

---# Publisher - Publisher of the game

---# NA_Sales - Sales in North America (in millions)

---# EU_Sales - Sales in Europe (in millions)

---# JP_Sales - Sales in Japan (in millions)

---# Other_Sales - Sales in the rest of the world (in millions)

---# Global_Sales - Total worldwide sales (in millions).



create database video_games;

use video_games;

--after importing the data into database ,table- video_games_sales

select * from video_games_sales;



--# shape of the table:


--total no. of rows in the table:

select count(*) as no_of_rows from video_games_sales;


--total no. of columns in the table:

select count(*) as no_of_columns from information_schema.columns 
		where table_name ='video_games_sales';



--selecting the conditional values:

select * from video_games_sales
	where Platform='Wii';


select * from video_games_sales
	where year=2010 and Publisher='Nintendo'
	order by 11;



--# use of like function

select * from video_games_sales
 where Genre like 'R%';



 --# updating the column values

 select * from video_games_sales 
 where Platform='2600';
 update video_games_sales 
	set Platform='Atari 2600'
	where Platform='2600';
	


--# unique games with their counts:

select vg.Name,count(vg.Name) as games_count
	from video_games_sales as vg
	group by vg.Name
	order by games_count desc ;

select publisher , genre from video_games_sales
where Name='Need for Speed: Most Wanted'

--# total no. of unique games:

create view[unique_games] as
	select count(vg.Name)
	from video_games_sales as vg
	group by vg.Name;

select count(*) from unique_games;



--# games of which platforms are more in sale:

select * from video_games_sales;
select platform ,count(platform) as platform_count
	from video_games_sales
	group by Platform
	order by platform_count desc;



--# publishers with average sales in all the countries:

select * from video_games_sales;
select Publisher,avg(NA_Sales) as avg_NA_sales,avg(EU_Sales) as  avg_EU_sales,
	avg(JP_Sales) as avg_JP_sales,avg(Other_Sales) as avg_Other_sales ,avg(Global_Sales) as avg_Global_sales
		from video_games_sales
		group by Publisher
		order by 6 desc;


		--OR  average percentage

select Publisher,round(avg(NA_Sales)*100,2) as avg_NA_sales,round(avg(EU_Sales)*100,2) as  avg_EU_sales,
	round(avg(JP_Sales)*100,2) as avg_JP_sales,round(avg(Other_Sales)*100,2) as avg_Other_sales,
	round(avg(Global_Sales)*100,2) as avg_Global_Sales
		from video_games_sales
		group by Publisher;



--# according to all the years find the maximum sales in all the countries with publisher, name, genre and platform


-- for NA_Sales:

select * from video_games_sales;
select t1.year,t1.NA_Sales as max_NA_Sales, t1.publisher, t1.name, t1.genre, t1.platform
	from video_games_sales as t1
	inner join (
		select max(NA_Sales) as Max_SAles,Year
			from video_games_sales
			group by year) t2 
		on t1.NA_Sales=t2.Max_SAles AND t1.Year=t2.Year
		order by t1.Year;


--for EU_Sales:

select * from video_games_sales;
select t1.year,t1.EU_Sales as max_EU_Sales, t1.publisher, t1.name, t1.genre, t1.platform
	from video_games_sales as t1
	inner join (
		select max(EU_Sales) as Max_SAles,Year
			from video_games_sales
			group by year) t2 
		on t1.EU_Sales=t2.Max_SAles AND t1.Year=t2.Year
		order by t1.Year;


--for Jp_Sales:

select t1.year,t1.JP_Sales as max_JP_Sales, t1.publisher, t1.name, t1.genre, t1.platform
	from video_games_sales as t1
	inner join (
		select max(JP_Sales) as Max_SAles,Year
			from video_games_sales
			group by year) t2 
		on t1.JP_Sales=t2.Max_SAles AND t1.Year=t2.Year
		order by t1.Year;


--for Other_sales:

select t1.year,t1.Other_Sales as max_Other_Sales, t1.publisher, t1.name, t1.genre, t1.platform
	from video_games_sales as t1
	inner join (
		select max(Other_Sales) as Max_SAles,Year
			from video_games_sales
			group by year) t2 
		on t1.Other_Sales=t2.Max_SAles AND t1.Year=t2.Year
		order by t1.Year;



--# no. of sales according to genre

select * from video_games_sales;
select genre,count(Genre) as Genre_count 
	from video_games_sales
	group by genre
	order by 2 desc;



--# average sales according to genre:

select genre,avg(NA_Sales) as avg_NA_sales,avg(EU_Sales) as  avg_EU_sales,avg(JP_Sales) as avg_JP_sales,
	avg(Other_Sales) as avg_Other_sales ,avg(Global_Sales) as avg_Global_sales
		from video_games_sales
		group by genre
		order by 6 desc;



--#sum of global sales according to year and publisher

select * from video_games_sales;
select year,publisher,
	sum(Global_Sales) as sum_Global_Sales 
	from video_games_sales
	group by year,publisher
	order by 1,2;



--# use of lag function to get the both present and previous sales at the same time :

select * from video_games_sales;
select year,publisher,Global_sales,
	lag(Global_Sales) over(partition by Publisher order by year) as pre_sales
		from video_games_sales
		order by 1;



--# use of lead function to get the post values:

select * from video_games_sales;
select year,publisher,Global_sales,
	lead(Global_Sales) over(partition by Publisher order by year) as post_sales
		from video_games_sales
		order by 1 desc;



----#------# CONCLUSION #------#----


--#  "Need for Speed: Most Wante" by "Electronic Arts" of "Racing" genre has the maximum no. of sales

--#  and games of 'DS' platform has more sales

--#  Publisher named Palcom has the maximum average Global Sale among all the years

--#  games of Action genre are more in demand

--#  North America has the highest sales among all countries








