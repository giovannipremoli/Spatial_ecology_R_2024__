# Code for remote sensing data handling and analysis

install.packages("devtools")
library(devtools)

install_github("ducciorocchini/imageRy") # function of devtools 

library(terra)
library(imageRy)

install.packages("ggplot2")
library(ggplot2)

# listing data inside imageRy
im.list()
# every sensor in recording one wavelength, every single layer is called band. b2 in the 25 data is band2

# sentinel 2 bands 
# https://gisgeography.com/sentinel-2-bands-combinations/

# importing the data 
b2 <- im.import("sentinel.dolomites.b2.tif")

# for changing colors 
cl <- colorRampPalette(c("black", "grey", "lightgrey")) (100)
plot(b2, col=cl)

# passive sensors and active sensors (watch the slide with the sun and sensors, before radiant flux and reflectance) 
# energy reflected for a red wavelength is zero in case of plants cause they absorbe this radiation 
# reflectance can go form 0 to 1 

# exercise: import b3 and plot it with the previous palette 
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=cl) # we are considering the green wavelength, see the tabella on the website 

# b4 is the red part, large wavelength and less frequency 
# importing the red band
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=cl) # the most clear is the blue wavelength in general 

# b8 is near infrared, 842 nm. We are not using b5,6,7 cause the resolution in these are 20m (too much, pixels are too big and there would be a mismatch)
# infrared is divided in near infrared, thermal infrared (reflect in a different way related to temperature, but is measuring the reflectance not the temperature), and at least middle infrared 

# importing the NIR band (near infrared)
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=cl)   this wavelength is related to vegetation 

# multiframe, to see all the images together 
par(mfrow=c(2,2))
plot(b2, col=cl)   
plot(b3, col=cl) 
plot(b4, col=cl)   
plot(b8, col=cl)   

# for stacking them we have to consider 
# stack
sentstack <- c(b2, b3, b4, b8)
plot(sentstack, col=cl) # the visible wavelength gives us similar informations, the infrared no (b8)

# plotting one layer 
dev.off()
plot(sentstack[[1]], col=cl)
plot(sentstack[[4]], col=cl)

# multiframe with different color palette 
# we need to rebuild the multiframe 
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

# exercise: apply the same concept to the green band (b3)
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

# plotting red band (b4)
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

# plotting the NIR band (b8)
cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)

par(mfrow=c(2,2))
> plot(b2, col=clb)   
> plot(b3, col=clg) 
> plot(b4, col=clr)   
> plot(b8, col=cln) 

# we can combine all the colours in a scheme called RGB, overlap of 3 basic colours compose all the other ones 
# you can't use R to see all the layers if you want to overlap, but you can combine them 
# in our stack the third layer is the red so we can put 3, 2 for green, 1 for blue. see the photo on iphone 
# RGB plotting 
dev.off() # for removing the multiframe 
im.plotRGB(sentstack, r=3, g=2, b=1) #sentstack is name of the image. u can write also red, green and blue for the letters or simply the numbers 3, 2, 1


# we can't see 4 layers so we are add 1 to each layer. by that we remove first layer and view 4 (it's called false colouring, to see the infrared)
# see the leaves slides, red and blue are absorbed by cloroplast for photosyntesis. CO2 is taken by rubisco protein. NIR is ultrareflected by plants (white arrow)
im.plotRGB(sentstack, r=4, g=3, b=2) # false color image, the plants will be red 
# we add NIR to distinguish elements like grasslands, forest's details and other things 


# Lecture 21/11/2024

im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")

sentstack <- c(b2, b3, b4, b8)
plot(sentstack)
im.plotRGB(sentstack, r=4, g=3, b=2) # the blue on top left is water that usually is black 

im.plotRGB(sentstack, r=3, g=4, b=2) # NIR has been put on top of the green 
im.plotRGB(sentstack, r=3, g=2, b=4) # blue, false color image   
