
library(httr)
library(XML)

res <- GET("http://www.w3schools.com/XQuery/books.xml")
content(res)
class(content(res))

node <- content(res)
node["//book"]

library(CSS)
cssToXpath("book")

# `[`(node,"//book")
xmlToDataFrame(node["//book"][-3])

