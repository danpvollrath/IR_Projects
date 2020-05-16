## ************************************
## Script name: Visualizations.R
## Purpose: Examples of ggplot visualizations
## For: Resource
## Location: GitHub
## Author: Dan Vollrath
## Email: danpvollrath@gmail.com
## Date Created: 2020-05-09
## ************************************
##
## Notes: 
##
##
##
## *************************************
  
  
library(ggplot2)
library(scales)


dat <- data.frame(PERSON = c("Ron Swanson", "Tom Haverford", "April Ludgate", "Andy Dwyer", "Ben Wyatt", 
                             "Leslie Knope", "Chris Traeger", "Donna Meagle", "Anne Perkins", "Jerry Gergich"),
                  GENDER = c("M", "M", "F", "M", "M", 
                             "F", "M", "F", "F", "F"),
                  AGE = c(58, 35, 31, 39, 45, 
                          45, 52, 55, 43, 72),
                  OCC_GROUP = c("Government", "Private Industry", "Non-Profit", "Private Industry", "Government",
                                "Government", "Non-Profit", "Private Industry", "Private Industry", "Government"),
                  FIELD_OF_STUDY = c("Career Tech", "Business", "Career Tech", "Career Tech", "Liberal Arts",
                                     "Liberal Arts", "Liberal Arts", "Business", "Liberal Arts", "Business")
                  
# *********************           
# Pie Charts ----
# *********************
dat <- data.frame(Team = c("Lions", "Bears", "Vikings"), 
                  Pct = c(0.68, 0.26, 0.06))
dat$Label <- paste0(round(dat$Pct, 2) * 100, "%")
team_palette <- c("#4e2683", "#0076b6", "#c93500")
names(team_palette) <- c("Vikings", "Lions", "Bears")

ggplot(data = dat, aes(x = "", y = Pct, fill = Team)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) + 
  scale_fill_manual(values = team_palette) +
#  geom_text(aes(y = Pct/3 + c(0, cumsum(Pct)[-length(Pct)]),
 #           label = Label), size = 4) +
  geom_text(aes(label = Label), position = position_stack(vjust = 0.5), 
            color = "white", fontface = "bold") +
  theme(panel.background = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(), 
        plot.title = element_text(hjust = 0.5),
        legend.title.align = 0.5) +
  labs(x = "", y = "") +
  ggtitle(label = "Michigander\'s Favorite NFL Teams")
