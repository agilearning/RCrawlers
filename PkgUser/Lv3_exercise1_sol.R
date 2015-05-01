# install.packages("quantmod")
library(quantmod)

# set debugger at getSymbols.yahoo
debug(getSymbols.yahoo)
getSymbols("^TWII")
undebug(getSymbols.yahoo)


# set debugger at getSymbols.yahoo
debug(getSymbols.oanda)
getSymbols("USD/TWD",src="oanda")
undebug(getSymbols.oanda)


# set debugger at download.file
debug(download.file)
getSymbols("^TWII")
undebug(download.file)


# set trace at download.file
trace(download.file, quote(print(url)), at=1)
getSymbols("^TWII")
getSymbols("USD/TWD",src="oanda")
untrace(download.file)
