#----------------------------------------------DATA COLLECTION AND PREPARATION------------------------------------

# 1. Install and load libraries

install.packages("tidyverse")

library(tidyverse) # for overall data importing and wrangling
library(skimr) # for dataframe summary
library(janitor) # for basic cleaning and wrangling functions

# 2. Collect data

## Import data into the RStudio environment

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

Cyclistic_022022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202202-divvy-tripdata.csv",
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

Cyclistic_032022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202203-divvy-tripdata.csv",
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

Cyclistic_042022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202204-divvy-tripdata.csv",
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

Cyclistic_052022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202205-divvy-tripdata.csv",
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

Cyclistic_062022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202206-divvy-tripdata.csv",
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

Cyclistic_072022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202207-divvy-tripdata.csv",
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

Cyclistic_082022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202208-divvy-tripdata.csv",
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

Cyclistic_092022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202209-divvy-tripdata.csv",
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

Cyclistic_102022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202210-divvy-tripdata.csv",
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

Cyclistic_112022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202211-divvy-tripdata.csv",
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

Cyclistic_122022 <- read_csv("Desktop/Data Analytics/Google Data Analytics Professional Certificate/8 - Google Data Analytics Case Study/Capstone Project/Cyclistic/Raw data - CSV files/202212-divvy-tripdata.csv",
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

# 3. Merge data

## In order to combine all the dataframes into one, all must share the same columns with the same exact names

compare_df_cols(Cyclistic_012022, Cyclistic_022022, Cyclistic_032022, Cyclistic_042022, Cyclistic_052022, Cyclistic_062022, Cyclistic_072022, Cyclistic_082022, Cyclistic_092022, Cyclistic_102022, Cyclistic_112022, Cyclistic_122022)
# It is possible to verify that all datasets have exactly the same column names

## Merge individual monthly data frames into one annual large data frame
Cyclistic_2022 <- bind_rows(Cyclistic_012022, Cyclistic_022022, Cyclistic_032022, Cyclistic_042022, Cyclistic_052022, Cyclistic_062022, Cyclistic_072022, Cyclistic_082022, Cyclistic_092022, Cyclistic_102022, Cyclistic_112022, Cyclistic_122022)

# 4. Rename columns

Cyclistic_2022 <- rename(Cyclistic_2022, bike_type=rideable_type, user_type=member_casual, start_latitude=start_lat, end_latitude=end_lat, start_longitude=start_lng, end_longitude=end_lng)

glimpse(Cyclistic_2022)
str(Cyclistic_2022)

# 5. Final overview
skim_without_charts(Cyclistic_2022)

