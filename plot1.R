## download data using link from coursera web page
## Data for Peer Assessment [29Mb]
## read data into R
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

## 1) Have total emmissions from PM2.5 decreased in the United States from 1999 to 2008? 
##    Using the base plotting system, make a plot showing the total PM2.5 emissions from
##  
all sources for each of the years, 1999, 2002, 2005, and 2008. 

png("plot1.png")
## extract only needed columns from NEI to create new dataset 
totUS<-NEI[, c("Emissions","year")]

## split by years
yearUS<-split(totUS, totUS$year)
totYear<-sapply(yearUS, function(x) sum(x[,"Emissions"], na.rm = TRUE))
year1<-c("1999","2002","2005","2008")
modYear<-totYear/1000000
plot(year1,modYear, type = "b", pch = 18, xlab = "", ylab = "Total Emissions in millions", 
     main = "Decline in Total Emissions in US", sub = "For Years 1999 to 2008", 
     xlim = c(1999, 2008), ylim = c(3, 7.5))
text(year1, modYear, round(totYear, digits = 2), cex = 0.5, pos = 1, col = "red")
dev.off()