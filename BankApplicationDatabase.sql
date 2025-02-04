-- Create the database
CREATE DATABASE IF NOT EXISTS BankAppDB;
USE BankAppDB;

CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
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

drop table loans;
-- Loans table
CREATE TABLE IF NOT EXISTS Loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    loan_type VARCHAR(50) NOT NULL,
    loan_amount DECIMAL(10, 2) NOT NULL,
    paid_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    interest_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    interest_rate DECIMAL(5, 2) NOT NULL,
    loan_term INT NOT NULL,
    approval_date DATE,
    paid_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);

-- Transactions table
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(50) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) 
);
-- Beneficiaries table
CREATE TABLE IF NOT EXISTS Beneficiaries (
    beneficiary_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    account_id INT,
    recipient_name VARCHAR(100) NOT NULL,
    account_number VARCHAR(50) NOT NULL,
    bank_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    foreign key (account_id) references accounts(account_id) on delete cascade
);
drop table mobiletopups;
-- Mobile Top-Ups table
CREATE TABLE IF NOT EXISTS MobileTopUps (
    topup_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    mobile_number VARCHAR(20) NOT NULL,
    topup_amount DECIMAL(10, 2) NOT NULL,
    topup_date DATEtime default current_timestamp,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE
);
drop table billno;
CREATE TABLE IF NOT EXISTS BILLNO (
    bill_no INT AUTO_INCREMENT PRIMARY KEY,
    bill_amount DECIMAL(10,2) NOT NULL,
    bill_type VARCHAR(100),
    due_date DATE,
    bill_paid BOOLEAN default false
);

-- Bills table
drop table bills;
CREATE TABLE IF NOT EXISTS Bills (
    billpaid_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_no INT NOT NULL,
    account_id INT,
    bill_type VARCHAR(50) NOT NULL,
    amount_due DECIMAL(10, 2) NOT NULL,
    due_date DATE,
    paid_date DATE,
    paid BOOLEAN DEFAULT 0,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (bill_no) REFERENCES billno(bill_no) 
);

-- Insert 10 users
INSERT INTO bankappdb.users (username, password, first_name, last_name, date_of_birth, email, phone, address)
VALUES
    ('user1', 'password1', 'Sharjeel', 'Safdar', '2004-01-15', 'sharjeelsafdar@gmail.com', '1234567890', 'Karsaz St 123'),
    ('user2', 'password2', 'Suhaib', 'Shaikh', '2004-05-15', 'suhaibshaikh@gmail.com', '9876543210', 'Tipu Sultan St 123'),
    ('user3', 'password3', 'Tulaib', 'Tauseef', '2004-09-30', 'tulaibtauseef@gmail.com', '5551112233', 'National ST St 123'),
    ('user4', 'password4', 'Adil', 'Gujjar', '1997-03-20', 'adilgujjar@gmail.com', '7778889999', 'Karsaz St 123'),
    ('user5', 'password5', 'Hamza', 'Rehman', '1998-12-10', 'hamzarehman@gmail.com', '2223334444', 'Green Town St 124'),
    ('user6', 'password6', 'Aqib', 'Rehman', '1999-07-05', 'aqibrehman@gmail.com', '9998887777', 'Green Town St 124'),
    ('user7', 'password7', 'Javeria', 'Farooq', '1995-11-25', 'javeriafarooq@gmail.com', '4445556666', 'Bahria University KHI'),
    ('user8', 'password8', 'Syeda', 'Mahnoor', '2001-04-18', 'syedamahnoor@gmail.com', '6667778888', 'Folio3 KHI'),
    ('user9', 'password9', 'Nawfal', 'Hussain', '1987-08-15', 'nawfalhussain@gmail.com', '1112223333', 'FB Area St 786'),
    ('user10', 'password10', 'Mahad', 'Baqar', '2005-06-22', 'mahadbaqar@gmail.com', '3334445555', '707 St Green TOWN');

-- Insert 10 accounts
INSERT INTO bankappdb.accounts (user_id, account_type, balance, open_date)
VALUES
    (1, 'Savings', 1000.00, '2024-01-01'),
    (2, 'Current', 500.00, '2024-02-02'),
    (3, 'Savings', 1500.00, '2024-03-03'),
    (4, 'Current', 2000.00, '2024-04-04'),
    (5, 'Savings', 800.00, '2024-05-05'),
    (6, 'Current', 1200.00, '2024-06-06'),
    (7, 'Savings', 3000.00, '2024-07-07'),
    (8, 'Current', 250.00, '2024-08-08'),
    (9, 'Savings', 1800.00, '2024-09-09'),
    (10, 'Current', 700.00, '2024-10-10');

-- Insert 10 loans
INSERT INTO bankappdb.loans (account_id, loan_type, loan_amount,paid_amount, interest_rate, loan_term, approval_date,paid_date)
VALUES
    (1, 'Home Loan', 50000.00, 0.0,5.0, 36, '2024-01-15',null),
    (2, 'Auto Loan', 20000.00,20000.0, 4.5, 24, '2024-02-15',"2024-05-05"),
    (3, 'Education Loan', 10000.00,1000.00, 3.0, 12, '2024-03-15',null),
    (4, 'Personal Loan', 3000.00, 0,6.0, 6, '2024-04-15',null),
    (5, 'Home Loan', 60000.00,0 ,5.5, 48, '2024-05-15',null),
    (6, 'Auto Loan', 18000.00, 0,4.0, 18, '2024-06-15',null),
    (7, 'Education Loan', 12000.00,0 ,3.5, 24, '2024-07-15',null),
    (8, 'Personal Loan', 5000.00, 1000.0,7.0, 12, '2024-08-15',null),
    (9, 'Home Loan', 45000.00, 45000.00,5.2, 36, '2024-09-15',"2024-10-11"),
    (10, 'Auto Loan', 22000.00, 10000.00,4.8, 24, '2024-10-15',null);
    
-- Insert 10 beneficiaries
INSERT INTO bankappdb.beneficiaries (user_id, account_id, recipient_name, account_number, bank_name)
VALUES
    (1, 1, 'Sharjeel', '987654321', 'Meezan Bank'),
    (2, 2, 'Suhaib', '123456789', 'Faysal Bank'),
    (3, 3, 'Tulaib', '555444333', 'Jazzcash Bank'),
    (4, 4, 'Adil', '111122223', 'Askari Bank'),
    (5, 5, 'Hamza', '999888777', 'HBL Bank'),
    (6, 6, 'Aqid', '666777888', 'MCB Bank'),
    (7, 7, 'Javeria', '444555666', 'ALFALAH Bank'),
    (8, 8, 'Syeda', '222333444', 'Sadapay Bank'),
    (9, 9, 'Nawfal', '888777999', 'Easypaisa Bank'),
    (10, 10, 'Mahad', '777666555', 'Nayapay Bank');


-- Insert 10 mobile top-ups
INSERT INTO bankappdb.mobiletopups (account_id, mobile_number, topup_amount, topup_date)
VALUES
    (1, '9876543210', 200.00, '2024-09-15'),
    (2, '8887776666', 150.00, '2024-09-01'),
    (3, '5554443333', 300.00, '2024-09-15'),
    (4, '1111222233', 250.00, '2024-09-01'),
    (5, '9998887777', 400.00, '2024-09-15'),
    (6, '6667778888', 500.00, '2024-09-01'),
    (7, '4445556666', 100.00, '2024-09-15'),
    (8, '2223334444', 350.00, '2024-09-01'),
    (9, '8887779999', 450.00, '2024-09-15'),
    (10, '7776665555', 180.00, '2024-09-01');
    
-- Insert 10 transactions
INSERT INTO bankappdb.transactions (account_id, transaction_type, transaction_date, amount, description)
VALUES
    (1, 'Debit', '2024-10-01', 500.00, 'Grocery shopping' ),
    (2, 'Credit', '2024-10-02', 100.00, 'Salary deposit' ),
    (3, 'Debit', '2024-10-03', 250.00, 'Dining out' ),
    (4, 'Credit', '2024-10-04', 200.00, 'Refund' ),
    (5, 'Debit', '2024-10-05', 300.00, 'Online purchase' ),
    (6, 'Credit', '2024-10-06', 800.00, 'Reimbursement' ),
    (7, 'Debit', '2024-10-07', 200.00, 'Movie tickets' ),
    (8, 'Credit', '2024-10-08', 150.00, 'Bonus' ),
    (9, 'Debit', '2024-10-09', 400.00, 'Coffee shop' ),
    (10, 'Credit', '2024-10-10', 120.00, 'Freelance payment' );
    
    -- Insert data into BILLNO table
INSERT INTO BILLNO (bill_no, bill_amount, bill_type,due_date, bill_paid) VALUES
(101, 500.00, 'Electricity','2024-12-10' ,FALSE),
(102, 300.50, 'Water','2024-12-15', FALSE),
(103, 750.75, 'Gas', '2024-12-20',FALSE),
(104, 400.25, 'Internet','2024-12-12', FALSE),
(105, 600.00, 'Rent', '2024-12-25',FALSE),
(106, 150.50, 'Phone', '2024-12-18',TRUE),
(107, 900.80, 'Insurance','2024-12-22', TRUE),
(108, 200.00, 'Groceries','2024-12-14', FALSE),
(109, 350.50, 'Clothing','2024-12-28', TRUE),
(110, 800.75, 'Medical', '2024-12-30',FALSE);

-- Insert data into Bills table
INSERT INTO Bills (bill_no, account_id, bill_type, amount_due, due_date,paid_date, paid) VALUES
(101, 1, 'Electricity', 500.00, '2024-12-10', NULL,FALSE),
(102, 2, 'Water', 300.50, '2024-12-15', NULL,FALSE),
(103, 3, 'Gas', 750.75, '2024-12-20', NULL,FALSE),
(104, 4, 'Internet', 400.25, '2024-12-12',NULL, FALSE),
(105, 5, 'Rent', 600.00, '2024-12-25',NULL, FALSE),
(106, 6, 'Phone', 150.50, '2024-12-18',CURDATE(), TRUE),
(107, 7, 'Insurance', 900.80, '2024-12-22', CURDATE(), TRUE),
(108, 8, 'Groceries', 200.00, '2024-12-14',NULL, FALSE),
(109, 9, 'Clothing', 350.50, '2024-12-28', curdate(),TRUE),
(110, 10, 'Medical', 800.75, '2024-12-30', NULL,FALSE);




drop trigger update_loan_status;
DELIMITER //
CREATE TRIGGER update_loan_status AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN 
    DECLARE remaining_loan_balance DECIMAL(10, 2);
    DECLARE excess_amount DECIMAL(10,2);
    -- Check if the transaction is related to a loan payment
    IF NEW.transaction_type = 'debit' AND LOWER(NEW.description) LIKE '%loanpayment%' THEN
        -- Calculate the remaining loan balance after a credit transaction
        SELECT ((loan_amount+interest_amount) - (NEW.amount+paid_amount)) INTO remaining_loan_balance
        FROM Loans
        WHERE account_id = NEW.account_id and paid_date is null;
        -- Check if the remaining loan balance is zero or less
        IF remaining_loan_balance <= 0 THEN
            UPDATE Loans SET paid_date = CURDATE(), paid_amount = loan_amount+interest_amount  WHERE account_id = NEW.account_id and paid_date is null;
            SET excess_amount = ABS(remaining_loan_balance);
            UPDATE Accounts SET balance = balance - remaining_loan_balance WHERE account_id = NEW.account_id;
        ELSE
            -- Update the loan amount if the loan is partially paid
            UPDATE Loans SET paid_amount = paid_amount+new.amount WHERE account_id = NEW.account_id;
        END IF;
    END IF;
END;
//
DELIMITER ;
INSERT INTO Transactions (account_id, transaction_type, amount, description, transaction_date)
	VALUES (1, 'debit', 500, 'Loanpayment', curdate());
select * from transactions;
select * from accounts;
select * from loans;
insert into bankappDB.transactions(account_id,transaction_type,transaction_date,amount,description) value (1,'credit','2023-11-11',49200,'loan');
insert into bankappDB.transactions(account_id,transaction_type,transaction_date,amount,description) value (1,'credit','2023-11-11',800,'deposit');
insert into bankappDB.transactions(account_id,transaction_type,transaction_date,amount,description) value (1,'credit','2023-11-11',800,'loan');

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
    IF NEW.transaction_type = 'credit' THEN
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
    ELSEIF NEW.transaction_type = 'debit' THEN
        IF NEW.description not LIKE '%Loan%' THEN
            -- Update account balance for a debit transaction not related to a loan
            UPDATE Accounts SET balance = balance + NEW.amount WHERE account_id = NEW.account_id;
        END IF;
    END IF;
END;
//
DELIMITER ;

insert into bankappdb.transactions(account_id,transaction_type,transaction_date,amount,description) value (3,'credit','2023-11-11',2100,'deposit');
insert into bankappdb.transactions(account_id,transaction_type,transaction_date,amount,description) value (1,'debit','2023-11-11',20000,'deposit');
insert into bankappdb.transactions(account_id,transaction_type,transaction_date,amount,description) value (1,'credit','2023-11-11',20000,'deposit');





DELIMITER //
CREATE TRIGGER update_transaction_on_topup AFTER INSERT ON mobiletopups
FOR EACH ROW
BEGIN
   insert into bankappdb.transactions(account_id,description,transaction_type,amount,transaction_date) values(new.account_id,Concat('mobile top up to ',new.mobile_number),'credit',new.topup_amount,curdate());

END;
//
DELIMITER ;

show triggers;
drop trigger update_transaction_on_topup;
select * from mobiletopups;
select * from accounts;
select * from transactions;
insert into mobiletopups(account_id,mobile_number,topup_amount)values(4,'1111222233',150);
drop procedure transfermoney;
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

    -- credit from the source account
    INSERT INTO Transactions (account_id, transaction_type, amount, description,transaction_date)
    VALUES (from_account_id, 'credit', transfer_amount, CONCAT('Transfer to Account #', to_account_id),curdate());

    -- debit to the destination account
    INSERT INTO Transactions (account_id, transaction_type, amount, description,transaction_date)
    VALUES (to_account_id, 'debit', transfer_amount, CONCAT('Transfer from Account #', from_account_id),curdate());

    -- Commit the transaction if everything is successful
    COMMIT;
END;
//
DELIMITER ;

select * from mobiletopups;
select * from accounts;
select * from transactions;
select * from mobiletopups;
call transferMoney(1,2,30);
call mobiletopup(4,1111222233,2);


-- Procedure to perform a mobile top-up
DELIMITER //
CREATE PROCEDURE MobileTopUp(
    IN account_id INT,
    IN mobile_number VARCHAR(20),
    IN topup_amount DECIMAL(10, 2)
)
BEGIN
    -- Insert the mobile top-up details
    INSERT INTO MobileTopUps (account_id, mobile_number, topup_amount,topup_date)
    VALUES (account_id, mobile_number, topup_amount,curdate());

    -- Display a message or take additional actions as needed
    SELECT 'Mobile top-up successful' AS Message;
END;
//
DELIMITER ;

drop procedure mobiletopup;
select * from accounts;
call paybill(5,5);


call addbeneficiary('10', '10', 'Mahad', '777666555', 'Nayapay Bank');
drop procedure addbeneficiary;
-- Procedure to add a beneficiary
DELIMITER //
CREATE PROCEDURE AddBeneficiary(
    IN user_id INT,
    IN accountid INT,
    IN recipient_name VARCHAR(100),
    IN acc_number VARCHAR(50),
    IN bank_name VARCHAR(100)
)
BEGIN
declare acc_no varchar(50);
	if not exists(select 1 from beneficiaries where account_number=acc_number and account_id = accountid) then
		-- Insert the beneficiary details
		INSERT INTO Beneficiaries (user_id, account_id, recipient_name, account_number, bank_name)
		VALUES (user_id, accountid, recipient_name, acc_number, bank_name);

		-- Display a message or take additional actions as needed
		SELECT 'Beneficiary added successfully' AS Message;
	else
		select 'beneficiary already exists.' as message;
	end if;
END;
//
DELIMITER ;
use bankappdb;
SELECT calculateloaninterest(100, 10,2);
DELIMITER //
CREATE FUNCTION CalculateLoanInterest(loan_amount DECIMAL(10, 2), interest_rate DECIMAL(5, 2), loan_term INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE interest DECIMAL(10, 2);
    SET interest = (loan_amount * interest_rate * loan_term) / (12 * 100);
    RETURN interest;
END;
//



DELIMITER //
CREATE FUNCTION GetAccountBalance(f_account_id INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE f_balance DECIMAL(10, 2);
    SELECT balance INTO f_balance FROM Accounts WHERE Accounts.account_id = f_account_id;
    RETURN f_balance;
END;
//
DELIMITER ;


drop function getaccountbalance;
select getaccountbalance(1);


call addloan(1,'sdf',4,5,3);
drop procedure addloan;
DELIMITER //

CREATE FUNCTION CheckLoanEligibility(accountIdParam INT) RETURNS BOOLEAN
deterministic
BEGIN
    DECLARE loanExists BOOLEAN;

    -- Check if the account exists
    SELECT COUNT(*) INTO loanExists FROM Loans WHERE account_id = accountIdParam;

    IF loanExists THEN
        -- Check if the last loan's paid_date is not null
        IF (SELECT paid_date FROM Loans 
            WHERE account_id = accountIdParam 
            ORDER BY loan_id DESC 
            LIMIT 1) IS NOT NULL THEN
            RETURN TRUE; -- Last loan exists and paid
        ELSE
            RETURN FALSE;  -- Last loan exists but not paid
        END IF;
    ELSE
        RETURN TRUE;      -- Account doesn't exist, eligible for a new loan
    END IF;
END //

drop function checkLoanEligibility;

select checkLoanEligibility(2) as isEligible;

DELIMITER //

CREATE PROCEDURE ApplyForLoan(
    IN accountIdParam INT,
    IN loanTypeParam VARCHAR(50),
    IN loanAmountParam DECIMAL(10, 2),
    IN interestRateParam DECIMAL(5, 2),
    IN loanTermParam INT
)
BEGIN
    DECLARE currentDate DATE;
    
    -- Get the current date
    SET currentDate = CURDATE();

    -- Insert into Loans table
    INSERT INTO Loans (account_id, loan_type, loan_amount, interest_rate, loan_term, approval_date)
    VALUES (accountIdParam, loanTypeParam, loanAmountParam, interestRateParam, loanTermParam, currentDate);

    -- Insert into Transactions table
    INSERT INTO Transactions (account_id, transaction_type, amount, description, transaction_date)
	VALUES (accountIdParam, 'debit', loanAmountParam, 'Loan', currentDate);
    
    update accounts set balance = balance+loanAmountParam where account_id = accountIdParam;

END //

DELIMITER ;

call applyforloan(2,"house",1000,2.6,36);

INSERT INTO Transactions (account_id, transaction_type, amount, description, transaction_date)
	VALUES (2, 'debit', 500, 'Loanpayment', curdate());

show triggers;

drop trigger after_insert_loan;
DELIMITER //
CREATE TRIGGER before_insert_loan BEFORE INSERT ON Loans
FOR EACH ROW
BEGIN
    -- Calculate interest_amount using the CalculateLoanInterest function
    SET NEW.interest_amount = CalculateLoanInterest(NEW.loan_amount, NEW.interest_rate, NEW.loan_term);
END;
//
DELIMITER ;

INSERT INTO Transactions (account_id, transaction_type, amount, description, transaction_date)
	VALUES (10, 'debit', 14122, 'Loanpayment', curdate());

INSERT INTO bankappdb.loans (account_id, loan_type, loan_amount, interest_rate, loan_term, approval_date) VALUE (10,"CAR",10000,5,12,CURDATE());
INSERT INTO Transactions (account_id, transaction_type, amount, description, transaction_date)
	VALUES (10, 'debit', 12000, 'Loanpayment', curdate());
    
DELIMITER //

CREATE PROCEDURE InsertTransaction(
    IN p_account_id INT,
    IN p_transaction_type VARCHAR(10),
    IN p_amount DECIMAL(10, 2),
    IN p_description VARCHAR(255)
)
BEGIN
    INSERT INTO Transactions (account_id, transaction_type, amount, description, transaction_date)
    VALUES (p_account_id, p_transaction_type, p_amount, p_description, curdate());
END;
//

DELIMITER ;

DELIMITER //

-- Create a function that checks if a beneficiary with the given account_number exists
CREATE FUNCTION BeneficiaryExists(accountNumber VARCHAR(50) , accountid INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE existsCount INT;

    -- Count the number of records with the given account_number
    SELECT COUNT(*) INTO existsCount
    FROM Beneficiaries
    WHERE account_number = accountNumber and account_id = accountid;

    -- Return true if at least one record exists, otherwise return false
    RETURN existsCount > 0;
END;

//
-- Create a procedure to delete a beneficiary based on account number

DELIMITER //

CREATE PROCEDURE DeleteBeneficiary(IN accountNumberToDelete VARCHAR(50) , IN accountid INT)
BEGIN
    -- Delete the beneficiary with the specified account_number
    delete from beneficiaries where account_number = accountNumberToDelete and account_id = accountid  LIMIT 1;
END //

DELIMITER //

CREATE FUNCTION CheckBillNoExists(p_bill_no INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE bill_exists BOOLEAN;

    -- Check if the bill_no exists in the BILLNO table
    SELECT EXISTS(SELECT 1 FROM BILLNO WHERE bill_no = p_bill_no) INTO bill_exists;

    -- Return the result
    RETURN bill_exists;
END //

DELIMITER ;
select checkBillNoExists(106);

DELIMITER //

CREATE FUNCTION CheckBillPaid(p_bill_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE is_paid BOOLEAN;

    -- Check if the bill is paid
    SELECT paid INTO is_paid FROM Bills WHERE bill_no = p_bill_id;

    -- Return the result
    RETURN is_paid;
END //

DELIMITER ;
select checkbillpaid(106);

DELIMITER //

CREATE FUNCTION CheckDueDatePassed(p_bill_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE is_due_date_passed BOOLEAN;

    -- Check if the due date has passed
    SELECT CASE WHEN due_date < CURRENT_DATE THEN TRUE ELSE FALSE END INTO is_due_date_passed
    FROM Bills
    WHERE bill_no = p_bill_id;

    -- Return the result
    RETURN is_due_date_passed;
END //

DELIMITER ;


select checkduedatepassed(102);
drop procedure paybillbybillno;
DELIMITER //

CREATE PROCEDURE PayBillByBillNo(
    IN p_bill_no INT,
    IN p_account_id INT,
    IN amount DECIMAL(10,2)
)
BEGIN
	DECLARE p_DUE_DATE DATE;
    DECLARE p_bill_amount DECIMAL(10, 2);
    DECLARE p_bill_type VARCHAR(100);

    -- Retrieve bill information from BILLNO table
    SELECT bill_amount, bill_type,due_date
    INTO p_bill_amount, p_bill_type,p_DUE_DATE
    FROM BILLNO
    WHERE bill_no = p_bill_no;

    -- Update bill_paid status in BILLNO table
    UPDATE BILLNO SET bill_paid = TRUE WHERE bill_no = p_bill_no;

    -- Insert data into Bills table
    INSERT INTO Bills (bill_no, account_id, bill_type, amount_due, due_date,paid_date, paid)
    VALUES (p_bill_no, p_account_id, p_bill_type, p_bill_amount, P_DUE_DATE,CURDATE(), TRUE);

    -- Insert data into transactions table
    INSERT INTO transactions (account_id, transaction_type, amount, transaction_date,description)
    VALUES (p_account_id, 'credit', p_bill_amount, curdate() ,CONCAT('Bill payment for bill_no: ', p_bill_no));

    -- Display a message or take additional actions as needed
    SELECT 'Bill paid successfully' AS Message;
END //

DELIMITER ;
call paybillbybillno(101,1,500);
DELIMITER //

CREATE FUNCTION GetBillAmount(p_bill_no INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE p_bill_amount DECIMAL(10, 2);

    -- Retrieve the bill amount for the given bill_id
    SELECT bill_amount INTO p_bill_amount FROM billno WHERE bill_no = p_bill_no;

    -- Return the bill amount
    RETURN p_bill_amount;
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION ISUSEREXIST(P_USERNAME VARCHAR(150))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE countuser INT;
    SELECT count(*) INTO countuser FROM USERS WHERE USERNAME = P_USERNAME;
    RETURN countuser > 0;
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION ISEmail(p_email VARCHAR(150))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE countuser INT;
    SELECT count(*) INTO countuser FROM USERS WHERE email = p_email;
    RETURN countuser > 0;
END //

DELIMITER ;
drop procedure cr_account;
DELIMITER //
create procedure cr_account (
	in user_id int,
    in acc_type varchar(100),
    in n_balance Decimal(10,2)
    )
    Begin
    insert into accounts (user_id,account_type,balance,open_date) values (user_id,acc_type,n_balance,Curdate());
    end//
DELIMITER ;

DELIMITER //

create procedure cr_user(
in n_username varchar(100),
in n_password varchar(100),
in n_firstname varchar(100),
in n_lastname varchar(100),
in n_date DATE,
in n_email varchar(100),
in n_phone varchar(100),
in n_address varchar(100))
begin

insert into users (username,password,first_name,last_name,date_of_birth,email,phone,address) values (n_username,n_password,n_firstname,n_lastname,n_date,n_email,n_phone,n_address);

end //
DELIMITER ;


Select getbillamount(101);
drop function CHECKDUEDATEPASSED;
drop procedure DeleteBeneficiary;
call InsertTransaction(10,"debit",90,"Cash Deposit");
call InsertTransaction(10,"debit",1000,"Cash Deposit");
call applyforloan(10,"house",10000,5,60);
call InsertTransaction(10,"debit",2000,"Loanpayment");
show triggers;
call InsertTransaction(10,"credit",300,"Cash Withdraw");
call InsertTransaction(10,"debit",90,"Cash Deposit");
call addbeneficiary(10, 10, 'Mahad', '777666555', 'Nayapay Bank');
select beneficiaryExists("111122223",10);
call DeleteBeneficiary("73776665533",10);
call bankappdb.ApplyForLoan(10, 'Car', 5000, 2, 12);
show triggers;