# Grafica las longitudes promedio anuales, las desviaciones tipicas anuales y
# la cantidad de trabajos anuales.

setwd("/data/Diego/UNAM/Titulacion/codigo/mio/analisis")
library(jsonlite)
library(ggplot2)
data <- fromJSON("tema/data_sin_2023.json")
data$date <- as.numeric(data$date)

# Extraer solo los titulos y años
titulos_fechas <- l_titulos_fechas <- data[, 2:3]

# Cambiar los titulos por sus longitudes en caracteres
l_titulos_fechas[, 1] <- nchar(titulos_fechas[, 1])

# Sacar las longitudes promedio por año
promedios <- aggregate(l_titulos_fechas[, 1],
    list(date = l_titulos_fechas[, 2]), mean)

# Graficar y sacar un png de los promedios anuales
png("promedio_longitud_anual.png")    # HAY QUE BORRAR ESTO Y HACERLO EN GGPLOT
plot(promedios, type = "l")           # HAY QUE BORRAR ESTO Y HACERLO EN GGPLOT
dev.off()                             # HAY QUE BORRAR ESTO Y HACERLO EN GGPLOT

# Graficar y sacar un png de las standard deviations anual es
sd_titulos_fechas <- aggregate(
    list(title = l_titulos_fechas$title),
    list(date = l_titulos_fechas$date),
    sd,
    )

# cambiar los nombres
sd_titulos_fechas <- data.frame(
    fecha = sd_titulos_fechas$date,
    desviacion_estandar = sd_titulos_fechas$title
)
# extraer solo los datos a partir del año 1980
i_2000 <- which(sd_titulos_fechas$fecha == 1980)
sd_2000 <- sd_titulos_fechas[i_2000[1] : nrow(sd_titulos_fechas), ]

# graficar desviacion estandar a partir del 2000
ggplot(sd_2000, aes(x = fecha, y = desviacion_estandar)) +
    geom_line()
    ggsave(
        filename = "sd_longitud_promedio.png",
        width = 5,
        height = 3
    )

# Cantidad de trabajos publicados por año
trabajos_anuales <- aggregate(l_titulos_fechas$date,
    by = list(date = l_titulos_fechas$date), length)
png("trabajos_anuales.png")
plot(trabajos_anuales, type = "l")
dev.off()

# Cantidad de trabajos publicados por año en puntos
ggplot(data = trabajos_anuales, aes(x = date, y = x)) +
    geom_point(size = 0.5)
    ggsave(
        filename = "gg_publicaciones_anuales.png",
        width = 5,
        height = 5
    )
