CREATE DATABASE IF NOT EXISTS PathPilot;

USE PathPilot;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50),
    year_of_study INT
);

SHOW TABLES;

USE PathPilot;

CREATE TABLE Skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    skill_category VARCHAR(50)
);

SHOW TABLES;

USE PathPilot;

CREATE TABLE Student_Skills (
    student_skill_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level VARCHAR(30),

    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    FOREIGN KEY (skill_id)
        REFERENCES Skills(skill_id),

    UNIQUE (student_id, skill_id)
);

USE PathPilot;
SHOW TABLES;

USE PathPilot;

CREATE TABLE Opportunities (
    opportunity_id INT PRIMARY KEY AUTO_INCREMENT,
    opportunity_title VARCHAR(100) NOT NULL,
    company_name VARCHAR(100),
    opportunity_type VARCHAR(50),
    location VARCHAR(100),
    stipend DECIMAL(10,2),
    minimum_cgpa DECIMAL(3,2),
    application_deadline DATE
);
USE PathPilot;
SHOW TABLES;

USE PathPilot;

CREATE TABLE Opportunity_Skills (
    opportunity_skill_id INT PRIMARY KEY AUTO_INCREMENT,
    opportunity_id INT NOT NULL,
    skill_id INT NOT NULL,

    FOREIGN KEY (opportunity_id)
        REFERENCES Opportunities(opportunity_id),

    FOREIGN KEY (skill_id)
        REFERENCES Skills(skill_id),

    UNIQUE (opportunity_id, skill_id)
);

USE PathPilot;
SHOW TABLES;

USE PathPilot;

CREATE TABLE Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    opportunity_id INT NOT NULL,
    application_date DATE,
    application_status VARCHAR(30) DEFAULT 'Applied',

    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),

    FOREIGN KEY (opportunity_id)
        REFERENCES Opportunities(opportunity_id),

    UNIQUE (student_id, opportunity_id)
);
USE PathPilot;
SHOW TABLES;


USE PathPilot;

INSERT INTO Students
(student_name, email, department, year_of_study, cgpa)
VALUES
('Divya', 'divya@example.com', 'CSE', 2, 7.95),
('Rohan', 'rohan@example.com', 'CSE', 2, 8.20),
('Anu', 'anu@example.com', 'IT', 3, 8.50),
('Rahul', 'rahul@example.com', 'CSE', 3, 7.60),
('Priya', 'priya@example.com', 'IT', 2, 9.00);

USE PathPilot;

ALTER TABLE Students
ADD COLUMN cgpa DECIMAL(3,2);

INSERT INTO Students
(student_name, email, department, year_of_study, cgpa)
VALUES
('Divya', 'divya@example.com', 'CSE', 2, 7.95),
('Rohan', 'rohan@example.com', 'CSE', 2, 8.20),
('Anu', 'anu@example.com', 'IT', 3, 8.50),
('Rahul', 'rahul@example.com', 'CSE', 3, 7.60),
('Priya', 'priya@example.com', 'IT', 2, 9.00);

SELECT * FROM Students;

INSERT INTO Skills (skill_name, skill_category)
VALUES
('Java', 'Programming'),
('Python', 'Programming'),
('SQL', 'Database'),
('HTML', 'Web Development'),
('CSS', 'Web Development'),
('JavaScript', 'Web Development'),
('Data Structures', 'Computer Science'),
('Communication', 'Soft Skills'),
('Problem Solving', 'Soft Skills');

USE PathPilot;
SELECT * FROM Skills;


USE PathPilot;

INSERT INTO Student_Skills
(student_id, skill_id, proficiency_level)
VALUES
(1, 1, 'Beginner'),
(1, 3, 'Intermediate'),
(1, 7, 'Beginner'),
(2, 2, 'Intermediate'),
(2, 3, 'Intermediate'),
(3, 1, 'Advanced'),
(3, 7, 'Advanced'),
(4, 2, 'Beginner'),
(4, 4, 'Intermediate'),
(5, 1, 'Intermediate'),
(5, 3, 'Advanced');

SELECT * FROM Student_Skills;

SELECT
    s.student_name,
    sk.skill_name,
    ss.proficiency_level
FROM Students s
JOIN Student_Skills ss
    ON s.student_id = ss.student_id
JOIN Skills sk
    ON ss.skill_id = sk.skill_id
ORDER BY s.student_name;

USE PathPilot;

INSERT INTO Opportunities
(opportunity_title, company_name, opportunity_type,
 location, stipend, minimum_cgpa, application_deadline)
VALUES
('Java Developer Intern', 'Tech Solutions',
 'Internship', 'Bangalore', 10000, 7.00, '2026-12-15'),

('Python Developer Intern', 'CodeWorks',
 'Internship', 'Hyderabad', 12000, 7.50, '2026-11-30'),

('Web Developer Intern', 'WebTech',
 'Internship', 'Chennai', 8000, 6.50, '2026-12-20'),

('Software Engineer Trainee', 'NextGen Systems',
 'Full-Time', 'Bangalore', 25000, 8.00, '2027-01-15'),

('Database Intern', 'DataSmart',
 'Internship', 'Hyderabad', 9000, 7.00, '2026-12-10');


SELECT * FROM Opportunities;


USE PathPilot;

INSERT INTO Opportunity_Skills
(opportunity_id, skill_id)
VALUES
(1, 1),
(1, 7),
(1, 3),
(2, 2),
(2, 3),
(3, 4),
(3, 5),
(3, 6),
(4, 1),
(4, 7),
(4, 9),
(5, 3);

SELECT * FROM Opportunity_Skills;

SELECT
    o.opportunity_title,
    o.company_name,
    s.skill_name
FROM Opportunities o
JOIN Opportunity_Skills os
    ON o.opportunity_id = os.opportunity_id
JOIN Skills s
    ON os.skill_id = s.skill_id
ORDER BY o.opportunity_title;


USE PathPilot;

INSERT INTO Applications
(student_id, opportunity_id, application_date, application_status)
VALUES
(1, 1, '2026-10-01', 'Applied'),
(1, 5, '2026-10-02', 'Under Review'),
(2, 2, '2026-10-03', 'Applied'),
(3, 4, '2026-10-04', 'Shortlisted'),
(5, 1, '2026-10-05', 'Applied');


SELECT * FROM Applications;

SELECT
    a.application_id,
    s.student_name,
    o.opportunity_title,
    o.company_name,
    a.application_date,
    a.application_status
FROM Applications a
JOIN Students s
    ON a.student_id = s.student_id
JOIN Opportunities o
    ON a.opportunity_id = o.opportunity_id;


 USE PathPilot;
SELECT * FROM Applications;

SELECT
    a.application_id,
    s.student_name,
    o.opportunity_title,
    o.company_name,
    a.application_date,
    a.application_status
FROM Applications a
JOIN Students s
    ON a.student_id = s.student_id
JOIN Opportunities o
    ON a.opportunity_id = o.opportunity_id;


  USE PathPilot;

SELECT DISTINCT
    s.student_name,
    sk.skill_name,
    o.opportunity_title,
    o.company_name,
    o.location
FROM Students s
JOIN Student_Skills ss
    ON s.student_id = ss.student_id
JOIN Skills sk
    ON ss.skill_id = sk.skill_id
JOIN Opportunity_Skills os
    ON sk.skill_id = os.skill_id
JOIN Opportunities o
    ON os.opportunity_id = o.opportunity_id
WHERE s.student_id = 1;


USE PathPilot;

SELECT DISTINCT
    s.student_name,
    s.cgpa,
    o.opportunity_title,
    o.company_name,
    o.minimum_cgpa,
    o.location
FROM Students s
JOIN Student_Skills ss
    ON s.student_id = ss.student_id
JOIN Skills sk
    ON ss.skill_id = sk.skill_id
JOIN Opportunity_Skills os
    ON sk.skill_id = os.skill_id
JOIN Opportunities o
    ON os.opportunity_id = o.opportunity_id
WHERE s.student_id = 1
  AND s.cgpa >= o.minimum_cgpa
  AND o.application_deadline >= CURDATE();



  USE PathPilot;

CREATE OR REPLACE VIEW Eligible_Opportunities AS
SELECT DISTINCT
    s.student_id,
    s.student_name,
    s.cgpa,
    o.opportunity_id,
    o.opportunity_title,
    o.company_name,
    o.location,
    o.minimum_cgpa,
    o.application_deadline
FROM Students s
JOIN Student_Skills ss
    ON s.student_id = ss.student_id
JOIN Skills sk
    ON ss.skill_id = sk.skill_id
JOIN Opportunity_Skills os
    ON sk.skill_id = os.skill_id
JOIN Opportunities o
    ON os.opportunity_id = o.opportunity_id
WHERE s.cgpa >= o.minimum_cgpa
  AND o.application_deadline >= CURDATE();



  SELECT *
FROM Eligible_Opportunities
WHERE student_id = 1;



SHOW FULL TABLES
WHERE Table_type = 'VIEW';


USE PathPilot;

SELECT
    s.student_name,
    o.opportunity_title,
    o.company_name,
    a.application_date,
    a.application_status
FROM Applications a
JOIN Students s
    ON a.student_id = s.student_id
JOIN Opportunities o
    ON a.opportunity_id = o.opportunity_id
ORDER BY a.application_date DESC;


SELECT
    application_status,
    COUNT(*) AS total_applications
FROM Applications
GROUP BY application_status;



UPDATE Applications
SET application_status = 'Under Review'
WHERE student_id = 1
  AND opportunity_id = 1;



  SELECT *
FROM Applications
WHERE student_id = 1;

USE PathPilot;
SELECT * FROM Students;


SHOW TABLES;
SELECT * FROM Students;


USE PathPilot;

SELECT
    student_name,
    opportunity_title,
    company_name,
    location
FROM Eligible_Opportunities
WHERE student_id = 1;


USE PathPilot;

SELECT
    student_name,
    cgpa,
    department
FROM Students
WHERE cgpa > (
    SELECT AVG(cgpa)
    FROM Students
);


USE PathPilot;

SELECT
    o.opportunity_title,
    o.company_name,
    COUNT(a.application_id) AS total_applications
FROM Opportunities o
LEFT JOIN Applications a
    ON o.opportunity_id = a.opportunity_id
GROUP BY
    o.opportunity_id,
    o.opportunity_title,
    o.company_name
ORDER BY total_applications DESC;



USE PathPilot;

SHOW TABLES;


SHOW FULL TABLES
WHERE Table_type = 'VIEW';



SELECT * FROM Applications;