# Why populations disperse over the landscape in a certain manner?

install.packages("sdm") # stands for species distribution models 
library(sdm)

install.packages("terra")
library(terra)

# finds names of files in package with the function and then make that an object (file)
file <- system.file("external/species.shp", package="sdm") # / means that we want the file "species" in the folder "external"
# with the last part of the command we're expliciting that we want the external from the package sdm since external is in all the folders 
file

# using vect() function to make it readable for R
rana <- vect(file) # we obtain a series of info class spatvect, that is an object from terra that shows vectorial spatial data 
# to select only the data for the presence of the species (occurrence = 1) 
rana$Occurrence
plot(rana)

# we're extracting from rana only the data we're looking for 
pres <- rana[rana$Occurrence==1,] # == means equal while != not equal

par(mfrow=c(1,2))
plot(rana)
plot(pres)

# exercise: select data from rana with only absences
# for absences there's more uncertainity cause you're not sure if the animal in not there, maybe you only haven't see it 
abse <- rana[rana$Occurrence==0,]
plot(abse)

# exercise: plot in a multiframe presence beside absences 
par(mfrow=c(1,2))
plot(pres)
plot(abse)

# exercise: presence on top of absences
par(mfrow=c(2,1))
plot(pres)
plot(abse)

# exercise: plot presences in blue together with absences in red 
plot(pres, col="blue")  
points(abse, col="red") # use points to show absences

# Covariates: datas in raster form to understand ecological parameters 
elev <- system.file("external/elevation.asc", package="sdm") # .asc cause it refers to raster 
elev

# now we want to see the map of elevation
elevmap <- rast(elev)
elevmap
plot(elevmap)

# exercise: change the colors of the elevation map by the colorRampPalette function
cl <- colorRampPalette(c("blue", "orange", "purple4"))(100)

# exercise: plot the presences together with elevation map
plot(elevmap, col=cl)
points(pres)
                      
