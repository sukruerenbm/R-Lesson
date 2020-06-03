library(quantmod) 
library(RJDBC)
drv <- JDBC("oracle.jdbc.OracleDriver", "C:\\Users\\GTUSR0174\\Desktop\\Chess\\ojdbc7.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521/orcl", "ODI_USER", "oracle") 
from <- c("USD", "EUR","USD","JPY","GBP")
to   <- c("TRY", "TRY","EUR","TRY","TRY")
df<-getQuote(paste0(from, to, "=X"))  
for (val in 1:length(from))
{
  dbSendQuery(conn,paste0("INSERT INTO FINANCE.FX_EXCHANGE_RATE (trade_time,V_FROM_CURRENCY_CD,V_TO_CURRENCY_CD,N_LAST_EXCHANGE_RATE,N_CHANGE,V_CHANGE_PERCENT,N_OPEN_EXCHANGE_RATE,N_HIGH_EXCHANGE_RATE,N_LOW_EXCHANGE_RATE,ETL_DATE) 
                        VALUES (to_date('", df[val,1], "','YYYY-MM-DD HH24:MI SS'),
                                '", from[val], "',
                                '", to[val], "',
                                '", df[val,2], "',
                                '", df[val,3], "',
                                '", df[val,4], "',
                                '", df[val,5], "',
                                '", df[val,6], "',
                                '", df[val,7], "',
                                to_date('", Sys.time(), "','YYYY-MM-DD HH24:MI SS')
                                )
                        ")
  )  
} 
#Get Query
df_get<-dbGetQuery(conn, "select count(*) from FINANCE.FX_EXCHANGE_RATE where V_FROM_CURRENCY_CD=?","USD")
 
#Read Table
df_read_table <- dbReadTable(conn, "FINANCE.FX_EXCHANGE_RATE")
 


 
