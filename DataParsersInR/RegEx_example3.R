

library(httr)

res = GET("http://search.udn.com/search/searchResult4utf8.jsp?ch=udn.news2014&df=2&rc=850&wc=10000&pw=220&mc=&q=%E5%8F%B0%E6%96%B0&fp=1")
resStr = content(res,as = "text",encoding="utf8")

# [phone number] try1:
matches = gregexpr("(arr\\[[0-9]+\\])",resStr)
regmatches(resStr,matches)

