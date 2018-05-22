# download baby names by state file from ssa.gov 
if(!dir.exists("nbs") & !file.exists("nbs.zip")) {
  download.file("https://www.ssa.gov/oact/babynames/state/namesbystate.zip", destfile = "nbs.zip")
} 

# unzip into new directory
if(!dir.exists("nbs")) { 
  unzip("nbs.zip", exdir = "nbs")
}
# get list of files 
files <- paste0("nbs/", list.files("nbs", pattern = "*.TXT"))

# read all the files in as comma-separated values 
df <- lapply(files, function(x) {
  read.csv(x, col.names = c("state", "sex", "year", "name", "n"), 
                  colClasses = c("character", "character", "integer", "character", "integer"))})
df <- bind_rows(df)

# save  
saveRDS(df, here::here("content/data/2018-05-20-us-of-bey/df.RDS"))


