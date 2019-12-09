## Course Fill up anomation

library(ggplot2)
library(plotly)
library(gganimate)
library(gifski)
library(png)

dat <- read.csv("F:/EnrollmentTransactionsbyDate.csv")


tbl <- data.frame(table(dat$Days.Relative.to.Start[dat$Date.Filter == "True"]))
plot(tbl$Var1, tbl$Freq)
lines(tbl$Var1, tbl$Freq)

# overlapping bar chart for one day
day40 <- dat[which(dat$Days.Relative.to.Start == 40 &
                   dat$Date.Filter == "True" &
                   dat$Course == "BIO-101"), ]
tblfill <- data.frame(table(day40$Section))
tblfill <- tblfill[which(tblfill$Freq > 0), ]
tblfill$Cap <- 30


barplot(tblfill$Cap, names.arg = tblfill$Var1, border = FALSE, col = "light grey")
barplot(tblfill$Freq, axes = FALSE, border = FALSE, col = "dark green", add = TRUE)

# animate (failed attempt)
bio110 <- dat[which(dat$Course == "BIO-110" & dat$Date.Filter == "True"), ]
bio110$Section <- droplevels(bio110$Section)
biotbl <- data.frame(table(bio110$Section, bio110$Days.Relative.to.Start))
biotbl$cap <- 30
biotbl$Var2 <- as.integer(biotbl$Var1)

ggplot(biotbl$cap, names.arg = biotbl$Var1, border = FALSE, col = "light grey", frame = biotbl$Var2)
ggplot(data = biotbl, aes(x = Var1, y = cap)) +
         geom_bar(stat = "identity") +
       theme(legend.position = "none", axis.text.y = element_blank(),
             axis.title.y = element_blank()) +
       geom_text(aes(label = Var1), vjust = 1, hjust = -0.1, color = "white", size = 3.5) +
       coord_flip() +
       labs(title = 'Day: {frame_time}') +
       transition_time(Var2) +
       ease_aes('linear')

str(biotbl)

# Ggplot2
bio101 <- dat[which(dat$Course == "BIO-101" & dat$Date.Filter == "True"), ]
bio101$Section <- droplevels(bio101$Section)
biotbl <- data.frame(table(bio101$Section, bio101$Days.Relative.to.Start))
biotbl$cap <- 30
colnames(biotbl) <- c("Section", "Day" , "Students", "Cap")

baseplot <- ggplot(data = biotbl, aes(x = Section, y = Students)) +
  geom_bar(stat = "identity") +
  ylim(0, 30)
  theme_bw()

animp <- baseplot +
  geom_text(aes(y = Students,
                label = as.character(Students),
                vjust = -2)) +
  labs(title = "Enrollment {closest_state} Days Relative to Start of Semester") +
  transition_states(Day) 
  
animate(animp, fps = 3, duration = 60)
baseplot

anim_save("C:/Users/danpv/OneDrive/Documents/Animation Project/animation.gif")
