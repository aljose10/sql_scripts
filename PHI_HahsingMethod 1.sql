create database 
use monogram;


--Creating a table named info

CREATE TABLE Info (
    Username NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    City NVARCHAR(100),
    ZipCode INT,
	SSN char(9),
	HashedUsername NVARCHAR(100),
	HashedEmail NVARCHAR(100),
	HashedDOB DATE,
	HashedZip INT,
);

-- Inserting the records 

INSERT INTO Info (Username, Email, DOB, City, ZipCode,SSN)
VALUES 
    ('John', 'john.a@gmail.com', '1990-05-15', 'New York', 10001 , '123456789'),
    ('Ram', 'ram.b@gmail.com', '1985-08-20', 'Los Angeles', 90001, '987654321'),
    ('Raju', 'raju.c@yahoo.com', '1995-03-10', 'Chicago', 60601, '123498765');

--Hashing the email 

UPDATE Info
SET HashedEmail = CONCAT(
    LEFT(
        CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_256', LEFT(Email, CHARINDEX('@', Email) - 1)), 2),
        LEN(CONVERT(NVARCHAR(MAX), HASHBYTES('SHA2_256', LEFT(Email, CHARINDEX('@', Email) - 1)), 2))
    ),
    SUBSTRING(Email, CHARINDEX('@', Email), LEN(Email))
);

--Hashing the username 
UPDATE Info
SET HashedUsername = CONVERT(NVARCHAR(100), HASHBYTES('SHA2_256', Username), 2);


ALTER TABLE Info
ALTER COLUMN HashedZip VARBINARY(64);

--Hashing the zipcode 
UPDATE Info
SET HashedZip = HASHBYTES('SHA2_256', CAST(Zipcode AS VARCHAR(5)));


alter table Info
alter column HashedSSN bigint;

--Hashing the ssn 

UPDATE Info
SET HashedSSN  = CAST(CONVERT(BIGINT, HASHBYTES('SHA2_256', SSN), 1) AS BIGINT);

alter table Info 
alter column HashedDOB char(10)

--Hashing the dob in aphanumeric format 

UPDATE Info
SET HashedDOB =CONVERT(CHAR(10), HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), DOB, 120)), 2);

alter table Info 
add HashedDOBdec DECIMAL(38,0)

--Hashing the dob with numbers only

UPDATE Info
SET HashedDOBdec = CAST(CONVERT(BIGINT, HASHBYTES('SHA2_256', CONVERT(VARCHAR(10), DOB, 120)), 1) AS DECIMAL(38,0));


--Inserting the same records  again to check the hashed values for incremental loads 

INSERT INTO Info (Username, Email, DOB, City, ZipCode,SSN)
VALUES 
    ('John', 'john.a@gmail.com', '1990-05-15', 'New York', 10001 , '123456789'),
    ('Ram', 'ram.b@gmail.com', '1985-08-20', 'Los Angeles', 90001, '987654321'),
    ('Raju', 'raju.c@yahoo.com', '1995-03-10', 'Chicago', 60601, '123498765');

select * from Info order by Username;






















