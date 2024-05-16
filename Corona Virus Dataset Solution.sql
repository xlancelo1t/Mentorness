-- Create Table

Create Table Corona_Virus_Dataset (
Province varchar(100),
Country varchar(100),
Latitude numeric(8, 5),
Longitude numeric(8, 5),
Date_column Date,
Confirmed Int,
Deaths Int,
Recovered Int
);

-- Display table content

select * from Corona_Virus_Dataset

-- import CSV file to postgreSQL

COPY Corona_Virus_Dataset FROM 'C:\Users\lancelot\Downloads\Corona_Virus_Dataset.csv' DELIMITER ',' CSV HEADER;

-- SQL query to display NULL values

SELECT COUNT(*) AS null_count
FROM Corona_Virus_Dataset
WHERE Corona_Virus_Dataset IS NULL;

-- SQL query to update NULL values with 0 if present

UPDATE Corona_Virus_Dataset
SET Province = 0, Country = 0, Latitude = 0, Longitude = 0,Date_column = NULL, Confirmed = 0, Deaths = 0, Recovered = 0
WHERE Province IS NULL OR Country IS NULL OR Latitude IS NULL OR Longitude IS NULL OR Date_column IS NULL OR Confirmed IS NULL OR Deaths IS NULL OR Recovered IS NULL;

-- Check total number of rows

SELECT COUNT(*) AS total_rows
FROM Corona_Virus_Dataset;

-- Check for start_date and end_date

SELECT MIN(Date_column) AS min_start_date, MAX(Date_column) AS max_end_date
FROM Corona_Virus_Dataset;

-- Number of months present in dataset

SELECT COUNT(DISTINCT CONCAT(EXTRACT(YEAR FROM Date_column), '_', EXTRACT(MONTH FROM Date_column))) AS num_month
FROM Corona_Virus_Dataset;

-- Find monthly average for confirmed, deaths, recovered

SELECT TO_CHAR(Date_column, 'YYYY_Month') AS YEAR_MONTH,
       AVG(confirmed) AS avg_confirmed,
       AVG(deaths) AS avg_deaths,
       AVG(recovered) AS avg_recovered
FROM Corona_Virus_Dataset
GROUP BY TO_CHAR(Date_column, 'YYYY_Month');

-- Find most frequent value for confirmed, deaths, recovered each month

SELECT TO_CHAR(Date_column, 'Month') AS MONTH,
       MODE() WITHIN GROUP (ORDER BY confirmed) AS most_frequent_confirmed,
       MODE() WITHIN GROUP (ORDER BY deaths) AS most_frequent_deaths,
       MODE() WITHIN GROUP (ORDER BY recovered) AS most_frequent_recovered
FROM Corona_Virus_Dataset
GROUP BY TO_CHAR(Date_column, 'Month');

-- Find minimum values for confirmed, deaths, recovered per year

SELECT EXTRACT(YEAR FROM Date_column) AS year,
       MIN(confirmed) AS min_confirmed,
       MIN(deaths) AS min_deaths,
       MIN(recovered) AS min_recovered
FROM Corona_Virus_Dataset
GROUP BY EXTRACT(YEAR FROM date_column);

-- Find maximum values of confirmed, deaths, recovered per year

SELECT EXTRACT(YEAR FROM Date_column) AS year,
       MAX(confirmed) AS max_confirmed,
       MAX(deaths) AS max_deaths,
       MAX(recovered) AS max_recovered
FROM Corona_Virus_Dataset
GROUP BY EXTRACT(YEAR FROM Date_column);

-- The total number of case of confirmed, deaths, recovered each month

SELECT TO_CHAR(Date_column, 'Month') AS Month,
       SUM(confirmed) AS total_confirmed,
       SUM(deaths) AS total_deaths,
       SUM(recovered) AS total_recovered
FROM Corona_Virus_Dataset
GROUP BY TO_CHAR(Date_column, 'Month');

-- Check how corona virus spread out with respect to confirmed case

SELECT COUNT(*) AS total_cases,
       AVG(confirmed) AS average_confirmed,
       VARIANCE(confirmed) AS variance_confirmed,
       STDDEV(confirmed) AS stddev_confirmed
FROM Corona_VIrus_Dataset;

-- Check how corona virus spread out with respect to death case per month

SELECT TO_CHAR(date_column, 'Month') AS Month,
       SUM(deaths) AS total_deaths,
       AVG(deaths) AS average_deaths,
       VARIANCE(deaths) AS variance_deaths,
       STDDEV(deaths) AS stddev_deaths
FROM Corona_Virus_Dataset
GROUP BY TO_CHAR(date_column, 'Month');

-- Check how corona virus spread out with respect to recovered case

SELECT TO_CHAR(Date_column, 'Month') AS Month,
       SUM(Recovered) AS total_recovered_cases,
       AVG(Recovered) AS average_recovered_cases,
       VARIANCE(Recovered) AS variance_recovered_cases,
       STDDEV(Recovered) AS stddev_recovered_cases
FROM Corona_Virus_Dataset
GROUP BY TO_CHAR(Date_column, 'Month');

-- Find Country having highest number of the Confirmed case

SELECT country,
       MAX(confirmed) AS max_confirmed_cases
FROM Corona_Virus_Dataset
GROUP BY country
ORDER BY max_confirmed_cases DESC
LIMIT 1;

-- Find Country having lowest number of the death case

SELECT country,
       MIN(Deaths) AS min_death_cases
FROM Corona_Virus_Dataset
GROUP BY country
ORDER BY min_death_cases ASC
LIMIT 1;

-- Find top 5 countries having highest recovered case

SELECT country,
       SUM(recovered) AS total_recovered
FROM Corona_Virus_Dataset
GROUP BY country
ORDER BY total_recovered DESC
LIMIT 5;












