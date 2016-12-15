## download data using link from coursera web page
## Data for Peer Assessment [29Mb]
## read data into R
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

## 2) Have total emissions from PM2.5 decreased in Baltimore City, Maryland (fips == "24510")
##    from 1999 to 2008? Use the base plotting system to make a plot answering the question.

png("plot2.png")
## Extract only needed columns from NEI
fipsTot<-NEI[,c("fips", "Emissions", "year")]

## to extract only info related to Baltimore City Maryland(fips == "24510")
fipsBCM<-fipsTot[fipsTot$fips %in% c("24510"),]
yearBCM<-split(fipsBCM,fipsBCM$year)
totBCM<-sapply(yearBCM, function(x) sum(x[,"Emissions"], na.rm = TRUE))
year1<-c("1999","2002","2005","2008")
plot(year1,totBCM, type = "b", pch = 18, xlab = "", ylab = "Total Emissions", 
     main = "Variation in Total Emissions in Baltimore City, Maryland", 
     sub = "For Years 1999 to 2008", xlim = c(1999, 2008))
text(year1, totBCM, round(totBCM, digits = 2), cex = 0.5, pos = 1, col = "red")
dev.off()