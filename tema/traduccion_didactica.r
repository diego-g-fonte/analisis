library(jsonlite)
library(knitr)
library(dplyr)
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

tf[grep("\"", tf$titulo), ]
tf$titulo[grep("\"", tf$titulo)]

tf[grep(", de", tf$titulo), ]

tf[grep("traduccion", tf$titulo), ]
tf[grep("traducciones", tf$titulo), ]

### TRADUCCIÓN ###
# cuales dicen "traduccion" sin decir "traduccion comentada"
tra <- grep("traduccion", tf$titulo)
tra_com <- grep("traduccion comentada", tf$titulo)
tra_secas <- setdiff(tra, tra_com)

tf[tra_com, ]
tf$titulo[tra_secas]
tf[tra_secas, ]

### INGLÉS ###
# cuales dicen "ingles" sin ser de didactica
didactica <- c("enseñanza", "aprendizaje", "didactica", "aula\\b", "aulas\\b",
    "colegio", "universidad", "lengua extranjera", "docente", "docencia",
    "docentes", "preescolar", "primaria", "secundaria", "preparatoria",
    "bachilleres", "bachillerato", "escuela", "ensenanza", "didactico",
    "comprension", "curricular", "facultad de estudios", "examen",
    "examenes", "cch", "c.c.h.", "e.n.p.", "posgrado")
didactica_regex <- paste(didactica, collapse = "|")
# titulos con "ingles"
ingles <- tf[grep("ingles\\b", tf$titulo), ]
# titulos con "ingles" y alguna de didactica
ingles_did <- ingles[grep(didactica_regex, ingles$titulo), ]
# titulos con "ingles" y ninguna de didactica
ingles_secas <- setdiff(ingles$titulo, ingles_did$titulo)

nrow(ingles)

# cuales son de didactica sin decir "ingles"
# ESTO ES UN ERROR PORQUE LAS PALABRAS QUE YO LLAMO DE DIDACTICA NO
# SIEMPRE LO SON, NI LO SON EN UNA PROPORCION NEGLIGIBLE.
did <- tf[grep(didactica_regex, tf$titulo), ]
nrow(did)

did_sin_ing <- did[grep("ingles\\b", did$titulo, invert = TRUE), ]
nrow(did_sin_ing)
did_sin_ing$titulo

### NARRATIVA ###
novel <- tf[grep("novel", tf$titulo), ] # esto matchea novela y novel
novel_n <- nrow(novel) # Novela Número. Cuántas tienen la palabra "novela"

cuento <- tf[grep("cuento|cuenti", tf$titulo), ] # para no matchar encuentros
cuento_n <- nrow(cuento) # Cuento Número

narra <- tf[grep("narra", tf$titulo), ]
narra_n <- nrow(narra) # Narrativa Número

intersect(novel$titulo, cuento$titulo) # no hay titulo que diga novela y cuento
intersect(narra$titulo, cuento$titulo)
intersect(novel$titulo, narra$titulo)

# queda horrible pero las cuentas salen. Hay 140 que dicen
# novel y/o cuento|cuento y/o narra
narrativa <- full_join(novel, cuento, by = join_by(titulo))
narrativa <- full_join(narrativa, narra, by = join_by(titulo))

### POESÍA ###
pp <- tf[grep("|poet|poem|poes", tf$titulo), ] # Poesía y Poética
p <- pp[grep("poetic(o|a)", pp$titulo), ]
p
# Los que son de poética pero no de poesía
# el fin de la parabola
# la cuadratura del círculo
# under the volcano
# el recurso poetico en cuatro novelas experimentales de virgina woolf
