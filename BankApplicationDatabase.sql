-- Create the database
CREATE DATABASE IF NOT EXISTS BankApplicationDB;
USE BankApplicationDB;

CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- Accounts table
CREATE TABLE IF NOT EXISTS Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    account_type VARCHAR(50) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0,
    open_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Loan table
drop table loans;
CREATE TABLE IF NOT EXISTS Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    loan_type VARCHAR(50) NOT NULL,
    loan_amount DECIMAL(10, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    loan_term INT NOT NULL,
    approval_date DATE,
    paid_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Transactions table
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    user_id INT,
    category_id INT,
    transaction_type VARCHAR(50) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ,
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
);

-- Bills table
CREATE TABLE IF NOT EXISTS Bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    bill_type VARCHAR(50) NOT NULL,
    amount_due DECIMAL(10, 2) NOT NULL,
    due_date DATE,
    paid BOOLEAN DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Beneficiaries table
CREATE TABLE IF NOT EXISTS Beneficiaries (
    beneficiary_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    recipient_name VARCHAR(100) NOT NULL,
    account_number VARCHAR(50) NOT NULL,
    bank_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Mobile Top-Ups table
CREATE TABLE IF NOT EXISTS MobileTopUps (
    topup_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    mobile_number VARCHAR(20) NOT NULL,
    topup_amount DECIMAL(10, 2) NOT NULL,
    topup_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

DELIMITER ;
-- Procedure to transfer money between accounts
DELIMITER //
CREATE PROCEDURE TransferMoney(
    IN from_account_id INT,
    IN to_account_id INT,
    IN transfer_amount DECIMAL(10, 2)
)
BEGIN
    -- Start a transaction
    START TRANSACTION;

    -- Debit from the source account
    INSERT INTO Transactions (account_id, transaction_type, amount, description)
    VALUES (from_account_id, 'debit', transfer_amount, CONCAT('Transfer to Account #', to_account_id));

    -- Credit to the destination account
    INSERT INTO Transactions (account_id, transaction_type, amount, description)
    VALUES (to_account_id, 'credit', transfer_amount, CONCAT('Transfer from Account #', from_account_id));

    -- Update triggers to handle the transactions
    CALL update_account_balance();

    -- Commit the transaction if everything is successful
    COMMIT;
END;
//
DELIMITER ;


-- Procedure to perform a mobile top-up
DELIMITER //
CREATE PROCEDURE MobileTopUp(
    IN user_id INT,
    IN mobile_number VARCHAR(20),
    IN topup_amount DECIMAL(10, 2)
)
BEGIN
    -- Insert the mobile top-up details
    INSERT INTO MobileTopUps (user_id, mobile_number, topup_amount, topup_date)
    VALUES (user_id, mobile_number, topup_amount, NULL);

    -- Display a message or take additional actions as needed
    SELECT 'Mobile top-up successful' AS Message;
END;
//
DELIMITER ;


-- Procedure to add a loan
DELIMITER //
CREATE PROCEDURE AddLoan(
    IN user_id INT,
    IN loan_type VARCHAR(50),
    IN loan_amount DECIMAL(10, 2),
    IN interest_rate DECIMAL(5, 2),
    IN loan_term INT
)
BEGIN
    -- Insert the loan details
    INSERT INTO Loans (user_id, loan_type, loan_amount, interest_rate, loan_term, approval_date)
    VALUES (user_id, loan_type, loan_amount, interest_rate, loan_term, NULL);

    -- Display a message or take additional actions as needed
    SELECT 'Loan application submitted successfully' AS Message;
END;
//
DELIMITER ;

-- Procedure to pay a bill
DELIMITER //
CREATE PROCEDURE PayBill(
    IN p_user_id INT,
    IN p_bill_id INT
)
BEGIN
    -- Update the bill status to paid
    UPDATE Bills SET paid = 1 WHERE user_id = p_user_id AND bill_id = p_bill_id;

    -- Display a message or take additional actions as needed
    SELECT 'Bill paid successfully' AS Message;
END;
//
DELIMITER ;



-- Procedure to add a beneficiary
DELIMITER //
CREATE PROCEDURE AddBeneficiary(
    IN user_id INT,
    IN recipient_name VARCHAR(100),
    IN account_number VARCHAR(50),
    IN bank_name VARCHAR(100)
)
BEGIN
    -- Insert the beneficiary details
    INSERT INTO Beneficiaries (user_id, recipient_name, account_number, bank_name)
    VALUES (user_id, recipient_name, account_number, bank_name);

    -- Display a message or take additional actions as needed
    SELECT 'Beneficiary added successfully' AS Message;
END;
//
DELIMITER ;

-- Procedure to add a transaction
DELIMITER //
CREATE PROCEDURE AddTransaction(
    IN account_id INT,
    IN transaction_type VARCHAR(50),
    IN amount DECIMAL(10, 2),
    IN description VARCHAR(255)
)
BEGIN
    -- Insert the transaction details
    INSERT INTO Transactions (account_id, transaction_type, amount, description)
    VALUES (account_id, transaction_type, amount, description);

    -- Display a message or take additional actions as needed
    SELECT 'Transaction added successfully' AS Message;
END;
//
DELIMITER ;

-- Procedure to update account balance for various transactions
DELIMITER //
CREATE PROCEDURE UpdateAccountBalance(
    IN p_user_id INT,
    IN p_transaction_type VARCHAR(50),
    IN p_transaction_id INT
)
BEGIN
    DECLARE transaction_amount DECIMAL(10, 2);

    -- Determine transaction amount based on transaction type
    IF p_transaction_type = 'MobileTopUp' THEN
        SELECT topup_amount INTO transaction_amount FROM MobileTopUps WHERE topup_id = p_transaction_id;
    ELSEIF p_transaction_type = 'BillPayment' THEN
        SELECT amount_due INTO transaction_amount FROM Bills WHERE bill_id = p_transaction_id;
    ELSEIF p_transaction_type = 'LoanPayment' THEN
        SELECT amount INTO transaction_amount FROM Transactions WHERE transaction_id = p_transaction_id;
    ELSE
        -- Add more conditions as needed for other transaction types
        -- If a new transaction type is added, update this procedure accordingly
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid transaction type';
        
	-- Exit the procedure if an invalid transaction type is provided
    END IF;

    -- Check if the transaction ID exists
    IF transaction_amount IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid transaction ID';
         -- Exit the procedure if the transaction ID is invalid
    END IF;

    -- Update the account balance
    UPDATE Accounts SET balance = balance - transaction_amount WHERE user_id = p_user_id;

    -- Display a message or take additional actions as needed
    SELECT 'Account balance updated successfully' AS Message;
END;
//
DELIMITER ;
SET GLOBAL LOG_BIN_TRUST_FUNCTION_CREATORS =1;
DELIMITER //
CREATE FUNCTION CalculateLoanInterest(loan_amount DECIMAL(10, 2), interest_rate DECIMAL(5, 2), loan_term INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE interest DECIMAL(10, 2);
    SET interest = (loan_amount * interest_rate * loan_term) / (12 * 100);
    RETURN interest;
END;
//
DELIMITER //
CREATE FUNCTION GetAccountBalance(account_id INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE balance DECIMAL(10, 2);
    SELECT balance INTO balance FROM Accounts WHERE Accounts.account_id = account_id;
    RETURN balance;
END;
//
DELIMITER ;



-- Insert 10 users
INSERT INTO bankapplicationdb.users (username, password_hash, first_name, last_name, date_of_birth, email, phone, address)
VALUES
    ('user1', 'hashed_password1', 'John', 'Doe', '1990-01-01', 'john.doe@example.com', '1234567890', '123 Main St'),
    ('user2', 'hashed_password2', 'Alice', 'Smith', '1985-05-15', 'alice.smith@example.com', '9876543210', '456 Oak St'),
    ('user3', 'hashed_password3', 'Bob', 'Johnson', '1980-09-30', 'bob.johnson@example.com', '5551112233', '789 Pine St'),
    ('user4', 'hashed_password4', 'Eva', 'Brown', '1992-03-20', 'eva.brown@example.com', '7778889999', '101 Elm St'),
    ('user5', 'hashed_password5', 'David', 'Williams', '1988-12-10', 'david.williams@example.com', '2223334444', '202 Maple St'),
    ('user6', 'hashed_password6', 'Sophie', 'Davis', '1995-07-05', 'sophie.davis@example.com', '9998887777', '303 Birch St'),
    ('user7', 'hashed_password7', 'Michael', 'Miller', '1983-11-25', 'michael.miller@example.com', '4445556666', '404 Oak St'),
    ('user8', 'hashed_password8', 'Olivia', 'Jones', '1998-04-18', 'olivia.jones@example.com', '6667778888', '505 Pine St'),
    ('user9', 'hashed_password9', 'Daniel', 'Wilson', '1987-08-15', 'daniel.wilson@example.com', '1112223333', '606 Elm St'),
    ('user10', 'hashed_password10', 'Sophia', 'Taylor', '1993-06-22', 'sophia.taylor@example.com', '3334445555', '707 Maple St');

-- Insert 10 accounts
INSERT INTO bankapplicationdb.accounts (user_id, account_type, balance, open_date)
VALUES
    (1, 'Savings', 1000.00, '2023-01-01'),
    (2, 'Checking', 500.00, '2023-02-01'),
    (3, 'Savings', 1500.00, '2023-03-01'),
    (4, 'Checking', 2000.00, '2023-04-01'),
    (5, 'Savings', 800.00, '2023-05-01'),
    (6, 'Checking', 1200.00, '2023-06-01'),
    (7, 'Savings', 3000.00, '2023-07-01'),
    (8, 'Checking', 250.00, '2023-08-01'),
    (9, 'Savings', 1800.00, '2023-09-01'),
    (10, 'Checking', 700.00, '2023-10-01');

-- Insert 10 loans
INSERT INTO bankapplicationdb.loans (user_id, loan_type, loan_amount, interest_rate, loan_term, approval_date,paid_date)
VALUES
    (1, 'Home Loan', 50000.00, 5.0, 36, '2023-01-15',null),
    (2, 'Auto Loan', 20000.00, 4.5, 24, '2023-02-15',"2023-05-05"),
    (3, 'Education Loan', 10000.00, 3.0, 12, '2023-03-15',null),
    (4, 'Personal Loan', 3000.00, 6.0, 6, '2023-04-15',null),
    (5, 'Home Loan', 60000.00, 5.5, 48, '2023-05-15',null),
    (6, 'Auto Loan', 18000.00, 4.0, 18, '2023-06-15',null),
    (7, 'Education Loan', 12000.00, 3.5, 24, '2023-07-15',null),
    (8, 'Personal Loan', 5000.00, 7.0, 12, '2023-08-15',null),
    (9, 'Home Loan', 45000.00, 5.2, 36, '2023-09-15',"2023-10-11"),
    (10, 'Auto Loan', 22000.00, 4.8, 24, '2023-10-15',null);
    
-- Insert 10 bills
INSERT INTO bankapplicationdb.bills (user_id, bill_type, amount_due, due_date, paid)
VALUES
    (1, 'Electricity', 80.00, '2023-02-01', 0),
    (2, 'Water', 30.00, '2023-02-15', 0),
    (3, 'Internet', 50.00, '2023-03-01', 0),
    (4, 'Phone', 25.00, '2023-03-15', 0),
    (5, 'Gas', 40.00, '2023-04-01', 0),
    (6, 'Rent', 800.00, '2023-04-15', 0),
    (7, 'Insurance', 120.00, '2023-05-01', 0),
    (8, 'Credit Card', 70.00, '2023-05-15', 0),
    (9, 'Medical', 60.00, '2023-06-01', 0),
    (10, 'Subscription', 15.00, '2023-06-15', 0);

-- Insert 10 beneficiaries
INSERT INTO bankapplicationdb.beneficiaries (user_id, recipient_name, account_number, bank_name)
VALUES
    (1, 'Alice', '987654321', 'XYZ Bank'),
    (2, 'Bob', '123456789', 'ABC Bank'),
    (3, 'Eva', '555444333', 'PQR Bank'),
    (4, 'David', '111122223', 'LMN Bank'),
    (5, 'Sophie', '999888777', 'DEF Bank'),
    (6, 'Michael', '666777888', 'GHI Bank'),
    (7, 'Olivia', '444555666', 'JKL Bank'),
    (8, 'Daniel', '222333444', 'MNO Bank'),
    (9, 'Sophia', '888777999', 'UVW Bank'),
    (10, 'Chris', '777666555', 'RST Bank');

-- Insert 10 mobile top-ups
INSERT INTO bankapplicationdb.mobiletopups (topup_id, mobile_number, topup_amount, topup_date)
VALUES
    (1, '9876543210', 20.00, '2023-02-15'),
    (2, '8887776666', 15.00, '2023-03-01'),
    (3, '5554443333', 30.00, '2023-03-15'),
    (4, '1111222233', 25.00, '2023-04-01'),
    (5, '9998887777', 40.00, '2023-04-15'),
    (6, '6667778888', 50.00, '2023-05-01'),
    (7, '4445556666', 10.00, '2023-05-15'),
    (8, '2223334444', 35.00, '2023-06-01'),
    (9, '8887779999', 45.00, '2023-06-15'),
    (10, '7776665555', 18.00, '2023-07-01');
    
-- Insert 10 transactions
INSERT INTO bankapplicationdb.transactions (account_id, transaction_type, transaction_date, amount, description,user_id)
VALUES
    (1, 'debit', '2023-02-01', 50.00, 'Grocery shopping',1),
    (2, 'credit', '2023-02-02', 100.00, 'Salary deposit',1),
    (3, 'debit', '2023-02-03', 25.00, 'Dining out',2),
    (4, 'credit', '2023-02-04', 200.00, 'Refund',2),
    (5, 'debit', '2023-02-05', 30.00, 'Online purchase',3),
    (6, 'credit', '2023-02-06', 80.00, 'Reimbursement',3),
    (7, 'debit', '2023-02-07', 20.00, 'Movie tickets',4),
    (8, 'credit', '2023-02-08', 150.00, 'Bonus',4),
    (9, 'debit', '2023-02-09', 40.00, 'Coffee shop',5),
    (10, 'credit', '2023-02-10', 120.00, 'Freelance payment',5);


CALL AddLoan(1, 'Car Loan', 15000.00, 4.5, 36);
CALL PayBill(1, 1);
CALL MobileTopUp(2, '9876543210', 20.00);

-- Example of a Mobile Top-Up transaction
CALL UpdateAccountBalance(1, 'MobileTopUp', 11);

-- Verify the updated account balance
SELECT user_id, balance FROM Accounts WHERE user_id = 1;

drop trigger update_loan_status;
DELIMITER //
CREATE TRIGGER update_loan_status AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN 
    DECLARE remaining_loan_balance DECIMAL(10, 2);
    DECLARE excess_amount DECIMAL(10,2);
    -- Check if the transaction is related to a loan payment
    IF NEW.transaction_type = 'credit' AND LOWER(NEW.description) LIKE '%loan%' THEN
        -- Calculate the remaining loan balance after a credit transaction
        SELECT (loan_amount - NEW.amount) INTO remaining_loan_balance
        FROM Loans
        WHERE user_id = NEW.user_id;
        -- Check if the remaining loan balance is zero or less
        IF remaining_loan_balance <= 0 THEN
            UPDATE Loans SET paid_date = CURDATE(), loan_amount = 0 WHERE user_id = NEW.user_id;
            SET excess_amount = ABS(remaining_loan_balance);
            UPDATE Accounts SET balance = balance - remaining_loan_balance WHERE user_id = NEW.user_id;
        ELSE
            -- Update the loan amount if the loan is partially paid
            UPDATE Loans SET loan_amount = remaining_loan_balance WHERE user_id = NEW.user_id;
        END IF;
    END IF;
END;
//
DELIMITER ;


insert into bankapplicationdb.transactions(account_id,transaction_type,transaction_date,amount,description,user_id) value (1,'credit','2023-11-11',800,'loan',1);
insert into bankapplicationdb.transactions(account_id,transaction_type,transaction_date,amount,description,user_id) value (1,'credit','2023-11-11',800,'deposit',1);
insert into bankapplicationdb.transactions(account_id,transaction_type,transaction_date,amount,description,user_id) value (1,'debit','2023-11-11',800,'mobile',1);

SHOW TRIGGERS;
drop trigger update_account_balance;
DELIMITER //
CREATE TRIGGER update_account_balance AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE current_balance DECIMAL(10, 2);
    DECLARE remaining_loan_balance DECIMAL(10, 2);
    DECLARE excess_amount DECIMAL(10, 2);

    -- Check if the transaction is a debit or credit
    IF NEW.transaction_type = 'debit' THEN
        -- Check for sufficient funds before debit transaction
        SELECT balance INTO current_balance FROM Accounts WHERE account_id = NEW.account_id;
        IF current_balance < NEW.amount THEN
            -- Signal an exception if there are insufficient funds
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient funds for the transaction';
        ELSE
            -- Update account balance for successful debit transaction
            UPDATE Accounts SET balance = balance - NEW.amount WHERE account_id = NEW.account_id;
        END IF;
    ELSEIF NEW.transaction_type = 'credit' THEN
        IF NEW.description not LIKE '%Loan%' THEN
            -- Update account balance for a credit transaction not related to a loan
            UPDATE Accounts SET balance = balance + NEW.amount WHERE account_id = NEW.account_id;
        END IF;
    END IF;
END;
//
DELIMITER ;

insert into bankapplicationdb.transactions(account_id,transaction_type,transaction_date,amount,description,user_id) value (1,'credit','2023-11-11',55000accounts,'loan',1);
insert into bankapplicationdb.transactions(account_id,transaction_type,transaction_date,amount,description,user_id) value (1,'debit','2023-11-11',20000,'deposit',1);
insert into bankapplicationdb.transactions(account_id,transaction_type,transaction_date,amount,description,user_id) value (1,'credit','2023-11-11',20000,'deposit',1);
