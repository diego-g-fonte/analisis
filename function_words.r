# Saca las 5 palabras más usadas en cada año.
# Hace falta pensar cómo visualizarlo para que
# sea información relevante.

setwd("/data/Diego/UNAM/Titulacion/codigo/mio/analisis")
library(jsonlite)
library(tidytext)
library(dplyr)
data <- fromJSON("data.json")
tf <- data[, 2:3]  #titulos fechas

# First, unnest the sentences into individual words
tf_words <- tf %>%
  unnest_tokens(word, title)

# Next, group the data by year and word and count the frequency
tf_wordscount <- tf_words %>%
  group_by(date, word) %>%
  summarise(freq = n()) %>%
  ungroup()

# Finally, get the most common words per year
tf_most_common <- tf_words_count %>%
  group_by(date) %>%
  top_n(5, freq) # Change 5 to the desired number of most common words

# Excluir lo anterior al 2000
tf_most_common_recent <- tf_most_common %>%
    filter(date >= 2000)

# View the result
print(tf_most_common_recent, n = nrow(tf_most_common_recent))
