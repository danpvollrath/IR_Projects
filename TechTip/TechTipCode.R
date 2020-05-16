## ************************************
## Script name: TechTipCode.R
## Purpose: Create Animations for AIR Tech Tip
## For: AIR
## Location: GitHub
## Author: Dan Vollrath
## Email: danpvollrath@gmail.com
## Date Created: 2020-05-12
## ************************************
##
## Notes: 
##
##
##
## *************************************
  
library(readr)
library(ggplot2)
library(gganimate)
library(gifski)
library(tidyverse)


# ******************************************
# Fill Rate Animation ----
# ******************************************
fill_rates <- read_csv(url("https://raw.githubusercontent.com/danpvollrath/IR_Projects/master/Tech%20Tip/FillRates.csv"))

baseplot <- ggplot(data = fill_rates, aes(x = Section, y = Students)) +
  geom_bar(stat = "identity", color = "#0c544a") +
  geom_text(aes(label = Students, vjust = -1.5, size = 3.0)) +
  theme(panel.background = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(), 
        plot.title = element_text(hjust = 0.5, size = 18),
        legend.position = 'none') +
  ylim(0, 35)
  
animp <- baseplot +
  transition_manual(frames = -DaysToStart) +
  labs(title = "Enrollment {current_frame} Days Relative to Term Start") +
  ease_aes('linear')


animate(plot = animp, nframes = 100, fps = 4, end_pause = 3)

anim_save("")


# ******************************************
# Top Programs Animation ----
# ******************************************
top_programs <- read_csv(url("https://raw.githubusercontent.com/danpvollrath/IR_Projects/master/Tech%20Tip/TopPrograms.csv"))

# Creating a Rank field
top_programs <- top_programs %>% group_by(Year) %>% 
  mutate(Rank = rank(-Students, ties.method = "random"), Label = as.character(Students)) %>%
  filter(Rank <= 10)
  

baseplot <- ggplot(top_programs, aes(x = Rank, group = Major, fill = as.factor(Major), 
                                     color = as.factor(Major), ymin = -20, ymax = max(top_programs$Students) + 5)) +
  geom_tile(aes(y = Students/2,
                height = Students,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = Major), hjust = 1.5) +
  geom_text(aes(y = Students, label = Label, hjust = -0.5)) +
  coord_flip() +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        plot.title = element_text(size = 18, hjust = 0.5))

animp <- baseplot +
  transition_states(Year) +
  view_follow(fixed_x = TRUE) +
  labs(title = "Top Programs: {closest_state}") +
  ease_aes('cubic-in-out')

animate(plot = animp, nframes = 200, fps = 10, start_pause = 20)

anim_save("C:/Users/danpv/OneDrive/Documents/GitHub/IR_Projects/Tech Tip/TopPrograms.gif")
