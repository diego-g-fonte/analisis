library(jsonlite)
library(knitr)
library(stringr)
data <- fromJSON("tema/data_sin_2023.json")
data <- data[, 2:3]
data$date <- as.numeric(data$date)
names(data) <- c("titulo", "fecha")

lower <- tolower(data$titulo)

lower <- gsub("á", "a", lower)
lower <- gsub("é", "e", lower)
lower <- gsub("í", "i", lower)
lower <- gsub("ó", "o", lower)
lower <- gsub("ú", "u", lower)
lower <- gsub("ü", "u", lower)

tf <- data.frame(          # Titulo_Fecha
    titulo = lower,
    fecha = data$fecha
)

# lista de nombres propios gringos (Baby Names)
bn <- scan("listas/baby-names-2.txt", what = "character")
bn <- tolower(bn)

# lista de 1000 apellidos gringos (SurNames)
sn <- read.csv("listas/1000_common_surnames_usa.csv") 
sn <- sn$Names
sn <- tolower(sn)

# matchear names en tf$titulo
# ERROR: nada sirve no sé por qué

pattern_n <- paste(bn, collapse = "|")
pattern_s <- paste(sn, collapse = "|")
pattern <- paste("(", pattern_n, ")", " ", "(", pattern_s, ")", sep = "")
indices <- stringr::str_detect(tf$titulo, pattern)

tf$titulo[indices]
