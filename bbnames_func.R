name_map <- function(nam, start_year = 1910, stop_year = 2016) { 
  library(babynames)
  library(dplyr)
  library(ggplot2)
  if(!require("bplots")) devtools::install_github("brooke-watson/bplots")
  library(bplots)
  
  data("babynames")
  
  nbs <- readRDS("content/posts/babynamesbystate.RDS")

  namedf <- filter(nbs, name == nam)
  
  nbs <- nbs %>% 
    select(state, year) %>% 
    unique() %>% 
    filter(year >= start_year & year < stop_year)
  
  namedf <- full_join(namedf, nbs, by = c("state", "year"))
  
  state_lookup = dplyr::data_frame(state = state.abb, region = state.name)
  
  usa_map <- ggplot2::map_data("state") 
  
  state_map <- full_join(namedf, state_lookup, by = "state") %>% 
    mutate(region = tolower(region)) %>% 
    full_join(usa_map, by = "region")  
  
  tit <- paste0("The US of ", nam ) 
  
  g <- ggplot() + 
    geom_polygon(data = state_map, aes(fill = n, x = long, y = lat, group = group, frame = year), 
                 color = "black", size=0, alpha=0.9) + 
    scale_fill_gradient(low = "lightblue", high = "darkblue", na.value = "lightgray", guide = "legend") + 
    ggtitle(tit) + 
    labs(caption = wrap120("Data from the Social Security Administration. To protect privacy, if a name has less than 5 occurrences for a year of birth in any state, those names are not recorded. The sum of the state counts is thus less than the national count.")) + 
    theme_blank() + 
    theme(
      plot.title = element_text(size = 22, hjust = .5, 
                                margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
      plot.subtitle = element_text(size = 12, hjust = .5, vjust = -2, color = "#4e4d47"), 
      axis.text = element_blank()
    ) + theme_fancy()
  
}

# g <- name_map("Nelson")
# gganimate::gganimate(g, "Nelson.gif", ani.width = 560, ani.height = 360, interval = .2)