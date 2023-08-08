/*Creating Table*/
CREATE TABLE Ministries (
ministry_ID INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);

CREATE TABLE Facilities (
facility_ID INT PRIMARY KEY AUTO_INCREMENT,
ministry_ID INT,
name VARCHAR(50),
address VARCHAR(50), 
city VARCHAR(50),
phone VARCHAR(50),
postalCode VARCHAR(50),
province VARCHAR(50),
capacity INT,
webAddress VARCHAR(50),
facilityType VARCHAR(50), 
subType VARCHAR(50),
FOREIGN KEY (ministry_ID) REFERENCES Ministries(ministry_ID)
);

CREATE TABLE Citizens (
medicareNumber INT PRIMARY KEY,
expiryDate DATE,
firstName VARCHAR(50),
lastName VARCHAR(50),
birthDate DATE,
citizenship VARCHAR(50),
email VARCHAR(50),
province VARCHAR(50),
phone VARCHAR(50),
city VARCHAR(50),
zip VARCHAR(50), 
address VARCHAR(50) 
);

CREATE TABLE Vaccines (
    vaccineID INT PRIMARY KEY,
    type VARCHAR(50)
);

CREATE TABLE Infections (
    infectionID INT PRIMARY KEY,
    type VARCHAR(50)
);

CREATE TABLE InfectedBy ( 
    infectionInstanceID INT PRIMARY KEY AUTO_INCREMENT,
    medicareNumber INT,
    infectionID INT,
    dateInfected DATE,
    FOREIGN KEY (medicareNumber) REFERENCES Citizens(medicareNumber),
    FOREIGN KEY (infectionID) REFERENCES Infections(infectionID)
);


CREATE TABLE Students (
    medicareNumber INT PRIMARY KEY,
    studentID INT UNIQUE,
    facility_ID INT,
    grade VARCHAR(255),
    FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID),
    FOREIGN KEY (medicareNumber) REFERENCES Citizens(medicareNumber)
);

Create Table Employees (
medicareNumber INT PRIMARY KEY,
employee_ID INT UNIQUE,
role VARCHAR(250),
specialization VARCHAR(250),
additionalRole VARCHAR(250),
FOREIGN KEY (medicareNumber) REFERENCES Citizens(medicareNumber)
);

CREATE TABLE EmployeeSchedule (
schedule_ID INT PRIMARY KEY AUTO_INCREMENT,
employee_ID INT,
facility_ID INT,
task VARCHAR(250),
startTime DATETIME,
endTime DATETIME,
FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID),
FOREIGN KEY (employee_ID) REFERENCES Employees(employee_ID),
CHECK (startTime < endTime)
);

CREATE TABLE Email (
email_ID INT PRIMARY KEY AUTO_INCREMENT,
date DATE,
facility_ID INT,
employee_ID INT,
subject VARCHAR(255),
body TEXT,
FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID),
FOREIGN KEY (employee_ID) REFERENCES Employees(employee_ID)
);

CREATE TABLE LogEmail (
email_ID INT PRIMARY KEY AUTO_INCREMENT,
date DATE,
facility_ID INT,
employee_ID INT,
subject VARCHAR(80),
body VARCHAR(80),
FOREIGN KEY (facility_ID) REFERENCES Facilities(facility_ID),
FOREIGN KEY (employee_ID) REFERENCES Employees(employee_ID)
);

Create Table TookVaccine ( 
vaccineInstanceID INT PRIMARY KEY AUTO_INCREMENT,
doseNumber INT,
vaccineID INT, 
vaccinationDate DATE, 
medicareNumber INT,
FOREIGN KEY (medicareNumber) REFERENCES Citizens(medicareNumber),
FOREIGN KEY (vaccineID) REFERENCES Vaccines(vaccineID)
);

/*Atler tables(When modifications are needed*/
/*
DROP TABLE EmployeeSchedule;
DROP TABLE Email;
DROP TABLE logEmail;
DROP TABLE Employees;
DROP TABLE Students;
DROP TABLE Facilities;
DROP TABLE InfectedBy;
DROP TABLE TookVaccine;
DROP TABLE Vaccines;
DROP TABLE Infections;
DROP TABLE Citizens;
DROP TABLE Ministries;
DROP TRIGGER IF EXISTS when_teacher_infected;
DROP PROCEDURE IF EXISTS emailPrincipal;
DROP PROCEDURE IF EXISTS cancelAssignments;
DROP EVENT IF EXISTS sunday_schedule;
DROP TRIGGER IF EXISTS  when_conflicting_schedule;
*/
/*Inserting rows*/
INSERT INTO Ministries(name) 
VALUES 
    ('Ministry of Education'),
	('Ministry of Health'),
	('Ministry of Social Services'),
	('Ministry of Finance'),
	('Ministry of Transportation'),
	('Ministry of Environment'),
	('Ministry of Agriculture'),
	('Ministry of Energy'),
	('Ministry of Tourism'),
	('Ministry of Culture');

INSERT INTO Facilities (ministry_ID, name, address, city, phone, postalCode, province, capacity, webAddress, facilityType, subType)
VALUES 
	(1, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(1, 'Rosemont', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(1, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(2, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(2, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(2, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(3, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(3, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(3, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
        
	(4, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(4, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(4, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(5, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(5, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(5, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(6, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(6, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(6, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(7, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(7, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(7, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(8, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(8, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(8, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(9, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(9, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(9, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
	(10, 'NotreDame', '123 Main Street', 'Montreal', '555-123-4567', 'A1B 2C3', 'Quebec', 1000, 'www.notredame.com', 'Management', 'Head office'),
	(10, 'Pointe Olivier', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'Primary'),
	(10, 'Beaulieu', '1234 Main Street', 'Montreal', '555-153-4567', 'A1B 2C3', 'Quebec', 200, 'www.pointeolivier.com', 'Education', 'secondary'),
    
    (2, 'Rosemont Elementary School', '123 Maple St.', 'Laval', '514-111-1111', 'H2X 3Y4', 'Quebec', 500, 'www.rosemontschool.com', 'Education', 'Primary'),
    (2, 'Laval Secondary School', '456 Oak Ave.', 'Laval', '514-222-2222', 'H3Y 2Z5', 'Quebec', 800, 'www.lavalsecondary.com', 'Education', 'secondary'),
    (2, 'Laval Middle School', '789 Elm Dr.', 'Laval', '514-333-3333', 'H4Z 1A2', 'Quebec', 600, 'www.lavalmiddleschool.com', 'Education', 'Primary');

INSERT INTO Citizens (medicareNumber, expiryDate, firstName, lastName, birthDate, citizenship, email, province, phone, city, zip, address)
VALUES 
/*Students*/
(1, '2024-08-31', 'John', 'Doe', '1990-05-15', 'USA', 'john.doe@email.com', 'California', '555-123-4567', 'Los Angeles', '90001', '123 Main St'),
(2, '2023-12-31', 'Jane', 'Smith', '1985-10-22', 'USA', 'jane.smith@email.com', 'New York', '555-987-6543', 'New York City', '10001', '456 Elm St'),
(3, '2025-06-30', 'Michael', 'Johnson', '1992-03-08', 'USA', 'michael.johnson@email.com', 'Texas', '555-555-5555', 'Houston', '77001', '789 Oak St'),
(4, '2023-11-30', 'Emily', 'Williams', '1988-12-01', 'USA', 'emily.williams@email.com', 'Florida', '555-111-2222', 'Miami', '33101', '101 Palm Ave'),
(5, '2024-09-30', 'Christopher', 'Jones', '1996-07-12', 'USA', 'chris.jones@email.com', 'Illinois', '555-444-3333', 'Chicago', '60601', '222 Maple St'),
(6, '2022-10-31', 'Olivia', 'Brown', '1999-09-25', 'USA', 'olivia.brown@email.com', 'Arizona', '555-666-7777', 'Phoenix', '85001', '333 Pine St'),
(7, '2023-03-31', 'William', 'Davis', '1980-11-18', 'USA', 'william.davis@email.com', 'California', '555-222-8888', 'San Francisco', '94101', '444 Cedar St'),
(8, '2025-04-30', 'Ava', 'Miller', '1982-02-05', 'USA', 'ava.miller@email.com', 'Texas', '555-999-1111', 'Dallas', '75201', '555 Birch St'),
(9, '2024-07-31', 'James', 'Garcia', '1991-06-30', 'USA', 'james.garcia@email.com', 'Florida', '555-777-3333', 'Tampa', '33601', '666 Willow St'),
(10, '2023-10-31', 'Isabella', 'Rodriguez', '1987-04-09', 'USA', 'isabella.rodriguez@email.com', 'New York', '555-333-6666', 'Buffalo', '14201', '777 Elm St'),
(11, '2024-11-30', 'Alexander', 'Martinez', '1997-08-14', 'USA', 'alex.martinez@email.com', 'California', '555-666-1111', 'San Diego', '92101', '888 Oak St'),
(12, '2023-09-30', 'Sophia', 'Hernandez', '1984-01-29', 'USA', 'sophia.hernandez@email.com', 'Texas', '555-888-4444', 'Austin', '73301', '999 Maple St'),
(13, '2025-05-31', 'Daniel', 'Lopez', '1989-03-23', 'USA', 'daniel.lopez@email.com', 'Florida', '555-222-9999', 'Miami', '33101', '111 Palm Ave'),
(14, '2024-08-31', 'Mia', 'Gonzalez', '1993-11-07', 'USA', 'mia.gonzalez@email.com', 'Illinois', '555-555-7777', 'Chicago', '60601', '222 Pine St'),
(15, '2023-12-31', 'Matthew', 'Nelson', '1981-12-19', 'USA', 'matthew.nelson@email.com', 'Arizona', '555-999-5555', 'Phoenix', '85001', '333 Oak St'),
(16, '2025-06-30', 'Emma', 'Carter', '1986-07-26', 'USA', 'emma.carter@email.com', 'California', '555-111-7777', 'San Francisco', '94101', '444 Maple St'),
(17, '2023-11-30', 'Joseph', 'Hill', '1995-05-04', 'USA', 'joseph.hill@email.com', 'Texas', '555-444-2222', 'Dallas', '75201', '555 Cedar St'),
(18, '2024-09-30', 'Madison', 'Mitchell', '1998-10-31', 'USA', 'madison.mitchell@email.com', 'Florida', '555-777-8888', 'Tampa', '33601', '666 Birch St'),
(19, '2022-10-31', 'Oliver', 'Perez', '1983-09-12', 'USA', 'oliver.perez@email.com', 'New York', '555-666-3333', 'Buffalo', '14201', '777 Willow St'),
(20, '2023-03-31', 'Ava', 'Roberts', '1990-02-28', 'USA', 'ava.roberts@email.com', 'California', '555-222-9999', 'San Diego', '92101', '888 Pine St'),
(21, '2020-04-30', 'Scarlett', 'Turner', '1987-01-05', 'USA', 'scarlett.turner@email.com', 'Texas', '555-888-7777', 'Austin', '73301', '999 Oak St'),
(22, '2020-07-31', 'Aiden', 'Phillips', '1991-10-20', 'USA', 'aiden.phillips@email.com', 'Florida', '555-111-4444', 'Miami', '33101', '111 Maple Ave'),
(23, '2023-10-31', 'Aria', 'Ross', '1984-03-16', 'USA', 'aria.ross@email.com', 'Illinois', '555-333-7777', 'Chicago', '60601', '222 Cedar Ave'),
(24, '2024-11-30', 'Henry', 'Sanchez', '1992-07-01', 'USA', 'henry.sanchez@email.com', 'Arizona', '555-666-5555', 'Phoenix', '85001', '333 Birch Ave'),
(25, '2023-09-30', 'Ella', 'Butler', '1989-04-03', 'USA', 'ella.butler@email.com', 'California', '555-999-2222', 'San Francisco', '94101', '444 Oak Ave'),
(26, '2025-05-31', 'Andrew', 'Barnes', '1981-06-29', 'USA', 'andrew.barnes@email.com', 'Texas', '555-222-7777', 'Dallas', '75201', '555 Pine Ave'),
(27, '2024-08-31', 'Grace', 'Fisher', '1994-12-13', 'USA', 'grace.fisher@email.com', 'Florida', '555-555-4444', 'Tampa', '33601', '666 Cedar Ave'),
(28, '2023-12-31', 'Alexander', 'Henderson', '1997-01-30', 'USA', 'alex.henderson@email.com', 'New York', '555-777-6666', 'Buffalo', '14201', '777 Willow Ave'),
(29, '2025-06-30', 'Luna', 'Coleman', '1982-08-25', 'USA', 'luna.coleman@email.com', 'California', '555-444-3333', 'San Diego', '92101', '888 Birch Ave'),
(30, '2023-11-30', 'Benjamin', 'Simmons', '1996-03-14', 'USA', 'benjamin.simmons@email.com', 'Texas', '555-111-8888', 'Austin', '73301', '999 Pine Ave'),
(31, '2024-09-30', 'Nora', 'Washington', '1987-05-22', 'USA', 'nora.washington@email.com', 'Florida', '555-777-3333', 'Miami', '33101', '111 Maple St'),
(32, '2022-10-31', 'Carter', 'Sanders', '1999-09-08', 'USA', 'carter.sanders@email.com', 'Illinois', '555-666-7777', 'Chicago', '60601', '222 Cedar St'),
(33, '2023-03-31', 'Chloe', 'Perry', '1980-04-05', 'USA', 'chloe.perry@email.com', 'Arizona', '555-222-8888', 'Phoenix', '85001', '333 Birch St'),
(34, '2025-04-30', 'Matthew', 'Butler', '1984-06-12', 'USA', 'matthew.butler@email.com', 'California', '555-999-1111', 'San Francisco', '94101', '444 Elm St'),
(35, '2024-07-31', 'Eleanor', 'Rivera', '1991-08-31', 'USA', 'eleanor.rivera@email.com', 'Texas', '555-111-2222', 'Dallas', '75201', '555 Maple St'),
(36, '2023-10-31', 'Gabriel', 'Reyes', '1995-11-24', 'USA', 'gabriel.reyes@email.com', 'Florida', '555-333-6666', 'Tampa', '33601', '666 Pine St'),
(37, '2024-11-30', 'Violet', 'Brooks', '1998-01-14', 'USA', 'violet.brooks@email.com', 'New York', '555-666-1111', 'Buffalo', '14201', '777 Cedar St'),
(38, '2023-09-30', 'Julian', 'Long', '1983-02-18', 'USA', 'julian.long@email.com', 'California', '555-888-4444', 'San Diego', '92101', '888 Elm St'),
(39, '2025-05-31', 'Penelope', 'Baker', '1989-03-07', 'USA', 'penelope.baker@email.com', 'Texas', '555-222-9999', 'Austin', '73301', '999 Pine St'),
(40, '2024-08-31', 'Leo', 'Evans', '1992-12-02', 'USA', 'leo.evans@email.com', 'Florida', '555-555-7777', 'Miami', '33101', '111 Birch St'),
(41, '2023-12-31', 'Layla', 'Bell', '1993-07-10', 'USA', 'layla.bell@email.com', 'Illinois', '555-777-8888', 'Chicago', '60601', '222 Oak St'),
(42, '2025-06-30', 'Thomas', 'Gomez', '1981-09-26', 'USA', 'thomas.gomez@email.com', 'Arizona', '555-444-3333', 'Phoenix', '85001', '333 Cedar St'),
(43, '2023-11-30', 'Grace', 'Ward', '1996-03-16', 'USA', 'grace.ward@email.com', 'California', '555-111-7777', 'San Francisco', '94101', '444 Elm St'),
(44, '2024-09-30', 'Stella', 'Murphy', '1987-04-19', 'USA', 'stella.murphy@email.com', 'Texas', '555-444-2222', 'Dallas', '75201', '555 Maple St'),
(45, '2022-10-31', 'Riley', 'Torres', '1990-10-25', 'USA', 'riley.torres@email.com', 'Florida', '555-666-3333', 'Tampa', '33601', '666 Cedar St'),
(46, '2023-03-31', 'Hudson', 'Peterson', '1984-03-22', 'USA', 'hudson.peterson@email.com', 'New York', '555-222-9999', 'Buffalo', '14201', '777 Birch St'),
(47, '2025-04-30', 'Nora', 'Foster', '1986-07-07', 'USA', 'nora.foster@email.com', 'California', '555-999-5555', 'San Diego', '92101', '888 Elm St'),
(48, '2024-07-31', 'Levi', 'Bryant', '1991-08-10', 'USA', 'levi.bryant@email.com', 'Texas', '555-111-4444', 'Austin', '73301', '999 Oak St'),
(49, '2023-10-31', 'Lydia', 'Alexander', '1995-05-11', 'USA', 'lydia.alexander@email.com', 'Florida', '555-333-7777', 'Miami', '33101', '111 Cedar St'),
(50, '2024-11-30', 'Elliot', 'Russell', '1998-11-28', 'USA', 'elliot.russell@email.com', 'Illinois', '555-666-5555', 'Chicago', '60601', '222 Elm St'),

/*Employees*/
(51, '2024-08-31', 'Lucas', 'Cooper', '1990-05-15', 'USA', 'lucas.cooper@email.com', 'California', '555-123-4567', 'Los Angeles', '90001', '123 Main St'),
(52, '2023-12-31', 'Harper', 'Ward', '1985-10-22', 'USA', 'harper.ward@email.com', 'New York', '555-987-6543', 'New York City', '10001', '456 Elm St'),
(53, '2025-06-30', 'Ethan', 'Gomez', '1992-03-08', 'USA', 'ethan.gomez@email.com', 'Texas', '555-555-5555', 'Houston', '77001', '789 Oak St'),
(54, '2023-11-30', 'Abigail', 'Mitchell', '1988-12-01', 'USA', 'abigail.mitchell@email.com', 'Florida', '555-111-2222', 'Miami', '33101', '101 Palm Ave'),
(55, '2024-09-30', 'Evelyn', 'Foster', '1996-07-12', 'USA', 'evelyn.foster@email.com', 'Illinois', '555-444-3333', 'Chicago', '60601', '222 Maple St'),
(56, '2022-10-31', 'Samuel', 'Bell', '1999-09-25', 'USA', 'samuel.bell@email.com', 'Arizona', '555-666-7777', 'Phoenix', '85001', '333 Pine St'),
(57, '2023-03-31', 'Avery', 'Peterson', '1980-11-18', 'USA', 'avery.peterson@email.com', 'California', '555-222-8888', 'San Francisco', '94101', '444 Cedar St'),
(58, '2025-04-30', 'Scarlett', 'Phillips', '1982-02-05', 'USA', 'scarlett.phillips@email.com', 'Texas', '555-999-1111', 'Dallas', '75201', '555 Birch St'),
(59, '2024-07-31', 'Jackson', 'Hernandez', '1991-06-30', 'USA', 'jackson.hernandez@email.com', 'Florida', '555-777-3333', 'Tampa', '33601', '666 Willow St'),
(60, '2023-10-31', 'Victoria', 'Russell', '1987-04-09', 'USA', 'victoria.russell@email.com', 'New York', '555-333-6666', 'Buffalo', '14201', '777 Elm St'),
(61, '2024-11-30', 'Leo', 'Howard', '1997-08-14', 'USA', 'leo.howard@email.com', 'California', '555-666-1111', 'San Diego', '92101', '888 Oak St'),
(62, '2023-09-30', 'Grace', 'Turner', '1984-01-29', 'USA', 'grace.turner@email.com', 'Texas', '555-888-4444', 'Austin', '73301', '999 Maple St'),
(63, '2025-05-31', 'Elijah', 'Lopez', '1989-03-23', 'USA', 'elijah.lopez@email.com', 'Florida', '555-222-9999', 'Miami', '33101', '111 Palm Ave'),
(64, '2024-08-31', 'Hannah', 'Gonzalez', '1993-11-07', 'USA', 'hannah.gonzalez@email.com', 'Illinois', '555-555-7777', 'Chicago', '60601', '222 Pine St'),
(65, '2023-12-31', 'Christopher', 'Nelson', '1981-12-19', 'USA', 'christopher.nelson@email.com', 'Arizona', '555-999-5555', 'Phoenix', '85001', '333 Oak St'),
(66, '2025-06-30', 'Leah', 'Carter', '1986-07-26', 'USA', 'leah.carter@email.com', 'California', '555-111-7777', 'San Francisco', '94101', '444 Maple St'),
(67, '2023-11-30', 'Isaac', 'Hill', '1995-05-04', 'USA', 'isaac.hill@email.com', 'Texas', '555-444-2222', 'Dallas', '75201', '555 Cedar St'),
(68, '2024-09-30', 'Elizabeth', 'Mitchell', '1998-10-31', 'USA', 'elizabeth.mitchell@email.com', 'Florida', '555-777-8888', 'Tampa', '33601', '666 Birch St'),
(69, '2022-10-31', 'Daniel', 'Perez', '1983-09-12', 'USA', 'daniel.perez@email.com', 'New York', '555-666-3333', 'Buffalo', '14201', '777 Willow St'),
(70, '2023-03-31', 'Eleanor', 'Roberts', '1990-02-28', 'USA', 'eleanor.roberts@email.com', 'California', '555-222-9999', 'San Diego', '92101', '888 Pine St'),
(71, '2025-04-30', 'Thomas', 'Turner', '1987-01-05', 'USA', 'thomas.turner@email.com', 'Texas', '555-888-7777', 'Austin', '73301', '999 Oak St'),
(72, '2024-07-31', 'Matthew', 'Phillips', '1991-10-20', 'USA', 'matthew.phillips@email.com', 'Florida', '555-111-4444', 'Miami', '33101', '111 Maple Ave'),
(73, '2023-10-31', 'Aria', 'Ross', '1984-03-16', 'USA', 'aria.ross@email.com', 'Illinois', '555-333-7777', 'Chicago', '60601', '222 Cedar Ave'),
(74, '2024-11-30', 'Liam', 'Sanchez', '1992-07-01', 'USA', 'liam.sanchez@email.com', 'Arizona', '555-666-5555', 'Phoenix', '85001', '333 Birch Ave'),
(75, '2023-09-30', 'Lily', 'Butler', '1989-04-03', 'USA', 'lily.butler@email.com', 'California', '555-999-2222', 'San Francisco', '94101', '444 Oak Ave'),
(76, '2025-05-31', 'Benjamin', 'Barnes', '1981-06-29', 'USA', 'benjamin.barnes@email.com', 'Texas', '555-222-7777', 'Dallas', '75201', '555 Pine Ave'),
(77, '2024-08-31', 'Aria', 'Fisher', '1994-12-13', 'USA', 'aria.fisher@email.com', 'Florida', '555-555-4444', 'Tampa', '33601', '666 Cedar Ave'),
(78, '2023-12-31', 'Mason', 'Henderson', '1997-01-30', 'USA', 'mason.henderson@email.com', 'New York', '555-777-6666', 'Buffalo', '14201', '777 Willow Ave'),
(79, '2025-06-30', 'Ella', 'Coleman', '1982-08-25', 'USA', 'ella.coleman@email.com', 'California', '555-444-3333', 'San Diego', '92101', '888 Birch Ave'),
(80, '2023-11-30', 'James', 'Simmons', '1996-03-14', 'USA', 'james.simmons@email.com', 'Texas', '555-111-8888', 'Austin', '73301', '999 Pine Ave'),
(81, '2024-09-30', 'Skylar', 'Washington', '1987-05-22', 'USA', 'skylar.washington@email.com', 'Florida', '555-777-3333', 'Miami', '33101', '111 Maple St'),
(82, '2022-10-31', 'Bella', 'Sanders', '1999-09-08', 'USA', 'bella.sanders@email.com', 'Illinois', '555-666-7777', 'Chicago', '60601', '222 Cedar St'),
(83, '2023-03-31', 'Jackson', 'Perry', '1980-04-05', 'USA', 'jackson.perry@email.com', 'Arizona', '555-222-8888', 'Phoenix', '85001', '333 Birch St'),
(84, '2025-04-30', 'Paisley', 'Butler', '1984-06-12', 'USA', 'paisley.butler@email.com', 'California', '555-999-1111', 'San Francisco', '94101', '444 Elm St'),
(85, '2024-07-31', 'Camila', 'Rivera', '1991-08-31', 'USA', 'camila.rivera@email.com', 'Texas', '555-111-2222', 'Dallas', '75201', '555 Maple St'),
(86, '2023-10-31', 'Lucas', 'Reyes', '1995-11-24', 'USA', 'lucas.reyes@email.com', 'Florida', '555-333-6666', 'Tampa', '33601', '666 Pine St'),
(87, '2024-11-30', 'Mateo', 'Brooks', '1998-01-14', 'USA', 'mateo.brooks@email.com', 'New York', '555-666-1111', 'Buffalo', '14201', '777 Cedar St'),
(88, '2023-09-30', 'Nora', 'Long', '1983-02-18', 'USA', 'nora.long@email.com', 'California', '555-888-4444', 'San Diego', '92101', '888 Elm St'),
(89, '2025-05-31', 'Ellie', 'Baker', '1989-03-07', 'USA', 'ellie.baker@email.com', 'Texas', '555-222-9999', 'Austin', '73301', '999 Pine St'),
(90, '2024-08-31', 'Grayson', 'Evans', '1992-12-02', 'USA', 'grayson.evans@email.com', 'Florida', '555-555-7777', 'Miami', '33101', '111 Birch St'),
(91, '2023-12-31', 'Ruby', 'Bell', '1993-07-10', 'USA', 'ruby.bell@email.com', 'Illinois', '555-777-8888', 'Chicago', '60601', '222 Oak St'),
(92, '2025-06-30', 'Luke', 'Gomez', '1981-09-26', 'USA', 'luke.gomez@email.com', 'Arizona', '555-444-3333', 'Phoenix', '85001', '333 Cedar St'),
(93, '2023-11-30', 'Layla', 'Ward', '1996-03-16', 'USA', 'layla.ward@email.com', 'California', '555-111-7777', 'San Francisco', '94101', '444 Elm St'),
(94, '2024-09-30', 'William', 'Mitchell', '1987-04-19', 'USA', 'william.mitchell@email.com', 'Texas', '555-444-2222', 'Dallas', '75201', '555 Maple St'),
(95, '2022-10-31', 'Anna', 'Torres', '1990-10-25', 'USA', 'anna.torres@email.com', 'Florida', '555-666-3333', 'Tampa', '33601', '666 Cedar St'),
(96, '2023-03-31', 'Hudson', 'Peterson', '1984-03-22', 'USA', 'hudson.peterson@email.com', 'New York', '555-222-9999', 'Buffalo', '14201', '777 Birch St'),
(97, '2025-04-30', 'Natalie', 'Foster', '1986-07-07', 'USA', 'natalie.foster@email.com', 'California', '555-999-5555', 'San Diego', '92101', '888 Elm St'),
(98, '2024-07-31', 'Sebastian', 'Bryant', '1991-08-10', 'USA', 'sebastian.bryant@email.com', 'Texas', '555-111-4444', 'Austin', '73301', '999 Oak St'),
(99, '2023-10-31', 'Maya', 'Alexander', '1995-05-11', 'USA', 'maya.alexander@email.com', 'Florida', '555-333-7777', 'Miami', '33101', '111 Cedar St'),
(100, '2024-11-30', 'Grayson', 'Russell', '1998-11-28', 'USA', 'grayson.russell@email.com', 'Illinois', '555-666-5555', 'Chicago', '60601', '222 Elm St'),

/*query 11*/
(500, '2025-12-31', 'John', 'Doe', '1990-05-15', 'Canadian', 'john.doe@email.com', 'Ontario', '123-456-7890', 'Toronto', 'M5V 2G3', '123 Main St'),
(501, '2024-10-31', 'Jane', 'Smith', '1985-09-20', 'Canadian', 'jane.smith@email.com', 'British Columbia', '987-654-3210', 'Vancouver', 'V6B 3E3', '456 Elm St'),
(502, '2023-06-30', 'Michael', 'Lee', '1988-11-02', 'Korean', 'michael.lee@email.com', 'Alberta', '345-789-0123', 'Calgary', 'T2P 1J9', '789 Oak Ave'),
(503, '2026-05-31', 'Maria', 'Garcia', '1993-03-25', 'Mexican', 'maria.garcia@email.com', 'Quebec', '567-123-8901', 'Montreal', 'H3B 2Y5', '1010 Rue de la Gauchetière'),
(504, '2025-08-31', 'Robert', 'Johnson', '1977-12-10', 'Canadian', 'robert.johnson@email.com', 'Saskatchewan', NULL, 'Regina', 'S4P 0V5', '222 Victoria Ave'),

/*Query 13*/
(505, '2025-10-31', 'Alice', 'Smith', '1992-07-15', 'Canadian', 'alice.smith@email.com', 'Ontario', '555-123-4567', 'Toronto', 'M4B 1V3', '789 Maple St'),
(506, '2023-09-30', 'Bob', 'Johnson', '1987-11-21', 'American', 'bob.johnson@email.com', 'New York', '444-789-1234', 'New York City', '10001', '123 Broadway Ave'),
(507, '2024-12-31', 'Ella', 'Garcia', '1990-04-05', 'Mexican', 'ella.garcia@email.com', 'California', '777-456-7890', 'Los Angeles', '90001', '456 Oak St'),
(508, '2023-08-15', 'David', 'Kim', '1985-12-10', 'Korean', 'david.kim@email.com', 'British Columbia', '333-987-6543', 'Vancouver', 'V6B 2G3', '789 Elm St'),
(509, '2026-05-31', 'Sophia', 'Martinez', '1995-03-17', 'Mexican', 'sophia.martinez@email.com', 'Quebec', '222-567-8901', 'Montreal', 'H3B 1C7', '1010 Rue de la Montagne'),

(1000, '2025-10-31', 'John', 'Doe', '1990-05-15', 'Canadian', 'john.doe@email.com', 'Ontario', '555-123-4567', 'Toronto', 'M4B 1V3', '789 Maple St'),
(1001, '2023-09-30', 'Jane', 'Smith', '1987-11-21', 'American', 'jane.smith@email.com', 'New York', '444-789-1234', 'New York City', '10001', '123 Broadway Ave'),
(1002, '2024-12-31', 'Michael', 'Johnson', '1995-04-05', 'Canadian', 'michael.johnson@email.com', 'British Columbia', '777-456-7890', 'Vancouver', 'V6B 2G3', '789 Elm St'),
(1003, '2023-08-15', 'Emily', 'Kim', '1985-12-10', 'Korean', 'emily.kim@email.com', 'California', '333-987-6543', 'Los Angeles', '90001', '456 Oak St'),
(1004, '2026-05-31', 'Daniel', 'Martinez', '1992-03-17', 'Mexican', 'daniel.martinez@email.com', 'Quebec', '222-567-8901', 'Montreal', 'H3B 1C7', '1010 Rue de la Montagne'),
(1005, '2026-05-31','John', 'Doe', '1985-02-15', 'Canadian', 'john.doe@email.com', 'Ontario', '1234567890', 'Toronto', 'M5H2N2', '123 Main St.'),
(1006, '2026-05-31','Jane', 'Smith', '1987-05-20', 'Canadian', 'jane.smith@email.com', 'Ontario', '2345678901', 'Toronto', 'M5H2N3', '124 Main St.'),
(1007, '2026-05-31','Alex', 'Johnson', '1990-10-10', 'Canadian', 'alex.johnson@email.com', 'Ontario', '3456789012', 'Toronto', 'M5H2N4', '125 Main St.'),
(1008, '2026-05-31','Emily', 'Davis', '1992-12-05', 'Canadian', 'emily.davis@email.com', 'Ontario', '4567890123', 'Toronto', 'M5H2N5', '126 Main St.');


INSERT INTO Students (medicareNumber, studentID, facility_ID, grade) 
VALUES 
      /*Ministry 1*/
	(1, 1, 2, 'Grade 1'),
	(2, 2, 3, 'Grade 2'),
    /*Ministry 2*/
	(3, 3, 5, 'Grade 3'),
	(4, 4, 6, 'Grade 4'),
    /*Ministry 3*/
    (5, 5, 8, 'Grade 4'),
    (6, 6, 9, 'Grade 9'),
    /*Ministry 4*/
    (7, 7, 11, 'Grade 4'),
	(8, 8, 12, 'Grade 4'),
    /*Ministry 5*/
	(9, 9, 14, 'Grade 4'),
	(10, 10, 15, 'Grade 4'),
    /*Ministry 6*/
	(11, 11, 17, 'Grade 4'),
	(12, 12, 18, 'Grade 4'),
    /*Ministry 7*/
	(13, 13, 20, 'Grade 4'),
	(14, 14, 21, 'Grade 4'),
    /*Ministry 8*/
	(15, 15, 23, 'Grade 4'),
    (16, 16, 24, 'Grade 4'),
    /*Ministry 9*/
    (17, 17, 26, 'Grade 4'),
    (18, 18, 27, 'Grade 4'),
    /*Ministry 10*/
    (19, 19, 29, 'Grade 4'),
    (20, 20, 30, 'Grade 4'),
    
    /**query 3, rosemont elementary school*/
	/*Ministry 1*/
	(21, 21, 2, 'Grade 1'),
	(22, 22, 2, 'Grade 2'),
    
    /*Query 4 student goes to laval*/
    (23, 23, 31, 'Grade 5'),
    (24, 24, 32, 'Grade 9'),
    (25, 25, 33, 'Grade 7');
    
INSERT INTO Employees (medicareNumber, employee_ID, role, specialization, additionalRole)
VALUES 
/*President of head office (minister)*/
(51, 1, 'President', NULL, 'Additional Role 1'), -- QUERY 10
(52, 2, 'President', NULL, 'Additional Role 2'),
(53, 3, 'President', NULL, 'Additional Role 3'),
(54, 4, 'President', NULL, 'Additional Role 4'),
(55, 5, 'President', NULL, 'Additional Role 5'),
(56, 6, 'President', NULL, 'Additional Role 6'),
(57, 7, 'President', NULL, 'Additional Role 7'),
(58, 8, 'President', NULL, 'Additional Role 8'),
(59, 9, 'President', NULL, 'Additional Role 9'),
(60, 10, 'President', NULL, 'Additional Role 10'),

/*Principals of education facility*/
(61, 11, 'Principal', NULL, 'Additional Role 11'),
(62, 12, 'Principal', NULL, 'Additional Role 12'),
(63, 13, 'Principal', NULL, 'Additional Role 13'),
(64, 14, 'Principal', NULL, 'Additional Role 14'),
(65, 15, 'Principal', NULL, 'Additional Role 15'),
(66, 16, 'Principal', NULL, 'Additional Role 16'),
(67, 17, 'Principal', NULL, 'Additional Role 17'),
(68, 18, 'Principal', NULL, 'Additional Role 18'),
(69, 19, 'Principal', NULL, 'Additional Role 19'),
(70, 20, 'Principal', NULL, 'Additional Role 20'),

/*Teachers*/
(71, 21, 'Teacher', 'Math', 'Additional Role 21'), 
(72, 22, 'Teacher', 'French', 'Additional Role 22'),
(73, 23, 'Teacher', 'Science', 'Additional Role 23'),
(74, 24, 'Teacher', 'English', 'Additional Role 24'),
(75, 25, 'Teacher', 'History', 'Additional Role 25'),
(76, 26, 'Teacher', 'Music', 'Additional Role 26'),
(77, 27, 'Teacher', 'Art', 'Additional Role 27'),
(78, 28, 'Teacher', 'Physical Education', 'Additional Role 28'),
(79, 29, 'Teacher', 'Biology', 'Additional Role 29'),
(80, 30, 'Teacher', 'Chemistry', 'Additional Role 30'),

/*More Teachers*/
(81, 31, 'Teacher', 'Physics', 'Additional Role 31'),
(82, 32, 'Teacher', 'Computer Science', 'Additional Role 32'),
(83, 33, 'Teacher', 'Geography', 'Additional Role 33'),
(84, 34, 'Teacher', 'Economics', 'Additional Role 34'),
(85, 35, 'Teacher', 'Psychology', 'Additional Role 35'),
(86, 36, 'Teacher', 'Sociology', 'Additional Role 36'),
(87, 37, 'Teacher', 'Physical Education', 'Additional Role 37'),
(88, 38, 'Teacher', 'English', 'Additional Role 38'),
(89, 39, 'Teacher', 'Math', 'Additional Role 39'),
(90, 40, 'Teacher', 'French', 'Additional Role 40'),

/*More Teachers*/
(91, 41, 'Teacher', 'Science', 'Additional Role 41'),
(92, 42, 'Teacher', 'Music', 'Additional Role 42'),
(93, 43, 'Teacher', 'Art', 'Additional Role 43'),
(94, 44, 'Teacher', 'Physical Education', 'Additional Role 44'),
(95, 45, 'Teacher', 'Biology', 'Additional Role 45'),
(96, 46, 'Teacher', 'Chemistry', 'Additional Role 46'),
(97, 47, 'Teacher', 'Physics', 'Additional Role 47'),
(98, 48, 'Teacher', 'Computer Science', 'Additional Role 48'),
(99, 49, 'Teacher', 'Geography', 'Additional Role 49'),
(100, 50, 'Teacher', 'Economics', 'Additional Role 50'),

/*Query 11*/
(500, 500, 'Teacher', 'Economics', 'Additional Role 50'),
(501, 501, 'Teacher', 'Economics', 'Additional Role 50'),
(502, 502, 'Teacher', 'Economics', 'Additional Role 50'),
(503, 503, 'Teacher', 'Economics', 'Additional Role 50'),
(504, 504, 'Teacher', 'Economics', 'Additional Role 50'),

/*Query 13*/
(505, 505, 'Teacher', 'Mathematics', NULL),
(506, 506, 'Teacher', 'Mathematics', NULL),
(507, 507, 'Teacher', 'Mathematics', NULL),
(508, 508, 'Teacher', 'Mathematics', NULL),
(509, 509, 'Teacher', 'Mathematics', NULL),

(1000, 1000, 'Teacher', 'Economics', 'Counselor'),
(1001, 1001, 'Teacher', 'Economics', 'Counselor'),
(1002, 1002, 'Teacher', 'Economics', 'Counselor'),
(1003, 1003, 'Teacher', 'Economics', 'Counselor'),
(1004, 1004, 'Teacher', 'Economics', 'Counselor'),

(1005, 1010, 'Teacher', 'Math', 'Head of Department'),
(1006, 1011, 'Teacher', 'Science', 'Lab Manager'),
(1007, 1012, 'Counselor', 'Student Affairs', 'Event Organizer'),
(1008, 1013, 'Librarian', 'Library Management', 'Book Club Head');

INSERT INTO Infections (infectionID, type)
VALUES 
(1, 'COVID-19'),
(2, 'SARS-Cov-2 Variant'),
(3, 'Influenza'),
(4, 'MERS-CoV'),
(5, 'Ebola'),
(6, 'Zika'),
(7, 'H1N1'),
(8, 'Cholera'),
(9, 'Measles'),
(10, 'Hepatitis B');

INSERT INTO InfectedBy (medicareNumber, infectionID, dateInfected)
VALUES 
(1, 1, '2023-07-01'),
(3, 1, '2023-07-02'),
(5, 1, '2023-07-03'),
(7, 1, '2023-07-04'),
(9, 1, '2023-07-05'),
(21, 1, '2023-07-05'),
(22, 1, '2023-07-05'),
(23, 1, '2023-07-21'),
(23, 1, '2023-07-20'),
(23, 1, '2023-07-19'),
(24, 2, '2023-07-15'), 
(24, 2, '2023-07-13'), 
(24, 2, '2023-07-11'),
(25, 1, '2023-07-17'), 
(25, 1, '2023-07-19'),
(25, 1, '2023-07-18'),

(81, 1, '2023-07-06'),
(83, 1, '2023-07-07'),
(85, 1, '2023-07-08'),
(87, 1, '2023-07-09'),
(89, 1, '2023-07-31'),
(89, 1, '2023-07-30'),  

/*Query 11*/
(500, 1, '2023-08-03'),
(501, 1, '2023-08-03'),
(502, 1, '2023-08-03'),
(503, 1, '2023-08-03'),
(504, 1, '2023-08-03'),

(500, 1, '2023-08-10'),

(1000, 1, '2023-05-30'),
(1000, 1, '2023-06-30'),
(1000, 1, '2023-07-30'),
(1001, 1, '2023-05-30'),
(1001, 1, '2023-06-30'),
(1001, 1, '2023-06-30'),
(1002, 1, '2023-07-30'),
(1002, 1, '2023-07-30'),
(1002, 1, '2023-07-30'),
(1003, 1, '2023-07-30'),
(1003, 1, '2023-07-30'),
(1003, 1, '2023-07-30'),
(1004, 1, '2023-07-30'),
(1004, 1, '2023-07-30'),
(1004, 1, '2023-05-30'),
(1004, 1, '2023-07-30');



INSERT INTO Vaccines (vaccineID, type)
VALUES 
(1, 'Pfizer'),
(2, 'Moderna'),
(3, 'AstraZeneca'),
(4, 'Johnson & Johnson'),
(5, 'Sinovac'),
(6, 'Novavax'),
(7, 'Covaxin'),
(8, 'Sputnik V'),
(9, 'Sinopharm'),
(10, 'CanSinoBIO'),
(11, 'Bharat Biotech'),
(12, 'Pfizer-BioNTech'),
(13, 'Janssen');

INSERT INTO TookVaccine (doseNumber, vaccineID, vaccinationDate, medicareNumber)
VALUES 
(1, 1, '2023-07-01', 2),
(2, 1, '2023-07-02', 4),
(3, 2, '2023-07-03', 6),
(1, 2, '2023-07-04', 8),
(2, 1, '2023-07-05', 10),
(3, 2, '2023-07-06', 82),
(1, 1, '2023-07-07', 84),
(2, 2, '2023-07-08', 86),
(1, 2, '2023-07-09', 88),
(3, 1, '2023-07-10', 90);

INSERT INTO EmployeeSchedule (employee_ID, facility_ID, task, startTime, endTime)
VALUES 

/*Test procedure cancelAssingments*/
(500, 3, 'Teaching', '2023-08-10 08:00:00', '2023-08-10 11:00:00'),
(500, 3, 'Teaching', '2023-08-15 08:00:00', '2023-08-15 11:00:00'),
(500, 3, 'Teaching', '2023-08-16 08:00:00', '2023-08-16 11:00:00'),
(500, 3, 'Teaching', '2023-08-26 08:00:00', '2023-08-26 11:00:00'),

/*Principal*/
(11, 3, 'Principal', '2023-07-30 08:00:00', '2023-07-30 17:00:00'),

/*query 10*/
(1, 1, 'Presides', '2023-07-30 08:00:00', '2023-07-30 17:00:00'),
(1, 1, 'Presides', '2023-07-31 08:00:00', '2023-07-31 17:00:00'),

/*Query 11*/
(500, 3, 'Teaching', '2023-08-06 08:00:00', '2023-08-06 11:00:00'),
(501, 3, 'Teaching', '2023-08-06 09:30:00', '2023-08-06 12:30:00'),
(502, 3, 'Teaching', '2023-08-06 12:00:00', '2023-08-06 14:00:00'),
(503, 7, 'Teaching', '2023-08-06 14:30:00', '2023-08-06 17:30:00'),
(504, 7, 'Teaching', '2023-08-06 10:00:00', '2023-08-06 13:00:00'),

/*Query 13*/
(505, 3, 'Teaching', '2023-08-06 08:00:00', '2023-08-06 11:00:00'),
(506, 3, 'Teaching', '2023-08-06 09:30:00', '2023-08-06 12:30:00'),
(507, 3, 'Teaching', '2023-08-06 12:00:00', '2023-08-06 14:00:00'),
(508, 7, 'Teaching', '2023-08-06 14:30:00', '2023-08-06 17:30:00'),
(509, 7, 'Teaching', '2023-08-06 10:00:00', '2023-08-06 13:00:00'),

(1000, 3, 'Consulting', '2023-07-31 08:00:00', '2023-07-31 17:00:00'),
(1001, 3, 'Consulting', '2023-08-01 09:30:00', '2023-08-01 18:30:00'),
(1002, 6, 'Consulting', '2023-08-02 10:00:00', '2023-08-02 19:00:00'),
(1003, 6, 'Consulting', '2023-08-03 11:15:00', '2023-08-03 20:15:00'),
(1004, 6, 'Consulting', '2023-08-04 11:45:00', '2023-08-04 21:45:00'),

(1010, 1, 'Teaching', '2023-07-05 08:00:00', '2023-07-05 15:00:00'),
(1011, 1, 'Teaching', '2023-07-06 08:00:00', '2023-07-06 16:00:00'),
(1012, 1, 'Guidance Session', '2023-07-07 09:00:00', '2023-07-07 17:00:00'),
(1013, 1, 'Library Management', '2023-07-08 08:30:00', '2023-07-08 14:30:00');
    
    /**/
INSERT INTO LogEmail (date, facility_ID, employee_ID, subject, body)
VALUES 
('2023-07-30', 1, 1, 'Schedule', 'Dear Employee, Just a quick update on the ongoing project.'),
('2023-07-31', 4, 2, 'Schedule', 'Dear Employee, Just a quick update on the ongoing project.'),

/*Query 12*/
('2023-07-31', 3, 500, 'Schedule', 'Dear Employee, Just a quick update on the ongoing project.'),
('2023-07-31', 3, 501, 'Schedule', 'Dear Employee, Just a quick update on the ongoing project.'),
('2023-07-31', 3, 502, 'Schedule', 'Dear Employee, Just a quick update on the ongoing project.'),
('2023-07-31', 3, 503, 'Schedule', 'Dear Employee, Just a quick update on the ongoing project.'),
('2023-07-31', 3, 504, 'Schedule', 'Dear Employee, Just a quick update on the ongoing project.');


/*Query 8*/
SELECT f.facility_ID,f.name, f.address, f.city, f.province, f.postalCode, f.phone,
 f.webAddress,f.facilityType, f.capacity, COUNT(DISTINCT es.employee_ID) AS CurrentEmployees
FROM Facilities f
LEFT JOIN EmployeeSchedule es ON es.facility_ID = f.facility_ID 
LEFT JOIN Employees e ON es.employee_ID = e.employee_ID 
LEFT JOIN Citizens c ON c.medicareNumber = e.medicareNumber
GROUP BY    f.facility_ID,
			f.name,
			f.address,
			f.city,
			f.province,
			f.postalCode,
			f.phone,
			f.webAddress,
			f.facilityType,
			f.capacity
ORDER BY f.province, f.city, f.facilityType, CurrentEmployees ASC;

/*Query 9 specific facility = 1, Justify them being current employees if they had a shift in the past week*/
SELECT c.firstName, c.lastName,  MIN(es.startTime) AS FirstShift,c.birthDate, 
c.medicareNumber as Medicare, c.phone, c.address, c.city, c.province, c.zip,c.citizenship, c.email
	FROM EmployeeSchedule es 
		JOIN Employees e ON es.employee_ID = e.employee_ID
        JOIN Citizens c ON e.medicareNumber = c.medicareNumber
        WHERE es.facility_ID = 1 
        GROUP BY e.medicareNumber
        ORDER BY e.role ASC, c.firstName ASC, c.lastName ASC;
        
/*Query 10*/
SELECT e.employee_ID,f.name,DAY(es.startTime) AS DAY,  es.startTime, es.endTime
FROM EmployeeSchedule es
JOIN Facilities f ON es.facility_ID = f.facility_ID
JOIN Employees e ON e.employee_ID = es.employee_ID AND e.employee_ID = 500
ORDER BY f.name ASC, DAY ASC, es.startTime ASC;

/*Q11 Get details of all the teachers who have been infected by COVID-19 in the past two weeks*/
SELECT c.medicareNumber, c.firstName, c.lastName, ib.dateInfected, f.name AS 'Facility Name'
FROM Facilities f
JOIN EmployeeSchedule es ON es.facility_ID = f.facility_ID
JOIN Employees e ON e.employee_ID = es.employee_ID
JOIN Citizens c ON c.medicareNumber = e.medicareNumber
JOIN InfectedBy ib ON ib.medicareNumber = c.medicareNumber
JOIN Infections i ON i.infectionID = ib.infectionID
WHERE 
    e.role = 'Teacher' AND
    ib.dateInfected >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK) AND
    i.type = 'COVID-19'
ORDER BY f.name, c.firstName;

/*Q12 List the emails generated by a given facility. The results should be displayed in ascending order by the date of the emails.*/
SELECT *
FROM LogEmail
WHERE facility_ID = 3
ORDER BY date ASC;

/*Q13 For a given facility, generate a list of all the teachers who have been on schedule to work in the last two weeks.*/
SELECT f.facility_ID, f.name AS 'Facility Name', c.medicareNumber, c.firstName, c.lastName, f.subType AS 'Role'
FROM Facilities f
JOIN EmployeeSchedule es ON es.facility_Id = f.facility_ID
JOIN Employees e ON e.employee_ID = es.employee_ID
JOIN Citizens c ON c.medicareNumber = e.medicareNumber
WHERE f.facility_ID = 3 AND e.role = 'Teacher' AND es.startTime >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK) AND es.startTime <= NOW()
ORDER BY f.subType, c.firstName;

/*Query 14*/
 SELECT c.firstName,
    c.lastName,
    SUM(HOUR(TIMEDIFF(es.endTime, es.startTime))) AS totalHoursScheduled
FROM
    Citizens c
JOIN
    Employees e ON c.medicareNumber = e.medicareNumber
JOIN
    EmployeeSchedule es ON e.employee_ID = es.employee_ID
JOIN
    Facilities f ON es.facility_ID = f.facility_ID
WHERE
    f.name = 'NotreDame' 
    AND es.startTime >= '2023-07-01'
    AND es.endTime <= '2023-07-31'
GROUP BY
    c.firstName,
    c.lastName
ORDER BY
    c.firstName ASC,
    c.lastName ASC;
    
/*Query 15*/
   SELECT  f.province,
    f.name AS school_name,
    f.capacity,
    COUNT(DISTINCT CASE WHEN i.dateInfected >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK) THEN es.employee_ID END) AS total_teachers_infected,
    COUNT(DISTINCT CASE WHEN i.dateInfected >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK) THEN s.medicareNumber END) AS total_students_infected
FROM
    Facilities f
LEFT JOIN
    EmployeeSchedule es ON f.facility_ID = es.facility_ID
LEFT JOIN
    Employees e ON es.employee_ID = e.employee_ID
LEFT JOIN
    InfectedBy i ON e.medicareNumber = i.medicareNumber
LEFT JOIN
    Students s ON f.facility_ID = s.facility_ID
WHERE
    f.facilityType = 'Education'
GROUP BY
    f.province,
    f.name,
    f.capacity
ORDER BY
    f.province ASC,
    total_teachers_infected ASC;
    
/*Query 16 */
SELECT
    c.firstName AS minister_first_name,
    c.lastName AS minister_last_name,
    c.city AS minister_city,
    COUNT(DISTINCT CASE WHEN f.facilityType = 'Management' THEN f.facility_ID END) AS total_management_facilities,
    COUNT(DISTINCT CASE WHEN f.facilityType = 'Educational' THEN f.facility_ID END) AS total_educational_facilities
FROM
    Ministries m
JOIN
    Facilities f ON m.ministry_ID = f.ministry_ID
JOIN
    EmployeeSchedule es ON f.facility_ID = es.facility_ID
JOIN
    Employees e ON es.employee_ID = e.employee_ID
JOIN
    Citizens c ON e.medicareNumber = c.medicareNumber
GROUP BY
    m.ministry_ID,
    c.firstName,
    c.lastName,
    c.city
ORDER BY
    c.city ASC,
    total_educational_facilities DESC;

/*Query 17*/
SELECT
    c.firstName AS minister_first_name,
    c.lastName AS minister_last_name,
    c.city AS minister_city,
    COUNT(DISTINCT CASE WHEN f.facilityType = 'Management' THEN f.facility_ID END) AS total_management_facilities,
    COUNT(DISTINCT CASE WHEN f.facilityType = 'Educational' THEN f.facility_ID END) AS total_educational_facilities
FROM
    Ministries m
JOIN
    Facilities f ON m.ministry_ID = f.ministry_ID
JOIN
    EmployeeSchedule es ON f.facility_ID = es.facility_ID
JOIN
    Employees e ON es.employee_ID = e.employee_ID
JOIN
    Citizens c ON e.medicareNumber = c.medicareNumber
GROUP BY
    m.ministry_ID,
    c.firstName,
    c.lastName,
    c.city
ORDER BY
    c.city ASC,
    total_educational_facilities DESC;

SELECT
	c.medicareNumber,
    c.firstName,
    c.lastName,
    c.birthDate,
    c.email,
    f.subType AS 'Role',
    MIN(es.startTime) AS first_day_of_work,
    COUNT(ib.medicareNumber) AS total_infections,
    SUM(DISTINCT HOUR(TIMEDIFF(es.endTime, es.startTime))) AS total_hours_scheduled
FROM
    Citizens c
JOIN
    Employees e ON c.medicareNumber = e.medicareNumber
JOIN
    EmployeeSchedule es ON e.employee_ID = es.employee_ID
JOIN 
	Facilities f ON f.facility_ID = es.facility_ID
JOIN
    InfectedBy ib ON c.medicareNumber = ib.medicareNumber
JOIN 
	Infections i ON i.infectionID = ib.infectionID
WHERE
    e.additionalRole = 'Counselor' AND
    i.infectionID = 1
GROUP BY
	e.employee_ID,
    c.firstName,
    c.lastName,
    c.birthDate,
    c.email,
    f.subType
HAVING
    COUNT(ib.medicareNumber) >= 3
ORDER BY
    e.role ASC,
    c.firstName ASC,
    c.lastName ASC;



/*Q18 triggers*/
/*Test when_teacher_infected
	INSERT INTO InfectedBy (medicareNumber, infectionID, dateInfected)
		VALUES 
		(500, 1, '2023-08-11');
*/
DELIMITER //
CREATE TRIGGER when_teacher_infected
AFTER INSERT ON InfectedBy
FOR EACH ROW
BEGIN
 
  -- Retrieve data from the inserted row in InfectedBy table
  DECLARE dateInfected DATE;
  DECLARE medicareNumber INT;
  DECLARE infectionID INT;
  SET dateInfected = NEW.dateInfected;
  SET medicareNumber = NEW.medicareNumber;
  SET infectionID = NEW.infectionID;

  /*Call procedures*/
  IF infectionID = 1 AND 
	(SELECT e.role FROM Employees e WHERE e.medicareNumber = medicareNumber) = 'Teacher'
  THEN
    CALL emailPrincipal(medicareNumber, infectionID, dateInfected);
   CALL cancelAssignments(medicareNumber, dateInfected);
  END IF;
END;
//
DELIMITER ;

/*email principal of the school where the teacher is infected*/
DELIMITER //
CREATE PROCEDURE emailPrincipal(IN medicareNumber INT, IN infectionID INT, IN dateInfected DATE)
BEGIN
  DECLARE dateEmail DATE;
  DECLARE principal_facility_ID INT;
  DECLARE principal_employee_ID INT;
  DECLARE subject VARCHAR(255);
  
  DECLARE nameTeacher VARCHAR(255);
  DECLARE typeInfection VARCHAR(255);
  DECLARE body TEXT;
  
  SET dateEmail = CURDATE();
  
	SET principal_facility_ID = (
		SELECT es.facility_ID
		FROM Employees e
		JOIN EmployeeSchedule es ON es.employee_ID = e.employee_ID
		WHERE e.medicareNumber = medicareNumber
		ORDER BY es.endTime DESC
		LIMIT 1
	);
  
  SET principal_employee_ID = (
    SELECT e.employee_ID
    FROM Employees e
    JOIN EmployeeSchedule es ON es.employee_ID = e.employee_ID
    WHERE e.role = 'Principal' AND es.facility_ID = principal_facility_ID
    LIMIT 1
  );
  
  SET subject = 'Warning';  
  
  SET nameTeacher = (
    SELECT CONCAT(c.firstName, ' ', c.lastName) AS full_name
    FROM Citizens c
    WHERE c.medicareNumber = medicareNumber
  );
  
  SET typeInfection = (
    SELECT i.type
    FROM Infections i
    WHERE i.infectionID = infectionID
  );
  
  SET body = CONCAT(nameTeacher, ' who teaches in your school has been infected with ', typeInfection, ' on ', dateInfected);

  /*Insert data in Email and logEmail table*/
  INSERT INTO Email (date, facility_ID, employee_ID, subject, body)
  VALUES (dateEmail, principal_facility_ID, principal_employee_ID, subject, body);

  INSERT INTO LogEmail (date, facility_ID, employee_ID, subject, body)
  VALUES (dateEmail, principal_facility_ID, principal_employee_ID, subject, SUBSTRING(body, 1, 80));
END;
//
DELIMITER ;

/*Cancel all assignment of teacher from two weeks of infected Date*/
DELIMITER //
CREATE PROCEDURE cancelAssignments(IN medicareNumber INT, IN dateInfected DATE)
BEGIN
	DECLARE employee_ID INT;
    
	SET employee_ID = (
		SELECT e.employee_ID
		FROM Employees e
		WHERE e.medicareNumber = medicareNumber
	);

	DELETE FROM EmployeeSchedule es
	WHERE es.employee_ID = employee_ID AND es.startTime <= DATE_ADD(dateInfected, INTERVAL 2 WEEK) AND es.startTime >= dateInfected;
END
//
DELIMITER ;

/*Q19 Requirements integrity*/
/*Check is there are conflicting schedules*/

/*Test when_conflicting_schedule
	INSERT INTO EmployeeSchedule (employee_ID, facility_ID, task, startTime, endTime)
	VALUES 
	(500, 3, 'Teaching', '2023-08-10 09:00:00', '2023-08-10 12:00:00');
*/
DELIMITER //
CREATE TRIGGER when_conflicting_schedule
BEFORE INSERT ON EmployeeSchedule 
FOR EACH ROW
BEGIN
    DECLARE employee_ID INT;
	DECLARE startTime DATETIME;
	DECLARE endTime DATETIME;
    DECLARE errorMessage VARCHAR(255);
    DECLARE recordCount INT;
	SET startTime = NEW.startTime;
	SET endTime = NEW.endTime;
    SET employee_ID = new.employee_ID;
    
    /*Check if there are conflicting time schedules*/
    SELECT COUNT(*)
    INTO recordCount
    FROM EmployeeSchedule es
    WHERE es.employee_ID = employee_ID 
		  AND  startTime >= es.startTime
          AND  startTime <= es.endTime;
    
	-- Check your conditions and set error_message if needed
    IF recordCount > 0
    THEN
        SET errorMessage = 'Cannot insert a conflicting schedule';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
    END IF;
END;
//
DELIMITER ;

/*
/*If an employee is scheduled for two different periods on the same day
either at the same facility or at different facilities, 
then at least one hour should be the duration between the first schedule and the second one.*/
DELIMITER //
CREATE TRIGGER check_schedule_1hour_break
BEFORE INSERT ON EmployeeSchedule
FOR EACH ROW
BEGIN
    DECLARE hourCount INT;

	DECLARE newStartTime DATETIME;
    DECLARE secondStartTime DATETIME;
	DECLARE employee_ID INT;
	DECLARE errorMessage VARCHAR(255);
	DECLARE recordCount INT;
	SET newStartTime = NEW.startTime;
	SET secondStartTime = NEW.endTime;
	SET employee_ID = new.employee_ID;

        -- Get the last end time of schedules on the same day
        SELECT MAX(es.endTime)
        INTO firstEndTime
        FROM EmployeeSchedule es 
        WHERE employee_ID = NEW.employee_ID
            AND DATE(startTime) = DATE(NEW.startTime);

        -- Check if there's at least one hour of duration between schedules
        IF TIMESTAMPDIFF(HOUR, lastEndTime, NEW.startTime) < 1 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot insert a schedule with less than one hour duration between periods on the same day';
        END IF;
END;
//
DELIMITER ;

/*Q20*/
/*Send email to all employees every sunday*/
/* --Check if event is created--
SELECT * FROM information_schema.events WHERE event_name = 'sunday_schedule';
DROP EVENT IF EXISTS sunday_schedule;
CALL send_schedule_emails();
*/

DELIMITER //
CREATE PROCEDURE send_schedule_emails()
BEGIN
    DECLARE facilityName VARCHAR(255);
    DECLARE facilityAddress VARCHAR(255);
    DECLARE facility_ID INT;
    DECLARE startTime DATETIME;
    DECLARE endTime DATETIME;    
    DECLARE emp_ID INT;
    DECLARE role VARCHAR(255);
    DECLARE firstName VARCHAR(255);
    DECLARE lastName VARCHAR(255);
    DECLARE email VARCHAR(255);
    DECLARE nextMonday DATE;
    DECLARE nextSunday DATE;
    DECLARE emailSubject TEXT;
    DECLARE emailBody TEXT;
    DECLARE done INT DEFAULT FALSE;
    
    /*Select all the schedule for the coming week*/
    DECLARE curs CURSOR FOR
    SELECT f.name, f.address, f.facility_ID, es.startTime, es.endTime, e.employee_ID, e.role, c.firstName, c.lastName, c.email
    FROM Citizens c
    JOIN Employees e ON c.medicareNumber = e.medicareNumber
    LEFT JOIN EmployeeSchedule es ON e.employee_ID = es.employee_ID
    JOIN Facilities f ON es.facility_ID = f.facility_ID
    WHERE es.startTime >= DATE_ADD(NOW(), INTERVAL 1 DAY) AND es.startTime <= DATE_ADD(NOW(), INTERVAL 1 WEEK);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	SET nextMonday = DATE_ADD(NOW(), INTERVAL 1 DAY);
    SET nextSunday = DATE_ADD(NOW(), INTERVAL 1 WEEK);

    OPEN curs;

    loop_start: LOOP
        FETCH curs INTO facilityName, facilityAddress, facility_ID, startTime, endTime, emp_ID, role, firstName, lastName, email;
        IF done THEN
            LEAVE loop_start;
        END IF;
        /*If no schedule for the coming week*/
        IF startTime IS NULL THEN
            SET emailSubject = CONCAT('Schedule for Monday', nextMonday, ' to Sunday ', nextSunday);
            SET emailBody = 'You have no assignments for that week';
            /*Insert data in Email and logEmail table*/
            INSERT INTO Email (date, facility_ID, employee_ID, subject, body)
            VALUES (NOW(), NULL, emp_ID, emailSubject, emailBody);
            INSERT INTO LogEmail (date, facility_ID, employee_ID, subject, body)
            VALUES (NOW(), NULL, emp_ID, emailSubject, SUBSTRING(emailBody, 1, 80));
        END IF;
		
        /*If schedule for the coming week*/
        IF startTime IS NOT NULL THEN
            SET emailSubject = CONCAT(facilityName, ' School Schedule for Monday', nextMonday, ' to Sunday ', nextSunday);
            SET emailBody = CONCAT(
                'Facility Name: ', facilityName, '\n',
                'Facility Address: ', facilityAddress, '\n',
                'First Name: ', firstName, '\n',
                'Last Name: ', lastName, '\n',
                'Employee Email: ', email, '\n',
                'Role: ', role, '\n',
                'Employee ID: ', CAST(emp_ID AS CHAR), '\n',
                'Start Time: ', startTime, '\n',
                'End Time: ', endTime, '\n'
            );
            
			/*Insert data in Email and logEmail table*/
            INSERT INTO Email (date, facility_ID, employee_ID, subject, body)
				VALUES (NOW(), facility_ID, emp_ID, emailSubject, emailBody);
            INSERT INTO LogEmail (date, facility_ID, employee_ID, subject, body)
				VALUES (NOW(), facility_ID, emp_ID, emailSubject, SUBSTRING(emailBody, 1, 80));
        END IF;     
    END LOOP loop_start;

    CLOSE curs;
END;
//
DELIMITER ;

/*Create the event to call the stored procedure every Sunday*/
DELIMITER //
CREATE EVENT sunday_schedule
ON SCHEDULE EVERY 1 WEEK 
DO
BEGIN
	CALL send_schedule_emails();
END;
//
DELIMITER ;
