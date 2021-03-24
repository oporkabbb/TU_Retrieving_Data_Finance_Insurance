#Author: Pasin Marupanthorn
#R version 4.0.2
#V.1
#Date: 24/3/2021
#Reading CSV, XML and JSON files by R
#Please run line by line by "Ctrl + Enter" at the single line sequentially !!

library(tidyverse) #Universal Data Wrangling
library(XML)      # Read XML file (Alternative)
library(xml2)     # Read XML files
library(htmltab)  # Read HTMLtable
library(rjson)    # Read JSON file (Alternative)
library(jsonlite) # Read JSON file
library(rvest)    # Read web's HTML and scraping

Sys.setlocale("LC_CTYPE", "thai") #Call Thai UTF - Unable Thai Thai Language
options(encoding="UTF-8")


#Example 1 (Read CSV file) - Read OHLC data from Yahoo Finance
#Data is provided in CSV file. 


URL <- "https://query1.finance.yahoo.com/v7/finance/download/PPT?period1=1584523699&period2=1616059699&interval=1d&events=history&includeAdjustedClose=true"
data <- read_csv(URL)
view(data) # Show the results 
write.csv(data,"data.csv") #keep csv file in your directory. 

####################################################################

#Example 2 (Read XML file) - Read university data in Bangkok from Thai open data

#xmlToDataFrame() can be used to transform XML file to flat data.frame
#if the file is in a stanadard xml form.

#Here our file is not in the standard form.

URL <- "https://data.go.th/dataset/84954e4a-3302-4b05-9dfc-c636f30b62ab/resource/e77e6dce-2bce-420d-99f9-c12d5018f8eb/download/university.gml"
data <- read_xml(URL)

#First you need to open the xml file by notepad or chrome to see 
#the name of the children node contains interest data
#put the name of the children node in xml_find_all() to get the data

tel <- data %>% xml_find_all("//BMAWMS:tel") %>% xml_text() 
dcode <- data %>% xml_find_all("//BMAWMS:dcode") %>% xml_text()
type <- data %>% xml_find_all("//BMAWMS:type") %>% xml_text()
address <- data %>% xml_find_all("//BMAWMS:address") %>% xml_text()
fax <- data %>% xml_find_all("//BMAWMS:fax") %>% xml_text()
web <- data %>% xml_find_all("//BMAWMS:web") %>% xml_text()
the_geom <- data %>% xml_find_all("//BMAWMS:the_geom") %>% xml_text()
name <- data %>% xml_find_all("//BMAWMS:name") %>% xml_text()

XML_Frame <- data.frame(name,dcode,type,address,fax,web,the_geom)
write.csv(XML_Frame,"XML_Frame.csv")

#####################################################################

#Example 3 (Read JSON file) - Read university data in Bangkok from Thai open data 

URL <- "https://data.go.th/dataset/84954e4a-3302-4b05-9dfc-c636f30b62ab/resource/31ddd8a7-c99a-43eb-8c2e-9644ddb1608b/download/university.json"
data <- fromJSON(URL) 
data$type
data$totalFeatures
JSON_Frame <- data$features

write.csv(JSONFrame,"JSON_Frame.csv")


##############################################################################

