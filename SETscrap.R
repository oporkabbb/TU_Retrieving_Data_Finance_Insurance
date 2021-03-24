library("xml2")
library("htmltab")
library("rvest")
library("tidyverse")


LetterList <- c("NUMBER", LETTERS)
TabDummy <- c()
for(i in 1:length(LetterList)){
SETCompanyURL <- paste0("https://www.set.or.th/set/commonslookup.do?language=en&country=US&prefix=",LetterList[i])
Dummy <- read_html(SETCompanyURL) %>% html_nodes("table") %>% html_table() %>% as.data.frame()
TabDummy <- rbind(TabDummy,Dummy)
}

write.csv(TabDummy,"ThaiTicker.csv")


ThaiTicker <- TabDummy$Symbol 
ThaiTicker <- gsub(" & ","+%26+",ThaiTicker)
ThaiTicker <- gsub("&","%26",ThaiTicker)
DataTabAll <- c()
for(i in 1:length(ThaiTicker)){
  print(paste0("Got it!!",ThaiTicker[i]))
for(j in 1:3){
SETData <- paste0("https://www.set.or.th/set/historicaltrading.do?symbol=",ThaiTicker[i],"&page=",j-1,"&language=en&country=US&type=trading")
DataTab <- read_html(SETData) %>% html_nodes("table") %>% html_table() 
if(length(DataTab)==0){next}else{DataTab <- as.data.frame(DataTab)}
DataTab$Ticker <- ThaiTicker[i]
DataTabAll <- rbind(DataTabAll,DataTab)
}
}

write.csv(DataTabAll,"DataTabAll.csv")
