# SE LLAMA NOMBRES_PROPIOS PORQUE EL OBJETIVO INICIAL ERA ESTUDIAR CUALES
# NOMBRES PROPIOS APARECÍAN EN LOS TÍTULOS Y CUÁLES, PARA VER QUÉ AUTORXS
# SE ESTUDIAN Y CUÁNDO, PERO IT DEVOLVED INTO UN ARCHIVO QUE BÁSICAMENTE USO
# COMO UN CTRL+F. LUEGO ENCONTRÉ LO DE TRADUCCIÓN Y DIDÁCTICA Y MIGRÉ AL
# ARCHIVO TRADUCCIÓN_DIDÁCTICA.R.
# ÉSTE ESTÁ MÁS O MENOS ABANDONADO

library(jsonlite)
library(knitr)
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

tf[grep("joyce carol", tf$titulo), ]
tf[grep("carson mccullers", tf$titulo), ]
tf[grep("colegio de ciencias", tf$titulo), ]
tf[grep("en ingles", tf$titulo), ]

nrow(tf[grep("poet|poem|poes", tf$titulo), ])
nrow(tf[grep("novel", tf$titulo), ])

# para comparar
a <- tf$titulo[grep("novela", tf$titulo)]
b <- tf$titulo[grep("novel", tf$titulo)]
setdiff(b, a)

# poesía sin poética
pp <- tf[grep("poetico|poet|poem|poes", tf$titulo), ] # Poesía y Poética
p <- pp[grep("poetica", pp$titulo), ]



tf[grep("\"", tf$titulo), ]
tf$titulo[grep("\"", tf$titulo)]

tf[grep(", de", tf$titulo), ]

tf[grep("\\bde\\b", tf$titulo), ]

# cuales dicen "traduccion" sin decir "traduccion comentada"
tra <- grep("traduccion", tf$titulo)
tra_com <- grep("traduccion comentada", tf$titulo)
tra_secas <- setdiff(tra, tra_com)

tf[tra_com, ]
tf$titulo[tra_secas]
tf[tra_secas, ]

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
did <- tf[grep(didactica_regex, tf$titulo), ]
nrow(did)

did_sin_ing <- did[grep("ingles\\b", did$titulo, invert = TRUE), ]
nrow(did_sin_ing)
did_sin_ing$titulo
