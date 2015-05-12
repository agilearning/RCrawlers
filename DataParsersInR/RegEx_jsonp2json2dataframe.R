
# res = GET("http://pi.isuphoto.org/api/user/uei?callback=jQuery17207272935493383557_1431032370563&page=0&_=1431032370635")
res = GET("http://live.nhl.com/GameData/20112012/2011020908/Roster.jsonp")
resStr = content(res,as="text")

sub("^[^\\{]*","",resStr)
sub("[^\\}]*$","",resStr)
sub("[^\\}]*$","",sub("^[^\\{]*","",resStr))
jsonDataString = sub("[^\\}]*$","",sub("^[^\\{]*","",resStr))

library(rjson)
jsonData = fromJSON(jsonDataString)

View(data.frame(do.call(rbind,jsonData$data$away$skaters$player)))
