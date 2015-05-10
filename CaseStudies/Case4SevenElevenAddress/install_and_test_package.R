# install.packages("devtools")
library(devtools)
install_git("https://github.com/agilearning/RCrawlers.git",subdir = "CaseStudies/Case4SevenElevenAddress/RCrawlerTW711/")

library(RCrawlerTW711)
?RCrawlerTW711::getCityCodes
example(getCityCodes)
