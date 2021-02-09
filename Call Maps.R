#R Shiny visualization for Phase II Capstone

dat <- read.csv("/Users/@ibm.com/Downloads/Data/siteDetailsUS.csv")
dat <- dat[, c("latitude", "longitude", "avg_daily_output")]
dat

#install.packages(c("leaflet", "sp"))
library(devtools)
install_github("wch/webshot")

library(sp)
library(leaflet)
library(dplyr)
library(htmlwidgets)
library(webshot)

#starting markers on map
leaflet(dat) %>% addMarkers() %>% addTiles()

#low == 1, medium == 2, high == 3
summary(dat)

dat$avg_daily_output_range = cut(dat$avg_daily_output,
                           breaks = c(0, 1, 2, 3),
                           labels = c("Low[0-1)", "Medium[1-2)", "High[2-3)"))

str(dat)
pal = colorFactor(palette = c("red", "yellow", "green"), domain = dat$avg_daily_output_range)

map = leaflet(dat) %>% addTiles() %>%
   addCircleMarkers(lng = ~longitude,
                    lat = ~latitude,
                    color = pal(dat$avg_daily_output_range))

map