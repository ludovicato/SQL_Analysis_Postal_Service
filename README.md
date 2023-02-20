## Introduction<br>
This project was the subject of my master thesis, and I worked on it during my internship at Cloudtec. My work focused on the database of a private postal company, whose identity I will not reveal for privacy reasons. The title of my thesis was
> **Data Analysis and Data Cleaning on a BigQuery Database**
<br>

## Database description<br>
The database was designed to easily track the entire journey of each individual parcel, from acceptance to delivery. It was created and is managed with MySQL8, but to avoid overloading the server with an excessive amount of data, every three months they are deleted locally. A permanent copy is kept on BigQuery in Google Cloud Platform.
![1](https://user-images.githubusercontent.com/119680854/219961910-1766fa66-eac4-4c51-83bb-d6415c8af209.png)
![3](https://user-images.githubusercontent.com/119680854/219961984-3036b204-2e84-4284-a092-a702a3144f26.png)




## My analysis<br>
The company's goal was to use the data we had to track the movements of mail carriers and their deliveries. However, the database presented some issues, including the presence of repeated data and anomalous frequencies regarding deliveries per mail carrier. My main objective throught my internship was to determine if the data we had were actually usable or not.

I carried a general analysis on the database to familiarize myself with the data, then proceeded to check for missing data. Luckily, while the database presented many out of scale values, the presence of null values was close to 0% for all relevant fields.

I realized my research with PostreSQL using some of the Google Cloud Platform technologies, specifically BigQuery, Looker Studio (still referred to as 'Data Studio' at the time of my research) and BigQuery Geo Viz.



![9](https://user-images.githubusercontent.com/119680854/219975351-e6cb35ad-29fa-4bbe-8889-3d9c0467eff8.png)
![7](https://user-images.githubusercontent.com/119680854/219975344-f4fbae0b-8f40-4b32-a0e0-6a185ab26336.png)

## Highlights<br>
Here, you can find some of the key highlights of the code I use and view examples of the results. To explore the rest of the code, you can access it from this [link](https://github.com/ludovicato/SQL_BigQuery_DataStudio_analysis/blob/37c63b838daa6fa69356c24d0e9a7db99963728c/Main_queries.sql) or you can check it in my [thesis].

![3](https://user-images.githubusercontent.com/119680854/219969190-dbfa8efd-ecb7-4b8e-87ff-e1b38e658426.png)
![4](https://user-images.githubusercontent.com/119680854/219969717-ae12d4ce-2bda-48e6-9316-a95c3c559ab8.png)
![6](https://user-images.githubusercontent.com/119680854/219972829-c1018867-dc4d-4791-adb2-490ad01a4294.png)
