# install.packages("quantmod")
library(quantmod)

example(trace)
?trace

trace(getSymbols, exit=quote(print(getsymbols.returned)))
trace(getSymbols, exit=function(){
  print(get(symbols.returned))
  print(symbols.returned) 
})

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

