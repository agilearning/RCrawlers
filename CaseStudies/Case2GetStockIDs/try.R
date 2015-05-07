
library(httr)

# Connector
# IDS = sii, otc, rotc, pub
res <- POST("http://mops.twse.com.tw/mops/web/ajax_t51sb01",
            body = "encodeURIComponent=1&step=1&firstin=1&TYPEK=sii&code=")

resString = content(res, "text", encoding = "utf8")

# Parser 
library(XML)
htmlParse(resString,encoding = "utf8")
tables <- readHTMLTable(htmlParse(resString,encoding = "utf8"),stringsAsFactors=FALSE)
View(tables[[2]])

dataCol = tables[[2]][,1]
dataCol[2]

gsub(" ", "", dataCol[2]) 

?substr
substr(dataCol[2],1,1) == " "

charToRaw(dataCol[2])
charToRaw(" ")

gsub(" ", "", " ReplaceSpace ") 

dataCol =  gsub("[$,\xc2\xa0]", "", dataCol) 
grep("[0-9]+", dataCol)
TWSE_IDs = dataCol[grep("[0-9]+", dataCol)]
