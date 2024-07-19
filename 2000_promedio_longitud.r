setwd("/data/Diego/UNAM/Titulacion/codigo/mio/analisis")
library(jsonlite)
library(ggplot2)
data <- fromJSON("data.json")
data <- data[, 2:3]
data$date <- as.numeric(data$date)
long <- data

# Cambiar los titulos por sus longitudes en caracteres
long$title <- nchar(data$title)

# usar aggregate() para sacar los promedios por año
promedios <- aggregate(
    list(title = long$title),
    list(date = long$date),
    mean,
    names = c("date", "title")
)

# cambiar nombres de las columnas de promedios
promedios <- data.frame(
    fecha = promedios$date,
    longitud = promedios$title
)

# eliminar el 2023
promedios <- promedios[1:nrow(promedios) - 1, ] # nolint: seq_linter.

# grafica longitudes promedio toda la historia
ggplot(promedios, aes(x = fecha, y = longitud)) +
    geom_line()
ggsave(filename = "longitud_promedio.png", width = 5, height = 3)

# extraer solo los datos a partir del año 2000
i_2000 <- which(promedios$fecha == 2000)
promedios_2000 <- promedios[i_2000[1] : nrow(promedios), ]

# graficar longitudes promedio a partir del 2000
ggplot(promedios_2000, aes(x = fecha, y = longitud)) +
    geom_point()
ggsave(filename = "gg_2000_longitudes_promedio.png", width = 5, height = 3)

# con lineas
ggplot(promedios_2000, aes(x = fecha, y = longitud)) +
    geom_line()
ggsave(filename = "2000_longitudes_promedio_lineas.png", width = 5, height = 3)