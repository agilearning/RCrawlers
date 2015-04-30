# install.packages("quantmod")
library(quantmod)


# quantmod::getSymbols 
getSymbols("2330.TW")

# view data
View(2330.TW)
View(get("2330.TW"))

# view data
TW2330 <- get("2330.TW")
head(TW2330)
tail(TW2330)
View(TW2330)
summary(TW2330)


# quantmod::chartSeries
chartSeries(TW2330)



