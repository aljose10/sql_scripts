create database encryptiontest;
use encryptiontest;

Create master key encryption by password = 'login@123';

Create certificate Geopits with subject = 'Encryptioncertificate';

Create symmetric key Encryption_key With

Algorithm = AES_256

Encryption by certificate geopits


CREATE TABLE Employee (
    Username NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    City NVARCHAR(100),
    ZipCode INT,
);

INSERT INTO Employee (Username, Email, DOB, City, ZipCode)
VALUES 
    ('John', 'john.a@gmail.com', '1990-05-15', 'New York', 10001),
    ('Ram', 'ram.b@gmail.com', '1985-08-20', 'Los Angeles', 90001),
    ('Raju', 'raju.c@yahoo.com', '1995-03-10', 'Chicago', 60601);

select * from Employee;


ALTER TABLE Employee
ADD EncryptedName varbinary(max);

select * from sys.openkeys

-- Open the symmetric key for decryption
OPEN SYMMETRIC KEY Encryption_key
DECRYPTION BY CERTIFICATE Geopits;


-- Close the symmetric key
CLOSE SYMMETRIC KEY Encryption_key;

UPDATE Employee
SET EncryptedName = LEFT(CONVERT(NVARCHAR(MAX), ENCRYPTBYKEY(KEY_GUID('Encryption_key'), Username)), 8);



UPDATE Employee
SET EncryptedName = (CONVERT(NVARCHAR(MAX), ENCRYPTBYKEY(KEY_GUID('Encryption_key'), Username)),8);
UPDATE Employee
SET EncryptedName = Encryptbykey(key_GUID('Encryption_key'),Username);

ALTER TABLE Employee
DROP COLUMN EncryptedName;