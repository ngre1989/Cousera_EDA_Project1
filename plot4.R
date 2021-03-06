Housedata <- as.data.frame(read.table("household_power_consumption.txt",
                                      header = TRUE,sep = ";",
                                      stringsAsFactors = FALSE, 
                                      dec ='.'))
subsetdata <- subset(Housedata, Housedata$Date %in% c("1/2/2007","2/2/2007"))
datetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
GlobalActivePower <- subsetdata$Global_active_power
GlobalActivePower <- as.numeric(GlobalActivePower)
GlobalReactivePower <- as.numeric(subsetdata$Global_reactive_power)
sub1 <- as.numeric(subsetdata$Sub_metering_1)
sub2 <- as.numeric(subsetdata$Sub_metering_2)
sub3 <- as.numeric(subsetdata$Sub_metering_3)

voltage <- as.numeric(subsetdata$Voltage)

png("plot4.png",width = 480, height = 480)
par(mfrow = c(2,2))

plot(datetime, GlobalActivePower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(datetime, voltage,type = "l", xlab = "datetime", ylab = "Voltage")
plot(datetime, sub1, type="l",ylab = "Energy Submetering", xlab = "")
lines(datetime, sub2, type = "l", col="red")
lines(datetime, sub3, type = "l", col = "blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, 
       lwd=2.5, 
       col=c("black", "red", "blue"))
plot(datetime,GlobalReactivePower,type = 'l',xlab = "datetime", ylab = "Global_reactive_power")
dev.off()