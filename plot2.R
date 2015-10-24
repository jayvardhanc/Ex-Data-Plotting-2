NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
data<-NEI[(NEI$fips==24510),]

data<-data[,c(4,6)]
png(filename = "plot2.png")
data<- aggregate(. ~ year, FUN = sum, data)
plot(data$year,data$Emissions,xlab="year",ylab=expression("total "*PM[2.5]*" emission from all sources"))
title(main=expression("Total "*PM[2.5]*" emissions in Baltimore City, Maryland")) 
dev.off()