-- Create New Database
CREATE DATABASE nhs_dna_project;

USE nhs_dna_project;
-- create table 
CREATE TABLE appointments_raw;


USE nhs_dna_project;
SELECT COUNT(*) FROM appointments_clean;
SELECT * FROM appointments_clean LIMIT 5;

-- Basic data cleaning in MySQL-----------------------------

-- 1. Check for missing values

SELECT 
    COUNT(*) AS total_rows,
    SUM(PatientId IS NULL) AS missing_patientid,
    SUM(AppointmentID IS NULL) AS missing_appointmentid,
    SUM(Age IS NULL) AS missing_age
FROM appointments_clean;

-- 2. Remove duplicates (if any)
DELETE t1 
FROM appointments_clean t1
INNER JOIN appointments_clean t2 
WHERE 
    t1.AppointmentID = t2.AppointmentID 
    AND t1.id < t2.id;  -- if  have an auto_increment id


-- 3. Standardize categorical values
-- For example, ensure Gender is only ‘M’ or ‘F’
UPDATE appointments_clean
SET Gender = UPPER(Gender)
WHERE Gender IS NOT NULL;

DELETE FROM appointments_clean
WHERE Gender NOT IN ('M','F');

-------- Step 2 — Feature Engineering in MySQL--------
-- 1. Waiting days
ALTER TABLE appointments_clean ADD COLUMN waiting_days INT;

UPDATE appointments_clean
SET waiting_days = DATEDIFF(AppointmentDay, ScheduledDay);


-- 2. Same-day booking flag

ALTER TABLE appointments_clean ADD COLUMN same_day_booking INT;

UPDATE appointments_clean
SET same_day_booking = CASE 
    WHEN DATEDIFF(AppointmentDay, ScheduledDay) = 0 THEN 1
    ELSE 0
END;


-- 3. Day of week for appointment

ALTER TABLE appointments_clean ADD COLUMN appointment_dayofweek VARCHAR(10);

UPDATE appointments_clean
SET appointment_dayofweek = DAYNAME(AppointmentDay);

-- 4. Convert No-show to numeric DNA

ALTER TABLE appointments_clean ADD COLUMN dna INT;

UPDATE appointments_clean
SET dna = CASE 
    WHEN `No-show`='Yes' THEN 1
    ELSE 0
END;



-- Step 3:  Aggregations / insights in MYSQL-----------------------

-- We can do quick trend analysis directly in MySQL:

-- 1. DNA rate by day of week

SELECT appointment_dayofweek, 
       COUNT(*) AS total_appointments,
       SUM(dna) AS total_dna,
       ROUND(SUM(dna)/COUNT(*)*100,2) AS dna_rate
FROM appointments_clean
GROUP BY appointment_dayofweek;


-- 2. DNA rate by age group

SELECT 
    CASE 
        WHEN Age BETWEEN 0 AND 18 THEN '0-18'
        WHEN Age BETWEEN 19 AND 30 THEN '19-30'
        WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        WHEN Age BETWEEN 61 AND 75 THEN '61-75'
        ELSE '76-100'
    END AS age_group,
    COUNT(*) AS total_appointments,
    SUM(dna) AS total_dna,
    ROUND(SUM(dna)/COUNT(*)*100,2) AS dna_rate
FROM appointments_clean
GROUP BY age_group;


-- 3. DNA rate by neighbourhood
SELECT Neighbourhood, 
       COUNT(*) AS total_appointments,
       SUM(dna) AS total_dna,
       ROUND(SUM(dna)/COUNT(*)*100,2) AS dna_rate
FROM appointments_clean
GROUP BY Neighbourhood
ORDER BY dna_rate DESC
LIMIT 10;

SELECT PatientId, AppointmentID, Gender, Age, Neighbourhood, 
       ScheduledDay, AppointmentDay, waiting_days, 
       same_day_booking, appointment_dayofweek, SMS_received, dna
FROM appointments_clean
INTO OUTFILE 'C:/Users/ASUS-PC/OneDrive/Desktop/nhs-dna-predictive-model/data/appointments_mysql_ready.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';