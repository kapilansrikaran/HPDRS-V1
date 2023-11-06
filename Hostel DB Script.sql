 create database hostel_db;
 use hostel_db;
 



-- GRANT INSERT, UPDATE, DELETE ON hostel_db.complaint TO 'student'@'localhost';
-- REVOKE INSERT, UPDATE, DELETE ON hostel_db.complaint FROM 'student'@'localhost';










-- Flush privileges to apply the changes
FLUSH PRIVILEGES;








-- Property
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx















-- Complaint 
-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CREATE TABLE complaint(
	complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_description TEXT NOT NUll,  
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    complainer_id INT,
    property_id INT,
    complain_current_status ENUM('open','in-progress', 'close') NOT NULL,
	FOREIGN KEY (complainer_id) REFERENCES users(user_id),
    FOREIGN KEY (property_id) REFERENCES property(property_id)
); 


CREATE TABLE complaint_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT,
    role_id INT,
    assigned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaint(complaint_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);


-- Complant View
CREATE VIEW complaint_view AS
SELECT
    c.complaint_id,
    c.complaint_description,
    c.create_date,
    u.username,
    c.complain_current_status,
    u.username AS complainer_username,
    p.property_name
FROM complaint c
LEFT JOIN users u ON c.complainer_id = u.user_id
LEFT JOIN property p ON c.property_id = p.property_id;

Select * from complaint_view;


-- Create complaint by using procedure
DELIMITER //
CREATE PROCEDURE CreateComplaint(
    IN p_complaint_description TEXT,
    IN p_complainer_id INT,
    IN p_property_id INT,
    IN p_complain_current_status ENUM('open','in-progress', 'close')
)
BEGIN
    INSERT INTO complaint (complaint_description, create_date, complainer_id, property_id, complain_current_status)
    VALUES (p_complaint_description, CURRENT_TIMESTAMP, p_complainer_id, p_property_id, p_complain_current_status);
END;
//
DELIMITER ;

Select * from hostel_db.complaint;
CALL CreateComplaint('Chair is broken', 2, 2, 'open');
CALL CreateComplaint('Again Chair is broken', 2, 2, 'open');
Select * from hostel_db.complaint;


-- Complaint escalation 
-- xxxxxxxxxxxxxxxxxxxx
-- Step 1:  Stored Function to Calculate Elapsed Time
DELIMITER //
CREATE FUNCTION CalculateElapsedTime(complaintDate TIMESTAMP) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE currentTime TIMESTAMP;
    DECLARE elapsedTime INT;

    SET currentTime = NOW();
    SET elapsedTime = TIMESTAMPDIFF(DAY, complaintDate, currentTime);

    RETURN elapsedTime;
END //
DELIMITER ;


-- Step 2: Stored Procedure to Update Complaint Status and Escalate
DELIMITER //
CREATE PROCEDURE UpdateComplaintStatusAndEscalate()
BEGIN
    DECLARE complaintID INT;
    DECLARE currentStatus ENUM('open', 'in-progress', 'close');

    -- Iterate through complaints
    DECLARE cur CURSOR FOR
        SELECT complaint_id, complain_current_status, create_date
        FROM complaint;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO complaintID, currentStatus, createDate;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate elapsed time
        SET elapsedTime = CalculateElapsedTime(createDate);

        -- Check escalation rules and update status
        IF currentStatus = 'open' AND elapsedTime > 7 THEN
            -- Escalate to academic-warden
            -- Update status and send notifications
            UPDATE complaint SET complain_current_status = 'in-progress' WHERE complaint_id = complaintID;
            -- Add logic to notify the academic-warden
        ELSEIF currentStatus = 'in-progress' AND elapsedTime > 14 THEN
            -- Escalate to SSC
            -- Update status and send notifications
            UPDATE complaint SET complain_current_status = 'in-progress' WHERE complaint_id = complaintID;
            -- Add logic to notify the academic warden
        END IF;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;


-- Step 3
DELIMITER //
CREATE EVENT CheckComplaintEscalation
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    CALL UpdateComplaintStatusAndEscalate();
END;
DELIMITER ;








CALL UpdateComplaintStatus(1, 'in-progress');
Select * from hostel_db.complaint;


CREATE TABLE complaint_status_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT,
    new_status ENUM('open', 'in-progress', 'closed'),
    status_change_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaint(complaint_id)
);

Select * from hostel_db.complaint_status_log;
















 

 