library(XML)

doc <- "<html>
<head></head>
<body>
<div id='character1' class='character'>
<span class='name'>Mike</span>
<span class='level digit'>10</span>
</div>
<div id='character2' class='character'>
<span class='name'>Stan</span>
</div>
</body>
</html>"

doc <- htmlParse(doc)

# try ... 
doc["//*[@class='name']"]
xmlValue(doc["//*[@class='name']"][[1]])

# extract data via xpath
xpathApply(doc,"//*[@class='name']",xmlValue)
unlist(xpathApply(doc,"//*[@class='name']",xmlValue))

# compare with css selector
library(CSS)
doc[cssToXpath(".name")]
cssApply(doc, ".name", cssCharacter)
