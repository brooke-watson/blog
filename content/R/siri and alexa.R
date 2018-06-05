devtools::install_github("brooke-watson/statebabynames")
library(statebabynames)
map_babynames("Alexa", filename = "Alexa.gif", start_year = 2000, stop_year = 2016, interval = .4)


alexa <- babynames::babynames %>% 
  filter(name == "Alexa" & sex == "F")

siri <- babynames::babynames %>% 
  filter(name == "Siri" & sex == "F")



g1 <- alexa %>% 
  ggplot(., aes(x = year, y = n)) +
  geom_line(aes(col = "#e41a1c")) + 
  ggtitle("Girls named Alexa born in the US, 1910-2015") +  
  theme_raleway() + 
  theme_fancy() + 
  xlim(1910, 2016) + 
  guides(col = F) + 
  annotate("text", x =2014, y = (alexa[which(alexa$year == 2014), ]$n-1000), label = "Amazon \nintroduces\n Alexa", family = "Raleway") +
  geom_point(aes(x = 2014, y = alexa[which(alexa$year == 2014), ]$n))

g1

g2 <- siri %>% 
  ggplot(., aes(x = year, y = n)) +
  geom_line(aes(col = "#e41a1c")) + 
  ggtitle("Girls named Siri born in the US, 1910-2015") +  
  theme_raleway() + 
  theme_fancy() + 
  xlim(1910, 2016) + 
  guides(col = F) + 
  annotate("text", x =2000, y = siri[which(siri$year == 2011), ]$n, label = "Apple \nintroduces\n Siri", family = "Raleway") +
  geom_point(aes(x = 2011, y = siri[which(siri$year == 2011), ]$n))
g2



g1 <- yonces %>% 
  filter(name == "Beyonce") %>% 
  ggplot(., aes(x = year, y = n)) +
  geom_line(aes(col = "#e41a1c")) + 
  ggtitle("Birth of a Beyhive") +
  labs(subtitle = "Children named Beyoncé born in the US, 1910-2015", 
       caption = wrap95("Data from the Social Security Administration. To protect privacy and prevent identification, if a name has less than 5 occurrences for a year of birth, those names are not recorded. Thus, Beyoncé Knowles' birth (in 1981) is not actually included in the public SSA data."), y = "Annual Beyoncés born in the US") +
  annotate("text", x = 1965, y = 30, label = "Beyoncé Knowles", family = "Raleway") +
  theme_raleway() + 
  theme_fancy() + 
  xlim(1910, 2015) + 
  geom_point(aes(x = 1981, y = 1, col = "#e41a1c"))  + 
  guides(col = F)

