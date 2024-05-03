SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
create database airlineee;
use airlineee;
drop database airlineee;  

CREATE TABLE airlines_list (
  id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  airlines text NOT NULL
);

CREATE TABLE airport_list (
  id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  airport text NOT NULL,
  location text NOT NULL
);

CREATE TABLE flight_list (
  id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  airline_id int NOT NULL,
  plane_no text NOT NULL,
  departure_airport_id int NOT NULL,
  arrival_airport_id int NOT NULL,
  departure_datetime datetime NOT NULL,
  arrival_datetime datetime NOT NULL,
  seats int NOT NULL DEFAULT 0,
  price double NOT NULL,
  date_created datetime NOT NULL DEFAULT current_timestamp(),
  FOREIGN KEY (airline_id) REFERENCES airlines_list(id),
  FOREIGN KEY (departure_airport_id) REFERENCES airport_list(id),
  FOREIGN KEY (arrival_airport_id) REFERENCES airport_list(id)
);

CREATE TABLE booked_flight (
  id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  flight_id int NOT NULL,
  name text NOT NULL,
  address text NOT NULL,
  contact text NOT NULL,
  FOREIGN KEY (flight_id) REFERENCES flight_list(id)
);

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);


ALTER TABLE airlines_list
  MODIFY id int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE airport_list
  MODIFY id int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE booked_flight
  MODIFY id int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
  
ALTER TABLE flight_list
  MODIFY id int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE Users
  MODIFY id int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

INSERT INTO airlines_list (id, airlines) VALUES
(1, 'Air India'),
(2, 'IndiGo'),
(3, 'SpiceJet');

INSERT INTO airport_list (id, airport, location) VALUES
(1, 'Indira Gandhi International Airport', 'New Delhi'),
(2, 'Chhatrapati Shivaji Maharaj International Airport', 'Mumbai'),
(3, 'Kempegowda International Airport', 'Bengaluru'),
(4, 'Netaji Subhas Chandra Bose International Airport', 'Kolkata'),
(5, 'Rajiv Gandhi International Airport', 'Hyderabad');

INSERT INTO flight_list (id, airline_id, plane_no, departure_airport_id, arrival_airport_id, departure_datetime, arrival_datetime, seats, price) VALUES
(1, 1, 'AI101', 1, 2, '2024-04-21 08:00:00', '2024-04-21 11:00:00', 200, 8000),
(2, 2, '6E205', 2, 3, '2024-04-22 10:00:00', '2024-04-22 12:30:00', 150, 6000),
(3, 3, 'SG321', 3, 4, '2024-04-23 12:00:00', '2024-04-23 15:00:00', 180, 7000),
(4, 1, 'AI102', 1, 2, '2024-04-21 14:00:00', '2024-04-21 17:00:00', 180, 8500),
(5, 2, '6E206', 2, 3, '2024-04-22 08:30:00', '2024-04-22 10:30:00', 160, 6200),
(6, 3, 'SG322', 4, 5, '2024-04-23 09:00:00', '2024-04-23 12:00:00', 200, 7200);

INSERT INTO booked_flight (id, flight_id, name, address, contact) VALUES
(1, 1, 'Rahul Sharma', '123, New Delhi', '+91 9876543210'),
(2, 2, 'Priya Singh', '456, Mumbai', '+91 9876543211'),
(3, 3, 'Amit Patel', '789, Bengaluru', '+91 9876543212');

INSERT INTO Users (id ,username, password, email, phone_number) VALUES
(1,'rahul_sharma', 'rs@123', 'rahul.sharma@example.com', '+91 98765 43210'),
(2,'priya_singh', 'ps@456', 'priya.singh@example.com', '+91 98765 43211'),
(3,'amit_patel', 'ap@789', 'amit.patel@example.com', '+91 98765 43212');

DELIMITER //
CREATE TRIGGER reduce_seats_after_booking
AFTER INSERT ON booked_flight
FOR EACH ROW
BEGIN
    UPDATE flight_list 
    SET seats = seats - 1 
    WHERE id = NEW.flight_id;
END;
//
DELIMITER ;

INSERT INTO booked_flight (flight_id, name, address, contact) VALUES
(4, 'Sneha Patel', '456, Ahmedabad', '+91 9876543213');

select * from booked_flight;
select * from flight_list;
select * from airport_list;
select * from airlines_list;
select * from Users;