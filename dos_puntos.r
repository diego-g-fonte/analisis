# Grafica y png del porcentaje anual de titulos con dos puntos

setwd("/data/Diego/UNAM/Titulacion/codigo/mio/analisis")
library(jsonlite)
library(ggplot2)
data <- fromJSON("data.json")
data$date <- as.numeric(data$date)
titulos_fechas <- dp_titulos_fechas <- data[, 2:3]

# check if 'n' is present in each title
dp_titulos_fechas$dp_present <- grepl(":", titulos_fechas$title)

# calculate percentage of titles with 'n' for each year
percent_dp <- aggregate(dp_present ~ date,
    data = dp_titulos_fechas, FUN = function(x) {
        mean(x) * 100
        })

# cambiar los nombres
percent_dp <- data.frame(
    fecha <- percent_dp$date,
    porcentaje <- percent_dp$dp_present
)

# quitar 2023
# extraer solo los datos a partir del año 1980
i_2023 <- which(percent_dp$fecha == 2023)
sin_2023 <- percent_dp[1 : (i_2023[1] - 1), ]
names(sin_2023) <- c("fecha", "porcentaje")

# Graficar y sacar un png de los promedios anuales
ggplot(sin_2023, aes(x = fecha, y = porcentaje)) +
    geom_line()
    ggsave(
        filename = "porcentaje_dp.png",
        height = 3,
        width = 5
    )
