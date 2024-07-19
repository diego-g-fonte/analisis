# el wdir es /data/Diego/UNAM/Titulacion/codigo/mio/analisis
library(jsonlite)
library(ggplot2)
library(knitr)
data <- fromJSON("tema/data_sin_2023.json")
data <- data[, 2:3]
data$date <- as.numeric(data$date)
limpios <- data

# limpiar
limpios$title <- tolower(limpios$title)
limpios$title <- gsub("á", "a", limpios$title)
limpios$title <- gsub("é", "e", limpios$title)
limpios$title <- gsub("í", "i", limpios$title)
limpios$title <- gsub("ó", "o", limpios$title)
limpios$title <- gsub("ú", "u", limpios$title)
limpios$title <- gsub("ü", "u", limpios$title)

## traduccion ##
tra_present <- limpios
tra_present$presente <- grepl("traduccion", tra_present$title)
names(tra_present) <- c("titulo", "fecha", "presente")

sum_tra_present <- aggregate(
    presente ~ fecha,
    data = tra_present,
    FUN = sum
)

# suma traduccion presente positivo (para no tener puntos en donde hubo 0)
sum_tra_present_pos <- sum_tra_present[which(sum_tra_present$presente != 0), ]

# graficar
ggplot(sum_tra_present_pos, aes(x = fecha, y = presente)) +
    geom_point(size = 0.5)
    ggsave(
        filename = "tema/cantidad_traduccion_anual.png",
        height = 2,
        width = 4
    )

## ingles ##
ing_present <- limpios
ing_present$presente <- grepl("ingles", ing_present$title)
names(ing_present) <- c("titulo", "fecha", "presente")

sum_ing_present <- aggregate(
    presente ~ fecha,
    data = ing_present,
    FUN = sum
)

# suma ingles presente positivo (para no tener puntos en donde hubo 0)
sum_ing_present_pos <- sum_ing_present[which(sum_ing_present$presente != 0), ]

# graficar
ggplot(sum_ing_present_pos, aes(x = fecha, y = presente)) +
    geom_point(size = 0.5)
    ggsave(
        filename = "tema/cantidad_ingles_anual.png",
        height = 2,
        width = 4
    )

## analisis ##
ana_present <- limpios
ana_present$presente <- grepl("analisis", ana_present$title)
names(ana_present) <- c("titulo", "fecha", "presente")

sum_ana_present <- aggregate(
    presente ~ fecha,
    data = ana_present,
    FUN = sum
)

# suma analisis presente positivo (para no tener puntos en donde hubo 0)
sum_ana_present_pos <- sum_ana_present[which(sum_ana_present$presente != 0), ]

# graficar
ggplot(sum_ana_present_pos, aes(x = fecha, y = presente)) +
    geom_point(size = 0.5)
    ggsave(
        filename = "tema/cantidad_analisis_anual.png",
        height = 2,
        width = 4
    )