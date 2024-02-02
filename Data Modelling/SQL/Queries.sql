------------------------------D.1---------------------------------------------------------------------
SELECT location AS [Country Name (CN)],
       total_vaccinations AS [Total Vaccinations (administered to date)],
       daily_vaccinations AS [Daily Vaccinations],
       date AS Date
FROM vaccination_stat
WHERE daily_vaccinations > avg_of_daily_vaccination_each_country AND 
       total_vaccinations != 0;

------------------------------D.2-----------------------------------------------------------------------
SELECT location,total_vaccinations
FROM (
        SELECT location ,total_vaccinations,date
        FROM vaccination_stat
        WHERE total_vaccinations!=0
        ORDER BY date DESC)
WHERE total_vaccinations > (WITH TotalVaccinationsLocation AS (
                                                            SELECT location,total_vaccinations
                                                            FROM (
                                                                    SELECT location ,total_vaccinations,date
                                                                    FROM vaccination_stat
                                                                    WHERE total_vaccinations!=0
                                                                    ORDER BY date DESC)
                                                            GROUP BY location)
                            SELECT AVG(total_vaccinations) AVERAGE 
                            FROM TotalVaccinationsLocation)
GROUP BY location;

----------------------------D.3---------------------------------------------------------------------------
SELECT location, vaccines
FROM vaccinations_by_location
ORDER BY location;

----------------------------D.4--------------------------------------------------------------------------
SELECT location,
       source_url,
       MAX(total_vaccinations)
FROM vaccinations_by_vaccine
WHERE total_vaccinations is NOT NULL AND total_vaccinations !=""
GROUP BY location,
          source_url
ORDER BY source_url;

----------------------------D.5--------------------------------------------------------------------------
WITH RECURSIVE dates (
    date,
    end_date
)
AS (
    VALUES (
        '2021-01-01',
        '2021-01-08'
    )
    UNION ALL
    SELECT date(date, '+8 days'),
           (CASE WHEN end_date = '2022-12-29' THEN date(end_date, '+2 days') ELSE date(end_date, '+8 days') END) 
      FROM dates
     WHERE date < '2022-12-31' AND 
           end_date < '2022-12-31'
)
SELECT (d.date || ' to ' || d.end_date) AS date_range,
       (CASE WHEN (
                      SELECT people_fully_vaccinated
                        FROM vaccination_stat v
                       WHERE v.location = 'Australia' AND 
                             v.date = d.end_date
                  )= 0 THEN 0 ELSE (ifnull( (
                                      SELECT people_fully_vaccinated
                                        FROM vaccination_stat v
                                       WHERE v.location = 'Australia' AND 
                                             v.date = d.end_date
                                  ), 0) - ifnull( (
                                                      SELECT people_fully_vaccinated
                                                        FROM vaccination_stat v
                                                       WHERE v.location = 'Australia' AND 
                                                             v.date = d.date
                                                  ), 0) ) END) AS total
FROM dates d;
---------------------------------------------------------------------------------------------------------

