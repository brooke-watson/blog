# download & read in the 2000-2009 population data from census.gov 
if(!file.exists("../data/2018-05-06-us-of-bey/pop20002010.xls") ) {
download.file("https://www2.census.gov/programs-surveys/popest/tables/2000-2010/intercensal/state/st-est00int-01.xls", destfile = "../data/2018-05-06-us-of-bey/pop20002010.xls")
}
pop20002010 <- readxl::read_excel("../data/2018-05-06-us-of-bey/pop20002010.xls")

# download & read in the 2010-2017 population data from census.gov 
if(!file.exists("../data/2018-05-06-us-of-bey/pop20102017.xls") ) {
  download.file("https://www2.census.gov/programs-surveys/popest/tables/2000-2010/intercensal/state/st-est00int-01.xls", destfile = "../data/2018-05-06-us-of-bey/pop20102017.xls")
}
pop20102017 <- readxl::read_excel("../data/2018-05-06-us-of-bey/pop20102017.xls")

# read in 1999 data. this one's just a txt file so it's a bit of a mess. 
pop1999 <- read.fwf("https://www.census.gov/population/estimates/state/st-99-1.txt", widths = c(26,12,12,11,11,11,11,14,10), skip = 30) 

#------------------------------------------------------------

#-------------------------------------------------------------

# clean 2000-2010 data 
names(pop20002010) <- c("state", pop20002010[3, 2:13])
pop1 <- pop20002010 %>% 
  clean_names() %>% 
  select(-na, -na_2, -na_3) %>% # get rid of these random vars 
  filter(str_detect(state, "^[.]")) %>%  # get all the states 
  mutate(region = tolower(str_replace(state, "[^[:alnum:] ]", ""))) %>%  # remote the dots from the states 
  select(-state) %>% 
  gather(-region, key = "year", value = "pop") %>% 
  mutate(year = as.numeric(str_replace(year, "x", "")), pop = as.numeric(pop)) # fix the fact that clean_names() gave all these guys a random x 

# clean 2010-2017 data 
names(pop20102017) <- c("state", pop20102017[3, 2:11]) 
pop2 <- pop20102017 %>% 
  filter(str_detect(state, "^[.]")) %>% 
  mutate(region = tolower(str_replace(state, "[^[:alnum:] ]", ""))) %>%
  select(-Census, -`Estimates Base`, -state) %>% 
  gather(-region, key = "year", value = "pop") %>% 
  mutate(year = as.numeric(year), pop = as.numeric(pop))

# clean 1999
pop3 <- pop1999 %>% 
  select(1,2) %>% 
  mutate(region = tolower(trimws(V1)), pop = V2) %>% 
  filter(row_number() < 52) %>% 
  mutate(year = 1999) %>% 
  filter(region %in% pop2$region) %>% 
  select(region, year, pop) %>% 
  mutate(pop = as.numeric(as.character(pop)))

# bind all to join with the state maps and save 
nbipop <- bind_rows(pop1, pop2, pop3) %>% 
  mutate(pop = as.numeric(pop))

saveRDS(nbipop, here::here("content/data/2018-05-06-us-of-bey/population_by_state.RDS"))

        