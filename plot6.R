## download data using link from coursera web page
## Data for Peer Assessment [29Mb]
## read data into R
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

## 6)  Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
##      vehicle sources in Los Angeles County California (fips == "06037").  Which city has seen 
##      greater changes over time in motor vehicle emissions?

## The Merriam-Webster Dictionary definition of motor vehicle:
##   https://www.merriam-webster.com/dictionary/motor%20vehicle
##  an automotive vehicle not operated on rails;especially one with rubber tires for use on highways
## With that definition in mind, the following EI.Sector levels in the SCC dataset were chosen:
##    Mobile - On-Road Diesel Heavy Duty Vehicles
##    Mobile - On-Road Diesel Light Duty Vehicles
##    Mobile - On-Road Gasoline Heavy Duty Vehicles
##    Mobile - On-Road Gasoline Light Duty Vehicles

## please note, these four levels also comprise the entire Data.Category level of "Onroad" in SCC,
## which is also noted on the NEI dataset as the "type" column
## entire "type" category of "ON-ROAD" in the NEI dataset.
## research operations run to verify:
levels(SCC$EI.Sector)
onroadmobile<-SCC[SCC$EI.Sector %in% c("Mobile - On-Road Diesel Heavy Duty Vehicles",
                                       "Mobile - On-Road Diesel Light Duty Vehicles",
                                       "Mobile - On-Road Gasoline Heavy Duty Vehicles",
                                       "Mobile - On-Road Gasoline Light Duty Vehicles"), ]
onroad<-split(SCC, SCC$Data.Category)
onroad1<-split(NEI, NEI$type)

## load ggplot package
library(ggplot2)
## eliminate unnecessary columns from NEI 
typeTot<-NEI[,-c(2:3)]
year1<-c("1999","2002","2005","2008")
## to extract only info related to Baltimore City Maryland(fips == "24510")
typeBCM<-typeTot[typeTot$fips %in% c("24510"),]
onroadBCM<-typeBCM[typeBCM$type %in% c("ON-ROAD"),]
yearBCM<-split(onroadBCM,onroadBCM$year)
totBCM<-sapply(yearBCM, function(x) sum(x[,"Emissions"], na.rm = TRUE))

## to extract only info related to Los Angeles County California (fips == "06037")
typeLAC<-typeTot[typeTot$fips %in% c("06037"),]
onroadLAC<-typeLAC[typeLAC$type %in% c("ON-ROAD"),]
yearLAC<-split(onroadLAC,onroadLAC$year)
totLAC<-sapply(yearLAC, function(x) sum(x[,"Emissions"], na.rm = TRUE))

png("plot6.png")
par(mfrow=c(1,2))
plot(year1,totBCM, type = "b", pch = 18, xlab = "", ylab = "Total Emissions", 
     main = "",
     sub = "Baltimore City, Maryland", font.sub = 3, xlim = c(1999, 2008))
text(year1, totBCM, round(totBCM, digits = 2), cex = 0.4, pos = 1, col = "red")
plot(year1,totLAC, type = "b", pch = 18, xlab = "", ylab = "Total Emissions", 
     main = "", 
     sub = "Los Angeles County, California", font.sub = 3, xlim = c(1999, 2008))
text(year1, totLAC, round(totLAC, digits = 2), cex = 0.4, pos = 1, col = "red")
mtext("Emissions comparisons - Baltimore and Los Angeles - Years 1999-2008",
      adj= 1,line = 3,font = 2, side = 3, outer = FALSE, cex = 1.0)
dev.off()
