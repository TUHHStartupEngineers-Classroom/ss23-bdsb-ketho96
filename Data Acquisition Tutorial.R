library(RSQLite)
library(tidyverse)
library(httr)
library(glue)
library(jsonlite)
library(rvest)
library(purrr)


con <- RSQLite::dbConnect(drv    = SQLite(), 
                          dbname = "Chinook_Sqlite.sqlite")

con %>% 
  dbListTables()

con %>% 
  tbl("Album")

album_tbl <- con %>% 
  tbl("Album") %>% 
  collect()

show(album_tbl)

dbDisconnect(con)

# GET("https://swapi.dev/api/people/?page=3")

get_sw_api <- function(path){
  url <- modify_url(url = "https://swapi.dev", path = glue("/api{path}"))
  resp <- GET(url)
  stop_for_status(resp)
}

resp <- get_sw_api("/people/1")
status_code(resp)

fromJSON(rawToChar(resp$content))

token <- Sys.getenv()
print(token)
Sys.getenv("APPDATA")

resp <- GET(glue("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=WDI.DE&apikey=WHYPGPQBTVZWLXFT"))
fromJSON(rawToChar(resp$content))


url <-  "https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"
read_html(url) %>% 
  html_nodes(css = "#constituents") %>%
  html_table() %>% 
  .[[1]] %>% 
  as_tibble()

url <-  "https://www.imdb.com/chart/top/?ref_=nv_mv_250"
read_html(url) %>% 
  html_nodes(css = "#lister") %>%
  html_table() %>% 
  .[1] %>% 
  as_tibble()

# str_extract("(?<= )[0-9]*(?={\\.\\n})"  
# For explanation expand 
# (?<= ) ist eine sogenannte "lookbehind assertion" und stellt sicher, dass der
# darauf folgende Ausdruck nur dann übereinstimmt, wenn ein Leerzeichen ( ) davor
# steht. Es wird nicht in die eigentliche Übereinstimmung einbezogen.
# 
# [0-9]* sucht nach einer beliebigen Anzahl von Ziffern (0 bis 9). Das * bedeutet,
# dass die Ziffern beliebig oft vorkommen können, einschließlich gar nicht.
# 
# (?={\.\n}) ist eine "lookahead assertion" und stellt sicher, dass der vorherige 
# Ausdruck nur dann übereinstimmt, wenn ihm eine geschweifte Klammer ({) gefolgt 
# von einem Punkt (.) und einem Zeilenumbruch (\n) folgt. Auch dieser Teil wird 
# nicht in die eigentliche Übereinstimmung einbezogen.
# In regulären Ausdrücken wird der Backslash (\) als Escape-Zeichen verwendet, um 
# bestimmte Zeichen mit spezieller Bedeutung zu kennzeichnen. Das Zeichen, das 
# unmittelbar auf den Backslash folgt, wird als Literal interpretiert, anstatt 
# seine spezielle Bedeutung zu haben.
# 
# Im konkreten Fall bedeutet \. im regulären Ausdruck, dass der Punkt (.) als ein 
# Literal interpretiert wird, anstatt seine Standardbedeutung zu haben. 
# Normalerweise würde der Punkt in einem regulären Ausdruck jedes beliebige 
# Zeichen außer einem Zeilenumbruch darstellen. Durch das Voranstellen des 
# Backslashes wird der Punkt jedoch als genau das Zeichen interpretiert, nach dem 
# der Backslash kommt.
  