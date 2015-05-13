
rm(list=ls(all.names = TRUE))

source("packIntoFunction.R")

listPageUrls = getListPageUrls("Gossiping")[1:5]
listPageUrls

postUrls = unlist(lapply(listPageUrls,getPostUrls))
postUrls

getPostData("https://www.ptt.cc/bbs/Gossiping/M.1431338763.A.1BF.html")


getPostData(postUrls[2])
postData = lapply(postUrls[3:5],getPostData)

postDf = data.frame(do.call(rbind,lapply(postData,function(xx) xx$postData)))
pushDf = do.call(rbind,lapply(postData,function(xx) xx$pushDf))
