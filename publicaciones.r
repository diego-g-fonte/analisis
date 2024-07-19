# Grafica las longitudes promedio anuales, las desviaciones tipicas anuales y
# la cantidad de trabajos anuales.

setwd("/data/Diego/UNAM/Titulacion/codigo/mio/analisis")
library(jsonlite)
library(ggplot2)
data <- fromJSON("data.json")
data$date <- as.numeric(data$date)

# Extraer solo los titulos y años
titulos_fechas <- l_titulos_fechas <- data[, 2:3]

# Cantidad de trabajos publicados por año
trabajos_anuales <- aggregate(l_titulos_fechas$date,
    by = list(date = l_titulos_fechas$date), length)

# quitar el 2023
trabajos_anuales <- trabajos_anuales[1 : (nrow(trabajos_anuales) - 1), ]

trabajos_anuales <- data.frame(     # cambiar los nombers de las columnas
    fecha = trabajos_anuales$date,
    cantidad = trabajos_anuales$x
)

ggplot(data = trabajos_anuales, aes(x = fecha, y = cantidad)) +
    geom_line()
    ggsave(
        filename = "trabajos_anuales.png",
        width = 5,
        height = 3
    )

# Cantidad de trabajos publicados por año en puntos
ggplot(data = trabajos_anuales, aes(x = fecha, y = cantidad)) +
    geom_point(size = 0.5)
    ggsave(
        filename = "gg_publicaciones_anuales.png",
        width = 5,
        height = 3
    )
