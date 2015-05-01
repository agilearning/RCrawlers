# install.packages("quantmod")
library(quantmod)

as.list(body(getSymbols))
body(getSymbols)

# print(getsymbols.returned) at the bigenning of BLOCK 14
trace(getSymbols, quote(print(symbols.returned)),at=c(14))
getSymbols("^TWII")
untrace(getSymbols)


# print(getsymbols.returned) at the bigenning of BLOCK 14
trace(getSymbols, quote(print(Symbols)),at=c(14))
getSymbols("^TWII")
getSymbols(c("^TWII","^VIX"))
untrace(getSymbols)


# print(symbols.returned) at the end of function
trace(getSymbols, exit=quote(print(symbols.returned)))
getSymbols("^TWII")
untrace(getSymbols)


# print(get(symbols.returned)) at the end of function
trace(getSymbols, exit=quote(print(get(symbols.returned))))
getSymbols("^TWII")
untrace(getSymbols)


# print(get(symbols.returned)) at the end of function
trace(getSymbols, exit=quote(function(){
  print(get(symbols.returned))
  print(symbols.returned)
}))
getSymbols("^TWII")
untrace(getSymbols)

