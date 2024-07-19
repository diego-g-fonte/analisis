# Saca las longitudes promedio de los titulos que tienen dos puntos, la
# longitud antes y despues de los dos puntos y la longitud de los que
# no tienen dos puntos

# FALTA JUNTAR LAS GRAFICAS DE LAS LONGITUDES DE LOS TITULOS CON Y SIN
# DOS PUNTOS
# Y LAS LONGITUDES PROMEDIO DE LO QUE VA ANTES Y LO QUE VA DESPUES
# DE LOS DOS PUNTOS

setwd("/data/Diego/UNAM/Titulacion/codigo/mio/analisis")
library(jsonlite)
library(ggplot2)
data <- fromJSON("tema/data_sin_2023.json")
data$date <- as.numeric(data$date)
colnames(data) <- c("name", "titulo", "fecha")

# Extraer solo los titulos y años
titulos_fechas <- l_titulos_fechas <- data[, 2:3]

# Cambiar los titulos por sus longitudes en caracteres
l_titulos_fechas[, 1] <- nchar(titulos_fechas[, 1])

## longitudes de los titulos sin dos puntos ##

# indices de los titulos con dos puntos
i_dp <- grepl(":", titulos_fechas$titulo) # grepl da resultado logico

# longitudes de titulos sin dos puntos
sin <- l_titulos_fechas[which(i_dp == FALSE), ]

# longitudes promedio anuales de titulos sin dos puntos
p_sin <- aggregate(
    list(sin$titulo),
    list(sin$fecha),
    mean
)
colnames(p_sin) <- c("fecha", "titulo")

## longitudes de los titulos con dos puntos ##

# longitudes de titulos con dos puntos
con <- l_titulos_fechas[i_dp, ]

# longitudes promedio anuales de titulos con dos puntos
p_con <- aggregate(
    list(con$titulo),
    list(con$fecha),
    mean
)
colnames(p_con) <- c("fecha", "titulo")

# graficar con dos puntos y sin dos puntos
p <- ggplot() +
    geom_line(data = p_con, aes(x = fecha, y = titulo, color = "con")) +
    geom_line(data = p_sin, aes(x = fecha, y = titulo))
        ggsave(
        filename = "longitudes_con_y_sin_dos_puntos.png",
        height = 3,
        width = 5
        )