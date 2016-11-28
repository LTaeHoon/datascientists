#data access
epc <- read.table('household_power_consumption.txt', header=TRUE, sep = ';', stringsAsFactors = FALSE)
#epc1 <- epc
#subsetting dates 2007-02-01 and 2007-02-02.

epc1 <- epc[epc$Date %in% c('1/2/2007','2/2/2007'),]
rm('epc')

#data
datetime <- strptime(paste(epc1$Date,epc1$Time,sep =' '), format= '%d/%m/%Y %H:%M:%S')
global_active_power <- as.numeric(epc1$Global_active_power)
sub_metering1 <- as.numeric(epc1$Sub_metering_1)
sub_metering2 <- as.numeric(epc1$Sub_metering_2)
sub_metering3 <- as.numeric(epc1$Sub_metering_3)
voltage <- as.numeric(epc1$Voltage)
global_reactive_power <- as.numeric(epc1$Global_reactive_power)

par(mfrow=c(2,2))
plot(datetime, global_active_power,ylab='Global_active_power',type='l')
plot(datetime, voltage,ylab='Voltage',type='l')
plot(datetime, sub_metering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, sub_metering2, type="l", col="red")
lines(datetime, sub_metering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(datetime, global_reactive_power,ylab='Global_reactive_power',type = 'l')



dev.copy(png,file='plot4.png',width=480,height=480)
dev.off()