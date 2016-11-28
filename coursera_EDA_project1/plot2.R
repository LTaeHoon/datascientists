#plot2

#data access
epc <- read.table('household_power_consumption.txt', header=TRUE, sep = ';', stringsAsFactors = FALSE)
#epc1 <- epc
#subsetting dates 2007-02-01 and 2007-02-02.

epc1 <- epc[epc$Date %in% c('1/2/2007','2/2/2007'),]
rm('epc')

datetime <- strptime(paste(epc1$Date,epc1$Time,sep =' '), format= '%d/%m/%Y %H:%M:%S')

epc1$datetime <- datetime

epc1$Global_active_power <- as.numeric(epc1$Global_active_power)
#str(epc1)


plot(epc1$datetime,epc1$Global_active_power,xlab='',ylab='Global_active_power(kilowatts)', type='l')
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()