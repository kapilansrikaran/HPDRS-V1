-- Demo Day 

-- pre requirest 
-- Open root user into mysql workbenck time to time check the are they currectly updating or not

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Administrator (root user)
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

-- User Table 
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE TABLE users (
  user_id int NOT NULL AUTO_INCREMENT primary key,
  full_name varchar(200),
  username varchar(45) NOT NULL,
  password varchar(64) NOT NULL
);

-- Insert user data by using procedure
DELIMITER //
CREATE PROCEDURE CreateUser(IN p_full_name VARCHAR(200),IN p_username VARCHAR(45),IN p_password VARCHAR(64))
BEGIN
    INSERT INTO users (full_name, username, password)
    VALUES (p_full_name, p_username, p_password);
END; //
DELIMITER ;

Call CreateUser('Kapilan', 'tg489', 'tg489');
Call CreateUser('Madhushan', 'tg507', 'tg507');
Call CreateUser('Chamidu', 'tg523', 'tg523');
Call CreateUser('Ravi', 'tg266', 'tg266');
Select * from hostel_db.users; 


-- Updatating full name by using procedure
DELIMITER //
CREATE PROCEDURE UpdateFullName(IN p_user_id INT, IN p_new_full_name VARCHAR(200))
BEGIN
    UPDATE users
    SET full_name = p_new_full_name
    WHERE user_id = p_user_id;
END; //
DELIMITER ;

Call UpdateFullName(1, "Kapilan Srikaran");
Select * from hostel_db.users;


-- Delete user by using procedure 
DELIMITER //
CREATE PROCEDURE DeleteUser(IN p_user_id INT)
BEGIN
    DELETE FROM users
    WHERE user_id = p_user_id;
END; //
DELIMITER ;

Call DeleteUser(1);
Select * from hostel_db.users;

-- Role Table
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE TABLE roles(
	role_id INT AUTO_INCREMENT PRIMARY KEY, 
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Insert role by using procedure
DELIMITER //
CREATE PROCEDURE InsertRole( IN p_role_name VARCHAR(50) )
BEGIN
    INSERT INTO roles (role_name)
    VALUES (p_role_name);
END; //
DELIMITER ;

CALL InsertRole('STUDENT');
CALL InsertRole('SUBWARDEN');
CALL InsertRole('ACADEMICWARDEN');
CALL InsertRole('SSC');
CALL InsertRole('DEAN');
Select * from hostel_db.roles;

-- RoleUser Table
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE TABLE users_roles(
	id int auto_increment primary key,
    user_id int not null,
    role_id int not null,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);


-- Insert role by using procedure
DELIMITER //
CREATE PROCEDURE InsertUserRole(IN p_user_id INT, IN p_role_id INT )
BEGIN
    INSERT INTO users_roles (user_id, role_id)
    VALUES (p_user_id, p_role_id);
END; //
DELIMITER ;

-- (user_id, role_id)
CALL InsertUserRole(2, 1); 
CALL InsertUserRole(3, 1); 
CALL InsertUserRole(4, 1); 
CALL InsertUserRole(5, 1); 

Select * from hostel_db.users_roles;


-- Property Table
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Create table property(
	property_id int auto_increment primary key,
    property_name varchar(100) not null,
    property_location varchar(100) not null
);

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Student
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE USER 'student'@'localhost' IDENTIFIED BY 'student';
GRANT EXECUTE ON PROCEDURE hostel_db.CreateComplaint TO 'student'@'localhost';
GRANT SELECT ON hostel_db.complaint_view TO 'student'@'localhost';

-- > mysql -u student -p
SHOW DATABASES;
USE hostel_db;
SHOW TABLES;
SHOW CREATE PROCEDURE CreateComplaint;

-- Listing all complaint by using view
Select * from complaint_view;

-- Add Complaint by using Stored Procedure
CALL CreateComplaint('Re-Again Chair is broken', 2, 2, 'open');




-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Sub-Warden
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE USER 'subwarden'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON hostel_db.complaint TO 'subwarden'@'localhost';
GRANT ALL PRIVILEGES ON hostel_db.property TO 'subwarden'@'localhost';

GRANT EXECUTE ON PROCEDURE hostel_db.InsertProperty TO 'subwarden'@'localhost';
GRANT EXECUTE ON PROCEDURE hostel_db.UpdatePropertyLocation TO 'subwarden'@'localhost';
GRANT EXECUTE ON PROCEDURE hostel_db.DeleteProperty TO 'subwarden'@'localhost';
SHOW CREATE PROCEDURE InsertProperty;

-- > mysql -u subwarden -p 
USE hostel_db;
SHOW TABLES;


-- Insert property by using procedure
DELIMITER //
CREATE PROCEDURE InsertProperty( IN p_property_name VARCHAR(100), IN p_property_location VARCHAR(100) )
BEGIN
    INSERT INTO property (property_name, property_location)
    VALUES (p_property_name, p_property_location);
END; //
DELIMITER ;

CALL InsertProperty('Chair', 'Room 123');
CALL InsertProperty('Fan', 'Room 212');
CALL InsertProperty('Table', 'Room 321');
Select * from hostel_db.property;


-- Update Property Location by procedure
DELIMITER //
CREATE PROCEDURE UpdatePropertyLocation(IN p_property_id INT, IN p_new_location VARCHAR(100))
BEGIN
    UPDATE property
    SET property_location = p_new_location
    WHERE property_id = p_property_id;
END; //
DELIMITER ;

CALL UpdatePropertyLocation(1, 'Room 132');
Select * from hostel_db.property;


-- Delete Property by using procedure
DELIMITER //
CREATE PROCEDURE DeleteProperty(IN p_property_id INT)
BEGIN
        DELETE FROM property WHERE property_id = p_property_id;
END; //
DELIMITER ;

CALL DeleteProperty(3);
Select * from hostel_db.property;


-- Property list by using view (academic- warden, ssc and dean to see the property)
CREATE VIEW property_view AS
SELECT
    property_id,
    property_name,
    property_location
FROM
    property;

Select * from property_view;




-- Complaint
-- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>












-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Academic warden
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE USER 'academicwarden'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON hostel_db.property_view TO 'academicwarden'@'localhost';
-- GRANT EXECUTE ON PROCEDURE hostel_db.DeleteProperty TO 'academicwarden'@'localhost';


-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- SSC 
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE USER 'ssc'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON hostel.property_view TO 'ssc'@'localhost';


-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-- Dean
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE USER 'dean'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON hostel.property_view TO 'dean'@'localhost';





