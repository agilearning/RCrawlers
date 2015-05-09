
library(httr)
# install.packages("rjson")
library(rjson)

res = GET("http://api.map.com.tw/net/familyShop.aspx?searchType=ShopList&type=&city=%E5%8F%B0%E5%8C%97%E5%B8%82&area=%E4%B8%AD%E5%B1%B1%E5%8D%80&road=&fun=showStoreList")
resStr = content(res,as="text")

sub("[^\\]]*$","",sub("^[^\\[]*","",resStr))
jsonDataString = sub("[^\\]]*$","",sub("^[^\\[]*","",resStr))

jsonData = fromJSON(jsonDataString)
View(data.frame(do.call(rbind,jsonData)))
