#Author: Pasin Marupanthorn
#R version 4.0.2
#V.1
#Date: 24/3/2021
#Connect Binance API
#Please run line by line by "Ctrl + Enter" at the single line sequentially !!


library(httr)
library(jsonlite)
library(binancer) #API package Binance
#remotes::install_github("daroczig/binancer")



#Example: Connect Binance API to get candlestick Data of bitcoin

#We need to read the webpage of API provider before coding
#because the query parameter and Respond data will be different
#depended on provider

###1.1. GET method

data <- GET(
  url = "https://api.binance.com",
  path = "/api/v3/klines",
  query = list (
    symbol = "LTCBTC",
    interval ="1m",
    limit = "60"
  )
)

#rawToChar used for transforming raw data to Characteristic

dataf <- fromJSON(rawToChar(data$content)) %>% data.frame()
colnames(dataf) <- c("Open time", "Open", "High", "Low", "Close", "Volume", "Close time", "Quote asset volume", "Number of trades", 
"Taker buy base asset volume","Taker buy quote asset volume",
"Ignore")

#convert Unix timestamp to Date time
dataf$`Open time` <- as.POSIXct(as.numeric(dataf$`Open time`)/1000, origin="1970-01-01", tz="UTC")
dataf$`Close time` <- as.POSIXct(as.numeric(dataf$`Close time`)/1000, origin="1970-01-01", tz="UTC")


###1.2. Using API URL

symbol <- "LTCBTC"
interval <- "1m"
limit <- "60"
pathapi <- "/api/v3/klines" 
APIURL <- paste0("https://api.binance.com",pathapi,"?symbol=",symbol,"&interval=",interval,"&limit=",limit)
URLbi <- fromJSON(APIURL)


###1.3. Using Package (Here we used "binancer")
#Everytime you use the package you need to read the instruction 
#on CRAN or provider Github.

datafp <- binance_klines('LTCBTC', interval = '1m',limit = 60)



           