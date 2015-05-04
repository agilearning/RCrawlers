library(httr)

httr::GET
httr:::make_request

# Demo GET method
res = GET("http://tw.stock.yahoo.com/d/s/major_2451.html")
res
class(res)
res$content
res$request
content(res,as="raw")
content(res,as="text",encoding="big5")


# Demo POST method
res = POST("http://mops.twse.com.tw/mops/web/ajax_t51sb01",
            body = "encodeURIComponent=1&step=1&firstin=1&TYPEK=sii&code=")
res
res$request
content(res, "text", encoding = "utf8")



