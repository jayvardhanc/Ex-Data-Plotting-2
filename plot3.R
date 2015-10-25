library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#susetting data for Baltimore City
data<-NEI[(NEI$fips==24510),]

#plotting data
png(filename = "plot3.png")
data<-data[,c(4,5,6)]
data<-aggregate(.~type+year,FUN=sum,data)
g<-ggplot(data,aes(factor(year),Emissions))+ geom_bar(aes(fill=type),stat="identity")+facet_grid(type~.,scale="free_x")+ylab(expression(PM[2.5]*" emissions (in tons)"))+xlab("year")+ggtitle(expression(PM[2.5]*" emissions from different sources in Baltimore City"))
print(g)
dev.off()