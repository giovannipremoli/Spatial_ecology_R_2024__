# vegetations indices 

library(imageRy)
library(terra)

im.list()

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") # ast means Aster that is another satellite, see "surface biology and geology" by nasa 

# we are using the site visible Earth by nasa, we downloaded the matogrosso image from there. they directly provided the NIR coloration 
# band 1 = NIR 
# band 2 = red 
# band 3 = green 

im.plotRGB(m2006, r=1, g=2, b=3) # if we invert 3 and 2 doesn't change, visual spectre infos are similar. what change is the NIR 
plot(m2006[[2]]) # only the second element, that is the red 
plot(m2006[[3]])
plot(m2006[[1]])

im.plotRGB(m2006, r=3, g=2, b=1) # we put the NIR on top of the blue, the water is yellowish and not black cause its not pure water (contaminated; non è limpida)
im.plotRGB(m2006, r=2, g=1, b=3) 

# Ancient data 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") # let's see the situation before human influence, through Landsat 5 satellite 
m1992

par(mfrow=c(1,2)) 
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

# exercise: make a multiframe with 6 images in pairs with nir on the same component 

# first row: m1992 and m2006 with r=1
# second row: m1992 and m2006 with g=1
# third row: m1992 and m2006 with b=1 
# 3 rows per 2 columns 

par(mfrow=c(3,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m2006, r=2, g=1, b=3)
im.plotRGB(m1992, r=3, g=2, b=1)
im.plotRGB(m2006, r=3, g=2, b=1)

# we are building spectral signature for healthy plant (see the photo on iphone) 
# Different Vegetation Index (DVI)= NIR - red= 90 for an healthy plant. 90 IS THE REFLECTANCE 
# if the plant is dead there's no photosyntesis, the points in the graph will be more near to each other DVI= 60 

# Difference Vegetation Index in 1992 
# we stated that 1st element is NIR and 2nd element is red 
# for each pixel from NIR band the same pixel from red band is subtracted 
# since the image is 8 bit, DVI can vary from 255 to -255 
# if NIR is max and red is 0 = 255
# if red is max and nir is 0 = -255
dvi1992 = m1992[[1]] - m1992[[2]]  # watch the 10 row 

dev.off()
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl) # DVI is high

dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl) # DVI is low

# for building the multiframe you need to do all these 3 functions together 
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# NDVI does the same but is a normalized valor, if we are using a scale of 100 or 1000 and the red is 0 if we don't normalize that we obtain the same value 
# NDVI is DVI/NIR+red, is usefull cause you can compare every image from different ranges 
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])

par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

