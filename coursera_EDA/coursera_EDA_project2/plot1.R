library(ggplot2)
if(!exists('NEI')){
NEI <- readRDS("data//summarySCC_PM25.rds")
}
if(!exists('SCC')){
SCC <- readRDS("data//Source_Classification_Code.rds")
}
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

data1 <- aggregate(NEI$Emissions,by=list(NEI$year),sum)
colnames(data1) <- c("year","Emissions")
data1$Emissions <- round(data1$Emissions/1000,2)

png('data/plot1.png')
barplot(data1$Emissions,names.arg=data1$year,xlab="year",ylab="Emissions(kilotons)",main="Total Emissions of PM2.5")
dev.off()

png('data/plot1b.png')
g <- ggplot(data1,aes(year,Emissions))
g+geom_line(color='steelblue')+geom_point()
dev.off()

