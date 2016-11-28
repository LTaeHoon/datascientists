#EDA Course project1

#data access
epc <- read.table('household_power_consumption.txt', header=TRUE, sep = ';', stringsAsFactors = FALSE)
#epc1 <- epc
#subsetting dates 2007-02-01 and 2007-02-02.

epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")
epc1 <- subset(epc, subset=c(Date >= "2007-02-01" & Date<="2007-02-02"))
rm('epc')

#plot1
Global_active_power <- as.numeric(epc1$Global_active_power)
Global_active_power <- Global_active_power[!is.na(Global_active_power)]
hist(Global_active_power,col='red',main='Global active power', xlab="Global active power(kilowatts)")
dev.copy(png,file='plot1.png',width=480,height=480)
dev.off()


