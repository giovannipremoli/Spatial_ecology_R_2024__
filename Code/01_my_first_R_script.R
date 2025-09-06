# take home message:
# object
# assign 
# array 
# function(), example: c(), plot(), ...
# comment 


# R can be used as a calculator 
2 + 3

sonia <- 2 + 3  # I assign the result of the operation to an object 
sonia 

lea <- 3 + 4 
lea 

sonia + lea 
sonia ^ lea 

tommaso <- c(10, 20, 30, 50, 70) # this is an array 
erica <- c(1, 3, 5, 7, 9)

plot(tommaso, erica) 
plot(tommaso, erica, pch=19) # pch is changing the point character 

# changing the color 
plot(tommaso, erica, pch=19, col="blue")

# character exaggeretion 
plot(tommaso, erica, pch=19, col="blue", cex=2) # doubled 

plot(tommaso, erica, pch=19, col="blue", cex=2, xlab="cannabis", ylab="dolphins")
