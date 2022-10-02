##Assignment 3

##1
data <- read.csv("StormEvents_details-ftp_v1.0_d1995_c20220425.csv")

##2,3
library(dplyr)
library(tidyverse)

limitdata <- data %>% 
  select(BEGIN_YEARMONTH, BEGIN_DATE_TIME,END_DATE_TIME,EPISODE_ID,EVENT_ID,STATE, STATE_FIPS,CZ_FIPS,CZ_NAME,SOURCE,EVENT_TYPE,BEGIN_LAT,BEGIN_LON,END_LAT,END_LON,CZ_TYPE ) %>% 
  arrange(BEGIN_YEARMONTH)

##4
limitdata$STATE<- str_to_title(limitdata$STATE)

##5
limitdata5 <- limitdata %>%
  filter(CZ_TYPE=='C') %>%
  select(-CZ_TYPE)

##6
limitdata5$STATE_FIPS <- str_pad(limitdata5$STATE_FIPS, width = '3', side = 'left', pad = '0')
        
limitdata5 %>%
  unite("county FIPS", STATE_FIPS,CZ_FIPS)

##7
limitdata5<-rename_all (limitdata5, tolower)

##8
data("state")
us_state_info<-data.frame(state=state.name, region=state.region, area=state.area)

##9
limitdata9 <- data.frame(table(limitdata5$state))
limitdata9<-rename(limitdata9, c("state"="Var1"))
merged <- merge(x=limitdata9,y=us_state_info,by.x="state", by.y="state")

##10
library(ggplot2)
storm_plot <-ggplot (merged,aes(x=area, y=Freq)) + 
  geom_point(aes(color = region)) +
  labs(x = 'land area', y = '# of storm event in 1995')

storm_plot



