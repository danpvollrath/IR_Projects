## ************************************
## Script name: Enrollment Progression Animation
## For: Showing how enrollment changes between sections over time
## Location: GitHub
## Author: Dan Vollrath
## Email: danpvollrath@gmail.com
## Date Created: 2019-11-10
## ************************************
##
## Notes: The data set used to create the actual images on campus is somewhat complex.
## We have one data set which consists of each transaction made by a student and that table is right joined
## with a table containing one row for each date in a semester (including registration period). 
##
## *************************************
  
library(haven)
library(DBI)
library(ggplot2)
library(plotly)
library(gganimate)
library(gifski)
library(png)

dat <- read.csv("//sfile.academic.elgin.edu/EmployeeData/dvollrath8361/MyDocs/GitHub/IR_Projects/Animation/ExampleData.csv")


# Ggplot2

tbl <- data.frame(table(dat$Info, dat$DaysBeforeStart))

colnames(tbl) <- c("Section", "Day" , "Students")

baseplot <- ggplot(data = tbl, aes(x = Section, y = Students)) +
  geom_bar(stat = "identity") +
  ylim(0, 30) +
  theme_bw()

animp <- baseplot +
  geom_text(aes(y = Students,
                label = as.character(Students),
                vjust = -2)) +
  labs(title = "Enrollment {closest_state} Days Relative to Start of Semester") +
  transition_states(Day) 
  
animate(animp, fps = 3, duration = 60)

anim_save("//sfile.academic.elgin.edu/EmployeeData/dvollrath8361/MyDocs/GitHub/IR_Projects/Animation/ExampleData.csv")
