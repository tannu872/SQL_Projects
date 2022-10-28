--in this project we are going to do basic of SQL

--first creating the database named Online_Bookstore
--containing following tables:-
--1. Writers
--2. Books
--3. Bookstore
--4. Workers
--5. Customers
--6. Orders

--and after that will be doing some analysis on it



create database Online_Bookstore;

use Online_Bookstore;



create table writers(
		writer_id varchar(20) primary key,
		writer_name varchar(20) not null,
		writer_commission money not null);

insert into writers values('W1','Brown, Dan	',0.2);
insert into writers values('W2','Bryson, Bill',0.3);
insert into writers values('W3','Sebold, Alice',0.4);
insert into writers values('W4','Meyer, Stephenie',0.9);
insert into writers values('W5','Carle, Eric',0.5);
insert into writers values('W6','James, E.L.',0.6);
insert into writers values('W7','Rowling, J.K.',0.2);
insert into writers values('W8','Stephenson, Pamela',0.8);

select * from writers;



create table books(
		book_id varchar(100) primary key,
		book_name varchar(100) not null,
		book_type varchar(100) not null,
		writer_id varchar(100) not null,
		book_price money not null,
		book_stock int not null);

insert into books values('B1','Digital Fortress','Crime, Thriller & Adventure','W1','$25',300);
insert into books values('B2','The Lost Symbol','Crime, Thriller','W1','$20',400);
insert into books values('B3','Down Under','Travel Writing','W2','$15',250);
insert into books values('B4','A Short History of Nearly Everything','Popular Science','W2','$19',270);
insert into books values('B5','The Lovely Bones','General & Literary Fiction','W3','$10',315);
insert into books values('B6','New Moon','Young Adult Fiction','W4','$30',500);
insert into books values('B7','Eclipse','Young Adult','W4','$27',430);
insert into books values('B8','Breaking Dawn','Young Adult Fiction','W4','$20',200);
insert into books values('B9','The Very Hungry Caterpillar','Picture Books','W5','$9',150);
insert into books values('B10','Fifty Shades of Grey','Romance & Sagas','W6','$35',450);
insert into books values('B11','Harry Potter and the Deathly Hallows','Childrens Fiction','W7','$40',500);
insert into books values('B12','Harry Potter and the Goblet of Fire','Fiction','W7','$38',360);
insert into books values('B13','Billy Connolly','Biography: The Arts','W8','$20',265);

select * from books;



create table bookstore(
		store_id varchar(20) primary key,
		store_name varchar(20) not null,
		store_address varchar(30) not null,);

insert into bookstore values('S1','Bookland book store','Q001 EY7');

select * from bookstore;



create table workers(
		worker_id varchar(20) primary key,
		worker_name varchar(50) not null,
		worker_salary money not null,
		worker_time varchar(20) not null,
		worker_role varchar(50) not null);

insert into workers values('Wo1','John','$1200','Mon-Sat','Manager');
insert into workers values('Wo2','Sam','$900','Mon-Sat','Database Administrator');
insert into workers values('Wo3','Michel','$1000','Mon-Sat','Clerk');
insert into workers values('Wo4','Paul','$800','Mon-Sun','Telephone Opreator');
insert into workers values('Wo5','James','$500','Mon-Sat','Driver');
insert into workers values('Wo6','Robert','$500','Mon-Sat','Driver');

select * from workers;



create table Customers(
		customer_id varchar(20) primary key,
		customer_name varchar(30) not null,
		customer_address varchar(30) not null,
		customer_phone varchar(20) not null);

insert into Customers values('C1','William','J19 0A3','647_XXXXX05');
insert into customers values('C2','Thomas','G1H 0R1','647_XXXXX02');
insert into customers values('C3','Tim','L01 PG3','647_XXXXX07');
insert into Customers values('C4','Aadam School','F1R 0R1','647_XXXXX08');
insert into Customers Values('C5','Lambton College','P1L 4W1','647_XXXXX03');
insert into Customers values('C6','David','L1F 4P5','647_XXXXX01');
insert into Customers values('C7','Bill Company','L0G 0W1','647_XXXXX09');
insert into Customers values('C8','Jane','M1F M47','647_XXXXX10');
insert into Customers values('C9','George','K1L 9K1','647_XXXXX04');
insert into Customers values('C10', 'Cestar School','L6G 0W5','647_XXXXX06');

select * from Customers;



create table Orders(
		order_id varchar(20) primary key,
		customer_id varchar(20) not null,
		book_id varchar(20) not null,
		store_id varchar(20) not null,
		order_quantity varchar(20) not null,
		arrival varchar(20) not null);

insert into Orders values('O1','C1','B3','S1',20,'YES');
insert into Orders values ('O2','C2','B1','S1',115,'YES');
insert into Orders values ('O3','C3','B11','S1',80,'NO');
insert into Orders values ('O4','C4','B4','S1',30,'NO');
insert into Orders values ('O5','C5','B6','S1',25,'YES');
insert into Orders values ('O6','C6','B2','S1',60,'YES');
insert into Orders values ('O7','C7','B4','S1',20,'NO');
insert into Orders values ('O8','C7','B6','S1',30,'NO');
insert into Orders values ('O9','C7','B3','S1',10,'YES');
insert into Orders values ('O10','C8','B13','S1',50,'NO');
insert into Orders values ('O11','C8','B3','S1',35,'YES');
insert into Orders values ('O12','C9','B4','S1',50,'YES');
insert into Orders values ('O13','C9','B7','S1',40,'NO');
insert into Orders values ('O14','C9','B10','S1',35,'NO');
insert into Orders values ('O15','C10','B1','S1',35,'YES');
insert into Orders values ('O16','C10','B2','S1',35,'NO');

select * from Orders;


-----Q 1:- show all the books available in the store with details.

select w.Writer_name,b.book_name,b.book_type,b.book_price,b.book_stock
	from writers as w
	Join books as b
	on w.writer_id=b.writer_id
	order by book_price;



-----Q 2:- book with max order quantity

select b.book_name,o.order_quantity from books as b
		join Orders as o
		on b.book_id=o.book_id
		where o.order_quantity in (select max(order_quantity) from Orders);



-----Q 3:- write a query to find the books with different ways:by(Bookname,BookTypeor WriterName)

create view [find_book] as
	select w.Writer_name,b.book_name,b.book_type,b.book_price,b.book_stock
		from writers as w 
		join books as b
		on w.writer_id=b.writer_id

select * from find_book
where writer_name='Rowling, J.K.'

select * from find_book
where book_name='Down Under'

select * from find_book
where book_type='Childrens Fiction'



-----Q 4:- Query to helping the customers about there orders

create view[helping_orders] as 
	select w.writer_name,b.book_name,b.book_type,o.order_quantity,(b.book_price* o.order_quantity) as total_price,c.customer_name,o.order_id,o.arrival
		from writers as w
		join books as b
		on w.writer_id=b.writer_id
		join Orders as o
		on b.book_id=o.book_id
		join Customers as c
		on c.customer_id=o.customer_id;
		
select * from helping_orders;

select * from helping_orders where order_id='O5';



-----Q 5: selecting the orders which have been arrived

select * from helping_orders
	where arrival='YES'
	order by order_id;



-----Q 6: query for how much money does store make per week

select sum(b.book_price * o.order_quantity) as total_week_money
	from books as b
	join Orders as o
	on b.book_id=o.book_id;



-----Q7:how much money the book store spends or worker's salaries with the profit for the week

--total salary of workers per week
create view[total_salary_by_workers] as
	select sum(worker_salary) as total_worker_salary 
		from workers;

select * from total_salary_by_workers;


--total commission of writers
create view[total_commission_by_writers] as
	select sum( w.writer_commission * book_price * o.order_quantity) as total_writers_commission
		from writers w, books b, orders o
		where w.writer_id = b.writer_id and b.book_id = o.book_id;

select * from total_commission_by_writers;


--total money store makes
create view[money_by_store] as
	select sum(b.book_price * o.order_quantity) as total_week_money
	from books as b
	join Orders as o
	on b.book_id=o.book_id;

select * from money_by_store;


--profit of book store
select (s.total_week_money-(wr.total_writers_commission + wk.total_worker_salary )) as profit 
	from total_commission_by_writers as wr,money_by_store as s,total_salary_by_workers as wk


-----Q 8: writer with highest commission according to the orders

select w.writer_name,(w.writer_commission * book_price * o.order_quantity)as total_writers_commission
	from writers w, books b, orders o 
	where (w.writer_commission * book_price * o.order_quantity) in (select max(w.writer_commission * book_price * o.order_quantity) as total_writers_commission
		from writers w, books b, orders o
		where w.writer_id = b.writer_id and b.book_id = o.book_id);

		--OR

create view[max_commission] as
	select max(w.writer_commission * book_price * o.order_quantity) as total_writers_commission
		from writers w, books b, orders o
		where w.writer_id = b.writer_id and b.book_id = o.book_id;

select w.writer_name,(w.writer_commission * book_price * o.order_quantity)as max_writers_commission
	from writers w, books b, orders o 
	where(w.writer_commission * book_price * o.order_quantity)in (select * from max_commission);