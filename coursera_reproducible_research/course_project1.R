# 1. Code for reading in the dataset and/or processing the data

data <- read.csv("activity.csv")

# 2. Histogram of the total number of steps taken each day
stepsPday <- aggregate(steps~date,data,sum,na.rm=TRUE)
hist(stepsPday$steps)

# 3. Mean and median number of steps taken each day
mean_stepsperday <- mean(stepsPday$steps)
mean_stepsperday
median_stepsperday <- median(stepsPday$steps)
median_stepsperday
# 4. Time series plot of the average number of steps taken
library(dplyr)
stepsbyInterval <- summarize(group_by(data,interval),steps=mean(steps,na.rm=TRUE))
plot(steps~interval,data=stepsbyInterval,type='l',main="the average number of steps")

# 5. The 5-minute interval that, on average, contains the maximum number of steps
maxstepsbyInterval <- stepsbyInterval[which.max(stepsbyInterval$steps),]$interval
maxstepsbyInterval
# 6. Code to describe and show a strategy for imputing missing data
totalmissingdata <- sum(is.na(data$steps))
totalmissingdata

stepsbyInterval$steps 


getmeansteps <- function(interval){
  stepsbyInterval[stepsbyInterval$interval==interval,]$steps
}
datanoNA <-data
for(i in 1:nrow(datanoNA)){
  if(is.na(datanoNA[i,]$steps)){
    datanoNA[i,]$steps <- getmeansteps(datanoNA[i,]$interval)
  }
}
head(datanoNA)

# 7. Histogram of the total number of steps taken each day after missing values are imputed
totstepsdatanoNA <- aggregate(steps~date,datanoNA,sum,na.rm=TRUE)
hist(totstepsdatanoNA$steps)

# 8. Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends

datanoNA$date <-as.Date(strptime(datanoNA$date,format="%Y-%m-%d"))
class(datanoNA$date)
datanoNA$day <- weekdays(datanoNA$date)
for(i in 1:nrow(datanoNA)){
  if(datanoNA[i,]$day %in% c("토요일","일요일")){
    datanoNA[i,]$day <-"weekend"
  }else{
    datanoNA[i,]$day <-"weekday"
  }
}
stepsbyday <- aggregate(steps~interval+day,datanoNA,mean)
head(stepsbyday)

library(ggplot2)
g<-ggplot(stepsbyday,aes(interval,steps))
g+geom_line()+
  facet_grid(.~day)+
  labs(x="interval")+
  labs(y="steps")+
  labs(title="comparing the average number of steps by interval across weekdays and weekends")
# 9. All of the R code needed to reproduce the results (numbers, plots, etc.) in the report
