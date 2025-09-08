# Classification process in R using imageRy

# important to know the class of each pixel, by knowing that we have a map of the distribution of each class
# we can also calculate how many pixels belong to each class

library(terra)
library(imageRy)
library(ggplot2)
im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # from the dataset

# to detect 3 classes: high, medium and low energy
sunc <- im.classify(sun, num_clusters=3)

# Mato Grosso example in terms of cover % of forest in 1992 and 2006

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

m1992c <- im.classify(m1992, num_clusters=2)
# class 1 = human related areas + water
# class 2 = forest

m2006c <- im.classify(m2006, num_clusters=2)
# class 1 = forest
# class 2 = human related areas + water

# frequencies (number of pixels) of each class
f1992 <- freq(m1992c)
tot1992 <- ncell(m1992c)  

p1992 = f1992 * 100 / tot1992 # is better to use percentages
# class 1 = human related areas + water = 17
# class 2 = forest = 83

f2006 <- freq(m2006c)
tot2006 <- ncell(m2006c)

p2006 = f2006 * 100 / tot2006
# class 1 = forest = 45
# class 2 = human related areas + water = 55

# building a dataframe
class <- c("Forest","Human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)
tabout

# library(ggplot2) for final graph
library(ggplot2)
# aes = aestethic; means what u put on X and Y axis and colours 
# with + geom_bar() we select the type of graph we want to use
# stat is the type of statistic we want to use, we want the exact value
# fill is the colour

p1 <- ggplot (tabout, aes(x=class, y=y1992, color=class))+ geom_bar(stat="identity", fill="white")
p2 <- ggplot (tabout, aes(x=class, y=y2006, color=class))+ geom_bar(stat="identity", fill="white")

# package "patchwork" to compose the graph
install.packages("patchwork")
library(patchwork)

p1 + p2

# add another element to limit y values in the range 0 to 100 
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1  + p2
# to have one graph above the other
p1 / p2




