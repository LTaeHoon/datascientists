#read data
#pm0 : 1999년 Air pollution 자료
pm0 <- read.table('E:\\github\\datascientist\\coursera_EDA\\data\\RD_501_88101_1999-0.txt',comment.char = "#",header = FALSE,sep="|",na.strings="")
dim(pm0)
head(pm0)
cnames <- readLines('E:\\github\\datascientist\\coursera_EDA\\data\\RD_501_88101_1999-0.txt',1)
cnames <- strsplit(cnames,"|",fixed = TRUE)

names(pm0)<-cnames[[1]]
head(pm0)
names(pm0) <- make.names(cnames[[1]]) #변수명의 빈칸을 점(dot)으로 대체해주는 함

x0 <- pm0$Sample.Value
class(x0)
str(x0)
summary(x0)
mean(is.na(x0)) #NA의 비율 11%

pm1 <- read.table('E:\\github\\datascientist\\coursera_EDA\\data\\RD_501_88101_2012-0.txt',comment.char="#",header=FALSE,sep="|",na.strings="")
dim(pm1)
names(pm1)<-make.names(cnames[[1]])
head(pm1)
x1 <- pm1$Sample.Value
class(x1)
str(x1)
#간단하게 비교 중간값이 감소
summary(x1)
 # Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
 # -10.00    4.00    7.63    9.14   12.00  909.00   73133 
summary(x0)
 # Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.00    7.20   11.50   13.74   17.90  157.10   13217 
mean(is.na(x1)) #na의 비율이 5% 
boxplot(x0,x1)
boxplot(log10(x0),log10(x1))
#pm2.5 값이 - 값이 있는것이 이상하다
negative <- x1 <0
str(negative)
sum(negative,na.rm = TRUE) 
#[1] 26474
mean(negative,na.rm = TRUE)
#0.0215034

dates <- pm1$Date
str(dates)
dates <- as.Date(as.character(dates),"%Y%m%d")
str(dates)
hist(dates,"month")

#pm2.5의 값이 음수일때의 월별 빈도수 겨울에 낮은 값이 많이 나오는 것을 볼 수 있고 여름은 그 반대이다.
hist(dates[negative],"month")
