library(httr)
library(jsonlite)
library(tibble)

# API-Anfrage an die DB-Fahrplan API senden
response <- GET("https://api.deutschebahn.com/timetables/v1/plan/8002549",
                add_headers(Accept = "application/json"))

# Überprüfen, ob die API-Anfrage erfolgreich war
if (http_status(response)$category == "Success") {
  # Daten aus der API-Antwort extrahieren
  data <- content(response, as = "text") %>%
    fromJSON(flatten = TRUE)
  
  # Filtern und Transformieren der relevanten Informationen
  ice_data <- data$plan$items$ICE
  connections <- lapply(ice_data, function(x) {
    tibble(train = x$name,
           destination = x$to$name,
           departure = x$departure$datetime,
           platform = x$departure$platform)
  })
  
  # Zusammenstellen der Tabelle mit den ICE-Verbindungen
  ice_table <- bind_rows(connections)
  
  # Ausgabe der Tabelle
  print(ice_table)
} else {
  # Bei einem Fehler bei der API-Anfrage eine entsprechende Meldung ausgeben
  print("Fehler beim Abrufen der Daten.")
}
