
library(httr)
library(XML)

# Connector
# IDS = sii, otc, rotc, pub
marketID = "sii"
postData = sprintf("encodeURIComponent=1&step=1&firstin=1&TYPEK=%s&code=",marketID) 
res <- POST("http://mops.twse.com.tw/mops/web/ajax_t51sb01",
            body = postData)

resString = content(res, "text", encoding = "utf8")

# Parser 
htmlParse(resString,encoding = "utf8")
tables <- readHTMLTable(htmlParse(resString,encoding = "utf8"),stringsAsFactors=FALSE)

dataCol = tables[[2]][,1]
dataCol =  gsub("[$,\xc2\xa0]", "", dataCol) 
TWSE_IDs = dataCol[grep("[0-9]+", dataCol)]
