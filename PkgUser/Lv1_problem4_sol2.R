# install.packages("quantmod")
library(quantmod)

crawlIDs = c("2330.TW", "USD/TWD", "^TWII", "2454.TW", "2498.TW")

getData = function(sid){
  if (sid == "USD/TWD"){
    data = getSymbols(sid,src="oanda",auto.assign = FALSE)
  }else{
    data = getSymbols(sid,auto.assign = FALSE)
  }
  return(data)
}

dataEnv = new.env()

for (sid in crawlIDs){
#   print(head(getData(sid)))
  dataEnv[[sid]] <- getData(sid)  
  
#   if (sid == "USDTWD"){
#     getSymbols(sid,src="oanda")
#   }else{
#     getSymbols(sid)
#   }
}

