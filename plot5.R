library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Selecting all vehicles from SCC.Level.Two
vehicle_sources<-SCC[grep("Vehicle", SCC[,8]), ]
#subsetting data for Baltimore City
BaltimoreData<-NEI[NEI$fips == 24510,]
#merging the emissions and the source data
data<-merge(BaltimoreData,vehicle_sources,by="SCC",sort=T)
#selecting the emissions and year column.
data<-data[,c(4,6)]

png(filename = "plot5.png")

g<-ggplot(data,aes(factor(year),Emissions,width=0.5))+geom_bar(stat="identity",fill="cyan")+xlab("year")+ylab(expression(PM[2.5]*" emissions"))+ggtitle(expression("Total "*PM[2.5]*" emissions from vehicle sources in Baltimore City"))

print(g)

dev.off()