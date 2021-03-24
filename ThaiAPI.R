#Author: Pasin Marupanthorn
#R version 4.0.2
#V.1
#Date: 24/3/2021
#Connect Thai API
#Please run line by line by "Ctrl + Enter" at the single line sequentially !!


library(httr) #GET method
library(jsonlite) #Read JSON file


Sys.setlocale("LC_CTYPE", "thai") #Use Thai Language 
options(encoding="UTF-8")

##Example 1: Connect to CCD API to get Covid Cases#########

##1.1. URL to JSON ####
today <- fromJSON("https://covid19.th-stat.com/api/open/today")
case <- fromJSON("https://covid19.th-stat.com/api/open/cases")

barplot(table(case$Data$ConfirmDate),las = 2,cex.names= 0.7)
#show distribution of cases

##1.2. GET Method (Here it was not Successful, so I give you many ways to connect to API)####
data <- GET(
  url = "https://covid19.th-stat.com/th/api",
  path = "//covid19.th-stat.com/api/open/cases"
)
content(data, as="parsed") 


##Example 2: Connect to TMD API to get climate data#########

#Here we read xml from web API
Climate <- read_xml("https://data.tmd.go.th/api/Weather3Hours/V2/?uid=api&ukey=api12345") %>% xml_find_all("//StationNameThai") %>% xml_text()




