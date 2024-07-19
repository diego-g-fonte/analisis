### Qué hace qué ###

[YA ES EL 2024, CREO QUE LO QUE TIENE SENTIDO ES USAR LOS DATOS DE 1962 A 2023. NADA DEL 2024. HAY QUE CORRER TODO OTRA VEZ]

ANALISIS:
    **data.json** [ACTUALIZAR]
        json de todos los títulos + autorx + año de publicación desde 1962 - 2023
    **2000_promedio_longitud.r**
        longitud_promedio.png                   - Longitudes promedio por año de los títulos en caracteres (línea)
        gg_2000_longitudes_promedio.png         - Longitudes promedio por año de los títulos en caracteres a partir del año 2000 (puntos)
        gg_2000_longitudes_promedio.png         - " (línea)
    **comillas.r**
        porcentaje_c.r                          - porcentaje de títulos por año con el caracter ". No estoy seguro de que funcione (línea)
    **dos_puntos.r**
        porcentaje_dp.r                         - porcentaje de títulos por año con el caracter :. Tampoco estoy seguro de que funcione. dice que extrae
                                                  los datos a partir de 1980, pero las gráficas empiezan desde 1960 (línea)
    **function_words.r**
        FALTA GRAFICAR                          - Se supone que saca las 5 palabras más usadas cada año en los títulos. No funciona nada
    **longitud.r**  # Esto es de lo primero que hice, entonces las gráficas o son redundantes o necesitan ser hechas bonitas.
        promedio_longitud_anual.png             - lo mismo que "longitud_promedio.png" pero sin ggplot (línea)
        sd_longitud_promedio.png                - desviación estándar de las longitudes de un año (línea)
        trabajos_anuales.png                    - cantidad de trabajos por año (línea)
        gg_publicaciones_anuales.png            - cantidad de trabajos por año (puntos)
    **longitudes_dos_puntos.r** [INCOMPLETO]
        longitudes_con_y_sin_dos_puntos.png     - longitudes promedio por año de títulos con dos puntos vs sin dos puntos (línea)
    **publicaciones.r**
        trabajos_anuales.png                    - cantidad de trabajos anuales [DUPLICADO EN "longitud.r", PERO AQUÍ USANDO GGPLOT]
        gg_publicaciones_anuales.png            - DUPLICADO EN "longitud.r"

ANALISIS/LISTAS
    Creo que todo esto es obsoleto

ANALISIS/TEMA
    **content_words_historia.r**
        cantidad_traduccion_anual.png           - cantidad total de títulos con la palabra "traduccion"
        cantidad_ingles_anual.png               - cantidad total de títulos con la palabra "ingles"
        cantidad_analisis_anual.png             - cantidad total de títulos con la palabra "anual"
    **nombres_2.0.r**
        [NO SIRVE NADA NO SÉ POR QUÉ]
    **nombres_propios.r**
        Se llama nombres_propios porque el objetivo inicial era estudiar cuáles nombres propios aparecían en los títulos y cuáles, para ver
        qué autorxs se estudian y cuándo, pero it devolved into un archivo que básicamente uso como un ctrl+f. Luego encontré lo de traducción
        y didáctica y migré al archivo traduccion_didactica.r. Éste está más o menos abandonado.
    **palabras_frecuentes_acentos.r**
    **palabras_frecuentes.r**
    **traduccion_didactica.r**