library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Selecting all vehicles from SCC.Level.Two
vehicle_sources<-SCC[grep("Vehicle", SCC[,8]), ]
#selecting the two cities
select_cities<-NEI[(NEI$fips=="06037"|NEI$fips=="24510"),]
#merging the data on emissions and its sources
data<-merge(select_cities,vehicle_sources,by="SCC",sort=T)
#subsetting the columns for fips,emissions and year
data_select<-data[,c(2,4,6)]
#calulating the sum for the two cities for each year
data_select<-aggregate(.~fips+year,FUN=sum,data_select)
#renaming the "fips" column with "City" and the rows with their respective city names
colnames(data_select)[1]<-"City"
data_select[data_select$City=="06037",]$City<-"Los Angeles County"
data_select[data_select$City=="24510",]$City<-"Baltimore City"
# plotting the filtered and calulated data
png(filename = "plot6.png",width=650,height=650,units="px")
g<-ggplot(data_select,aes(factor(year),Emissions))+geom_bar(aes(fill=City),stat="identity")+facet_grid(.~City)+xlab("year")+ylab(expression("Total "*PM[2.5]*" emissions (in tons)"))+ggtitle(expression(PM[2.5]*" Emissions from vehical sources in Baltimore and Los Angeles"))+theme_bw()
print(g)
dev.off()