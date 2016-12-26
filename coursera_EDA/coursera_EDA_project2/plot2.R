library(ggplot2)
if(!exists('NEI')){
  NEI <- readRDS("data//summarySCC_PM25.rds")
}
if(!exists('SCC')){
  SCC <- readRDS("data//Source_Classification_Code.rds")
}
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

png('data/plot2b.png')
g<-ggplot(data2,aes(year,Emissions))
g+geom_line(color='steelblue',size=1)+geom_point()
dev.off()

