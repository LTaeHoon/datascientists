if(!exist(NEI)){
NEI <- readRDS("data//summarySCC_PM25.rds")
}
if(!exist(SCC)){
SCC <- readRDS("data//Source_Classification_Code.rds")
}
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

data1 <- aggregate(NEI$Emissions,by=list(NEI$year),sum)
colnames(data1) <- c("year","Emissions")
data1$Emissions <- round(data1$Emissions/1000,2)

png('data/plot1.png')
barplot(data1$Emissions,names.arg=data1$year,xlab="year",ylab="Emissions(kilotons)",main="Total Emissions of PM2.5")
dev.off()


# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
# subset by fips=='24510'
str(NEI)
Maryland_data <- subset(NEI,fips=="24510",c(fips,Emissions,year))
data2 <- aggregate(Maryland_data$Emissions,by=list(Maryland_data$year),sum)
colnames(data2) <- c("year","Emissions")
head(data2)
png('data/plot2.png')
barplot(data2$Emissions,names.arg = data2$year,xlab="year",ylab="Emissions",main="Total emissions of PM2.5 in Maryland")
dev.off()

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

str(NEI)
str(SCC)

fips1999 <- subset(NEI,year==1999,c(fips,Emissions))
sum(is.na(fips1999$Emissions))#0 -> na값이 없음
fips2002<- subset(NEI,year==2002,c(fips,Emissions))
fips2005<- subset(NEI,year==2005,c(fips,Emissions))
fips2008<- subset(NEI,year==2008,c(fips,Emissions))
sum1999 <- with(fips1999, tapply(Emissions,fips,sum,na.rm=T))
sum2002 <- with(fips2002, tapply(Emissions,fips,sum,na.rm=T))
sum2005 <- with(fips2005, tapply(Emissions,fips,sum,na.rm=T))
sum2008 <- with(fips2008, tapply(Emissions,fips,sum,na.rm=T))

str(sum1999)
names(sum1999)
#1999년 U.S. county 별 pm2.5 배출량 합
d1999 <- data.frame(fips = names(sum1999), Emissions = sum1999)
d2002 <- data.frame(fips = names(sum2002), Emissions = sum2002)
d2005 <- data.frame(fips = names(sum2005), Emissions = sum2005)
d2008 <- data.frame(fips = names(sum2008), Emissions = sum2008)

mrg <- merge(d1999,d2002,by="fips")
mrg <- merge(mrg,d2005,by="fips")
mrg <- merge(mrg,d2008,by="fips")
mrg <- as.data.frame(mrg)
colnames(mrg) <- c('fips','1999sum','2002sum','2005sum','2008sum')
head(mrg)

par(mfrow=c(1,1))
with(mrg,plot(rep(1999,nrow(mrg)),mrg[,2],xlim=c(1999,2008),ylim =))
with(mrg,points(rep(2002,nrow(mrg)),mrg[,3]))
with(mrg,points(rep(2005,nrow(mrg)),mrg[,4]))
with(mrg,points(rep(2008,nrow(mrg)),mrg[,5]))
segments(rep(1999,nrow(mrg)),mrg[,2],rep(2002,nrow(mrg)),mrg[,3])
segments(rep(2002,nrow(mrg)),mrg[,3],rep(2005,nrow(mrg)),mrg[,4])
segments(rep(2005,nrow(mrg)),mrg[,4],rep(2008,nrow(mrg)),mrg[,5])

?segments


# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?