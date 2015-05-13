

####################################################
# getListPageUrls via boardName
####################################################

#' getListPageUrls
#' 
#' Get urls of the list pages, each contains certain posts of the input board.
#' 
#' @param boardName The name of a board.
#' @examples
#' listPageUrls = getListPageUrls("Gossiping")[1:5]
#' listPageUrls
#' @import httr CSS XML
#' @export
getListPageUrls = function(boardName){  
  # function input: boardName
  # boardName = "Gossiping"
  
  boardUrl = sprintf("https://www.ptt.cc/bbs/%s/index.html",boardName)
  res <- GET(boardUrl,set_cookies(over18=1))
  node = content(res, encoding = "utf8")
  
  node[cssToXpath("div.btn-group.pull-right > a")]
  maxPage = as.numeric(gsub(".html","",unlist(strsplit(xmlAttrs(node[cssToXpath("div.btn-group.pull-right > a")][[2]])["href"],split = "index"))[2]))
  
  allListPages = c("",1:maxPage)
  allListUrls = sapply(allListPages,function(page){
    sprintf("https://www.ptt.cc/bbs/%s/index%s.html",boardName,page)
  })
  # function output: allListUrls
  allListUrls
  
}


####################################################
# getPostUrls via listPageUrl
####################################################

#' getPostUrls
#' 
#' Get urls of posts that listed in the list page.
#' 
#' @param listPageUrl The url of the list page.
#' @examples
#' listPageUrls = getListPageUrls("Gossiping")[1:5]
#' postUrls = unlist(lapply(listPageUrls,getPostUrls))
#' postUrls
#' @import httr CSS XML
#' @export
getPostUrls = function(listPageUrl){
  # function input: listPageUrl
  # listPageUrl = allListUrls[10]
  
  res <- GET(listPageUrl,set_cookies(over18=1))
  node = content(res, encoding = "utf8")
  node[cssToXpath(".title a")]
  postUrls = cssApply(node,".title a",function(node){
    sprintf("https://www.ptt.cc%s",xmlAttrs(node)["href"])
  })
  # function output: postUrls
  postUrls
  
}

####################################################
# getPostData via postUrl
####################################################

#' getPostData
#' 
#' Get the content of the post.
#' 
#' @param postUrl The url of the post.
#' @examples
#' getPostData("https://www.ptt.cc/bbs/Gossiping/M.1431338763.A.1BF.html")
#' @import httr CSS XML
#' @export
getPostData = function(postUrl){
  # function input: postUrl
  # postUrl <- "https://www.ptt.cc/bbs/Gossiping/M.1431338763.A.1BF.html"
  res <- GET(postUrl,set_cookies(over18=1))
  node = content(res, encoding = "utf8")
  
  postData = list()
  postData$Board = cssApply(node,".article-metaline-right > .article-meta-value",cssCharacter)
  
  metaTemp = cssApply(node,".article-metaline > .article-meta-value",cssCharacter)
  
  postData$Author = metaTemp[1]
  postData$Title = metaTemp[2]
  postData$Time = metaTemp[3]
  
  removeNodes(node[cssToXpath(".article-metaline-right > .article-meta-value")])
  removeNodes(node[cssToXpath(".article-metaline > .article-meta-value")])
  
  postData$Text = xmlValue(node[cssToXpath("#main-content")][[1]])
  
  postData$postUrl = postUrl
  postData$postId = gsub("[/]|.html","",unlist(strsplit(postUrl,postData$Board))[2])
  
  pustData = lapply(node[cssToXpath("div.push")],function(test){
    list(pushTag=xmlValue(test["span"][[1]]),
         userId=xmlValue(test["span"][[2]]),
         text=xmlValue(test["span"][[3]]),
         time=xmlValue(test["span"][[4]]))
  })
  
  
  pushDf = data.frame(postId = postData$postId,
                      postUrl = postUrl,
                      do.call(rbind,pustData),stringsAsFactors = FALSE)
  
  # function output: 
  list(postData=postData,pushDf=pushDf)
  
} 

