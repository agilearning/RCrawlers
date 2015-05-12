
library(httr)

# connector with cookie
resWithoutCookie <- GET("https://www.ptt.cc/bbs/Gossiping/index.html")
htmlParse(content(resWithoutCookie, "text", encoding = "utf8"))
# cookies(resWithoutCookie)
# resWithoutCookie$request

resWithCookie <- GET("https://www.ptt.cc/bbs/Gossiping/index.html",set_cookies(over18=1))
htmlParse(content(resWithCookie, "text", encoding = "utf8"))
# cookies(resWithCookie)
# resWithCookie$request


####################################################
# getPostData via GET Method with cookie
####################################################

postUrl <- "https://www.ptt.cc/bbs/Gossiping/M.1431338763.A.1BF.html"
res <- GET(postUrl,set_cookies(over18=1))
node = htmlParse(content(res, "text", encoding = "utf8"))

library(CSS)

############ Exploratory Selector Analysis ############
# Board
node[cssToXpath(".article-metaline-right > .article-meta-value")]
# Author, Title, Time
node[cssToXpath(".article-metaline > .article-meta-value")]
# Post Text
node[cssToXpath("#main-content")]
# Post Pushes
node[cssToXpath("div.push")]



############ Data Parser ############

postData = list()
postData$Board = cssApply(node,".article-metaline-right > .article-meta-value",cssCharacter)

metaTemp = cssApply(node,".article-metaline > .article-meta-value",cssCharacter)

postData$Author = metaTemp[1]
postData$Title = metaTemp[2]
postData$Time = metaTemp[3]

removeNodes(node[cssToXpath(".article-metaline-right > .article-meta-value")])
removeNodes(node[cssToXpath(".article-metaline > .article-meta-value")])

node[cssToXpath(".article-metaline-right > .article-meta-value")]
node[cssToXpath(".article-metaline > .article-meta-value")]

print(xmlValue(node[cssToXpath("#main-content")][[1]]))
cat(xmlValue(node[cssToXpath("#main-content")][[1]]))

postData$Text = xmlValue(node[cssToXpath("#main-content")][[1]])

postData$postUrl = postUrl
postData$postId = gsub("[/]|.html","",unlist(strsplit(postUrl,postData$Board))[2])


node[cssToXpath("div.push")]

lapply(node[cssToXpath("div.push")],function(test){
  list(pushTag=xmlValue(test["span"][[1]]),
       userId=xmlValue(test["span"][[2]]),
       text=xmlValue(test["span"][[3]]),
       time=xmlValue(test["span"][[4]]))
})

pustData = lapply(node[cssToXpath("div.push")],function(test){
  list(pushTag=xmlValue(test["span"][[1]]),
       userId=xmlValue(test["span"][[2]]),
       text=xmlValue(test["span"][[3]]),
       time=xmlValue(test["span"][[4]]))
})


pushDf = data.frame(postId = postData$postId,
                    postUrl = postUrl,
                    do.call(rbind,pustData),stringsAsFactors = FALSE)



