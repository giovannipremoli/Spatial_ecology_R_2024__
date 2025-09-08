# script to measure variability
# higher variability means higher complexity of the system, higher the complexity higher will be the potential biodiversity
# higher is the amount of outliers (from the mean -> standard deviation) in the sample, higher will be the variability

library(imageRy)
library(terra)
im.list()

# data from Sentinel satelite
sent <- im.import("sentinel.png")
im.plotRGB(sent, r=1, g=2, b=3)

# band 1: NIR
# band 2: red
# band 3: green 
# the ground is green, woodlands are dark red and rocks are blue

im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=2, g=3, b=1) # yellow helps us to gain more info

# measuring standard deviation on a chosen band 
nir <- sent[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)

# focal() calculate standard deviation
# 9 pixels in a moving window, 3 rows and 3 columns. 1/9 to specify that we want to use 1 pixel (data) over the total 9

# Exercise: sd for 7x7 pixels (moving window)
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
# bigger window means higher standard deviation, but also lower resolution
# it's a try and error, there's no right choice for the dimension of the window 
plot(sd7)

# put sd3 and sd7 together 
par(mfrow=c(1,2))
plot(sd3)
plot(sd7)
