bn <- read.csv("listas/baby-names.csv") # BabyNames
names <- bn$name
names <- names[!duplicated(names)]

file.create("listas/baby-names-2.txt")
writeLines(names, "listas/baby-names-2.txt")