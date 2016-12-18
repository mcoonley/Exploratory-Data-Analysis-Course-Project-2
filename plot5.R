## download data using link from coursera web page
## Data for Peer Assessment [29Mb]
## read data into R
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

## 5) Have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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

## create plot
png("plot5.png")
## eliminate unnecessary columns from NEI 
typeTot<-NEI[,-c(2:3)]
## to extract only info related to Baltimore City Maryland(fips == "24510")
typeBCM<-typeTot[typeTot$fips %in% c("24510"),]
## to extract ON-ROAD data from Baltimore City Maryland data set
onroadBCM<-typeBCM[typeBCM$type %in% c("ON-ROAD"),]
## split by year
yearBCM<-split(onroadBCM,onroadBCM$year)
## calculate summary totals by year
totBCM<-sapply(yearBCM, function(x) sum(x[,"Emissions"], na.rm = TRUE))
year1<-c("1999","2002","2005","2008")
plot(year1,totBCM, type = "b", pch = 18, xlab = "", ylab = "Total Emissions", 
     main = "Decline in Motor Vehicle Emissions in Baltimore City, Maryland", 
     sub = "For Years 1999 to 2008", xlim = c(1999, 2008))
text(year1, totBCM, round(totBCM, digits = 2), cex = 0.5, pos = 1, col = "red")
dev.off()
