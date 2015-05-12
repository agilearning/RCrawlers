# Sample Site: http://ecshweb.pchome.com.tw/search/v3.3/?q=sony 

# Parser
library(CSS)
doc <- '<dd class="c2f">
<b class="sp">24小時到貨</b>
<h5>
<a href="http://24h.pchome.com.tw/prod/DGALS8-A9005BTBS">
<em>SONY</em> Xperia M2 D2303
</a>
</h5>
<span>▼春電斬↘狂降$1000▼<em>SONY</em> Xperia M2 D2303 高速娛樂智慧機</span>
<ul class="clearfix" id="bookInfo"></ul>
</dd>'


doc <- htmlParse(doc)

# extract data via xpath and css
doc["//h5/a"]
cssToXpath("h5>a")

xmlValue(doc["//h5/a"][[1]])
cssApply(doc, "h5>a", cssCharacter)
