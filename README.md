## Introduction<br>
This project was the subject of my master thesis, and I worked on it during my internship at Cloudtec. My work focused on the database of a private postal company, whose identity I will not reveal for privacy reasons. The title of my thesis was
> **Data Analysis and Data Cleaning on a BigQuery Database**
<br>

## Database description<br>
The database was designed to easily track the entire journey of each individual parcel, from acceptance to delivery. It was created and is managed with MySQL8, but to avoid overloading the server with an excessive amount of data, every three months they are deleted locally. A permanent copy is kept on BigQuery in Google Cloud Platform.
![1](https://user-images.githubusercontent.com/119680854/219961910-1766fa66-eac4-4c51-83bb-d6415c8af209.png)
![3](https://user-images.githubusercontent.com/119680854/219961984-3036b204-2e84-4284-a092-a702a3144f26.png)




## My analysis<br>
The company's goal was to use the data we had to track the movements of mail carriers and their deliveries. However, the database presented some issues, including the presence of repeated data and anomalous frequencies regarding deliveries per mail carrier.


## Highlights<br>
He
