# Example of using R to geocode student addresses
# Dan Vollrath

# Usually I try to save Excel files as csv files before bringing them into R
# Excel is possible, using read_table
# Use read.csv for csv 
# file.choose opens the directory for you to select a file
# I like to at least add the filepath to the code, because I am always re-importing my original dataset
# "<-" is an assignment operator. It assigns our table to an object called mydata
# "=" can also be an assignment operator, but because of equality uses of "=", using "<-" is a good habit.
# Common mistakes by me: Using "\" instead of "/", forgetting ".csv", forgetting "header = T"

mydata <- read.csv("C:/Users/dvollrat/Desktop/addresses.csv",header = T)
mydata <- read.csv(file.choose(),header = T)


# Click on the object in the Environment window to view your dataframe
# R is great because you can have multiple dataframes in your environment
# Or use View(),
View(mydata)

# Google API Keys
# The function we're using uses the Google Maps API (Application programming interface) to geocode our addresses.
set.api.key(XXXXXXXXXXXXXXX)

# First I'm creating empty columns for latitude and longitude in my dataframe
# The semicolon acts as a new line of code, since these two lines are so related, I find it more neat
#     to code this way
# To access a part of a data frame, we use brackets. First position is row, second column
# To find what's in row 1 column 1, we would write mydata[1,1] for example
# By not having a row in the first position of the [,], I'm accessing the entire 12th and 13 columns of mydata

length(mydata)
mydata[,12] <- NA ; colnames(mydata)[12] <- "lat"
mydata[,13] <- NA ; colnames(mydata)[13] <- "lon"
View(mydata)

# First I'm creating empty columns for latitude and longitude in my dataframe
# The semicolon acts as a new line of code, since these two lines are so related, I find it more neat
#     to code this way
# To access a part of a data frame, we use brackets. First position is row, second is column
# To find what's in row 1 column 2, we would write mydata[1,2] for example
# By not having a row in the first position of the [,], I'm accessing the entire 12th and 13 columns of mydata

colnum_a <- length(mydata)
colnum_b <- length(mydata)+1
mydata[,colnum_a] <- NA ; colnames(mydata)[colnum_a] <- "lat"
mydata[,colnum_b] <- NA ; colnames(mydata)[colnum_b] <- "lon"
View(mydata)

# Moving Step by step through this:
# Line 1: We start by creating a for loop, we use i as our iterator, 
# i gets set to 1, the colon is like saying "to", row 10
# Line 2: Our geocode function returns a 1 row 2 column dataframe, so we save it to an object called x
# We make sure that each row of "Address" is in character format by using the function as.character
# We are then accessing row i, of column 'Address' in mydata
# Line 3: We are then setting row i, column "lon" of mydata to the value in the column of x which is longitude
# Line 4: We are then setting row i, column "lat" of mydata to the value in the column of x which is latitude
# Line 5: We slightly stall the loop, for .03 seconds, with Sys.sleep because there's a limit to how many geocodes
# you can do in a second
# Our for loop then automatically does this again and again for however many rows we input.
# We're limited to 2500 geocodes per day by google. However, you can go onto other computers
# You could also use 


for(i in 1:10){
  x <- geocode(as.character(mydata[i,"Address"]),get.api.key())
  mydata[i,"lon"] <- x[,"lon"]
  mydata[i,"lat"] <- x[,"lat"]
  Sys.sleep(.03)
}