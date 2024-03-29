# Cyclistic bike-sharing

This is the capstone project of the Google Data Analytics Professional Certificate course, which aims to demonstrate my technical and analytical skills for an entry-level Data Analyst Position.

In this BI project, I used R (tidyverse packages) to clean, manipulate, and analyze the dataset. I also created an [interactive dashboard](https://public.tableau.com/app/profile/diogo.ferreira1451/viz/Cyclistic_bikeshare_2022/Cyclistic_2022_Analysis?publish=yes) in Tableau that allow for comparing the behavior of two types of users: casual riders and annual members.

## Summary

1. Scope

2. About the data

3. Data Cleaning and Manipulation

4. Summary of Analysis

5. Key Findings and Supporting Visualizations

6. Recommendations

## 1. Scope

### Scenario

Cyclistic is a bike-sharing company based in Chicago with two different types of clients. Casual riders are customers who purchase single-ride or full-day passes, whereas members are customers who purchase annual subscriptions. Financial researchers at Cyclistic have determined that annual members are significantly more profitable than casual riders. The director of marketing believes that the company's future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently, in order to convert casual riders into members.

### Business task

Analyze the historical trip data of cyclists from 2022 in order to identify trends in the behavior of casual riders and annual members.

### Stakeholders

* Primary stakeholders: Cyclistic director of marketing and the Cyclistic executive team.
* Secondary stakeholders: Cyclistic marketing analytics team.

### Deliverables

* Documentation of cleaning and manipulation data; 
* Summary of analysis; 
* Supporting visualizations and key findings; 
* Recommendations.

## 2. About the data

### Source

It is possible to access Cyclistic historical trip data through this [link](https://divvy-tripdata.s3.amazonaws.com/index.html). The data sets have a different name because Cyclistic is a fictional company. The data has been made available by Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement).

For this study, we will use the twelve CSV files (January to December) referring to the trip history in 2022.

### Quality

Bearing in mind that this is primary data collected by Cyclistic, we can assume that the data is reliable, original, comprehensive, and current. With regard to its integrity, an analysis will be made of various situations during the data cleaning process, such as duplicate observations, missing or inconsistent values, and the validity of data range, as well as data type conversions, to ensure that the data is accurate, complete, consistent, trustworthy, and aligned with the business objective.

### Structure

Data are organized in a tabular structure and all CSV files share the same columns:

* ride_id
* rideable_type
* started_at
* ended_at
* start_station_name
* start_station_id
* end_station_name
* end_station_id
* start_lat
* start_lng
* end_lat
* end_lng
* member_casual

### Prepare

RStudio was the tool of choice for cleaning, manipulating, and analyzing the data. To begin, it was necessary to import the data from the 12 CSV files into RStudio:

```
Cyclistic_012022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202201-divvy-tripdata.csv",
                             col_types = cols(ride_id = col_character(),
                                              rideable_type = col_character(),
                                              started_at = col_datetime(), 
                                              ended_at = col_datetime(), 
                                              start_station_name = col_character(), 
                                              start_station_id = col_character(), 
                                              end_station_name = col_character(), 
                                              end_station_id = col_character(), 
                                              start_lat = col_double(), start_lng = col_double(), 
                                              end_lat = col_double(), end_lng = col_double(), 
                                              member_casual = col_character()))
```

Next, the various columns of the different CSV files were compared to ensure that they all had the same exact name:

```
compare_df_cols(Cyclistic_012022, Cyclistic_022022, Cyclistic_032022, Cyclistic_042022, Cyclistic_052022, Cyclistic_062022, Cyclistic_072022, Cyclistic_082022, Cyclistic_092022, Cyclistic_102022, Cyclistic_112022, Cyclistic_122022)
```

The twelve data frames are combined into a single, annual data frame:

```
Cyclistic_2022 <- bind_rows(Cyclistic_012022, Cyclistic_022022, Cyclistic_032022, Cyclistic_042022, Cyclistic_052022, Cyclistic_062022, Cyclistic_072022, Cyclistic_082022, Cyclistic_092022, Cyclistic_102022, Cyclistic_112022, Cyclistic_122022)
```

Finally, to improve understanding of the data frame, we rename the column names:

```
Cyclistic_2022 <- rename(Cyclistic_2022, bike_type=rideable_type, user_type=member_casual, start_latitude=start_lat, end_latitude=end_lat, start_longitude=start_lng, end_longitude=end_lng)
```

### 3. Data cleaning and manipulation

In order to verify the need for data cleaning, all columns of interest were checked for the existence of null values, duplicate entries, validity of data range, and unique values according to their specificity. Below are some examples of these checks:

* Check null values

```
Cyclistic_2022 %>% filter(is.na(ride_id))
Cyclistic_2022 %>% filter(is.na(bike_type))
```

* Check duplicated entries

```
Cyclistic_2022 %>% filter(duplicated(ride_id))
```

* Check validity of data range

```
valid_start_at <- ymd_hms("2022-01-01 00:00:00")
valid_end_at <- ymd_hms("2022-12-31 23:59:59")

Cyclistic_2022 %>% filter(started_at < valid_start_at | started_at > valid_end_at)
```
* Check unique values

```
Cyclistic_2022 %>% select(bike_type) %>% unique()
Cyclistic_2022 %>% select(user_type) %>% unique()
```

Next, only the columns of interest were selected for analysis:

```
Cyclistic_2022_v2 <- Cyclistic_2022 %>% 
  select(ride_id, bike_type, started_at, ended_at, user_type)
```

Then a column for ride duration was created:

```
Cyclistic_2022_v2$ride_duration <- difftime(strptime(Cyclistic_2022_v2$ended_at, "%Y-%m-%d %H:%M:%S"), 
                                             strptime(Cyclistic_2022_v2$started_at, "%Y-%m-%d %H:%M:%S"))
```

All observations with ride duration less than or equal to zero were removed:

```
Cyclistic_2022_v3 <- Cyclistic_2022_v2 %>% filter(ride_duration > 0)
```

Finally, in order to allow for a more specific analysis, new columns were created, such as date, month, day of the week, start hour, season, and time of day:

```
Cyclistic_2022_v3$date <- as.Date(Cyclistic_2022_v3$started_at)
Cyclistic_2022_v3$month <- format(as.Date(Cyclistic_2022_v3$date), "%m")
Cyclistic_2022_v3 <-Cyclistic_2022_v3 %>% mutate(month = 
                                                   case_when(month == "01" ~ "January",
                                                             month == "02" ~ "February",
                                                             month == "03" ~ "March",
                                                             month == "04" ~ "April",
                                                             month == "05" ~ "May",
                                                             month == "06" ~ "June",
                                                             month == "07" ~ "July",
                                                             month == "08" ~ "August",
                                                             month == "09" ~ "September",
                                                             month == "10" ~ "October",
                                                             month == "11" ~ "November",
                                                             month == "12" ~ "December"))

Cyclistic_2022_v3$weekday <- format(as.Date(Cyclistic_2022_v3$date), "%A")
Cyclistic_2022_v3$day <- format(as.Date(Cyclistic_2022_v3$date), "%d")
Cyclistic_2022_v3$start_hour <- hour(Cyclistic_2022_v3$started_at)
Cyclistic_2022_v3 <-Cyclistic_2022_v3 %>% mutate(season = 
                                             case_when(month == "01" ~ "Winter",
                                                       month == "02" ~ "Winter",
                                                       month == "03" ~ "Spring",
                                                       month == "04"  ~ "Spring",
                                                       month == "05"  ~ "Spring",
                                                       month == "06"  ~ "Summer",
                                                       month == "07" ~ "Summer",
                                                       month == "08" ~ "Summer",
                                                       month == "09" ~ "Fall",
                                                       month == "10" ~ "Fall",
                                                       month == "11" ~ "Fall",
                                                       month == "12" ~ "Winter"))

Cyclistic_2022_v3 <- Cyclistic_2022_v3 %>% mutate(time_of_day = 
                                             case_when(start_hour == "0" ~ "Night",
                                                       start_hour == "1" ~ "Night",
                                                       start_hour == "2" ~ "Night",
                                                       start_hour == "3" ~ "Night",
                                                       start_hour == "4" ~ "Night",
                                                       start_hour == "5" ~ "Night",
                                                       start_hour == "6" ~ "Morning",
                                                       start_hour == "7" ~ "Morning",
                                                       start_hour == "8" ~ "Morning",
                                                       start_hour == "9" ~ "Morning",
                                                       start_hour == "10" ~ "Morning",
                                                       start_hour == "11" ~ "Morning",
                                                       start_hour == "12" ~ "Afternoon",
                                                       start_hour == "13" ~ "Afternoon",
                                                       start_hour == "14" ~ "Afternoon",
                                                       start_hour == "15" ~ "Afternoon",
                                                       start_hour == "16" ~ "Afternoon",
                                                       start_hour == "17" ~ "Afternoon",
                                                       start_hour == "18" ~ "Evening",
                                                       start_hour == "19" ~ "Evening",
                                                       start_hour == "20" ~ "Evening",
                                                       start_hour == "21" ~ "Evening",
                                                       start_hour == "22" ~ "Evening",
                                                       start_hour == "23" ~ "Evening"))
```

## 4. Summary of Analysis

Taking into account that the business task is to identify the different trends in the behavior of the two types of Cyclistic users, we analyzed the following key metrics.

**Total Rides by User Type**

```
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  count(user_type)
```

![total_rides_user](https://user-images.githubusercontent.com/129385224/228984011-8603010b-c189-4ac6-af2f-f9a5753a3efd.png)

**Findings:**

* Members had the most amount of the rides at 59% of total rides.

**Total Rides by Bike Type and User Type**

```
Cyclistic_2022_v3 %>%
  group_by(user_type, bike_type) %>% 
  count(bike_type)
```
![rides_bike_user](https://user-images.githubusercontent.com/129385224/228984233-32ac20d8-107b-4ae5-bbd3-22b1a4410631.png)

**Findings:**

* Members have a slight preference for classic bikes, while casual users prefer electric bikes.
* Docked bikes are underused compared to the other two options.

**Average Ride Duration by User Type**

```
Cyclistic_2022_v3 %>% group_by(user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))
```

![avg_rides_user](https://user-images.githubusercontent.com/129385224/228984320-eeb73f7e-6d4b-495d-9ee5-e67e1938f5c1.png)

**Findings:**

* Casual users tend to have longer bicycle rides, on average more than twice as long as those of member users.

**Sum of Ride Duration by User Type**

```
Cyclistic_2022_v3 %>% group_by(user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = sum))
```

![sum_ride_duration](https://user-images.githubusercontent.com/129385224/228984394-a0f1cc8d-09b2-4d10-b515-d369f3e96f66.png)

**Findings:**

* Of the total riding time in 2022, casual users cycled the longest.

Based on the above, it is possible to identify that members took a greater number of rides throughout the year 2022, however, the rides of casual users are on average longer. When it comes to the total time of the rides, casual users have an advantage, accounting for about 62% of the total time of the rides.

Then, we went to analyze in detail the differences between the two types of users taking into account different timeframes.

## 5. Supporting visualizations and key findings

Using Tableau, we're able to plot several graphs in different timeframes, analyse them and draw some conclusions.

A interactive dashboard with all supporting views and conclusions has been created, which is available from this [link](https://public.tableau.com/app/profile/diogo.ferreira1451/viz/Cyclistic_bikeshare_2022/Cyclistic_2022_Analysis?publish=yes).


### Percentage of Rides per Season

![season](https://user-images.githubusercontent.com/129385224/229159561-c51dcc19-bf81-4299-843e-6a1433976a36.png)

**Findings:**

* The use of the service by both members and casual users has a similar trend throughout the seasons, that is, the most popular season is Summer, followed by Fall, Spring, and the least popular season is Winter.

* Regarding casual users, it appears that the use of service in the Summer is above average (48.84%), whereas in Winter is lower (3.65%).

* Members have a more balanced distribution taking into account the trend indicated above. 

### Total Rides by Month

![month](https://user-images.githubusercontent.com/129385224/228985001-19d6f3cb-d810-4034-b67a-c53f66dc9036.png)

**Findings:**

* Throught the 12 months of the year, members ride more than casual users.

* It can be seen that from March onwards there is an increasing trend in the number of rides per month, culminating in the summer (July for casual riders, and August for members). This is followed by a downward trend in the number of rides until the end of the year.

* The months of January and February are constant for both groups of users.

### Percentage of Rides per Weekday

![weekday](https://user-images.githubusercontent.com/129385224/229160266-026f19df-5350-41d0-816a-92a3bb327bb4.png)

**Findings:**

* Members have the highest percentage of rides on Thursday (15.91%), while for casual users have the highest percentage of rides on Saturday (20.38%).

### Total Rides by Weekday

![weekday_line](https://user-images.githubusercontent.com/129385224/228985131-0498377a-f92c-43d7-aeca-9166f1fd2dd8.png)

**Findings:**

* The number of member rides is higher on weekdays, while the number of casual rides is higher on weekends.

* Member rides increase at the beginning of the week, reaching a peak on Thursday and then decreasing.

* Casual rides have the opposite trend, peaking on Saturday and then decreasing during the week.

### Percentage of Rides per Time of Day

![time_of_day](https://user-images.githubusercontent.com/129385224/229161411-d1576da8-4cb2-4247-89ff-ff9b61339bc6.png)

**Observations:**

* Both members and casual users have a higher percentage of rides during afternoon (12 PM - 5 PM).

#### Total Rides by Day Hour

![start_hour](https://user-images.githubusercontent.com/129385224/228985326-352151f3-a70a-4dc4-a2da-66869a195e63.png)

**Observations:**

* Except between the hours of 10 PM and 4 AM, when both groups execute a comparably low number of rides, members typically exceed casuals in terms of the number of rides.

* At peak commute times, more rides are performed by members (7-8 AM and 4-5 PM).

* In the case of casual users, there is a progressive increase in the number of rides from 6 AM, with a stabilization between 8-9 AM, and reaching the peak of rides at 5 PM.


## 6. Recommendations

Here are some recommendations that can be implemented to convert casual riders to annual members:

* Start promotional initiatives in the summer (from June to August).

* Hold promotions for memberships over the weekends to attract more casual riders.

* Raise the cost of renting bikes, especially electric bikes, for weekend casual riders.

* Develop some educational banners and promotions to enlighten casual riders about the cost-effectiveness of using Cyclistic bikes as an annual member for their everyday commute.






