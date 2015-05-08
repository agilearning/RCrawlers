
library(httr)
resWithoutCookie <- GET("https://www.ptt.cc/bbs/Gossiping/index.html")
htmlParse(content(resWithoutCookie, "text", encoding = "utf8"))
# cookies(resWithoutCookie)
# resWithoutCookie$request

resWithCookie <- GET("https://www.ptt.cc/bbs/Gossiping/index.html",set_cookies(over18=1))
htmlParse(content(resWithCookie, "text", encoding = "utf8"))
# cookies(resWithCookie)
# resWithCookie$request
