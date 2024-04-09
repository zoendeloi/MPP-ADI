##### Ayudantía 2 - Estad. descript. #####
##### GOB3022 - Análisis de Datos  I #####
## Camila Carrasco (cicarrasco5@uc.cl) ###

# Retomando el final de la ayudantía 1...
## Fijar Directorio 

# En ocasiones necesitamos trabajar con más de un archivo
# debiendo "llamar" otros archivos desde "donde estamos"

# Podemos obtener el directorio actual de trabajo
getwd()
# Y podemos cambiarlo a una nueva ruta o a través del menú
setwd("~/Desktop/2024-1/DATOS/Ayudantías/02")

## Para ir terminando un script

# Podemos guardar nuestros avances en un proyecto o carpeta
# o podemos vaciar el ambiente de programación
rm(list = ls())

## Paquetes en R

# Para conocer la lista de librerias o paquetes instalados usamos
library()

## Para instalar un paquete por primera vez
# install.packages("nombre del paquete")

## Para cagar o llamar al paquete instalado en cada ambiente que se trabaje 
# library(nombre del paquete)

## Librerías más comunes 
install.packages("tidyverse") # Manipular datos
install.packages("dplyr") # Manipular datos
install.packages("stargazer") # Generar tablas en formato académico
install.packages("ggplot2") # Generar gráficos

## Ayuda en R

library(dplyr)
help("dplyr")
??sum

## Importar datos
# Vamos a utilizar tidyverse que contiene el paquete readr

library(tidyverse)

# Los datos pueden tener distintos formatos de codificación
# read_csv() -> Separador ','
# read_csv2() -> Separador ';'
# read_delim() -> Separador cualquiera

df = read_csv('permisos.csv')

dim(df)
colnames(df)
head(df)

###############################
## Estadísticos descriptivos ##
###############################

# Podemos analizar las variables cuantitativas de la base como
# año del vehículo, tasación, valor del permiso, valor de la multa,
# año del permiso

## Tipos de variables
class(df$Marca)
class(df$Ano_Vehiculo)

## Promedio
mean(df$Tasacion) 
mean(df$Tasacion, na.rm = T)#...con o sin valores perdidos

## Mediana
median(df$Valor_Neto)

## Moda (no existe una función directa, pero hay varias opciones)

# Opción 1: Revisar la tabla de frecuencia
tf = table(df$Ano_Permiso)
sort(tf, decreasing = TRUE)

# Opción 2
install.packages("modeest")
library(modeest)
mlv(df$Ano_Permiso, method = "mfv")

## Todas las medidas de tendencia central
summary(df$Valor_Pagado)
quantile(df$Valor_Pagado)

## Varianza
var(df$Valor_IPC)

## Desviación estándar
sd(df$Valor_Multa)

# Análisis visual simple

hist(df$Ano_Vehiculo)
boxplot(df$Ano_Vehiculo)
boxplot(Ano_Vehiculo ~ Ano_Permiso, data = df)

# Visualización con stargazer

install.packages("stargazer")
library(stargazer)

stargazer(df, type = "text", title="Descriptive statistics") 
stargazer(df, type = "text", title="Descriptive statistics", out="Output/table1.txt") 
stargazer(df, type = "html", title="Descriptive statistics", out="Output/table1.doc")
stargazer(df, type = "html", title="Descriptive statistics", out="Output/table2.doc", digits=1)

# Visualización con ggplot2

library(ggplot2)
# La expresión más básica contiene los datos, una variable y el tipo de gráfico
ggplot(df, aes(x=Ano_Vehiculo)) + geom_histogram()

# Dentro del tipo de gráfico podemos agregar aspectos estéticos
ggplot(df, aes(x=Ano_Vehiculo)) + 
  geom_histogram(color="black", fill="white", bins=40)

# También podemos complementar el histograma con una aproximación normal
ggplot(df, aes(x=Ano_Vehiculo)) + 
  geom_histogram(aes(y =..density..),color="black", fill="white", bins=40)+
  stat_function(fun = dnorm, args = list(mean = mean(df$Ano_Vehiculo), sd = sd(df$Ano_Vehiculo)))

# También podemos analizar las variables no numéricas

table(df$Tipo_Combustible)
# Generamos una variable dummy
df$dummy_comb = df$Tipo_Combustible

# Recodificamos según la naturaleza de la variable
df$dummy_comb[df$dummy_comb == 'Benc' | df$dummy_comb == 'BENC'] = 0
df$dummy_comb[df$dummy_comb == 'Dies' | df$dummy_comb == 'DIES'] = 1

# Etiquetamos
df$dummy_comb = factor(df$dummy_comb,
                          levels = c(0,1),
                          labels = c("Bencina", "Diesel"))

# En general las variables categorizadas se analizan en proporción o frecuencia
# así que utilizaremos "prop.table" para la tabla de proporciones
table(df$dummy_comb)
prop.table(table(df$dummy_comb))
prop.table(table(df$dummy_comb))*100

# o podemos utilizar las librerías dplyr y pander y 
# la función "group_by" para las categorías
install.packages("dplyr")
install.packages("pander")

library(dplyr)
library(pander)

df %>%
  group_by(dummy_comb) %>%
  summarize(n = n()) %>%
  mutate(prop = n/sum(n)*100,
        prop = round(prop,1),
        prop = paste(prop, "%", sep="")) %>%
  rename(Combustible=dummy_comb,
        Frecuencia=n,
        Porcentaje=prop) %>%
pander()

# E incluso podemos analizar las variables conjuntamente

df %>%
  group_by(dummy_comb) %>%
  filter(all(!is.na(dummy_comb))) %>%
    summarise(mean=mean(Valor_Pagado),
              sd=sd(Valor_Pagado)) %>%
pander()


ggplot(df, aes(y=Ano_Vehiculo)) +  geom_boxplot()
ggplot(data = filter(df, !is.na(df$dummy_comb)), aes(x=dummy_comb,y=Ano_Vehiculo, color=dummy_comb)) + geom_boxplot()
