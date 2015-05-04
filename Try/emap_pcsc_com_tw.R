
library(httr)
library(XML)
library(CSS)

res = GET("http://emap.pcsc.com.tw/EMapSDK.aspx?commandid=SearchStore&city=%E5%8F%B0%E5%8C%97%E5%B8%82&town=%E5%A4%A7%E5%AE%89%E5%8D%80&roadname=&ID=&StoreName=&SpecialStore_Kind=&isDining=False&isParking=False&isLavatory=False&isATM=False&is7WiFi=False&isIce=False&isHotDog=False&isHealthStations=False&isIceCream=False&isOpenStore=False&isFruit=False&isCityCafe=False&address=")
node = xmlParse(content(res,as="text"))
View(xmlToDataFrame(node["//GeoPosition"]))

