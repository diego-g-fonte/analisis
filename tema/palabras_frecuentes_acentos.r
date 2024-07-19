# el wdir es /data/Diego/UNAM/Titulacion/codigo/mio/analisis
library(jsonlite)
library(knitr)
data <- fromJSON("tema/data_sin_2023.json")
data <- data[, 2:3]
data$date <- as.numeric(data$date)

# limpiar los titulos. "individuales" porque los elementos son
# palabras individuales
individuales <- strsplit(data$title, "\\W")
individuales <- unlist(individuales)
individuales <- individuales[individuales != "" & individuales != "s"]
individuales <- tolower(individuales)

# ordenar
pal_comunes <- table(individuales)
pal_comunes <- sort(pal_comunes, decreasing = TRUE)

# hacerla data frame y cambiar los nombres de las columnas
pal_comunes <- data.frame(pal_comunes)
pal_comunes <- data.frame(
    palabra = pal_comunes$individuales,
    frecuencia = pal_comunes$Freq
)

# plaintext de las top 1000
pt_pal_comunes <- knitr::kable(pal_comunes[1:1000, ], format = "pipe")

# quitar las stop words
sw <- scan("tema/stop_words.txt", what = "character")   # stop words
cw_comunes <- pal_comunes[!(pal_comunes$palabra %in% sw), ]

# plaintext top 50 content words
pt_cw_comunes <- knitr::kable(cw_comunes[1:50, ], format = "pipe")

# plaintext top 1000 content words
# FALTA AÑADIR MUCHÍSIMAS STOP WORDS
pt_cw_comunes_1000 <- knitr::kable(cw_comunes[1:1000, ], format = "pipe")