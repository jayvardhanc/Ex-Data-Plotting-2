library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting SCC to get coal-combustion related sources
source<-SCC[grep("Coal", SCC[,4]), ]

#merging the emission and source data
data1<-merge(NEI,source,by="SCC",sort=T)

#subsetting emissions and year columns
data1<-data1[,c(4,6)]

#Calculating sum for all coal-cumbustion related sources
coal_emission<-aggregate(.~year,FUN=sum,data1)

#plotting data
png(filename = "plot4.png")
g<-ggplot(coal_emission,aes(factor(year),Emissions/10^5,width=0.5))+geom_bar(stat="identity",fill=51)+xlab("year")+ylab(expression(PM[2.5]*" emissions (10^5 tons)"))+ggtitle(expression("Total "*PM[2.5]*" emission from Coal related sources from 1999 - 2008"))
print(g)
dev.off()