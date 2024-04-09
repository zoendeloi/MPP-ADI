library(dplyr)
library(tidyverse)
library(modeest)

# TAREA 1

## Pregunta 1

### Parte a

Ciudad <- c("Paris",
            "Zurich",
            "Estambul",
            "Montevideo",
            "Barcelona",
            "Oslo",
            "Londres",
            "Santiago")

Tamano <- c("Grande",
            "Mediana",
            "Grande",
            "Pequeña",
            "Mediana",
            "Mediana",
            "Grande",
            "Grande")

Ingreso <- c(60000,
             75000,
             38000,
             40000,
             58000,
             72000,
             58000,
             45000)

Criminal_index <- c(65,
                    30,
                    58,
                    30,
                    35,
                    25,
                    30,
                    38)

Air_quality <- c(6.8,
                 8.0,
                 6.7,
                 7.0,
                 7.5,
                 7.8,
                 7.0,
                 6.3)

Development_lvl <- c("Alto",
                     "Alto",
                     "Medio",
                     "Bajo",
                     "Medio",
                     "Alto",
                     "Alto",
                     "Medio")

df <- data.frame(Ciudad = Ciudad,
                 Tamaño = Tamano,
                 "Ingreso USD" = Ingreso,
                 "Indice Criminalidad" = Criminal_index,
                 "Calidad Aire" = Air_quality,
                 "Nivel Desarrollo" = Development_lvl)

head(df)

### Parte b
summary(df[c(3,4,5)])

apply(df[c(3,4,5)], 2, mlv, method = 'mfv')

var(df$Ingreso.USD)
var(df$Indice.Criminalidad)
var(df$Calidad.Aire)

sd(df$Ingreso.USD)
sd(df$Indice.Criminalidad)
sd(df$Calidad.Aire)

### Parte c

prop.table(table(df$Tamaño))*100
prop.table(table(df$Nivel.Desarrollo))*100


## Pregunta 2

### Parte a
library(ggplot2)
ggplot(df, aes(Ingreso,
               Indice.Criminalidad,
               color = Ciudad)) +
  geom_point(size = 4) +
  labs(title = "Ingreso vs Calidad de aire",
       x = "Ingreso (USD)",
       y = "Indice de Criminalidad")

cor(df$Ingreso.USD, df$Indice.Criminalidad) # -0.3563189

### Parte b

ggplot(df, aes(Ingreso,
               Calidad.Aire,
               color = Ciudad)) +
  geom_point(size = 4) +
  labs(title = "Ingreso vs Calidad de aire",
       x = "Ingreso (USD)",
       y = "Indice de Criminalidad")

cor(df$Ingreso.USD, df$Calidad.Aire) # 0.8066411


