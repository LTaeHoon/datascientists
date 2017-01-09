Peer-graded Assignment: Course Project 1
===================================================

## Loading and preprocessing the data




```r
data <- read.csv("activity.csv")
summary(data)
```

```
##      steps                date          interval     
##  Min.   :  0.00   2012-10-01:  288   Min.   :   0.0  
##  1st Qu.:  0.00   2012-10-02:  288   1st Qu.: 588.8  
##  Median :  0.00   2012-10-03:  288   Median :1177.5  
##  Mean   : 37.38   2012-10-04:  288   Mean   :1177.5  
##  3rd Qu.: 12.00   2012-10-05:  288   3rd Qu.:1766.2  
##  Max.   :806.00   2012-10-06:  288   Max.   :2355.0  
##  NA's   :2304     (Other)   :15840
```

## What is mean total number of steps taken per day?
1.Calculate the total number of steps taken per day

```r
stepsPday <- aggregate(steps~date,data,sum,na.rm=TRUE)
head(stepsPday)
```

```
##         date steps
## 1 2012-10-02   126
## 2 2012-10-03 11352
## 3 2012-10-04 12116
## 4 2012-10-05 13294
## 5 2012-10-06 15420
## 6 2012-10-07 11015
```

2.If you do not understand the difference between a histogram and a barplot, research the difference between them. Make a histogram of the total number of steps taken each day

```r
hist(stepsPday$steps)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)
3.Calculate and report the mean and median of the total number of steps taken per day

```r
mean_stepsperday <- mean(stepsPday$steps)
mean_stepsperday
```

```
## [1] 10766.19
```

```r
median_stepsperday <- median(stepsPday$steps)
median_stepsperday
```

```
## [1] 10765
```

##What is the average daily activity pattern?
1.Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.3.1
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
stepsbyInterval <- summarize(group_by(data,interval),steps=mean(steps,na.rm=TRUE))
plot(steps~interval,data=stepsbyInterval,type='l',main="the average number of steps")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png)

2.Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
maxstepsbyInterval <- stepsbyInterval[which.max(stepsbyInterval$steps),]$interval
maxstepsbyInterval
```

```
## [1] 835
```

##Imputing missing values
1.Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

```r
totalmissingdata <- sum(is.na(data$steps))
totalmissingdata
```

```
## [1] 2304
```
2.Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

```r
getmeansteps <- function(interval){
  stepsbyInterval[stepsbyInterval$interval==interval,]$steps
}
```
3.Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
datanoNA <-data
for(i in 1:nrow(datanoNA)){
  if(is.na(datanoNA[i,]$steps)){
    datanoNA[i,]$steps <- getmeansteps(datanoNA[i,]$interval)
  }
}
head(datanoNA)
```

```
##       steps       date interval
## 1 1.7169811 2012-10-01        0
## 2 0.3396226 2012-10-01        5
## 3 0.1320755 2012-10-01       10
## 4 0.1509434 2012-10-01       15
## 5 0.0754717 2012-10-01       20
## 6 2.0943396 2012-10-01       25
```
4.Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

```r
totstepsdatanoNA <- aggregate(steps~date,datanoNA,sum,na.rm=TRUE)
hist(totstepsdatanoNA$steps)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png)

##Are there differences in activity patterns between weekdays and weekends?
1.Create a new factor variable in the dataset with two levels <e2>€<93> <e2>€œweekday<e2>€<9d> and <e2>€œweekend<e2>€<9d> indicating whether a given date is a weekday or weekend day.

```r
datanoNA$date <-as.Date(strptime(datanoNA$date,format="%Y-%m-%d"))
class(datanoNA$date)
datanoNA$day <- weekdays(datanoNA$date)
for(i in 1:nrow(datanoNA)){
  if(datanoNA[i,]$day %in% c("<U+653C><U+3E64>† <U+653C><U+3E63>š”<U+653C><U+3E63>¼","<U+653C><U+3E63>¼<U+653C><U+3E63>š”<U+653C><U+3E63>¼")){
    datanoNA[i,]$day <-"weekend"
  }else{
    datanoNA[i,]$day <-"weekday"
  }
}
stepsbyday <- aggregate(steps~interval+day,datanoNA,mean)
head(stepsbyday)
```

```
## Error: invalid multibyte character in parser at line 5
```
2.Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.

```r
library(ggplot2)
g<-ggplot(stepsbyday,aes(interval,steps))
g+geom_line()+
  facet_grid(.~day)+
  labs(x="interval")+
  labs(y="steps")+
  labs(title="comparing the average number of steps by interval across weekdays and weekends")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png)


