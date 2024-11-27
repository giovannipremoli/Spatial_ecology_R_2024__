# time series analysis in R 

library(terra)
library(imageRy)

im.list() # EN menas european nitrogen 

# importing data 
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png") # those are processed datas, not direct from the satellite 

EN01
difEN = EN01[[1]] - EN13[[1]]
plot(difEN) # see the difference between januast and march, it's higher in march 

# example 2: ice melt in Greenland 

gr <- im.import("greenland") # greenland is a common part of the name of the datas that we are intersted in, we want to import all of them not only one
gr

# u can plot one single layer 
plot(gr[[1]]) # we have plotted the data from 2000 cause is the first element in our elencum 
plot(gr[[4]])

# exercise: plot in a multiframe the first and last element of gr 
par(mfrow=c(1,2))
plot(gr[[1]]) 
plot(gr[[4]])  # u need to give all the commands together 

difgr = gr[[1]] - gr[[4]]
dev.off() # to cancel the previous multiframe 
plot(difgr)

# exercise: compose an RGB image with the years of Greenland temperature 
im.plotRGB(gr, 1, 2, 4)
# gr: 2000, 2005, 2010, 2015. so the 2015 is number 4 
# everything in cold color has high value of temperature in the blue, so in 2015. everything in red has high temperatures in 2000. green in 2005

# take home message: u can have wide ammount of different datas and use all of them or make the difference between two of them 
