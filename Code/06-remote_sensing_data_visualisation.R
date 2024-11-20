# Code for remote sensing data handling and analysis

# install.packages("devtools")
# install_github

library(terra)
library(imageRy)

# listing data inside imageRy
im.list()
# every sensor in recording one wavelength, every single layer is called band. b2 in the 25 data is band2

# sentinel 2 bands 
https://gisgeography.com/sentinel-2-bands-combinations/

# importing the data 
b2 <- im.import("sentinel.dolomites.b2.tif")

# for changing colors 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
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
