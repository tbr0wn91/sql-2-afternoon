--Joins

--1.
select *
from invoice
join invoice_line on(invoice.invoice_id = invoice.invoice_id)
where invoice_line.unit_price > 0.99;

--2.
select invoice.invoice_date, customer.first_name, customer.last_name, invoice.total
from invoice
join customer  on (invoice.customer_id = customer.customer_id);

--3.
select customer.first_name, customer.last_name, employee.first_name, employee.last_name
from customer
join employee on (customer.support_rep_id = employee.employee_id);

--.4
select album.title, artist.name
from album
join artist on (album.artist_id = artist.artist_id);

--.5
select playlist_track.track_id
from playlist_track
join playlist on (playlist.playlist_id = playlist_track.playlist_id)
where playlist.name = 'Music'

--6.
select track.name
from track
join playlist_track on (track.track_id = playlist_track.track_id)
where playlist_track.playlist_id = 5;

--.7
select track.name, playlist.name
from track
join playlist_track on (track.track_id = playlist_track.track_id)
join playlist on playlist_track.playlist_id = playlist.playlist_id;

--8.
select track.name, album.title
from track
join album on (track.track_id = album.album_id)
join genre on (track.track_id = genre.genre_id)
where genre.name = 'Alternative & Punk';


--Nested Queries

--1.
select *
from invoice
where invoice_id in (select invoice_id from invoice_line where unit_price > 0.99);

--2.
select *
from playlist_track
where playlist_id in (select playlist_id from playlist where name = 'Music');

--.3
select *
from track
where track_id in (select track_id from playlist_track where playlist_id = 5);

--4.
select *
from track
where genre_id in (select genre_id from genre where name = 'Comedy');

--.5
select *
from track
where album_id in (select album_id from album where name = 'Fireball');

--.6
select *
from track
where album_id in (select album_id from album where artist_id in 
                   (select artist_id from artist where name = 'Queen'));

--UPDATING ROWS

--.1
update customer
set fax = null
where fax is not null;

select * from customer;

--2.
update customer
set company = 'Self'
where company is null;

select * from customer;


--3.
update customer
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett';

select * from customer;


--4.
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

select * from customer;

--5.
update track
set composer = 'The darkness around us'
where genre_id = (select genre_id from genre where name = 'Metal')
and composer is null;

select * from track;

-- GROUP BY

--1.
select count(*), genre.name
from track
join genre on track.genre_id = genre.genre_id
group by genre.name;

--2.select count(*), genre.name
from track
join genre on (track.genre_id = genre.genre_id)
where genre.name = 'Pop' or genre.name = 'Rock'
group by genre.name;


--3.
select count(*), artist.name
from album
join artist on artist.artist_id = album.album_id
group by artist.name;


--USE DISTINCT

--1.
select distinct composer
from track;

--2.
select distinct billing_postal_code
from invoice;

--3.select distinct company
from customer;

--DELETE

--1.
delete 
from practice_delete
where type = 'bronze';

--2.
delete 
from practice_delete
where type = 'silver';

--3.
delete 
from practice_delete
where value = 150;

--eCommerce simulation--
create table users(
    user_id serial primary key,
    name text,
    email varchar(64)
)

insert into users(name, email)
values
('Thomas','Thomas@gmail.com')('Matt','Matt@gmail.com'), ('Charley', 'Charley@yahoo.com');

select * from users;


create table products(
  product_id serial primary key,
  name text,
  price decimal
  );


  insert into products(name, price)
values
('burger', 3.50), ('fries', 1.50), ('shake', 2.00);




create table orders(
  order_id serial primary key,
  product_id integer references products(product_id),
  user_id integer references users(user_id)
  );

insert into orders (user_id, product_id)
values
(1, 2);
              
 select * from orders;
 select * from products;
 select * from users;

select *
from products
join orders on (products.product_id = orders.order_id)
where orders.order_id = 1;


select * from orders;


select SUM(products.price), order_id
from products
join orders on (products.product_id = orders.order_id)
group by orders.order_id;





























