CREATE DATABASE bank;

USE bank;

CREATE TABLE TransactionTable (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer VARCHAR(50) NOT NULL,
    amount DOUBLE NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO TransactionTable (customer, amount) VALUES 
('Alice', 200.50),
('Bob', 150.75),
('Charlie', 300.20);

SELECT * FROM TransactionTable;
