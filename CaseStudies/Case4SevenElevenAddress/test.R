rm(list=ls(all.names = TRUE))
# install.packages("dplyr")
source("packIntoFunction.R")

cityCodeDf = getCityCodes()
View(cityCodeDf)
View(getOneTownDf("01"))
townDf = getTownDf(cityCodeDf$cityCode)
View(townDf)

View(townDf[,c("cityName","TownName")])
testTownDf = townDf[,c("cityName","TownName")][1:10,]

listOfData = apply(testTownDf,1,function(x){
  print(getStoreData(x[1],x[2]))
})

totalDf = do.call(rbind,listOfData)
View(totalDf)
