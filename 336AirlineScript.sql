CREATE DATABASE IF NOT EXISTS 336AirlineProject;

USE 336AirlineProject;

DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Flight_Avalibility;
DROP TABLE IF EXISTS Flight_Operating_Days;
DROP TABLE IF EXISTS Flight_Schedule;
DROP TABLE IF EXISTS Airline_Company_Aircraft;
DROP TABLE IF EXISTS Airline_Company_Airport;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Airline_Company;
DROP TABLE IF EXISTS Account;

CREATE TABLE Account (
   Account_Number INT PRIMARY KEY AUTO_INCREMENT,
   First_Name VARCHAR(50) NOT NULL,
   Last_Name VARCHAR(50) NOT NULL,
   Username VARCHAR(50) NOT NULL,
   Password VARCHAR(50) NOT NULL,
   SSN VARCHAR(11) NOT NULL,
   Role ENUM('Customer', 'Representative', 'Administrator') NOT NULL
);

INSERT INTO Account (First_Name, Last_Name, Username, Password, SSN, Role) VALUES 
('c', 'c', 'c', 'c', 'c', 'Customer'),
('r', 'r', 'r', 'r', 'r', 'Representative'),
('a', 'a', 'a', 'a', 'a', 'Administrator');



CREATE TABLE Airline_Company (
Airline_ID VARCHAR(2) PRIMARY KEY,
Airline_Name VARCHAR (20)
);

INSERT INTO Airline_Company (Airline_ID, Airline_Name) VALUES
('DA', 'Delta Air Lines'),
('AA', 'American Airlines'),
('UA', 'United Airlines'),
('SW', 'Southwest Airline');


CREATE TABLE Airport (
   Airport_ID VARCHAR(3) PRIMARY KEY,
   City VARCHAR (30),
   State VARCHAR (10)
);

INSERT INTO Airport (Airport_ID, City, State) VALUES
('ATL', 'Atlanta', 'GA'),
('LAX', 'Los Angeles', 'CA'),
('DFW', 'Dallas', 'TX'),
('DEN', 'Denver', 'CO'),
('ORD', 'Chicago', 'IL'),
('JFK', 'New York City', 'NY'),
('MCO', 'Orlando', 'FL'),
('LAS', 'Las Vegas', 'NV'),
('CLT', 'Charlotte', 'NC'),
('MIA', 'Miami', 'FL'),
('SEA', 'Seattle and Tacoma', 'WA'),
('EWR', 'Newark', 'NJ'),
('SFO', 'San Francisco', 'CA'),
('PHX', 'Phoenix', 'AZ'),
('IAH', 'Houston', 'TX'),
('BOS', 'Boston', 'MA'),
('FLL', 'Fort Lauderdale', 'FL'),
('MSP', 'Minneapolis', 'MN'),
('LGA', 'New York City', 'NY'),
('DTW', 'Detroit', 'MI'),
('PHL', 'Philadelphia', 'PA'),
('SLC', 'Salt Lake City', 'UT'),
('BWI', 'Baltimore/Washington, D.C.', 'MD'),
('DCA', 'Washington, D.C.', 'VA'),
('SAN', 'San Diego', 'CA'),
('IAD', 'Washington, D.C.', 'VA'),
('TPA', 'Tampa', 'FL'),
('BNA', 'Nashville', 'TN'),
('AUS', 'Austin', 'TX'),
('MDW', 'Chicago', 'IL');


CREATE TABLE Aircraft(
   Aircraft_ID VARCHAR(10) PRIMARY KEY,
   Seats INT
);

INSERT INTO Aircraft (Aircraft_ID, Seats) VALUES
('0000', 50),
('0001', 45),
('0002', 40),
('0003', 35),
('0004', 30),
('0005', 25),
('0006', 20);



CREATE TABLE Airline_Company_Airport (
Airline_ID VARCHAR(2),
Airport_ID VARCHAR(3),
PRIMARY KEY (Airline_ID, Airport_ID),
FOREIGN KEY (Airline_ID) REFERENCES Airline_Company(Airline_ID),
FOREIGN KEY (Airport_ID) REFERENCES Airport(Airport_ID)
);

INSERT INTO Airline_Company_Airport (Airline_ID, Airport_ID) VALUES
('DA','EWR'),
('DA','JFK'),
('DA','FLL'),
('DA','SFO'),
('DA','SLC'),
('DA','MDW'),
('DA','BOS'),
('AA','EWR'),
('AA','JFK'),
('AA','FLL'),
('AA','SFO'),
('AA','SLC'),
('AA','MDW'),
('AA','BOS'),
('UA','EWR'),
('UA','JFK'),
('UA','FLL'),
('UA','SFO'),
('UA','SLC'),
('UA','MDW'),
('UA','BOS');

CREATE TABLE Airline_Company_Aircraft(
   Airline_ID VARCHAR(2),
   Aircraft_ID VARCHAR(10),
   PRIMARY KEY (Airline_ID, Aircraft_ID),
   FOREIGN KEY (Airline_ID) REFERENCES Airline_Company(Airline_ID),
   FOREIGN KEY (Aircraft_ID) REFERENCES Aircraft(Aircraft_ID)
);
INSERT INTO Airline_Company_Aircraft (Airline_ID, Aircraft_ID) VALUES
('DA', '0000'),
('DA', '0001'),
('DA', '0002'),
('DA', '0003'),
('DA', '0004'),
('DA', '0005'),
('DA', '0006'),
('AA', '0000'),
('AA', '0001'),
('AA', '0002'),
('AA', '0003'),
('AA', '0004'),
('AA', '0005'),
('AA', '0006'),
('UA', '0000'),
('UA', '0001'),
('UA', '0002'),
('UA', '0003'),
('UA', '0004'),
('UA', '0005'),
('UA', '0006');

#Recurring airline schedual
CREATE TABLE Flight_Schedule(
Flight_Number VARCHAR(20) PRIMARY KEY,
Airline_ID VARCHAR(2),
Departure_Airport_ID VARCHAR(3),
Departure_Time TIME,
Arrival_Airport_ID VARCHAR(3),
Arrival_Time TIME,
FOREIGN KEY (Airline_ID) REFERENCES Airline_Company(Airline_ID),
FOREIGN KEY (Departure_Airport_ID) REFERENCES Airport(Airport_ID),
FOREIGN KEY (Arrival_Airport_ID) REFERENCES Airport(Airport_ID)
);

INSERT INTO Flight_Schedule (Flight_Number, Airline_ID, Departure_Airport_ID, Departure_Time, Arrival_Airport_ID, Arrival_Time) VALUES
('DA100', 'DA', 'JFK', '08:00:00', 'SFO', '11:15:00'),
('DA200', 'DA', 'JFK', '12:00:00', 'SFO', '15:15:00'),
('AA200', 'AA', 'EWR', '09:45:00', 'MIA', '12:30:00'),
('UA300', 'UA', 'SFO', '13:15:00', 'JFK', '16:45:00');

#Flight opp days
CREATE TABLE Flight_Operating_Days (
Flight_Number VARCHAR(20),
Day_Of_Week VARCHAR (50),
CHECK (Day_Of_Week IN ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'))
);

INSERT INTO Flight_Operating_Days (Flight_Number, Day_Of_Week) VALUES
('DA100', 'Monday'),
('DA100', 'Wednesday'),
('AA200', 'Tuesday'),
('AA200', 'Friday'),
('UA300', 'Thursday'),
('UA300', 'Saturday');

#flight avalibility
CREATE TABLE Flight_Avalibility (
Instance_ID INT PRIMARY KEY AUTO_INCREMENT,
Flight_Number VARCHAR(20),
Flight_Date DATE,
Aircraft_ID VARCHAR(20),
Base_Price DECIMAL (10,2),
Seats_Available INT,
FOREIGN KEY (Flight_Number) REFERENCES Flight_Schedule(Flight_Number),
FOREIGN KEY (Aircraft_ID) REFERENCES Aircraft(Aircraft_ID)
);

INSERT INTO Flight_Avalibility (Flight_Number, Flight_Date, Aircraft_ID, Base_Price, Seats_Available) VALUES
('DA100', '2025-06-02', '0001', 100.00, 45),
('DA100', '2025-06-04', '0003', 100.00, 35),
('DA200', '2025-06-02', '0003', 100.00, 35),
('AA200', '2025-06-03', '0000', 100.00, 50),
('AA200', '2025-06-06', '0002', 100.00, 40),
('UA300', '2025-06-05', '0004', 100.00, 30),
('UA300', '2025-06-07', '0005', 100.00, 25);

CREATE TABLE Bookings(
Account_Number INT,
Instance_ID INT,
Price DECIMAL(10,2),
Class ENUM('Economy', 'Business', 'First'),
PRIMARY KEY (Account_Number, Instance_ID),
FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number) ON DELETE CASCADE,
FOREIGN KEY (Instance_ID) REFERENCES Flight_Avalibility(Instance_ID)
);





