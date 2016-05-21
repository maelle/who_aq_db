
##################################################################
# Visualization
##################################################################
# 2 maps, 1 for PM10 and 1 for PM25
# for cities with *measured* data
# colour depending on year of data

library("ggplot2")
load("who_aq_data2.RData")
library("dplyr")
library("viridis")
library("rworldmap")

map.world <- map_data(map="world")
gg <- ggplot() + geom_map(data=map.world, map=map.world, aes(map_id=region, x=long, y=lat))

dataPM25 <- mutate(data, PM25_year = floor(PM25_year)) %>%
  mutate(PM25_year = as.factor(PM25_year)) %>%
  filter(PM25_note == "measured data")

gg2 <- gg+
  geom_point(data = dataPM25,
             aes(x=longitude, y=latitude, col = PM25_year), size=1)+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())+
  ggtitle("WHO PM2.5 data") +
  scale_color_viridis(option = "magma", discrete = TRUE) +
  theme(plot.title = element_text(lineheight=1, face="bold"))

ggsave(gg2, file = "PM25.PNG", width = 12, height = 12)

 ######################
dataPM10 <- mutate(data, PM10_year = floor(PM10_year)) %>%
  mutate(PM10_year = as.factor(PM10_year)) %>%
  filter(PM10_note == "measured data")

gg2 <- gg+
  geom_point(data = dataPM10,
             aes(x=longitude, y=latitude, col = PM10_year), size=1)+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())+
  ggtitle("WHO PM10 data") +
  scale_color_viridis(option = "magma", discrete = TRUE) +
  theme(plot.title = element_text(lineheight=1, face="bold"))

ggsave(gg2, file = "PM10.PNG", width = 12, height = 12)