CREATE DATABASE IF NOT EXISTS supermarketdb;

use supermarketdb;

CREATE TABLE IF NOT EXISTS Users 
(u_id INTEGER,
 u_name VARCHAR(40),
 surname VARCHAR(40),
 username VARCHAR(40),
 pwd VARCHAR(40),
 PRIMARY KEY (u_id));

CREATE TABLE IF NOT EXISTS Admins
	(employee_id INTEGER,
	 u_id INTEGER,
	 PRIMARY KEY (u_id),
	 FOREIGN KEY (u_id) REFERENCES Users(u_id));

CREATE TABLE IF NOT EXISTS Customers
	(home_address VARCHAR(200),
	 city VARCHAR(40),
	 phone CHAR(11),
	 u_id INTEGER,
	 PRIMARY KEY (u_id),
	 FOREIGN KEY (u_id) REFERENCES Users(u_id));

CREATE TABLE IF NOT EXISTS Vouchers
	(v_id INTEGER,
	discount_rate INTEGER CHECK (discount_rate BETWEEN 1 AND 100),
	v_name VARCHAR(40),
	PRIMARY KEY (v_id));

CREATE TABLE IF NOT EXISTS Products
	(p_id INTEGER,
	stock_amount INTEGER,
	category VARCHAR(40),
	price DECIMAL(6,2) CHECK (price >= 0),
	p_name VARCHAR(40),
	PRIMARY KEY (p_id));

CREATE TABLE IF NOT EXISTS Orders
	(o_id INTEGER,
	payment_type VARCHAR(40),
	total_price DECIMAL(9,2) CHECK (total_price >= 0),
	order_date DATETIME,
order_status 	VARCHAR(40),
PRIMARY KEY (o_id));

CREATE TABLE IF NOT EXISTS Order_Products 
	(p_id INTEGER,
	o_id INTEGER,
p_amount INTEGER,
purchased_price DECIMAL(6,2) CHECK (purchased_price >= 0),
FOREIGN KEY (p_id) REFERENCES Products(p_id),
FOREIGN KEY (o_id) REFERENCES Orders(o_id),
PRIMARY KEY (p_id, o_id));

CREATE TABLE IF NOT EXISTS Customer_Vouchers
	(u_id INTEGER,
	 v_id INTEGER,
	 v_amount INTEGER,
	 PRIMARY KEY (u_id, v_id),
	 FOREIGN KEY (u_id) REFERENCES Customers(u_id),
	 FOREIGN KEY (v_id) REFERENCES Vouchers(v_id));

CREATE TABLE IF NOT EXISTS Order_Placements
	(u_id INTEGER,
	 v_id INTEGER,
	 o_id INTEGER,
	 rating INTEGER CHECK (rating BETWEEN 1 AND 5),
	 PRIMARY KEY (u_id, v_id, o_id),
	 FOREIGN KEY (u_id) REFERENCES Customers(u_id),
	 FOREIGN KEY (v_id) REFERENCES Vouchers(v_id),
	 FOREIGN KEY (o_id) REFERENCES Orders(o_id));




