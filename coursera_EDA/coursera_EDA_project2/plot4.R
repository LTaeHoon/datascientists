# 4. Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999–2008?
library(ggplot2)
if(!exists('NEI')){
  NEI <- readRDS("data//summarySCC_PM25.rds")
}
if(!exists('SCC')){
  SCC <- readRDS("data//Source_Classification_Code.rds")
}
scc.coal<-SCC[grep("Fuel Comb.*Coal",SCC$EI.Sector),]

nei.coal <- NEI[NEI$SCC %in% scc.coal$SCC,]

data4 <- aggregate(nei.coal$Emissions,by=list(nei.coal$year),FUN = sum)
head(data4)
colnames(data4)<- c("year","emissions")

png('data//plot4.png')
g <- ggplot(data4,aes(x=factor(year),y=emissions/1000,fill=year,label=round(emissions/1000,2)))
g+geom_bar(stat = "identity")+
  labs(x="year")+
  labs(y=expression(paste("total PM",''[2.5],"emissions in kilotons")))+
  labs(title="Emissions from coal combustion-related sources in kilotons")+
  geom_label(aes(fill=year),color="white",fontface="bold")
dev.off()    
