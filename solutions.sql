-- Joins

--1
select *
from invoice i
join invoice_line il on il.invoice_id = i.invoice_id
where il.unit_price > 0.99;

--2
select i.invoice_date, c.first_name, c.last_name, i.total
from invoice i
join customer c on i.customer_id = c.customer_id;

--3
select c.first_name, c.last_name, r.first_name, r.last_name
from customer c
join employee r on c.support_rep_id = r.employee_id;

--4
select al.title, ar.name
from album al
join artist ar on al.artist_id = ar.artist_id;

--5
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

--6
SELECT t.name
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

--7
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

--8
SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

-- Nested Queries

--1
select * from invoice
where invoice_id in (
  select invoice_id 
  from invoice_line 
  where unit_price > 0.99);

--2
select *
from playlist_track
where playlist_id in (
  select playlist_id 
  from playlist 
  where name = 'Music' );

--3
select name
from track
where track_id in (
  select track_id
  from playlist_track
  where playlist_id = 5);

--4
select *
from track
where genre_id in(
  select genre_id
  from genre
  where name = 'Comedy');

--5
select *
from track
where album_id in(
  select album_id
  from album
  where title = 'Fireball');

--6
select *
from track
where album_id in( 
  select album_id
  from album
  where artist_id in( 
    select artist_id
    from artist
    where name = 'Queen'
  )
); 

-- Updating Rows

--1
update customer
set fax = null
where fax is not null;

--2
update customer
set company = 'Self'
where company is null;

--3
update customer
set last_name = 'Thompson'
where first_name = 'Julia' 
  and last_name = 'Barnett';

--4
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

--5
update track
set composer = 'The darkness around us'
where genre_id = (
  select genre_id
  from genre
  where name = 'Metal')
and composer is null;

-- Group By

--1
select count(*), g.name
from track t
join genre g
on t.genre_id = g.genre_id
group by g.name;

--2
select count(*), g.name
from track t
join genre g
on g.genre_id = t.genre_id
where g.name = 'Pop'
or g.name = 'Rock'
group by g.name;

--3
select ar.name, count(*)
from album al
join artist ar
on ar.artist_id = al.artist_id
group by ar.name;

-- Use Distinct

--1
select distinct composer
from track;

--2
select distinct billing_postal_code
from invoice;

--3
select distinct company
from customer;

-- Delete Rows

--1
delete from practice_delete
where type = 'bronze';

--2
delete from practice_delete
where type = 'silver';

--3
delete from practice_delete
where value = 150;

-- eCommerce

create table users (
  users_id serial primary key,
  name varchar(50),
  email varchar(250)
);

create table product (
  product_id serial primary key,
  name varchar(50),
  price float
);

create table orders (
  order_id serial primary key,
  product_id integer references product(product_id)
);

insert into users (name, email)
values 
('James', 'james@email.com'),
('Thomas', 'thomas@email.com'),
('Sam', 'sam@email.com');

insert into product (name, price)
values
('Muffin', 1.00),
('Banana', 0.50),
('Doughnut', 1.25);

insert into orders (product_id)
values
(1),
(2),
(3);