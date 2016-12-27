# 5. How have emissions from motor vehicle sources changed 
#    from 1999–2008 in Baltimore City?
library(ggplot2)
if(!exists('NEI')){
  NEI <- readRDS("data//summarySCC_PM25.rds")
}
if(!exists('SCC')){
  SCC <- readRDS("data//Source_Classification_Code.rds")
}

#NEI 데이터에서 motor vehicle sources type==onroad 추출
data5sub <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]


#sum of emissions by year
data5 <- aggregate(data5sub$Emissions,by=list(data5sub$year),sum)

colnames(data5) <- c("year","emissions")
head(data5)
  
png("data//plot5.png")

g<-ggplot(data5,aes(x=factor(year),emissions,fill=year))
g+geom_bar(stat="identity")+
  labs(x="year")+
  labs(y="emissions of PM in kilotons")+
  labs(title="emissions of PM for motor vehicle in baltimore city")

dev.off()
