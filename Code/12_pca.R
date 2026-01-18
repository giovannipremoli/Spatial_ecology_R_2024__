# PCA - principal component analysis

library(imageRy)
library(terra)
im.list()

sent <- im.import("sentinel.png")

# to see the correlation between all the bands 
pairs(sent)

# perform PCA on sent
sentpc <- im.pca(sent)
# gave us 3 values of sd for each band

# extract pc1 that has more variability so more info
pc1 <- sentpc[[1]] 
pc1

# calculate sd on top of pc1
pc1sd <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd)
