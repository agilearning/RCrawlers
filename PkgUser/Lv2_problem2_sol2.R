# install.packages("quantmod")
library(quantmod)

?debug
?browser

# set debug to getSymbols and call it!
# commands: n, s, f, Q, c, help, where
debug(getSymbols)
getSymbols("^TWII")


# unset debug to getSymbols and call it!
undebug(getSymbols)
getSymbols("^TWII")

