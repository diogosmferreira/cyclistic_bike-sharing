#----------------------------------------------DESCRIPTIVE ANALYSIS------------------------------------

#Load libraries
library(tidyverse)

#--------------TOTAL RIDES--------------

#total number of rides
nrow(Cyclistic_2022_v3)

#---------------USER TYPE---------------
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  count(user_type)

#---------------BIKE TYPE---------------
#total rides by user type 
Cyclistic_2022_v3 %>%
  group_by(user_type, bike_type) %>% 
  count(bike_type)

#total rides 
Cyclistic_2022_v3 %>%
  group_by(bike_type) %>% 
  count(bike_type)

#-----------------HOUR------------------

#total rides by user type 
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  count(start_hour) %>% 
  print(n = 48) #lets you view the entire tibble

#total rides
Cyclistic_2022_v3 %>%
  count(start_hour) %>% 
  print(n = 24) #lets you view the entire tibble

#----------------------TIME OF DAY-----------------------

#-----morning-------
#total rides by user type 
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(time_of_day == "Morning") %>% 
  count(time_of_day)

#total rides
Cyclistic_2022_v3 %>%
  filter(time_of_day == "Morning") %>% 
  count(time_of_day)

#-----afternoon-------
#total rides by user type 
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(time_of_day == "Afternoon") %>% 
  count(time_of_day)

#total rides 
Cyclistic_2022_v3 %>%
  filter(time_of_day == "Afternoon") %>% 
  count(time_of_day)

#-----evening-------
#total rides by user type
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(time_of_day == "Evening") %>% 
  count(time_of_day)

#total rides
Cyclistic_2022_v3 %>%
  filter(time_of_day == "Evening") %>% 
  count(time_of_day)

#-----night-------
#number of rides by user type
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(time_of_day == "Night") %>% 
  count(time_of_day)

#number of rides 
Cyclistic_2022_v3 %>%
  filter(time_of_day == "Night") %>% 
  count(time_of_day)

#---all times of day----
#total rides by user type 
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  count(time_of_day)

#number of rides
Cyclistic_2022_v3 %>%
  group_by(time_of_day) %>% 
  count(time_of_day)

#----------------WEEKDAY-----------------

#total rides by user type
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  count(weekday)

#total rides 
Cyclistic_2022_v3 %>%
  count(weekday)

#----------------DAY OF THE MONTH-----------------

#total rides by user type
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  count(day) %>% 
  print(n = 62) #lets you view the entire tibble

#total rides
Cyclistic_2022_v3 %>%
  count(day) %>% 
  print(n = 31) #lets you view the entire tibble

#---------------------MONTH-----------------------

#total rides by user type 
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  count(month) %>% 
  print(n = 24) #lets you view the entire tibble

#total rides
Cyclistic_2022_v3 %>%
  count(month) 

#--------------------SEASON-----------------------

#-----spring-------

#total rides by user type 
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(season == "Spring") %>% 
  count(season)

#total rides
Cyclistic_2022_v3 %>%
  filter(season == "Spring") %>% 
  count(season)

#-----summer-------

#total rides by user type
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(season == "Summer") %>% 
  count(season)

#total rides
Cyclistic_2022_v3 %>%
  filter(season == "Summer") %>% 
  count(season)

#-----fall-------

#total rides by user type
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(season == "Fall") %>% 
  count(season)

#total rides
Cyclistic_2022_v3 %>%
  filter(season == "Fall") %>% 
  count(season)

#-----winter-------

#total rides by user type
Cyclistic_2022_v3 %>%
  group_by(user_type) %>% 
  filter(season == "Winter") %>% 
  count(season)

#total rides 
Cyclistic_2022_v3 %>%
  filter(season == "Winter") %>% 
  count(season)

#-----all seasons-------

#total rides by user type
Cyclistic_2022_v3 %>%
  group_by(season, user_type) %>% 
  count(season)

#total rides
Cyclistic_2022_v3 %>%
  group_by(season) %>% 
  count(season)

#------------------------------------AVERAGE RIDE DURATION-----------------------------------

#average of ride duration
cyclistic_avgRide <- mean(Cyclistic_2022_v3$ride_duration)
print(cyclistic_avgRide)

#------------------USER TYPE--------------------

#average ride duration
Cyclistic_2022_v3 %>% group_by(user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#----------------BIKE TYPE---------------------

#average rides by user type 
Cyclistic_2022_v3 %>% group_by(user_type, bike_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% group_by(bike_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#-----------------------HOUR-------------------------

#average ride duration by user type
Cyclistic_2022_v3 %>% group_by(start_hour, user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean)) %>% 
  print(n=48) #lets you view entire tibble

#average ride duration
Cyclistic_2022_v3 %>% group_by(start_hour) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean)) %>% 
  print(n=24) #lets you view entire tibble

#--------------------TIME OF DAY---------------------

#----morning----

#average ride length by user type
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(time_of_day == "Morning") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  filter(time_of_day == "Morning") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#----afternoon----

#average ride duration by user type
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(time_of_day == "Afternoon") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  filter(time_of_day == "Afternoon") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#----evening----

#average ride duration by user type
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(time_of_day == "Evening") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  filter(time_of_day == "Evening") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#----night----

#average ride duration by user type 
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(time_of_day == "Night") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  filter(time_of_day == "Night") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#---all times of day---

#average ride duration by user type
Cyclistic_2022_v3 %>% 
  group_by(time_of_day, user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  group_by(time_of_day) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#-------------------WEEKDAY-----------------

#average ride duration by user type
Cyclistic_2022_v3 %>% group_by(user_type, weekday) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% group_by(weekday) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#-----------------DAY OF THE MONTH------------------

#average ride duration by user type
Cyclistic_2022_v3 %>% group_by(day, user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean)) %>% 
  print(n=62)  #lets you view entire tibble

#average ride duration
Cyclistic_2022_v3 %>% group_by(day) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean)) %>% 
  print(n=31)  #lets you view entire tibble

#---------------------MONTH--------------------------

#average ride duration by user type
Cyclistic_2022_v3 %>% group_by(month, user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean)) %>% 
  print(n=24)  #lets you view entire tibble

#average ride duration
Cyclistic_2022_v3 %>% group_by(month) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#----------------------SEASON-------------------------

#-----spring------

#average ride duration by user type
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(season == "Spring") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  filter(season == "Spring") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#-----summer------

#average ride duration by user type for summer 
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(season == "Summer") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration for summer 
Cyclistic_2022_v3 %>% 
  filter(season == "Summer") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#-----fall------

#average ride duration by user type
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(season == "Fall") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  filter(season == "Fall") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#-----winter-----

#average ride duration by user type
Cyclistic_2022_v3 %>% 
  group_by(user_type) %>% 
  filter(season == "Winter") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3 %>% 
  filter(season == "Winter") %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#----all seasons----

#average ride duration by user type
Cyclistic_2022_v3 %>% 
  group_by(season, user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#average ride duration
Cyclistic_2022_v3%>% 
  group_by(season) %>% 
  summarise_at(vars(ride_duration),
               list(time = mean))

#------------------------------------SUM RIDE DURATION-----------------------------------

#------------------USER TYPE--------------------

Cyclistic_2022_v3 %>% group_by(user_type) %>% 
  summarise_at(vars(ride_duration),
               list(time = sum))
