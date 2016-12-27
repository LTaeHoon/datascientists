library(ggplot2)
if(!exists('NEI')){
  NEI <- readRDS("data//summarySCC_PM25.rds")
}
if(!exists('SCC')){
  SCC <- readRDS("data//Source_Classification_Code.rds")
}

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

data3sub1 <- subset(NEI, fips=="24510",c(fips,Emissions,year,type))
data3sub2 <- aggregate(data3sub1$Emissions,by=list(data3sub1$type,data3sub1$year),sum)
colnames(data3sub2) <- c("type","year","emissions")


png('data//plot3.png')
g1<-ggplot(data3sub2, aes(year,emissions,color=type))
g1+geom_line()+geom_point()
dev.off()

png('data//plot3b.png')
g<-ggplot(data3sub1,aes(x=factor(year),y=log(Emissions)))
g+geom_boxplot(aes(fill=type),stat="boxplot",outlier.color = "red")+
  facet_grid(.~type)+
  labs(x="year")+
  labs(y=expression(paste('log',' of PM'[2.5],'Emissions')))+
  labs(title='Emissions per type in bartimore city, maryland')
dev.off()
# data3sub$year <- factor(data3sub$year,levels=c('1999','2002','2005','2008'))
# ggplot(data=data3sub, aes(x=year, y=log(emissions))) + 
# facet_grid(. ~ type)+
# geom_boxplot(aes(fill=type))+ 
# ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + 
# xlab('Year') + 
# ggtitle('Emissions per Type in Baltimore City, Maryland')
#geom_jitter(alpha=0.10)

