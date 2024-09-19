-- Create the Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    email VARCHAR(100),
    join_date DATE
);

-- Create the Accounts table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(15, 2),
    open_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create the Transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(20),
    amount DECIMAL(15, 2),
    description VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- sample data Customers table
INSERT INTO customers (customer_id, first_name, last_name, birth_date, email, join_date)
VALUES
(1, 'John', 'Doe', '1985-03-20', 'john.doe@example.com', '2021-01-01'),
(2, 'Jane', 'Smith', '1990-07-15', 'jane.smith@example.com', '2021-03-15'),
(3, 'Robert', 'Brown', '1975-12-01', 'robert.brown@example.com', '2022-04-10'),
(4, 'Emily', 'Clark', '1988-05-25', 'emily.clark@example.com', '2022-02-01'),
(5, 'Michael', 'Jones', '1995-11-03', 'michael.jones@example.com', '2021-09-15'),
(6, 'Sarah', 'Miller', '1982-07-18', 'sarah.miller@example.com', '2020-12-20'),
(7, 'Daniel', 'Williams', '1979-08-12', 'daniel.williams@example.com', '2021-05-05'),
(8, 'Sophia', 'Taylor', '1992-04-17', 'sophia.taylor@example.com', '2022-01-15'),
(9, 'David', 'Wilson', '1986-02-22', 'david.wilson@example.com', '2021-07-30'),
(10, 'Olivia', 'Martinez', '1993-06-30', 'olivia.martinez@example.com', '2021-10-25');

-- Sample data for Accounts
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date, status)
VALUES
(1, 1, 'Savings', 10000.00, '2021-01-01', 'Active'),
(2, 1, 'Checking', 500.00, '2021-01-01', 'Active'),
(3, 2, 'Savings', 15000.00, '2021-03-15', 'Active'),
(4, 3, 'Checking', 2000.00, '2022-04-10', 'Active'),
(5, 4, 'Savings', 12000.00, '2022-02-01', 'Active'),
(6, 5, 'Checking', 3500.00, '2021-09-15', 'Active'),
(7, 6, 'Savings', 17500.00, '2020-12-20', 'Active'),
(8, 7, 'Checking', 2200.00, '2021-05-05', 'Active'),
(9, 8, 'Savings', 14000.00, '2022-01-15', 'Active'),
(10, 9, 'Checking', 500.00, '2021-07-30', 'Active');


-- Sample data for Transactions

INSERT INTO transactions (transaction_id, account_id, transaction_date, transaction_type, amount, description)
VALUES
(1, 1, '2022-08-01', 'Deposit', 1000.00, 'Direct deposit salary'),
(2, 2, '2022-08-05', 'Withdrawal', -200.00, 'ATM withdrawal'),
(3, 1, '2022-08-07', 'Deposit', 500.00, 'Mobile deposit'),
(4, 4, '2022-08-10', 'Withdrawal', -100.00, 'Online purchase'),
(5, 3, '2022-08-15', 'Deposit', 1200.00, 'Wire transfer'),
(6, 5, '2022-08-18', 'Deposit', 2500.00, 'Direct deposit salary'),
(7, 6, '2022-08-20', 'Withdrawal', -300.00, 'POS purchase'),
(8, 7, '2022-08-22', 'Deposit', 800.00, 'Check deposit'),
(9, 8, '2022-08-25', 'Withdrawal', -150.00, 'ATM withdrawal'),
(10, 9, '2022-08-30', 'Deposit', 600.00, 'Bank transfer');



Certainly! Below is a comprehensive SQL Data Analysis Project on Finance, which covers the entire process from start to finish. This project focuses on analyzing financial transactions and customer account behavior for a fictional bank.

Project: Financial Transactions Analysis
Objective:
Analyze customer transactions, identify trends, detect potential fraud, and generate insights into account balances, spending habits, and customer segmentation.

Step 1: Database Setup and Data Ingestion
First, you need to set up a relational database consisting of three main tables:

Customers – Information about each bank customer.
Accounts – Information about each customer's bank account.
Transactions – Financial transactions made by customers.
sql
Copy code
-- Create the Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    email VARCHAR(100),
    join_date DATE
);

-- Create the Accounts table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(15, 2),
    open_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create the Transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(20),
    amount DECIMAL(15, 2),
    description VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Sample data for Customers
INSERT INTO customers (customer_id, first_name, last_name, birth_date, email, join_date) VALUES
(1, 'John', 'Doe', '1985-03-20', 'john.doe@example.com', '2021-01-01'),
(2, 'Jane', 'Smith', '1990-07-15', 'jane.smith@example.com', '2021-03-15'),
(3, 'Robert', 'Brown', '1975-12-01', 'robert.brown@example.com', '2022-04-10');

-- Sample data for Accounts
INSERT INTO accounts (account_id, customer_id, account_type, balance, open_date, status) VALUES
(1, 1, 'Savings', 10000.00, '2021-01-01', 'Active'),
(2, 1, 'Checking', 500.00, '2021-01-01', 'Active'),
(3, 2, 'Savings', 15000.00, '2021-03-15', 'Active'),
(4, 3, 'Checking', 2000.00, '2022-04-10', 'Active');

-- Sample data for Transactions
INSERT INTO transactions (transaction_id, account_id, transaction_date, transaction_type, amount, description) VALUES
(1, 1, '2022-08-01', 'Deposit', 1000.00, 'Direct deposit salary'),
(2, 1, '2022-08-05', 'Withdrawal', -200.00, 'ATM withdrawal'),
(3, 2, '2022-08-07', 'Deposit', 500.00, 'Check deposit'),
(4, 3, '2022-08-10', 'Withdrawal', -100.00, 'Online purchase'),
(5, 4, '2022-08-15', 'Deposit', 1200.00, 'Bank transfer');

--Step 2: Exploratory Data Analysis (EDA)
---1. Total Deposits and Withdrawals by Account
select 
       account_id,
	   sum(case when transaction_type = 'Deposit' then amount else 0 end) as total_deposots,
	   sum(case when transaction_type = 'withdrawal' then amount else 0 end) as total_withdrawals
from transactions
group by account_id;

-- 2. Customer Balances Overview
select
      c.customer_id,
	  c.first_name,
	  c.last_name,
	  sum(a.balance) as total_balance
from customers c
join accounts a on c.customer_id = a.customer_id
group by c.customer_id, c.first_name, c.last_name;

-- Monthly Transaction Summary
select 
      extract(year from transaction_date) as year,
	  extract(month from transaction_date) as month,
	  count(*) as total_transactions,
	  sum(amount) as total_amount
from transactions
group by year, month
order by year, month;

-- Transaction Frequency by Customer
(To understand which customers are most active, we’ll calculate the number of transactions they made.)
select 
      c.customer_id,
	  c.first_name,
	  c.last_name,
	  count(t.transaction_id) as transaction_count
from customers c
join accounts a on c.customer_id = a.customer_id
join transactions t on a.account_id = t.account_id
group by c.customer_id, c.first_name, c.last_name
order by transaction_count desc;

Step 3: Advanced Data Analysis
1. Identifying High-Value Customers
select 
     c.customer_id,
	 c.first_name,
	 c.last_name,
	 sum(a.balance) as total_balance
from customers c
join accounts a on c.customer_id = a.customer_id
group by c.customer_id, c.first_name,c.last_name
order by total_balance desc
limit 10;

--Detecting Potential Fraud
select 
      t.transaction_id,
	  t.account_id,
	  t.transaction_id,
	  t.amount
from transactions t
join accounts a on t.account_id = a.account_id
where t.amount <   -1000 --Unusually large withdrawals
order by t.transaction_date desc;

-- Analyzing Account Activity Over Time
select 
      a.status,
	  extract(year from t.transaction_date) as year,
	  extract(month from t.transaction_date) as month,
	  count(t.transaction_id) as transaction_count
from transactions t
join accounts a on t.account_id = a.account_id
group by a.status, year, month
order by year, month;

--Step 4: Optimizing Query Performance
-- Create indexes to speed up joins and filtering
CREATE INDEX idx_customer_id ON accounts(customer_id);
CREATE INDEX idx_account_id ON transactions(account_id);

-- Step 5: Reporting and Visualization
Once the data is analyzed, you can create reports or visualizations using BI tools like Tableau or Power BI. Export the data or use SQL queries directly in the BI tool to create:

-- 1] Customer Balance Overview Dashboards
-- 2] Transaction Trends
-- 3] High-Value Customer Reports
-- 4] Potential Fraud Detection Alerts

-- Export data (if required)
COPY (SELECT * FROM transactions) TO '/path/to/transactions_data.csv' CSV HEADER;












