## download data using link from coursera web page
## Data for Peer Assessment [29Mb]
## read data into R
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")
"
## 4)   Across the US, how have emissions from coal combustion-related sources changed from 1999-2008?
## SCC has 15 variables, making it difficult to view.  The variable necessary to identify coal 
## combustion-related sources is "EI.Sector".  Therefore, creating a less noisy SCC dataset allows 
## for easier review and analysis to determine appropriately required levels.

newSCC<-SCC[ , c("SCC", "Data.Category", "EI.Sector")]

## Using View(newSCC) in RStudio to open the file in the script area, allows for both cleaner viewing
## as well as offering a filtering option.  Selecting the filter option allows user to select key
## descriptors to narrow down the list.  Enter key work 'coal' as a filter, the original count of observations
## is reduced from 11717 to 529.  By reviewing the truncated dataset, specifically the associated 
## SCC, a pattern emerges showing all "coal" related levels of "EI.Sector"  end within the range of 000:318.

## create plot
png("plot4.png")
## Extract only needed columns from NEI
allSCC<-NEI[,c("SCC","Emissions","year")]
## Subset to include only coal combustion related sources
coalSCC<-allSCC[allSCC$SCC %in% c(10100101:10100318,10200101:10200307, 10300101:10300309, 10500102,
                                      10500202, 10102001, 10102018,2101001000:2101003000,2102001000,
                                  2102002000,2103001000,210300200,2199001000:2199003000),]
## split by year
yearCoal<-split(coalSCC, coalSCC$year)
## calculate summary totals by year
totCoal<-sapply(yearCoal, function(x) sum(x[,"Emissions"], na.rm = TRUE))
year1<-c("1999","2002","2005","2008")
plot(year1,totCoal, type = "b", pch = 18, xlab = "", ylab = "Total Emissions", 
     main = "Changes in Emissions from Coal-related Sources across the US", 
     sub = "For Years 1999 to 2008", xlim = c(1999, 2008))
text(year1, totCoal, round(totCoal, digits = 2), cex = 0.5, pos = 1, col = "red")
dev.off()
