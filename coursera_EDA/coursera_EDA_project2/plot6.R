# 6. Compare emissions from motor vehicle sources in Baltimore City 
#    with emissions from motor vehicle sources in Los Angeles County, 
#    California (fips == "06037"). 
#     Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)
if(!exists('NEI')){
  NEI <- readRDS("data//summarySCC_PM25.rds")
}
if(!exists('SCC')){
  SCC <- readRDS("data//Source_Classification_Code.rds")
}

balti.data6 <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
la.data6 <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]

balti.data6$county <- "Baltimore City, MD"
la.data6$county <- "Los Angels, CA"

data6 <- rbind(balti.data6,la.data6)
str(data6)

data6sub <- aggregate(data6$Emissions,by=list(data6$county,data6$year),sum)

colnames(data6sub) <- c("county","year","emissions")

png("data//plot6.png")
g<-ggplot(data6sub,aes(x=factor(year),y=emissions,fill=county,label=round(emissions,2)))
g+geom_bar(stat='identity')+
  facet_grid(county~.,scales="free")+ 
  labs(x="year")+
  labs(y="emissions in tons")+
  labs(title="Motor vehicle emissions for MD and CA")+
  geom_label(aes(fill=county),color="white",fontface="bold")
dev.off()
