

library(ggplot2)
library(dplyr)
library(tidyr)
library(DT)
library(scales)

library(ggthemes)

library(lubridate)

setwd('D:/R-DataAnalytics/Uber-data')

colors = c("#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0")



apr_data <- read.csv("uber-raw-data-apr14.csv")
may_data <- read.csv("uber-raw-data-may14.csv")
jun_data <- read.csv("uber-raw-data-jun14.csv")
jul_data <- read.csv("uber-raw-data-jul14.csv")
aug_data <- read.csv("uber-raw-data-aug14.csv")
sep_data <- read.csv("uber-raw-data-sep14.csv")

data_2014 <-rbind(apr_data, may_data,jun_data, jul_data, aug_data, sep_data)



data_2014$Date.Time <- as.POSIXct(data_2014$Date.Time, format = "%m/%d/%Y %H:%M:%S")


#data_2014$Time <- format(as.POSIXct(data_2014@Date.Time, format= "%m/%d/%Y %H:%M:%S "),format="%H:%M:%S")

data_2014$Time <- format(as.POSIXct(data_2014$Date.Time, format= "%m/%d/%Y %H:%M:%S "),format="%H:%M:%S")

data_2014$Date.Time<-ymd_hms(data_2014$Date.Time)


data_2014$Day <- factor(day(data_2014$Date.Time))
data_2014$Month <- factor(month(data_2014$Date.Time, label=TRUE))
data_2014$Year <- factor(year(data_2014$Date.Time))

data_2014$dayofweek <- factor(wday(data_2014$Date.Time, label = TRUE))

data_2014$hour   <- factor(hour(hms(data_2014$Time)))
data_2014$minute <- factor(minute(hms(data_2014$Time)))
data_2014$second <- factor(second(hms(data_2014$Time)))



hour_data <- data_2014 %>%
  group_by(hour) %>%
  dplyr::summarize(Total = n()) 


datatable(hour_data)




month_hour <- data_2014 %>% group_by(Month, hour) %>% dplyr::summarize(Total=n())



ggplot(month_hour, aes( hour, Total, fill=Month)) +
  geom_bar(stat='identity') + ggtitle("Trips by hour and month")+
  scale_y_continuous(labels = comma)


day_month_group <- data_2014 %>% group_by(Month, Day) %>% dplyr::summarise(Total=n())



ggplot(day_month_group, aes(Month, Total,fill=Month)) + 
        geom_bar(stat='identity', position = 'dodge' ) + ggtitle("Trips by Day and month") +
          scale_y_continuous(labels=comma) + scale_fill_manual(values=colors)





month_weekday <- data_2014 %>% group_by(Month, dayofweek) %>%
                  dplyr::summarise(Total=n())



ggplot(month_weekday, aes(Month, Total, fill=dayofweek) ) +
      geom_bar(stat='identity', position='dodge') + ggtitle("Trip by Month and Day of Week") +
  scale_y_continuous(labels=comma)+scale_fill_manual(values=colors)



ggplot(day_month_group, aes(Month, Day, fill=Total)) + geom_tile(color='blue') +
          ggtitle("Heat Map, Month -Day ")







