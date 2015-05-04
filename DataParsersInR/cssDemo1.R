library(CSS)

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
# Names of the characters
cssApply(doc, ".character>.name", cssCharacter)
# Name of character1
cssApply(doc, "#character1>.name", cssCharacter)