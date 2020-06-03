library(rchess)
library(RJDBC)
library(stringr)
library(plotrix)  
drv <- JDBC("oracle.jdbc.OracleDriver", "C:\\Users\\GTUSR0174\\Desktop\\Chess\\ojdbc7.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521/orcl", "ODI_USER", "oracle")
df<-dbGetQuery(conn, "select  MOVES from dwh.CHESS_GAME  WHERE ID='QCoY6CSm'")  
df<-str_split(as.character(df) , " ") 
df<- unlist(df)  
chss <- Chess$new()    
for (val in df) { 
    chss$move(val) 
  print(plot(chss) )  
  Sys.sleep(1) 
}


