library(httr)

token = ""
url = sprintf("https://graph.facebook.com/v2.3/me?access_token=%s",token)
res = GET(url)
content(res)


url = sprintf("https://graph.facebook.com/v2.3/me/feed?access_token=%s",token)
res = GET(url)
content(res)


res = POST("https://graph.facebook.com/v2.3/me/feed",
           body=list(message=sprintf("[TEST Posting Message] %s At %s","httr 測試",Sys.time()),
                     access_token=token))

content(res)
postId = content(res)$id


url = sprintf("https://graph.facebook.com/v2.3/%s?access_token=%s",postId,token)
res = DELETE(url)
content(res)
