library(httr)
# install.packages("jpeg")
library(jpeg)

res1 = GET("http://lvr.land.moi.gov.tw/N11/homePage.action")
cookies(res1)

res2 = GET("http://lvr.land.moi.gov.tw/N11/ImageNumberN13?")
captcha <- content(res2)
plot(0:1, 0:1, type = "n")
rasterImage(captcha, 0, 0, 1, 1)
