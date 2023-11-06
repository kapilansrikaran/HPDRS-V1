CREATE DATABASE uhpdcs;
USE uhpdcs;

-- Table 1:
CREATE TABLE roles(
	role_id INT AUTO_INCREMENT PRIMARY KEY, 
    role_name VARCHAR(50) UNIQUE NOT NULL
);
-- Insert roles
INSERT INTO roles (role_name) 
VALUES 
	('student'),
	('sub-warden'),
	('academic_warden'),
	('ssc'),
	('dean'),
	('administrator');


-- Table 2:
-- This based on role based, For future scope use genterlazation 
CREATE TABLE users(
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL, 
    user_password VARCHAR(200) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(80) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);
-- Insert users
INSERT INTO users(username,user_password,first_name,last_name,email,role_id) 
VALUES
	('ACS001','acs001','Subash','Jayasinghe','subash@ictec.ruh.ac.lk',5),

	('ACS002','acs002','D.N.','Kannangara','ssc@ictec.ruh.ac.lk',4),

	('ACS003','acs001','Ajward','A.M','ajward@gmail.com',3),
	('ACS004','acs002','Rajawatta','K.M.W','rajawatta@gmail.com',3),

	('NACS001','nacs001','N.B.Kusala','K.M.W','kusala@gmail.com',2),
	('NACS002','nacs002','Gunawardhana','S.P.A','gunawardhana@gmail.com',2),

	('TG489','tg489','Kapilan','Srikaran','kapilansrikaran@gmail.com',1),
	('TG555','tg555','Pavitha','Nimal','pavitha@gmail.com',2);

CREATE TABLE  user_contact_no(
	user_contact_no_id INT AUTO_INCREMENT PRIMARY KEY,
	contact_no VARCHAR(20),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
INSERT INTO user_contact_no(contact_no,user_id) 
VALUES
	('+94714335101',5),
	('+94702132518',6),
	('+94740012375',6);

-- Table 3:
CREATE TABLE hostels(
	hostel_id INT AUTO_INCREMENT PRIMARY KEY,
    hostel_name VARCHAR(100) NOT NULL,
	hostel_type ENUM('boys','girls') NOT NULL,
	hostel_capacity INT NOT NULL
);
-- Insert hostels
INSERT INTO hostels(hostel_name, hostel_type, hostel_capacity) VALUES
("Boy's Hostel", "boys", 400),
("Girl's Hostel", "girls", 400);


-- Table 4:
CREATE TABLE hostel_users(
	hostel_user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    hostel_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id)
);
-- Insert handlers of the hostels and complaints
INSERT INTO hostel_users(user_id,hostel_id)
VALUES
	(1,1),
	(1,2),
	(2,1),
	(2,2),
	(3,1),
	(4,2),
    (5,1),
    (6,2),
    (7,1);


-- Table 5:
CREATE TABLE rooms(
	room_id INT AUTO_INCREMENT PRIMARY KEY,
	room_no INT NOT NULL,
	room_capacity INT NOT NULL, 
    user_id INT,
    hostel_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id)
);
-- Insert Rooms


-- Table 6: 
CREATE TABLE hostel_properties(
	property_id INT AUTO_INCREMENT PRIMARY KEY,
    property_name VARCHAR(50) NOT NULL,
    property_type ENUM('furniture','electrical_item','plumbing','building_structural') NOT NULL,
    property_location VARCHAR(100) NOT NULL, 	/*{eg: Room 489, 2nd floor bathroom} */
	property_qr_code BLOB, 
	room_id INT,
    hostel_id INT,
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);


-- Table 7:  
CREATE TABLE hostel_property_damage_complaints(
	complain_id INT AUTO_INCREMENT PRIMARY KEY,
	complaint_ticket_id VARCHAR(50) UNIQUE NOT NULL,
    complaint_description TEXT NOT NUll,  
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    attachment LONGBLOB, 
    user_id INT, 
    property_id INT,
    hostel_id INT,
    complain_current_status ENUM('open','under_review','resolved') NOT NULL,
    hostel_user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES hostel_properties(property_id),
    FOREIGN KEY (hostel_id) REFERENCES hostels(hostel_id),
    FOREIGN KEY (hostel_user_id) REFERENCES hostel_users(hostel_user_id)
);






