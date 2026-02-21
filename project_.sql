create database Paytm;
use Paytm;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(50)
);

INSERT INTO users (name, phone, email) VALUES
('Aarav','9000000001','a1@gmail.com'),
('Diya','9000000002','a2@gmail.com'),
('Rohan','9000000003','a3@gmail.com'),
('Isha','9000000004','a4@gmail.com'),
('Kunal','9000000005','a5@gmail.com'),
('Meera','9000000006','a6@gmail.com'),
('Arjun','9000000007','a7@gmail.com'),
('Neha','9000000008','a8@gmail.com'),
('Rahul','9000000009','a9@gmail.com'),
('Ananya','9000000010','a10@gmail.com'),
('Siddhi','9000000011','a11@gmail.com'),
('Amit','9000000012','a12@gmail.com'),
('Pooja','9000000013','a13@gmail.com'),
('Varun','9000000014','a14@gmail.com'),
('Kavya','9000000015','a15@gmail.com'),
('Nikhil','9000000016','a16@gmail.com'),
('Riya','9000000017','a17@gmail.com'),
('Manish','9000000018','a18@gmail.com'),
('Sneha','9000000019','a19@gmail.com'),
('Yash','9000000020','a20@gmail.com');


CREATE TABLE wallet (
    wallet_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    balance DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


INSERT INTO wallet (user_id, balance) VALUES
(1,500),(2,1200),(3,800),(4,1500),(5,300),
(6,900),(7,2000),(8,650),(9,400),(10,1000),
(11,750),(12,1800),(13,600),(14,950),(15,1100),
(16,500),(17,1400),(18,700),(19,1600),(20,850);

CREATE TABLE bank_accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    bank_name VARCHAR(50),
    account_number VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


INSERT INTO bank_accounts (user_id, bank_name, account_number) VALUES
(1,'SBI','SB1001'),(2,'HDFC','HD1002'),(3,'ICICI','IC1003'),
(4,'AXIS','AX1004'),(5,'SBI','SB1005'),
(6,'HDFC','HD1006'),(7,'ICICI','IC1007'),
(8,'AXIS','AX1008'),(9,'SBI','SB1009'),
(10,'HDFC','HD1010'),(11,'ICICI','IC1011'),
(12,'AXIS','AX1012'),(13,'SBI','SB1013'),
(14,'HDFC','HD1014'),(15,'ICICI','IC1015'),
(16,'AXIS','AX1016'),(17,'SBI','SB1017'),
(18,'HDFC','HD1018'),(19,'ICICI','IC1019'),
(20,'AXIS','AX1020');


CREATE TABLE merchants (
    merchant_id INT PRIMARY KEY AUTO_INCREMENT,
    merchant_name VARCHAR(50),
    category VARCHAR(30)
);


INSERT INTO merchants (merchant_name, category) VALUES
('Amazon','Shopping'),('Flipkart','Shopping'),
('Zomato','Food'),('Swiggy','Food'),
('IRCTC','Travel'),('BookMyShow','Entertainment'),
('Uber','Transport'),('Ola','Transport'),
('Jio','Recharge'),('Airtel','Recharge'),
('BSNL','Recharge'),('Netflix','OTT'),
('Spotify','OTT'),('Myntra','Shopping'),
('Ajio','Shopping'),('Dominos','Food'),
('PizzaHut','Food'),('MakeMyTrip','Travel'),
('Goibibo','Travel'),('PayElectric','Bills');


CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    merchant_id INT,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20),
    transaction_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (merchant_id) REFERENCES merchants(merchant_id)
);


INSERT INTO transactions (user_id, merchant_id, amount, transaction_type, transaction_date, status) VALUES
(1,1,500,'Wallet','2025-01-01','Success'),
(2,3,300,'Wallet','2025-01-02','Success'),
(3,5,800,'Bank','2025-01-03','Success'),
(4,6,400,'Wallet','2025-01-04','Failed'),
(5,2,600,'Wallet','2025-01-05','Success'),
(6,4,250,'Wallet','2025-01-06','Success'),
(7,7,700,'Bank','2025-01-07','Success'),
(8,8,350,'Wallet','2025-01-08','Success'),
(9,9,199,'Wallet','2025-01-09','Success'),
(10,10,299,'Wallet','2025-01-10','Success'),
(11,11,399,'Wallet','2025-01-11','Failed'),
(12,12,499,'Bank','2025-01-12','Success'),
(13,13,199,'Wallet','2025-01-13','Success'),
(14,14,650,'Wallet','2025-01-14','Success'),
(15,15,700,'Bank','2025-01-15','Success'),
(16,16,350,'Wallet','2025-01-16','Success'),
(17,17,450,'Wallet','2025-01-17','Success'),
(18,18,900,'Bank','2025-01-18','Success'),
(19,19,850,'Bank','2025-01-19','Success'),
(20,20,300,'Wallet','2025-01-20','Success');


CREATE TABLE recharge_bills (
    recharge_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    service_type VARCHAR(30),
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


INSERT INTO recharge_bills (user_id, service_type, amount, status) VALUES
(1,'Mobile',199,'Success'),
(2,'DTH',350,'Success'),
(3,'Electricity',800,'Success'),
(4,'Mobile',299,'Failed'),
(5,'Gas',600,'Success'),
(6,'Mobile',199,'Success'),
(7,'DTH',450,'Success'),
(8,'Electricity',700,'Success'),
(9,'Mobile',249,'Success'),
(10,'Gas',550,'Success'),
(11,'Mobile',199,'Failed'),
(12,'Electricity',900,'Success'),
(13,'DTH',400,'Success'),
(14,'Mobile',299,'Success'),
(15,'Gas',650,'Success'),
(16,'Mobile',199,'Success'),
(17,'Electricity',850,'Success'),
(18,'DTH',500,'Success'),
(19,'Mobile',249,'Success'),
(20,'Gas',600,'Success');


select * from transactions
where amount >250;

select * from transactions
where amount > 300 and status = "failed";

select * from transactions
where amount > 300 or status = "failed";

select * from merchants
where not category = "shopping";

select status, sum(amount) as total_amount
from transactions
group by status;

select status, count(*) as total_amount
from recharge_bills
group by status;

select status, count(*) as total_amount
from recharge_bills
group by status
having total_amount >5;

select status, count(*) as total_amount
from recharge_bills
group by status
having count(*) between 1 and 5;

select status, sum(amount) as total_amount
from recharge_bills
group by status
having total_amount > 250;

select status, count(user_id) as total_users
from recharge_bills
group by status;

select status, avg(amount) as total_amount
from recharge_bills
group by status;

select user_id, service_type, amount
from recharge_bills
order by amount asc;


select user_id, service_type, amount
from recharge_bills
order by amount asc
limit 2;

select user_id, service_type, amount
from recharge_bills
order by amount desc;

select user_id, service_type, amount
from recharge_bills
order by amount desc
limit 2;

select user_id, service_type, amount
from recharge_bills
order by amount desc
limit 2,2;

select distinct status from recharge_bills;

select * from transactions
where amount in (300);

select * from transactions
where amount between 300 and 600;

select * from users
where name like "A%";

select * from users
where name like "%l";

select * from users
where name like "%ddh%";

select * from users
where name like "______";

select * from wallet
where balance is NULL;

select * from wallet
where balance is not NULL;

select w.user_id, w.balance, b.bank_name
from wallet w
inner join bank_accounts b
on b.user_id = w.user_id;

select w.user_id, r.amount, r.status
from wallet w
left join recharge_bills r
on r.user_id= w.user_id;

select w.user_id, r.amount, r.status
from wallet w
right join recharge_bills r
on r.user_id= w.user_id;

select w.user_id, r.amount, r.status
from wallet w
left join recharge_bills r
on r.user_id= w.user_id
union
select w.user_id, r.amount, r.status
from wallet w
right join recharge_bills r
on r.user_id= w.user_id;

select r.service_type, t.merchant_id
from recharge_bills r
cross join transactions t;


delimiter //
create procedure show_users()
begin
	select * from users;
end//
delimiter ;

call show_users;

delimiter //
create procedure insert_users(
	in cname varchar(100),
    in cphone varchar(13),
    in cemail varchar(100)
)
begin
	insert into users (name, phone, email)
    values (cname, cphone, cemail) ;
end //
delimiter ;

select * from users;
call insert_users("jaya","90000000021","a21@gmail.com");

select * from users;


select * from transactions;

select user_id, amount,
row_number() over (order by amount desc) as row_numb
from transactions;

select merchant_id, sum(amount) as total_amt,
	rank() over (order by sum(amount) desc) as amt_rank
from transactions
group by merchant_id;


select merchant_id, 
	sum(amount) as total_amt,
	dense_rank() over (order by sum(amount) desc) as amt_rank
from transactions
group by merchant_id;
