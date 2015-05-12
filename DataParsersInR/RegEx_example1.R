
library(httr)

res = GET("http://www.319papago.idv.tw/lifeinfo/tkkinc-02.html")
resStr = content(res,as = "text")

# try1:
gregexpr("[0-9]+-[0-9]+",resStr)
matches = gregexpr("[0-9]+-[0-9]+",resStr)
regmatches(resStr,matches)
unlist(regmatches(resStr,matches))


# try2:
matches = gregexpr("[0-9]{4}-[0-9]{4}",resStr)
regmatches(resStr,matches)
unlist(regmatches(resStr,matches))


# try3:
matches = gregexpr("[(][0-9]+[)][0-9]+-[0-9]+",resStr)
regmatches(resStr,matches)
unlist(regmatches(resStr,matches))

