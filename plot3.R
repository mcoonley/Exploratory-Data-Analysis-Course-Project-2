## download data using link from coursera web page
## Data for Peer Assessment [29Mb]
## read data into R
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

## 3) Of the four types of sources indicated by type (point, nonpoint, onroad, ,nonroad)
##    variable, which of these four sources have seen decreases in emissions from 1999 to 
##    2008 for Baltimore City? Which have seen increases in emissions from 1999 to 2008?
##    Use ggplot2 plotting system to make a plot to answer these questions. 

## load ggplot package
library(ggplot2)
## create plot
png("plot3.png")
## eliminate unnecessary columns from NEI 
typeTot<-NEI[,-c(2:3)]
## to extract only info related to Baltimore City Maryland(fips == "24510")
typeBCM<-typeTot[typeTot$fips %in% c("24510"),]
type<-ggplot(typeBCM, aes(year, Emissions, color=factor(year)))
type+geom_point(size=4)+facet_grid(.~type)+theme(axis.text.x = element_text
    (angle=90))+ggtitle("Four Source Activity in Baltimore City from 1999 to 2008")
dev.off()
