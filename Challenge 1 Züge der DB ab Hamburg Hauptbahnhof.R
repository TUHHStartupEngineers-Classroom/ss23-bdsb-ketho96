library(httr)
library(jsonlite)
library(tibble)

# API Dokumentation: 
# https://developers.deutschebahn.com/db-api-marketplace/apis/product/timetables/api/26494#/Timetables_10213/operation/%2Fplan%2F{evaNo}%2F{date}%2F{hour}/get 

Client_ID <- "0d2d10e480ed413839545d86bd9ebe73"
API_Key <- "73b260c27da328fb225590951c36805e"
evaNo <- "8000148" # Hamburg Hbf
date <- "220930" #YYMMDD
hour <- "10" #10Uhr


r <- GET("https://apis.deutschebahn.com/db-api-marketplace/apis/timetables/v1/plan/{evaNo}/{date}/{hour}",add_headers(.headers = c("DB-Client-Id" = Client_ID, "DB-Api-Key" = API_Key)))


# Überprüfen, ob die API-Anfrage erfolgreich war

sprintf("API Status Code: %i", r$status)
# wirft immer Error 410


