# install.packages("quantmod")
library(quantmod)

?quantmod
?quantmod::getSymbols
?quantmod::getSymbols.yahoo
?quantmod::getSymbols.oanda

# looking at example and source code of quantmod::getSymbols.yahoo
example(getSymbols.yahoo)
getSymbols.yahoo('MSFT',env=globalenv())
getSymbols.yahoo


# looking at example and source code of quantmod::getSymbols.oanda
example(getSymbols.oanda)
getSymbols("USD/EUR",src="oanda",from="2005-01-01")
getSymbols.oanda

# quantmod::getSymbols 
getSymbols("USD/TWD",src="oanda")
chartSeries(USDTWD)


# add TAs 
?quantmod
addBBands()
addCCI()
addADX()

# add TAs 
getSymbols("2330.TW")
TW2330 <- get("2330.TW")
chartSeries(TW2330)
addBBands()
addCCI()
addADX()
