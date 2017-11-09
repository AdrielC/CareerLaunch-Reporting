rm(list = ls())
setwd("~/MAIN/BCC/CareerLaunch Analytics/")
### this will automatically install the packages you need and then load them into your library
if(!("easypackages" %in% installed.packages()[,"Package"])) install_packages("easypackages"); library(easypackages)
list.of.packages <- c("ggplot2", "dplyr", "csv")
packages(list.of.packages, prompt = F)
source("Helpers.R")

CLdataRaw <- read.csv("CL export 11_08_17.csv", header = T)

# Objective: Create a report for each club showing how many students are subscribed to their emails

## Clean the data
### Remove all blank rows in Clubs, rows with Graduation as NA, rows where Rejected 
CLdataRaw %>% filter(!is.na(Graduation) & Rejected == "" & Clubs != "" & Unsubscribed == "") -> CLdata

### Apply the function we just created to each row in the Clubs column
CLdata$Clubs <- unlist(lapply(CLdata$Clubs, FUN = function(x2) removeParen(x2)))

### Create a list of all the clubs and then create a report for each club of the students that subscribe to them on CL
strsplit(levels(CLdata$Clubs), split = ", ") %>% Reduce(c, .) %>% unique() -> ClubNames

#### Create all the reports based on subscription
clubReports <- list()
for(club in ClubNames){
  assign(club, filter(CLdata, grepl(club, CLdata$Clubs))) %>%
    select(First.Name, Last.Name, Email.Address, Email.Frequency, Students..Major) -> clubReports[[club]]
}

# I need it for an xlsx writer package

