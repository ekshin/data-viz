library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("plyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("xlsx", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("reshape2", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("gmodels", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("knitr", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("markdown", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

lgas<-read.csv("lgas.csv")
nmis<- read.csv("Health_Mopup_and_Baseline_NMIS_Facility.csv")
data<-merge(nmis, lgas, by="unique_lga")
names(data)
ls()
data<-rename(data,c(num_nurses_fulltime="nurs"))
data<-rename(data,c(num_doctors_fulltime="doct"))
data<-rename(data,c(facility_name="name"))
data<-rename(data,c(pop_2006="popu"))
data<-rename(data,c(area_sq_km="area"))
names(data)
myvars<-c("name","nurs","doct","state","zone","area","popu")
newdata<-data[myvars]
names(newdata)
head(newdata)
str(newdata)
newdata<-na.omit(newdata)
summary(newdata)
write.csv(newdata, file="newdata.csv")
attach(newdata)
mynurstable<-table(state, nurs)
mynurstabledoctortable<-margin.table(mydocttable,1)
nursetable<-margin.table(mynurstable,1)
nursetable
mydocttable<-table(state, doct)
doctortable<-margin.table(mydocttable,1)
doctortable
barplot(doctortable, legend=T,beside=T, main='Total Number of Doctors by State')
barplot(nursetable, legend=T,beside=T, main='Total Number of Nurses by State')
newdata$zone[newdata$zone == "North-Central"] <- "ns"
newdata$zone[newdata$zone == "Northeast"] <- "ns"
newdata$zone[newdata$zone == "Northwest"] <- "ns"
newdata$zone[newdata$zone == "South-South"] <- "s"
newdata$zone[newdata$zone == "Southeast"] <- "s"
newdata$zone[newdata$zone == "Southwest"] <- "s"
table(newdata$zone)
finaldata<-subset(newdata, zone == "s")
table(finaldata$zone)
finaldata$zone <- as.factor(finaldata$zone)
str(finaldata)

