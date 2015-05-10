# 
# library(httr)
# library(XML)
# library(dplyr)
# 
# 
####################################################
# getCityCodes via POST cityid
####################################################

#' getCityCodes via POST cityid
#' 
#' getCityCodes via POST cityid
#'
#' @examples
#' cityCodeDf = getCityCodes()
#' View(cityCodeDf)
#' @export
getCityCodes = function(){
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
  return(cityCodesDf)
}


####################################################
# getOneTownDf via POST cityid
####################################################

#' getOneTownDf via POST cityid
#' 
#' getOneTownDf via POST cityid
#' 
#' @examples
#' View(getOneTownDf("01"))
#' 
#' @export
getOneTownDf = function(cityCode){
  # function input: cityCode
  # cityCode = "09"
  # connector
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
  
}


####################################################
# getTownDf via POST cityCodes
####################################################

#' getTownDf via POST cityCodes
#' 
#' getTownDf via POST cityCodes
#' 
#' @examples
#' cityCodeDf = getCityCodes()
#' townDf = getTownDf(cityCodeDf$cityCode)
#' View(townDf)
#' 
#' @export
getTownDf = function(cityCodes){
  # function input: cityCodes
  # cityCodes = cityCodesDf$cityCode
  
  listTownDfs = lapply(cityCodes,getOneTownDf)
  
  townDf = do.call(rbind,listTownDfs[!sapply(listTownDfs,is.null)])
  townDf = inner_join(getCityCodes(),townDf,by = "cityCode")
  # function output:
  return(townDf)
}


####################################################
# getStoreData via POST cityName and townName
####################################################

#' getStoreData via POST cityName and townName
#' 
#' getStoreData via POST cityName and townName
#' 
#' @examples
#' cityCodeDf = getCityCodes()
#' townDf = getTownDf(cityCodeDf$cityCode)
#' testTownDf = townDf[,c("cityName","TownName")][1:10,]
#' listOfData = apply(testTownDf,1,function(x){
#'    print(getStoreData(x[1],x[2]))
#' })
#' totalDf = do.call(rbind,listOfData)
#' View(totalDf)
#' 
#' @export
getStoreData = function(cityName, townName){
  # function input: cityName, townName
  # cityName = "台北市"
  # townName = "大安區"
  
  
  # connector
  res = POST("http://emap.pcsc.com.tw/EMapSDK.aspx",
             body=list(commandid="SearchStore",city=cityName,town=townName))
  
  # parser
  node = xmlParse(content(res,as="text"))
  storeDf = xmlToDataFrame(node["//GeoPosition"])
  # function output: 
  return(storeDf)
}

