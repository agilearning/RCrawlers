
library(httr)
library(XML)

####################################################
# getStoreData via GET Method
####################################################
# res = GET("http://emap.pcsc.com.tw/EMapSDK.aspx?commandid=SearchStore&city=%E5%8F%B0%E5%8C%97%E5%B8%82&town=%E5%A4%A7%E5%AE%89%E5%8D%80&roadname=&ID=&StoreName=&SpecialStore_Kind=&isDining=False&isParking=False&isLavatory=False&isATM=False&is7WiFi=False&isIce=False&isHotDog=False&isHealthStations=False&isIceCream=False&isOpenStore=False&isFruit=False&isCityCafe=False&address=")
# node = xmlParse(content(res,as="text"))
# View(xmlToDataFrame(node["//GeoPosition"]))

####################################################
# getStoreData via POST city and town
####################################################
# connector
res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
           body=list(commandid="SearchStore",city="台北市",town="大安區"))

# parser
node = xmlParse(content(res,as="text"))
View(xmlToDataFrame(node["//GeoPosition"]))


####################################################
# getTown via POST cityid
####################################################
# connector
res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
           body=list(commandid="GetTown",cityid="01"))

# parser
node = xmlParse(content(res,as="text"))
View(xmlToDataFrame(node["//GeoPosition"]))


####################################################
# getCityCodes via POST cityid
####################################################
res = GET("http://emap.pcsc.com.tw/lib/areacode.js")
resText = content(res,"text",encoding = "utf8")
matches = gregexpr("AreaNode[(][^,]+(,[^,]+){3}",resText)
unlist(regmatches(resText,matches))
cityCodesStr = unlist(regmatches(resText,matches))

str = cityCodesStr[2]
str
matches = gregexpr("[']([^']+)[']",str)
unlist(regmatches(str,matches))

cityCodes = lapply(cityCodesStr,function(str){
  matches = gregexpr("[']([^']+)[']",str)
  return(unlist(regmatches(str,matches)))
})

cityCodes = lapply(cityCodesStr[2:length(cityCodesStr)],function(str){
  matches = gregexpr("[']([^']+)[']",str)
  return(gsub("'","",unlist(regmatches(str,matches))))
})

cityCodesDf = data.frame(do.call(rbind,cityCodes),stringsAsFactors = FALSE)
colnames(cityCodesDf) = c("cityName","cityCode")
View(cityCodesDf)
