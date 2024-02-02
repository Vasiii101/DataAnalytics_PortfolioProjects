# ReadMe.md

This project use a publicly available dataset: A Global Database of COVID-19 Vaccinations. Further details about this dataset are available in the article available through the following URL: https://www.nature.com/articles/s41562-021-01122-8. The abstract of the article is as follows.

> An effective rollout of vaccinations against COVID-19 offers the most promising prospect of bringing the pandemic to an end. We present the Our World in Data COVID-19 vaccination dataset, a global public dataset that tracks the scale and rate of the vaccine rollout across the world. This dataset is updated regularly and includes data on the total number of vaccinations administered, first and second doses administered, daily vaccination rates and population-adjusted coverage for all countries for which data are available (169 countries as of 7 April 2021). It will be maintained as the global vaccination campaign continues to progress. This resource aids policymakers and researchers in understanding the rate of current and potential vaccine rollout; the interactions with non-vaccination policy responses; the potential impact of vaccinations on pandemic outcomes such as transmission, morbidity and mortality; and global inequalities in vaccine access.

A live version of the vaccination dataset and documentation are available in a public GitHub repository at https://github.com/owid/covid-19-data/tree/master/public/data/vaccinations. These data can be downloaded in CSV and JSON formats.
For the purposes of completing this assignment, we are only using the following files. You are required to review and analyse the dataset available in these files. You will find that reviewing the rest of the files, even if not listed below, will help you to form a better understanding about the big picture.

| FILE NAME                        | DESCRIPTION                                                                                                                                                                                                                           |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| locations.csv                    | Country names and the type of vaccines administered. Each line represents the last observation in a specific country. Refer to README.md for the details.                                                                             |
| us_state_vaccinations.csv        | History of observations for various locations in the US. 3 vaccinations-by-age-group.csv History of observations for vaccinations of various age groups in each country.                                                              |
| vaccinations-by-manufacturer.csv | History of observations for various types of vaccines used in each country. 5 vaccinations.csv Country-by-country data on global COVID-19 vaccinations. Each line represents an observation date. Refer to README.md for the details. |
| country_data/Australia.csv       | Daily observations of vaccination in Australia.                                                                                                                                                                                       |
| country_data/Germany.csv         | Daily observations of vaccination in Germany.                                                                                                                                                                                         |
| country_data/England.csv         | Daily observations of vaccination in England.                                                                                                                                                                                         |
| country_data/France.csv          | Daily observations of vaccination in France.                                                                                                                                                                                          |

<br>

## Designing the database

---

It was essential to adhere to good design principles throughout the process. This required transforming the structure of the dataset, rather than the data itself, to fit the database schema. To accomplish this, Lucidchart was used to create an Entity-Relationship (ER) diagram using UML notation, ensuring clarity and consistency in the database model representation. The ER diagram depicted the relationships between entities and attributes, providing a visual guide for database design.

As part of the database design process, normalization activities performed to ensure the database schema was efficient and scalable. This involved identifying and resolving any design issues to achieve a well-structured and optimized database. Next, documented the normalization activities, detailing the initial design, identified problems, and the changes made to rectify them. By following best practices in database normalization, ensured the integrity and efficiency of the database schema, laying a solid foundation for data management and analysis.

PDF file named model.pdf containing the following sections,

- Database ER diagram.
- Explanation of normalisation challenges and the resulting changes.
- Database schema.

<br>

## Creating the Database and Importing Data

---

SQL script file named database.sql contains SQL statments necessary to create all the database relations and their corresponding integrity constraints as per the proposed design in the designing stage.

Note that this script is not supposed to store any data into the relations.

Next, database file named Vaccinations.db is created and imported the given dataset into the created database. To complete this task, CSV files formate is change to match the attributes of the designed database. Spreadsheet editor such as Microsoft Excel is used to the necessary changes. Finally the spreadsheet is imported into the database.

<br>

## Data Retrieval and Visualisation

---

After successfully creating and populating the database, the next step in the project was to analyze the data and visualize the results. This section outlines the tasks performed and the techniques used for data retrieval and visualization.

**Queries**

---

SQL queries to investigate various aspects of the COVID-19 dataset, each consisting of a single SQL statement. Even though complex queries were a possibility each task contained within a single query for efficiency and clarity. The queries were organized and documented in a single SQL script file named Queries.sql, with comment lines separating each query and indicating the task they belong to.

**Data Visualization**

---

For each query result, data visualization is provided using Ms Excel. The goal was to present the results in a visually appealing and easy-to-understand manner. Following factors such as ordering, grouping, and chart types were considered to ensure the visualizations effectively conveyed the insights derived from the data.

**Example Tasks**

---

**Task D.1: Country with Above-Average Vaccinations**

Listed countries with more than the average number of people vaccinated on each observation day, displaying the country name, total vaccinations administered to date, daily vaccinations, and date. The results were visualized using bar charts to highlight countries with above-average vaccination rates over time.

**Task D.2: Countries with Above-Average Doses Administered**

Identified countries with cumulative numbers of COVID-19 doses administered above the average, showcasing each country's name and cumulative dose count. The visualization displayed a comparison of cumulative doses administered across multiple countries.

**Task D.3: Countries and Vaccine Types**

Produced a list of countries along with the vaccine types administered in each country. For countries with multiple vaccine types, separate tuples were reported for each vaccine type. The visualization depicted a breakdown of vaccine types by country using pie charts.

**Task D.4: Total Vaccines Administered by Source**

Generated a report showing the total number of vaccines administered in each country according to each data source. The results were ordered by source name (URL), and the visualization illustrated the distribution of vaccines administered by source.

**Task D.5: Vaccine Administration Speed Comparison**

Compared the speed of vaccine administration across different countries by listing the total number of people fully vaccinated for each observation week. The visualization presented a weekly comparison of fully vaccinated individuals across four countries.
