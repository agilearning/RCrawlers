
library(httr)
library(XML)
# install.packages("dplyr")
library(dplyr)


####################################################
# getCityCodes via POST cityid
####################################################

# function input:
res = GET("http://emap.pcsc.com.tw/lib/areacode.js")
resText = content(res,"text",encoding = "utf8")
matches = gregexpr("AreaNode[(][^,]+(,[^,]+){3}",resText)
unlist(regmatches(resText,matches))
cityCodesStr = unlist(regmatches(resText,matches))
cityCodes = lapply(cityCodesStr[2:length(cityCodesStr)],function(str){
  matches = gregexpr("[']([^']+)[']",str)
  return(gsub("'","",unlist(regmatches(str,matches))))
})

cityCodesDf = data.frame(do.call(rbind,cityCodes),stringsAsFactors = FALSE)
colnames(cityCodesDf) = c("cityName","cityCode")
# function output:
cityCodesDf


####################################################
# getOneTownDf via POST cityid
####################################################

# function input: cityCode
cityCode = "09"
# connector
res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
           body=list(commandid="GetTown",cityid=cityCode))

# parser
node = xmlParse(content(res,as="text"))
townDf = xmlToDataFrame(node["//GeoPosition"],stringsAsFactors = FALSE)
townDf = data.frame(cityCode=cityCode,townDf,stringsAsFactors = FALSE)
# function output:
townDf


####################################################
# getTownDf via POST cityCodes
####################################################

# function input: cityCodes
cityCodes = cityCodesDf$cityCode
# merge(cityCodesDf,townDf,by = "cityCode")
# inner_join(cityCodesDf,townDf,by = "cityCode")
# townDf = inner_join(cityCodesDf,townDf,by = "cityCode")

# listTownDfs = lapply(cityCodes,function(cityCode){
#   print(cityCode)
#   res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
#              body=list(commandid="GetTown",cityid=cityCode))
#   
#   # parser
#   node = xmlParse(content(res,as="text"))
#   townDf = xmlToDataFrame(node["//GeoPosition"],stringsAsFactors = FALSE)
#   townDf = data.frame(cityCode=cityCode,townDf,stringsAsFactors = FALSE)
#   # function output:
#   return(townDf)  
# })

listTownDfs = lapply(cityCodes,function(cityCode){
  print(cityCode)
  res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
             body=list(commandid="GetTown",cityid=cityCode))
  
  # parser
  node = xmlParse(content(res,as="text"))
  townDf = xmlToDataFrame(node["//GeoPosition"],stringsAsFactors = FALSE)
  if (dim(townDf)[1] > 0){
    townDf = data.frame(cityCode=cityCode,townDf,stringsAsFactors = FALSE)
    # function output:
    return(townDf)  
  }else{
    return(NULL)
  }
  
})

townDf = do.call(rbind,listTownDfs[!sapply(listTownDfs,is.null)])
townDf = inner_join(cityCodesDf,townDf,by = "cityCode")
# function output:
townDf


####################################################
# getStoreData via POST cityName and townName
####################################################

# function input: cityName, townName
cityName = "台北市"
townName = "大安區"


# connector
res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
           body=list(commandid="SearchStore",city=cityName,town=townName))

# parser
node = xmlParse(content(res,as="text"))
storeDf = xmlToDataFrame(node["//GeoPosition"])
# function output: 
storeDf





