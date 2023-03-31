#----------------------------------------------DATA CLEANING AND MANIPULATION------------------------------------

# 1. Load libraries

install.packages("tidyverse")

library(tidyverse) # for overall data importing and wrangling
library(lubridate) # for data and time related functions
library(skimr) # for dataframe summary
library(janitor) # for basic cleaning and wrangling functions
library(hms) # for storing and formatting time-of-day values

# 2. Data Cleaning

## 2.1 Clean up text data

### The clean_names function will remove any unwanted characters and consolidate data to facilitate aggregation

clean_names(Cyclistic_2022)

## 2.2 Check columns

### 2.2.1 ride_id

Cyclistic_2022 %>% filter(is.na(ride_id)) #to check for null values
Cyclistic_2022 %>% filter(duplicated(ride_id)) #to check for duplicated values

### Observations:
#* No null values.
#* No duplicate values.

### 2.2.2 bike_type

Cyclistic_2022 %>% filter(is.na(bike_type)) #to check for null values
Cyclistic_2022 %>% select(bike_type) %>% unique() #to check for unique values

### Observations:
#* No null values, only 3 bike types available.
#* Values are consistent.

### 2.2.3 started_at

Cyclistic_2022 %>% filter(is.na(started_at))

valid_start_at <- ymd_hms("2022-01-01 00:00:00")
valid_end_at <- ymd_hms("2022-12-31 23:59:59")

Cyclistic_2022 %>% filter(started_at < valid_start_at | started_at > valid_end_at)

### Observations:
#* No null values.
#* There are no dates not belonging to the year 2022.
#* Column type is date-time.

### 2.2.4 ended_at

Cyclistic_2022 %>% filter(is.na(ended_at))

### Observations:
#* No null values.
#* Column type is date-time.

### 2.2.5 Check user_type

Cyclistic_2022 %>% select(user_type) %>% unique()

### Observations:
#* No empty values.
#* Two user types available (member, casual).

# 3. Data Manipulation

## 3.1 Select only necessary columns
Cyclistic_2022_v2 <- Cyclistic_2022 %>% 
  select(ride_id, bike_type, started_at, ended_at, user_type)
  
## 3.2 Add new columns

Cyclistic_2022_v2$ride_duration <- difftime(strptime(Cyclistic_2022_v2$ended_at, "%Y-%m-%d %H:%M:%S"), #ended_at needs to be first converted to time data type
                                             strptime(Cyclistic_2022_v2$started_at, "%Y-%m-%d %H:%M:%S")) #ended_at needs to be first converted to time data type


Cyclistic_2022_v2 %>%  filter(ride_duration <= 0) %>% 
  select(ride_id, started_at, ended_at, ride_duration)

### Observations:
#* There are 531 records where started_at value is greater than or equal to the ended_at value.
#* started_at greater or equal to ended_at records need to be removed from the data set.

Cyclistic_2022_v3 <- Cyclistic_2022_v2 %>% filter(ride_duration > 0)
glimpse(Cyclistic_2022_v3)

### Change the format of the ride_duration variable, instead of being formatted in "x seconds", change it to "%h:%m:$s", in order to have a cleaner look

Cyclistic_2022_v3$ride_duration_hms <- as_hms(Cyclistic_2022_v3$ride_duration)

### Observations:
#* Cyclistic_2022_v3 contains only duration_in_seconds positive records.

### Next, we will create new columns so that it is possible to aggregate and analyze the data in a more specific way.

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



# 3. CSV file for creating Visualizations in Tableau
write.csv(Cyclistic_2022_v3, "Bike_Share_Cyclistic_2022_v3.csv")





