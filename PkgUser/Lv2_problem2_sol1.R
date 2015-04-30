# install.packages("quantmod")
library(quantmod)

getwd()
# setwd()
list.files()

source("copiedGetSymbls.R")
copiedGetSymbls("^TWII")

source("copiedGetSymblsPrints.R")
copiedGetSymblsPrints("^TWII")

