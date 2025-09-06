# How to calculate the density of individuals in a population?

# installing the spatstat package, needed for point pattern analysis
install.packages("spatstat") # spatstat stands for "spatial statistics"

# recalling the package
library(spatstat) 

# dataset
bei

plot(bei) # the result is a plot with black and white circles

# changing the symbol 
plot(bei, pch=19) 
# changing the dimension
plot(bei, pch=19, cex=0.5)

# additional dataset for covariates soil types, temperatures, etc
bei.extra
plot(bei.extra)

# extracting data, we want to use only part of the dataset (elev)
elevation <- bei.extra$elev
plot(elevation)

# another method to select elements, in this case we're selecting the first element
elevation2 <- bei.extra[[1]]
plot(elevation2)

# density map of a population, starting from points  
density(bei)
densitymap <- density(bei)
plot(densitymap)

points(bei) # add the points of the dataset, we're showing together the map of density and the original points  
points(bei, col="green", pch=19, cex=0.5) # assign color, dimension and symbol

# build a multiframe
par(mfrow=c(1,2)) # 1 row 2 columns 
plot(elevation)
plot(densitymap)

# multiframe with 2 rows and 1 column
par(mfrow=c(2,1))
plot(elevation)
plot(densitymap)

# deleting the multiframe  
dev.off()

# changing colors to maps
cl1 <- colorRampPalette(c("red", "orange", "yellow"))(3) # 3 is for gradients
plot(densitymap, col=cl1)

# if we want to increase the ammount of gradients
cl1 <- colorRampPalette(c("red", "orange", "yellow"))(100)

# where we can find all the colours available in R "http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf"

# different colours, more gradients
cl2 <- colorRampPalette(c("darkmagenta", "lightgrey", "forestgreen"))(100)
plot(densitymap, col=cl2)

# excercise: build a multiframe and plot two different densitymaps with two different palettes
par(mfrow=c(1,2))
plot(densitymap, col=cl1)
plot(densitymap, col=cl2)
