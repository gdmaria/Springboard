CREATE DATABASE event_ticket_system;

USE event_ticket_system;

CREATE TABLE ticket_sales (
ticket_id INT,
trans_date DATE,
event_id INT,
event_name VARCHAR(50),
event_date DATE,
event_type VARCHAR(10),
event_city VARCHAR(20),
event_addr VARCHAR(100),
customer_id INT,
price DECIMAL,
num_tickets INT
);

