create database ola;

use ola;

SELECT * FROM ola_database.`ola dataset`;

select count(*) from ola_database.`ola dataset`;

-- Data Preprocessing 

UPDATE ola_database.`ola dataset`
SET Canceled_Rides_by_Customer = COALESCE(Canceled_Rides_by_Customer, 0);

UPDATE ola_database.`ola dataset`
SET Canceled_Rides_by_Driver   = COALESCE(Canceled_Rides_by_Driver, 0);

SELECT * FROM ola_database.`ola dataset`;

UPDATE ola_database.`ola dataset` 
SET Incomplete_Rides = COALESCE(Incomplete_Rides, 0);

SELECT * FROM ola_database.`ola dataset`;

UPDATE ola_database.`ola dataset` 
SET Incomplete_Rides_Reason = COALESCE(Incomplete_Rides_Reason, 'Not Applicable');

SELECT * FROM ola_database.`ola dataset`;

UPDATE ola_database.`ola dataset` 
SET Payment_Method =  COALESCE(Payment_Method, 'Unknown');

SELECT * FROM ola_database.`ola dataset`;

UPDATE ola_database.`ola dataset`
SET Driver_Ratings = (
    SELECT ROUND(AVG(tmp.Driver_Ratings), 2)
    FROM (
        SELECT Driver_Ratings 
        FROM ola_database.`ola dataset`
        WHERE Driver_Ratings IS NOT NULL AND Driver_Ratings <> 0
    ) AS tmp
)
WHERE Driver_Ratings = 0;

SELECT * FROM ola_database.`ola dataset`;


UPDATE ola_database.`ola dataset`
SET Customer_Rating = (
    SELECT ROUND(AVG(tmp.Customer_Rating), 2)
    FROM (
        SELECT Customer_Rating 
        FROM ola_database.`ola dataset`
        WHERE Customer_Rating IS NOT NULL AND Customer_Rating <> 0
    ) AS tmp
)
WHERE Customer_Rating = 0;


SELECT * FROM ola_database.`ola dataset`;

select count(*) from ola_database.`ola dataset`;

-- Questions 

-- 1. Retrieve all successful bookings
SELECT * FROM ola_database.`ola dataset`
where Booking_Status = 'Success';

-- 2. Find the average ride distance for each vehicle type
SELECT Vehicle_Type, avg(Ride_Distance) FROM ola_database.`ola dataset`
Group by Vehicle_Type;

-- 3. Get the total number of cancelled rides by customers
select count(*) FROM ola_database.`ola dataset`
where Booking_Status = 'Canceled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides
SELECT Customer_ID, COUNT(*) AS Total_Rides FROM ola_database.`ola dataset`
GROUP BY Customer_ID
ORDER BY Total_Rides DESC
LIMIT 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
select count(*) FROM ola_database.`ola dataset`
where Canceled_Rides_by_Driver = 'Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings
select max(Driver_Ratings), min(Driver_Ratings) FROM ola_database.`ola dataset`
where Vehicle_Type = 'Prime Sedan';

-- 7. Retrieve all rides where payment was made using UPI
SELECT * FROM ola_database.`ola dataset`
where Payment_Method = 'UPI';

-- 8. Find the average customer rating per vehicle type:
select Vehicle_Type, round(avg(Customer_Rating), 2) as average_rating from ola_database.`ola dataset`
group by Vehicle_Type;

-- 9. Calculate the total booking value of rides completed successfully
SELECT SUM(Booking_Value) AS Total_Booking_Value FROM ola_database.`ola dataset`
WHERE Booking_Status = 'Success';

-- 10. List all incomplete rides along with the reason
SELECT Booking_ID, Customer_ID, Booking_Status, Incomplete_Rides_Reason
FROM ola_database.`ola dataset`
WHERE Booking_Status <> 'Success';

-- 11. Find the top 3 vehicle types that generated the highest revenue
SELECT Vehicle_Type, SUM(Booking_Value) AS Total_Revenue FROM ola_database.`ola dataset`
WHERE Booking_Status = 'Success'
GROUP BY Vehicle_Type
ORDER BY Total_Revenue DESC
LIMIT 3;

-- 12. Calculate the average waiting time (V_TAT) for each vehicle type.
SELECT Vehicle_Type, AVG(V_TAT) AS Avg_Waiting_Time FROM ola_database.`ola dataset`
WHERE V_TAT IS NOT NULL
GROUP BY Vehicle_Type;

-- 13. Find the customer who gave the lowest average rating to drivers.
SELECT Customer_ID, AVG(Driver_Ratings) AS Avg_Driver_Rating FROM ola_database.`ola dataset`
WHERE Driver_Ratings IS NOT NULL
GROUP BY Customer_ID
ORDER BY Avg_Driver_Rating ASC
LIMIT 5;

SELECT * FROM ola_database.`ola dataset`






