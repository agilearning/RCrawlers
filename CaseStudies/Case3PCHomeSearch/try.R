library(httr)

url <- "http://ecshweb.pchome.com.tw/search/v3.3/all/results?q=sony&page=1&sort=rnk/dc"
res = GET(url)
res_json = content(res)
do.call(rbind,res_json$prods)
View(data.frame(do.call(rbind,res_json$prods)))
