
# PARA INSTALAR EL ARCHIVO DE ANALISIS VUELOS
install.packages("nycflights13")

#cargando paquete del archivo
library(nycflights13)

#tidyverse ayuda a visualizar importar modelar datos
library(tidyverse)

#carga la base de datos
nycflights13::flights
#esto para exportar base de datos a excel
write.csv(flights, "base_datos.csv")

#Para ver el conjunto de datos completo
View(flights)

#ejemplo de filtro   filter(nombre_datos, seleccion_de_columna_datos.....)
filter(flights, month == 1, day == 1)

#ejemplo el signo $ es para ver datos especificos de una columna
flights $distance

#--------------------------------------------------------
#ejercicios

#1. Tuvo_un_retraso_de_llegada_de_dos_o_más_horas.
retraso_llegada<- filter(flights, arr_delay >= 2)

#2. Voló a Houston ( IAHo HOU)

volo_a_houston <- filter(flights, dest == "IAH" | dest == "HOU")



# -----------------------------------------------

#ejemplos:
#arrange ordena de menor a mayor las variables que se desean 
prueba2<-arrange(flights, year, month, day)

#Use desc()para reordenar por una columna dd mayor a menor:

orden_des <-arrange(flights, desc(dep_delay))


#--------------------------------------------------------
# 5.3.1 Ejercicios


# 1.  is.na se usa para filtrar todos los datos que contengan N/A
orden_des_2 <- arrange(flights,desc(is.na(dep_delay)))

# 2."encontrar los vuelos más retrasados"
vuelos_retraso_salida <- arrange(flights, desc(dep_delay))
#Encuentra los vuelos que salieron antes.
vuelos_salieron_antes <- arrange(flights, dep_delay)


# 3. velocidad más alta

#para la velocidad max debe ser distancia la mayor  y hora la menor  v=m/s 
velocidad_alta <- arrange(flights, desc(distance) / hour)
velocidad_alta2 <- arrange(flights, desc(distance)  , hour)

# 4. ¿Qué vuelos viajaron más lejos? ¿Cuál viajó menos?

mas_recorrido <- arrange(flights, desc(distance))
#¿Cuál viajó menos?
menoss_recorrido <- arrange(flights, distance)


#--------------------------------------------------------
# 5.4.1 Ejercicios

#funcion select es para seleccionar columnas
seleccion <-select(flights, arr_delay, dest)

# 2.  
#¿Qué sucede si incluye el nombre de una variable
#varias veces en una select()llamada?
# respuesta= sobreescribe los datos de la misma columna 
seleccion3 <-select(flights, arr_delay, arr_delay)

#3 ¿ Qué hace la any_of()función? ¿Por qué podría ser útil 
# junto con este vector?

#vars es el nombre del vector 
vars <- c("year", "month", "day", "dep_dela", "arr_delay")

#la funcion any_of entrega los datos del emcabezado del vector 
# importados del dataset
funcion_any <- select(flights, any_of(vars))

# 4. Cómo tratan los ayudantes selectos el caso de forma predeterminada?
#¿Cómo se puede cambiar ese valor predeterminado?

#esto filtra todas las columnas que dicen time
prueba<-select(flights, contains("TIME"))


#--------------------------------------------------------
# 5.5.2 Ejercicios

# 1.   Conviértalos a una representación más conveniente de 
#la cantidad de minutos 

#la funcion mutate sirve para agregar datos o colunmas al dataset original
vuelos_dataset <- mutate(flights, salida_programada_min = 
                           (sched_dep_time / 100 * 60))

vuelos_dataset <- mutate(vuelos_dataset, tiempo_espera_min =
                           (dep_time / 100 * 60))
#ver desde la media noche
media_noche <- arrange(vuelos_dataset, desc(salida_programada_min))

# 2. Comparar air_timecon arr_time - dep_time. Que esperas ver? ¿Que ves?
#¿Qué necesitas hacer para arreglarlo?

#seleccionar para ver las tres variables y determinar que sucede
seleccionar <- select(vuelos_dataset, air_time, arr_time , dep_time)

#Que esperas ver?---------
#que al tomar la diferencia  de air_time con  (arr_time - dep_time) den
#resultados parecidos

tiempo_vuelos <- mutate( vuelos_dataset , tiempo_en_aire_2  = 
                           arr_time  -  dep_time )
#¿Que ves?---------
#al comparar air time con tiempo_en_aire_2 se ven diferencias muy significativas

#¿Qué necesitas hacer para arreglarlo?---------
# la diferencia entre hora de llegada y hora de salida no coincide porque
#la variable tiempo en el aire esta en minutos por lo cual debemos calcular
#dicha diferencia con el mismo tipo de datos

tiempo_vuelos <- select(mutate( vuelos_dataset , tiempo_en_aire_2  = 
                           (arr_time/100)*60  -  (dep_time/100)*60 ) ,
                        air_time, tiempo_en_aire_2)
#aunque siguen existiendo diferencias, se observa que son mas reducidas 
#que en el primer calculo en variables en min y h


#--------------------------------------------------------

