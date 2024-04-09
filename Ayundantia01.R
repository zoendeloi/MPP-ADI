##### Ayudantía 1 - Introducción a R #####
##### GOB3022 - Análisis de Datos  I #####
## Camila Carrasco (cicarrasco5@uc.cl) ###

## ¿Cómo usar R? ##

# A través de la consola o dentro de un script ejecutamos la/s línea/s que necesitamos.
# Los "#" nos permiten comentar nuestro código y no ejecutar esas líneas.

## R tiene una calculadora

# Podemos sumar con "+"
1 + 2
# Podemos restar con "-"
2 - 3
# Podemos multiplicar con "*"
3 * 4
# Podemos dividir con "/"
4 / 5
# Podemos elevar potencias con "^" o "**"
5 ^ 6
5 ** 6
# Siempre que usemos operaciones aritméticas recordemos
# PA(réntesis)PO(tencia)MU(ltiplicación)D(ivisión)A(dición)S(ustracción)

## Y en más de una dimensión!

# Podemos generar una secuencia de números con ":" o "seq()"
1:3
seq(1,3)

# "Llamamos" a seq(x, y, by = z) para que genere una secuencia de x a y de z en z
seq(2, 8, by = 2)
c(2,4,6,8)

# Estas secuencias o vectores de números se pueden operar
c(2,4,6,8)/2
c(1,0,1,0) + c(0,1,0,1)

## Datos en R

# Podemos tener números enteros, decimales, texto o valores lógicos
3
3.14
"3.14"
"pi"
T
F

# Podemos asignar un valor a una variable con "=" o "<-"
x = 1 
y <- 'uno'

# También podemos asignar vectores enteros!

nombres = c("Roberto","Eduardo","Daniela","Camila")
nombres

# Podemos considerar los vectores como columnas de información
vector1 = c(15,2,35,64,18)
vector2 = c("A","AB","A","O","O")

## Matrices
# Las matrices corresponden a un conjunto de columnas y filas

# Podemos generarla llamando a matrix(seq, nrow = f, ncol = c, byrow = T/F)
# Genera una matriz de f filas y c columnas añadiendo los números
# de la secuencia seq por filas o columnas.

matriz1 = matrix(1:20,4,5,byrow=T)

# Podemos construir una matriz con datos desde una lista
matriz2 = matrix(c(55,28,50,40,18,
                    150000,400000,280000,1200000,750000,
                    "Hombre","Mujer","Mujer","Hombre","Mujer",
                    "Obrero","Servicios","Asistente","Medico","Consultora"),
                  nrow=5, ncol=4,
                  dimnames = list(c(1,2,3,4,5),c("edad","salario","genero","ocupacion")))
matriz2

# ...o uniendo cada columna
edad = c(23, 45, 67, 89)
sexo = c(1, 0, 1, 0)
peso = c(80, 60, 70, 50)
altura = c(180, 160, 200, 140)

matriz3 = cbind(edad, sexo, peso, altura)
matriz3

## Operaciones sobre matrices

imc <- peso / ((altura/100)^2)

matriz4 <- cbind(edad, sexo)
matriz4
matriz5 <- cbind(peso, altura)
matriz5

# Combinar matrices y columnas
matriz <- cbind(matriz4, matriz5, imc)
matriz

# Acceder a elementos de la matriz
matriz[1,2]

## Bases de Datos
# Trabajar una matriz como una base de datos nos entreg muchas más herramientas
# que iremos conociendo en el curso!

data <- as.data.frame(matriz)
data

# Podemos conocer las dimensiones de la base de datos con "dim()"
dim(data)
# Podemos listar las columnas de la base de datos con "names()"
names(data)
# Podemos generar tablas de frecuencia llamando a "table()"
table(data$edad)

## Fijar Directorio 

# En ocasiones necesitamos trabajar con más de un archivo
# debiendo "llamar" otros archivos desde "donde estamos"

# Podemos obtener el directorio actual de trabajo
getwd()
# Y podemos cambiarlo a una nueva ruta o a través del menú
# setwd("ruta")

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
??dyplyr