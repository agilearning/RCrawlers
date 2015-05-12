install.packages("quantmod")
library(quantmod)

getSymbols("2330.TW")
View(2330.TW)
chartSeries(2330.TW)

# View(get("2330.TW"))
# chartSeries(get("2330.TW"))
