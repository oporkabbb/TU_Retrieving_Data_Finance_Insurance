#Author: Pasin Marupanthorn
#R version 4.0.2
#V.1
#Date: 24/3/2021
#Scrap Static Web Page by R
#Please run line by line by "Ctrl + Enter" at the single line sequentially !!


library(rvest)    # Read web's HTML and scraping



###Example Getting text and table from Wiki

#1. Open google chrome 
#2. Navigate to webpage you want to sracp
#3. Right-click at text on webpage and choose "Inspect" 
#4. Looking for details you want on developer window
#5. We can point the location of data we want by node, attribute or xpath.

URL <- "https://en.wikipedia.org/wiki/Life_expectancy"
data <- read_html(URL)
Getalltext <- data %>% html_nodes("p") %>% html_text()
textbynode <- data %>% html_nodes("p b") %>% html_text()
textbyattribute <- data %>%  html_nodes("p a") %>% html_attr("href") 
textbyxpath <- data %>% html_nodes(xpath = "//*[@id='mw-content-text']/div[1]/p[3]/b") %>% html_text()

## Easier way to get html table is to use htmltab package
htmltable <- URL %>% htmltab(which = "//*[@id='mw-content-text']/div[1]/center/table")