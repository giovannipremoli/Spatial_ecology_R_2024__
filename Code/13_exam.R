## Multitemporal analysis of vegetation health and landscape variability in the Blue Mountains National Park (Australia) due to the bushfires of 2019-2020.

# Installing the packages necessary for the analysis.  
install.packages("devtools") # Needed to download packages directly from GitHub repositories.
install.packages("terra") # Essential for managing spatial data, particularly raster and vector data (e.g. satellite images).
install.packages("ggplot2") # Used for creating statistical graphs. 
install.packages("patchwork") # Useful for combining multiple plots in a single window for comparison.
install.packages("viridis") # Used for applying colorblind-friendly and uniform color palettes.

# Recalling the package "devtools" to install "imageRy". 
library(devtools)

# Installing "imageRy" package from GitHub.
install_github("ducciorocchini/imageRy") # Consent the use of specialized functions for environmental monitoring.

# Recall all the other packages.
library(terra)
library(ggplot2)
library(patchwork)
library(viridis)
library(imageRy)

# Setting the working directory to upload the satellite images.
setwd("/Users/giovannipremoli/Desktop/spatial ecology in R")

# Checking if the path is correct. 
getwd()


## PART 1: 2019 PRE-FIRE ANALYSIS

# Importing the 2019 Sentinel-2 images from Copernicus Browser: https://browser.dataspace.copernicus.eu/. 
# TC stands for True Colors (bands: red, green and blue)and FC for False Colors (bands: NIR, green, blue). The images I've chosen are all cloudless.
tc19 <- rast("2019_TC.jpg") # rast() imports the file as a SpatRaster object, preserving its multilayer structure. 
fc19 <- rast("2019_FC.jpg") 

# Visualizing the two images from 2019.
par(mfrow=c(2,1))
plot(tc19)
plot(fc19) 

dev.off() # Clearing the current graph window.

# Extracting the bands from 2019 images. Useful to classify the objects and extract more information from the data.
# From the TC image I'm taking the red (r), blue (b) and green (g) bands.
r19 <- tc19[[1]]
g19 <- tc19[[2]]
b19 <- tc19[[3]]

# From the FC image I'm taking the NIR band.
nir19 <- fc19[[1]] 

# Combining the bands in a single object.
stack19 <- c(r19, g19, b19, nir19)

# Plotting the result to verify the 4 layers.
plot(stack19)

dev.off()

# Visualizing the different bands in a RGB plot alternating their color representation. This is useful to highlight specific environmental features.
im.plotRGB(stack19, r=4, g=2, b=3) # NIR on red. Healthy vegetation appear bright red.
im.plotRGB(stack19, r=1, g=4, b=3) # NIR on green. Active clorophylle is highlighted in green tones.
im.plotRGB(stack19, r=1, g=2, b=4) # NIR on blue. Emphazize surface reflectance properties, useful to identify structural differences in the landscape.

# Calculating the Divergence Vegetation Index (DVI). 
# This index measures the raw difference in reflectance. In a 8-bit image, an healthy plant has an high NIR reflectance (reflected by leaves) and low red reflectance due to absorption of these wavelengths by the clorophyll (DVI>90), while if the plant is stressed or dead DVI drops. 
# My goal is to assess forest's health before the fires of late 2019 - early 2020.
dvi19 <- nir19 - r19
dvi19 # The range covers between -75 and 179

# Visualizing the plotted DVI. Instead of creating a manual palette, I'm using the viridis function to ensure that maps are accesible to colorblind viewers.
# I'm also assigning a title to the plot with main =.
plot(dvi19, col=viridis(100), main="DVI 2019")

dev.off()

# Calculating the Normalized Difference Vegetation Index (NDVI). 
# Normalizing this value allow me to compare the result with any other.
# Formula: (NIR - red)/(NIR + red)
ndvi19 <- (nir19 - r19)/(nir19 + r19)

# Visualizing the NDVI map. 
plot(ndvi19, col=viridis(100), main="NDVI 2019")

dev.off()

# Running the Principal Component Analysis on the 2019 stack. Useful to reduce data redundancy by compressing the information from all 4 spectral bands into fewer components.
# My aim is to obtain the maximum amount of environmental variability in fewer principal components, useful to have a more clear representation.
pca19 <- im.pca(stack19)

# Standard Deviations obtained from R:
# pca1 = 22.300805
# pca2 = 13.894895
# pca3 = 8.694020
# pca4 = 2.365775

# Calculating the total variability as the sum of SDs of the components.
tot19pca <- sum(22.300805, 13.894895, 8.694020, 2.365775)
# 47.2555

# Estimating the percentage of information represented by each axis.
22.300805*100/47.2555 # 47.19% (PC1)
13.894895*100/47.2555 # 29.40% (PC2)
8.694020*100/47.2555 # 18.40% (PC3)
2.365775*100/47.2555 # 5.01% (PC4)
# PC1 and PC2 together cover ~76.59% of the original information, which is enough to describe the landscape structure.
compactpca19 <- pca19[[1]] + pca19[[2]]

# Calculating the Standard Deviation (pcsd19), based on the principal components, to measure the spatial hetereogeneity of the landscape. I'm applying focal() function to calculate SD in a 3x3 moving window.
# Areas with high SD indicate high landscape complexity.
pcsd19 <- focal(compactpca19, matrix(1/9,3,3), fun=sd) 

# Visualizing the final variability map using a colorblind-friendly palette.
plot(pcsd19, col=viridis(100), main = "Landscape Variability 2019 (SD)")

dev.off()
     
# Classifying the image into 2 clusters: Forest (vegetation) and Other (rocks/water/bare soil).
cl19 <- im.classify(stack19, num_clusters=2)

# Plotting the classification to visually check the consistency of the results.
plot(cl19, main = "Land Cover Classification 2019")     

dev.off()

# Calculating the frequencies to get the percentage of land cover of each land cover class.
f19 <- freq(cl19) # Number of pixels for each class
tot19 <- ncell(cl19) # Total number of pixels in the image
p19 <- f19*100/tot19 # Percentage for each class
p19     
# Class 1 (Forest) = 31.89005%
# Class 2 (Others) = 68.10995%     


## PART 2: POST-FIRE ANALYSIS 

# Now I will repeat all the steps for the year 2020. Once I will have the data, the aim is to compare them to obtain important information.

# Importing the 2020 Sentinel-2 images from Copernicus Browser: https://browser.dataspace.copernicus.eu/
tc20 <- rast("2020_TC.jpg")
fc20 <- rast("2020_FC.jpg")

# Visualizing the two images from 2020.
par(mfrow=c(2,1))
plot(tc20)
plot(fc20)

dev.off()

# Extracting the bands from 2020 images. 
# From the TC image I'm taking the red (r), blue (b) and green (g) bands.
r20 <- tc20[[1]]
g20 <- tc20[[2]]
b20 <- tc20[[3]]

# From the FC image I'm taking the NIR band.
nir20 <- fc20[[1]] 

# Combining the bands in a single object.
stack20 <- c(r20, g20, b20, nir20)

# Plotting the result to verify the 4 layers.
plot(stack20)

dev.off()

# Visualizing the different bands in a RGB plot alternating their color representation. 
im.plotRGB(stack20, r=4, g=2, b=3) # NIR on red. Healthy vegetation appear bright red.
im.plotRGB(stack20, r=1, g=4, b=3) # NIR on green. Active clorophylle is highlighted in green tones.
im.plotRGB(stack20, r=1, g=2, b=4) # NIR on blue. Emphazize surface reflectance properties, useful to identify structural differences in the landscape.

# Calculating the Divergence Vegetation Index (DVI). 
# My goal is to assess forest's health after the fires of late 2019 - early 2020.
dvi20 <- nir20 - r20
dvi20 # The range covers between -91 and 200

# Visualizing the plotted DVI. 
plot(dvi20, col=viridis(100), main="DVI 2020")

dev.off()

# Calculating the Normalized Difference Vegetation Index (NDVI). 
ndvi20 <- (nir20 - r20)/(nir20 + r20)

# Visualizing the NDVI map. 
plot(ndvi20, col=viridis(100), main="NDVI 2020")

dev.off()

# Running the Principal Component Analysis on the 2020 stack. 
pca20 <- im.pca(stack20)

# Standard Deviations obtained from R:
# pca1 = 30.18312
# pca2 = 28.80024
# pca3 = 19.72079
# pca4 = 5.34542

# Calculating the total variability as the sum of SDs of the components.
tot20pca <- sum(30.18312, 28.80024, 19.72079, 5.34542)
# 84.04957

# Estimating the percentage of information represented by each axis.
30.18312*100/84.04957 # 35.91% (PC1)
28.80024*100/84.04957 # 34.26% (PC2)
19.72079*100/84.04957 # 23.46% (PC3)
5.34542*100/84.04957 # 6.36% (PC4)
# PC1 and PC2 together cover ~70.15% of the original information, which is enough to describe the landscape structure.
compactpca20 <- pca20[[1]] + pca20[[2]]

# Calculating the Standard Deviation (pcsd19), based on the principal components, to measure the spatial hetereogeneity of the landscape. I'm applying focal() function to calculate SD in a 3x3 moving window.
# Areas with high SD indicate high landscape complexity.
pcsd20 <- focal(compactpca20, matrix(1/9,3,3), fun=sd) 

# Visualizing the final variability map using a colorblind-friendly palette.
plot(pcsd20, col=viridis(100), main = "Landscape Variability 2020 (SD)")

dev.off()
     
# Classifying the image into 2 clusters: Forest (vegetation) and Other (rocks/water/bare soil).
cl20 <- im.classify(stack20, num_clusters=2)

# Plotting the classification to visually check the consistency of the results.
plot(cl20, main = "Land Cover Classification 2020")     

dev.off()

# Calculating the frequencies to get the percentage of land cover of each land cover class.
f20 <- freq(cl20) # Number of pixels for each class
tot20 <- ncell(cl20) # Total number of pixels in the image
p20 <- f20*100/tot20 # Percentage for each class
p20     
# Class 1 (Others) = 70.61403%     
# Class 2 (Forest) = 29.38597%


## PART 3: COMPARISONS

# Visualizing the images:
par(mfrow=c(2,2))
plot(tc19, main = "TC19")
plot(fc19, main = "FC19")
plot(tc20, main = "TC20")
plot(fc20, main = "FC20")

# By comparing these images, there are clear differences also in the visible spectrum. The exposed soil, due to the fires, is more abboundant in 2020. 
dev.off()


# Visualizing the images with different colors:
par(mfrow=c(3,2))
im.plotRGB(stack19, r=4, g=2, b=3) 
im.plotRGB(stack19, r=1, g=4, b=3) 
im.plotRGB(stack19, r=1, g=2, b=4)
im.plotRGB(stack20, r=4, g=2, b=3) 
im.plotRGB(stack20, r=1, g=4, b=3) 
im.plotRGB(stack20, r=1, g=2, b=4)

# First column (NIR on red): in the 2020 image the red color is less continuous, it means that there's a reduction in NIR reflectance due to the fires. The vegetation is less healthy.
# Second column (NIR on green): in the 2020 image comes out more irregular patches, that's a typical output caused by early regrowing and exposed soil. The vegetation is more stressed.
# Third column (NIR on blue): in the 2020 image there's more landscape heterogeneity.
# Conclusion: Multispectral RGB colouring, obtained by combining different spectral bands, highlight an increase in spatial heterogeneity between 2019 and 2020. While the overall geomorphological structure remain recognizable, post-fire images shows a more fragmented spectral pattern, consistent with vegetation healt reduction and patchy recovery following the stressful event.
# I will make a NDVI analysis to highlight more these differences, not made to evident by the RGB analysis.
dev.off()


# Comparing DVI outputs:
# 2019: DVI range covers from -75 to 179. 
# 2020: DVI range covers from -90 to 200.
# Conclusion: The most important data to consider is the decrease in minimum range in 2020 (-90). This indicates areas where red reflectance exceed the NIR reflectance, a clear sign of clorophyll loss: with less photosynthesis, red wavelengths are less absorbed and so vegetation is less or stressed. 
# Regarding the higher maximum value in 2020 (200), it's likely not due to better vegetation, but rather to different atmospheric illumination or the high overall reflectance of exposed bare rocks or soil, which can reflect strongly across the entire spectrum.
# Visualizing the NDVI during the years and the difference between them.
# DVI allowed me to observe the physical behavior of the spectral of the NIR-red bands and the direct loss of photosynthetic efficiency. NDVI is essential to normalize the data by filtering out potential "noise" caused by different illumination or atmospheric conditions.
par(mfrow=c(1,3))
plot(ndvi19, col=viridis(100), main="NDVI 2019")
plot(ndvi20, col=viridis(100), main="NDVI 2020")

ndvi_diff <- ndvi19 - ndvi20
plot(ndvi_diff, col=viridis(100), main="NDVI difference: Biomass Loss")

# 2019: NDVI has mean elevated and homogeneous values all over the image. There're spatial continuous consistency along valleys and slopes. These data represent a structurally stable landscape.
# 2020: There's a generalized diminuation of NDVI values, with the appearing of large areas with low NDVI. The general pattern is more fragmented and there're more evident contrast between near patches. These are effects caused by the loss of biomass, by the vegetation's stress and by the disomogeneous effects of fire.
# Conclusion: While pre-fire NDVI values appear relatively high and spatially continuous, post-fire conditions are characterized by reduced NDVI and a fragmented spatial pattern, reflecting heterogeneous vegetation damage and early recovery processes.
dev.off()


# Comparing Landscape Variability due to SD
par(mfrow=c(2,1))
plot(pcsd19, col=viridis(100), main = "Landscape Variability 2019 (SD)")
plot(pcsd20, col=viridis(100), main = "Landscape Variability 2020 (SD)")

# 2019: SD values result generally low and spatially coherent, indicating a relative homogeneous landscape. The main geomorphological structures (like valleys, slopes and river) are recognizible but not too spatially discontiuous.
# 2020: While maintaining a similar global distribution, I can notice a low increment of variability, with a stronger presence of high SD pixels (yellow) and a more fragmented distribution. These outputs are consistent with an heterogenous stress event like fire. The fire acted as a "disturbing agent" thet broke the spatial continuity noticed in 2019 and generated "disorder".
# Coclusion: Differences between 2019 and 2020 are mainly expressed in terms of fine-scale spatial heterogeneity and highlight a general increment in spatial complexity in post-fire period.
dev.off()


# Comparing percentage of land cover landscape classification
# 2019:"Forest" coverage -> 31.89005%
# 2020:"Forest" coverage -> 29.38597%
# Net loss = ~2.5% of "forest" coverage 
par(mfrow=c(2,1))
plot(cl19, main = "Land Cover Classification 2019") 
plot(cl20, main = "Land Cover Classification 2020") 

# 2019: The unsupervised landscape classification shows relatively large and continuous patches of the two classes. This distribution reflects moderate landscape variability and a structural stable environment, consistent with an healthy forest.
# 2020: There's an increased fragmentation and a more irregular distribution of small patches. 
# Conclusion: Due to unsupervised classification function the numbers of the two classes are inverted between 2019 and 2020. The classification results indicate a reduction of 2.5% in Forest class in 2020 after bushfires. Although, because the classification is unssupervised, class proportions represent changes in spatial configuration and spectral similarity rather than true gain or loss in forest covered area. This pattern is consistent with the general loss of NDVI in 2020 and increased landscape fragmentation.


# Statistical analysis with ggplot2
# Building a dataframe to visualize the class percentage from 2019 and 2020.
y19 <- c(31.89, 68.11) # Forest, Others
y20 <- c(29.39, 70.61) # Forest, Others
classes <- c("Forest", "Others")
# Creating the dataframe
dataF <- data.frame(classes, y19, y20)
dataF

# Visualizing a clear quantitative representation
F19 <- ggplot(dataF, aes(x=classes, y=y19, fill=classes)) + geom_bar(stat="identity") + scale_fill_viridis_d(option="D") + ylim(c(0, 100)) + labs(title="Land Cover 2019 (%)", y="Percentage", x="Class")
F20 <- ggplot(dataF, aes(x=classes, y=y20, fill=classes)) + geom_bar(stat="identity") + scale_fill_viridis_d(option="D") + ylim(c(0, 100)) + labs(title="Land Cover 2020 (%)", y="Percentage", x="Class")
F19 + F20
F19 / F20

                        
