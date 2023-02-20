## Introduction<br>
This project was the subject of my master thesis, and I worked on it during my internship at Cloudtec. My work focused on the database of a private postal company, whose identity I will not reveal for privacy reasons. The title of my thesis was
> **Data Analysis and Data Cleaning on a BigQuery Database**
<br>

## Database description<br>
The database was designed to easily track the entire journey of each individual parcel, from acceptance to delivery. It was created and is managed with MySQL8, but to avoid overloading the server with an excessive amount of data, every three months they are deleted locally. A permanent copy is kept on BigQuery in Google Cloud Platform.
![1](https://user-images.githubusercontent.com/119680854/219961910-1766fa66-eac4-4c51-83bb-d6415c8af209.png)
![3](https://user-images.githubusercontent.com/119680854/219961984-3036b204-2e84-4284-a092-a702a3144f26.png)

## My analysis<br>
I realized my research with PostreSQL using some of the Google Cloud Platform technologies, specifically BigQuery, Looker Studio (still referred to as 'Data Studio' at the time of my research) and BigQuery Geo Viz.<br>
The company's goal was to use the data we had to track the movements of mail carriers and their deliveries. However, the database presented some issues, including the presence of repeated data and anomalous frequencies regarding deliveries per mail carrier. My main objective throught my internship was to determine if the data we had were actually usable or not.<br>
I carried a general analysis on the database to familiarize myself with the data, then proceeded to check for missing data. Luckily, while the database presented many off-scale values, the presence of null values was close to 0% for all relevant fields.

![1](https://user-images.githubusercontent.com/119680854/220138903-414c5d94-4f48-4e35-a3c5-be3b647aacdb.png)

To understand the cause of the off-scale values, I analyzed the scans for each mail carrier by day, week, and month. I found duplicate data caused by a problem with the 'UNNEST' command in BigQuery. I solved the problem with a subquery using 'GROUP BY', but the excessive peaks persisted, indicating an issue with the data itself. However, I found that the excessive peaks were limited to one part of the database. To determine the amount of usable data, I checked what percentage of daily scans fell between 10 and 600 (values the company indicated as reasonable) and found that 78% of the data was valid, which was surprising given the initial concerns about unusable data.

![2](https://user-images.githubusercontent.com/119680854/220140000-b79ac4b8-1656-492e-b881-89ec3d4760fd.png)


The previously unusable data was filtered and can now be utilized to extract routes of the mail carriers to improve delivery efficiency. Machine learning functions can be applied to calculate new routes that can optimize deliveries, evaluate delivery times, determine the most active areas, and assess the possibility of opening new branches in these locations. Additionally, growth trends can be analyzed and compared to the company's economic data to determine if the increase in revenue is correlated with an increase in activities. In summary, the analysis produced a positive outcome, as the filtered data can now be used for further analysis and improvements to benefit the company.

## Highlights<br>
Here, you can find some of the key highlights of the code I use and view examples of the results. To explore the rest of the code, you can access it from this [link](https://github.com/ludovicato/SQL_BigQuery_DataStudio_analysis/blob/37c63b838daa6fa69356c24d0e9a7db99963728c/Main_queries.sql) or you can check it in my [thesis](https://github.com/ludovicato/SQL_Analysis_Postal_Service/blob/4b5919767469aff68d57cd5ceaffbc966aa41a0e/My%20Thesis%20(english).pdf).

![3](https://user-images.githubusercontent.com/119680854/219969190-dbfa8efd-ecb7-4b8e-87ff-e1b38e658426.png)
![4](https://user-images.githubusercontent.com/119680854/219969717-ae12d4ce-2bda-48e6-9316-a95c3c559ab8.png)
![6](https://user-images.githubusercontent.com/119680854/219972829-c1018867-dc4d-4791-adb2-490ad01a4294.png)
