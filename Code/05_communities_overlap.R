# Code to estimate the temporal overlap between species 

# Install.packages("overlap")

library(overlap)

data(kerinci)

head(kerinci)  #to show the first 6 rows of kerinci

kerinci

summary(kerinci)

kerinci$Timecirc <- kerinci$Time * 2 * pi # we are creating a new column 
summary(kerinci)

# tiger data 
tiger <- kerinci[kerinci$Sps=="tiger",]
# the name of the species is Sps, $ is inside something 

tigertime <- tiger$Timecirc

densityPlot(tigertime, rug=T)
# it shows the predatory activity of the tiger, it goes hunting when it wakes up and nearby 18:00

# macaque 
# Exercise: select the data for the macaque and assign them to a new object 
# in SQL the double == means equal, != otherwise means "does not equal"

macaque <- kerinci[kerinci$Sps=="macaque",]
head(macaque)

# Exercise: select the time for the macaque data and make a density plot 
macaque 

macaquetime <- macaque$Timecirc

densityPlot(macaquetime, rug=T)

overlapPlot(tigertime, macaquetime)

#---- SQL 
macaque <- kerinci[kerinci$Sps=="macaque",]
summary(macaque)

nomacaque <- kerinci[kerinci$Sps!="macaque",]
summary(nomacaque)
