rm(list=ls(all.names = TRUE))
source("packIntoFunction.R")

Data_Table = getStockMajorData(2330)
View(Data_Table)

library("RSQLite")
drv <- dbDriver("SQLite")
conn <- dbConnect(drv,"yahooStockMajor.sqlite")
dbListTables(conn)
dbWriteTable(conn, "StockMajor", Data_Table,row.names=FALSE,append=TRUE) 
dbDisconnect(conn)


drv <- dbDriver("SQLite")
conn <- dbConnect(drv,"yahooStockMajor.sqlite")
dbListTables(conn)
View(dbReadTable(conn,"StockMajor"))
dbDisconnect(conn)
