#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#selecting emissions and year column for calculating sum
temp<-NEI[,c(4,6)]

png(filename = "plot1.png")
data<- aggregate(. ~ year, FUN = sum, temp)
plot(data$year,data$Emissions,xlab="year",ylab=expression("total "*PM[2.5]*" emission from all sources"))
title(main = expression("Total "*PM[2.5]*" emissions over various years in United States"))
dev.off()
