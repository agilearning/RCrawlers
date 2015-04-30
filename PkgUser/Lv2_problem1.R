# install.packages("quantmod")
library(quantmod)

?quantmod
?quantmod::getSymbols
?quantmod::getSymbols.yahoo

# looking at source code of quantmod::getSymbols.yahoo
quantmod::getSymbols.yahoo

# quantmod::getSymbols 
TW2330 <- getSymbols("2330.TW", auto.assign= FALSE)
head(TW2330)
tail(TW2330)

# quantmod::getSymbols 
TW2330 <- getSymbols("2330.TW", auto.assign= FALSE, from = "2000-01-01")
head(TW2330)
tail(TW2330)
chartSeries(TW2330)


# add TAs 
?quantmod 
addADX()
addBBands()
addCCI()

