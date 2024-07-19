library(jsonlite)
library(ggplot2)
data <- fromJSON("data.json")
data$date <- as.numeric(data$date)
titulos_fechas <- c_titulos_fechas <- data[, 2:3]

# check if '"' is present in each title
c_titulos_fechas$c_present <- grepl("\"", titulos_fechas$title)

# calculate percentage of titles with 'n' for each year
percent_c <- aggregate(c_present ~ date,
    data = c_titulos_fechas, FUN = function(x) {
        mean(x) * 100
        })

# cambiar los nombres
percent_c <- data.frame(
    fecha <- percent_c$date,
    porcentaje <- percent_c$c_present
)

# quitar 2023
# extraer solo los datos a partir del año 1980
i_2023 <- which(percent_c$fecha == 2023)
sin_2023 <- percent_c[1 : (i_2023[1] - 1), ]
names(sin_2023) <- c("fecha", "porcentaje")

# Graficar y sacar un png de los promedios anuales
ggplot(sin_2023, aes(x = fecha, y = porcentaje)) +
    geom_line()
    ggsave(
        filename = "porcentaje_c.png",
        height = 3,
        width = 5
    )
