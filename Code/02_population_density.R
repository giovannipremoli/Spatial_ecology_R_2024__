# How to calculate the density of individuals in a population?

# installing the spatstat package, needed for point pattern analysis
install.packages("spatstat")

# recalling the package
library(spatstat)

# dataset
bei

plot(bei) # the result is a plot with black and white circles

# changing the symbol 
plot(bei, pch=19) 
# changing the dimension
plot(bei, pch=19, cex=0.5)

# additional datasets
bei.extra
plot(bei.extra)

# extracting data, we want to use only part of the dataset (elev)
elevation <- bei.extra$elev
plot(elevation)

# another method to select elements 
elevation2 <- bei.extra[[1]]
plot(elevation2)

# density map starting from points to a continuous surface 
density(bei)
densitymap <- density(bei)
plot(densitymap)

points(bei) # add the points 
points(bei, col="green", pch=19, cex=0.5) # assign color, dimension and symbol

# build a multiframe
par(mfrow=c(1,2)) # 1 row 2 columns 
plot(elevation)
plot(densitymap)

par(mfrow=c(2,1))
plot(elevation)
plot(densitymap)

# back to the original plot 
dev.off()

# Changing colors to maps
cln <- colorRampPalette(c("red", "orange", "yellow"))(15)
plot(densitymap, col=cln)

# where we can find all the colours available in R
http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

clg <- colorRampPalette(c("darkmagenra", "lightgrey", "forestgreen"))(100)
plot(densitymap, col=clg)

# esercizio per mettere le due mappe di due colori diversi una accanto all'altra
par(mfrow=c(1,2))
plot(densitymap, col=cln)
plot(densitymap, col=clg)
