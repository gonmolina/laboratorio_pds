---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.1
kernelspec:
  display_name: dsp
  language: python
  name: python3
---

```{code-cell}
import numpy as np
import matplotlib.pyplot as plt
import sympy as sp
%matplotlib inline
```

# Procesamiento Digital de Señales Aplicado a Mediciones

## Repaso y Aspectos Prácticos

### Parte 1

+++

## Motivación 

INCLUIR FIGURAS DE MEDICIONES Y TRANSFORMADAS FOURIER Y CORRELACIONES (AUTOCORRELACIÓN Y CORRELACIÓN CRUZADA)

+++

## Notas del orador

Muchas de las mediciones que se realizan en el área de la ingeniería involucran "procesos estacionarios", en los cuales las variaciones son meros reflejos de fuentes de error aleatorio. Es decir se quiere medir una señal constante que posee ruido.

Sin embargo existen mediciones en las cuales la variación temporal es parte central de la información que queremos obtener.
Para obtener esta información deberemos realizar algún tipo de procesamiento de las mediciones realizadas. 
En algunos casos el simple ajuste de la evolución temporal es suficiente, por ejemplo en crecimientos o decaimientos exponenciales, sin embargo en otros casos es necesario rescatar información subyacente, descomponiendo la señal en componentes. 
En este proceso de descomposición se introducen otras restricciones, en particular se decide qué tipo de componentes se quieren rescatar de la señal (y se descartan otros):
crecimientos exponenciales, oscilaciones senoidales, etc, 
que dependerán de otras consideraciones, por ejemplo los modelos que utilizamos como hipótesis de trabajo. 
El objetivo de este curso es dar una breve introducción al procesamiento de señales temporales obtenidas de mediciones experimentales. 
Haremos foco en el uso de la Transformada Digital de Fourier, la estimación del Espectro de Potencia y el uso de Correlaciones Cruzadas para la identificación de atrasos. 
Esto es solo una pequeña parte de las técnicas que se pueden utilizar, habiendo técnicas de Descomposición Ortogonal Propia, Descomposición en Modos Dinámicos y una gran variedad de métodos dentro de lo que se llama “Inteligencia Artificial”. 
La realidad es que en el presente se están incorporando nuevas técnicas de procesamiento de datos a una velocidad que hace difícil permanecer actualizado, sin embargo las técnicas básicas no solo siguen siendo de gran utilidad sino que son necesarias para el entendimiento de las más sofisticadas.

+++

## Sistema

¿Para que analizamos una señal?

+++

## Notas del orador

La respuesta es “para conocer el sistema que estamos estudiando” 
La idea es que el análisis de la señal nos da información sobre el origen de esta señal. 
Algunos sistemas tienen entradas y salidas.

+++

METER DIAGRAMA DE MEDICIONES Y PROCESAMIENTO DE SEÑALES

+++

## Notas del orador

En el mundo de hoy el uso de computadoras capaces de manejar grandes cantidades de datos hace que la extracción de información de mediciones que varían en el tiempo prácticamente en todos los casos se haga por procesamiento digital. 
Ese procesamiento puede ser en tiempo real, o con posterioridad a la medición. 
En el laboratorio en general lo realizaremos con posterioridad a la medición pero los fundamentos en ambos casos son los mismos. 
Este proceso posee varios pasos. 
El primero es convertir las magnitudes físicas, como por ejemplo elongación, temperatura, velocidad, etc., en señales eléctricas analógicas mediante un transductor.
Esta señal será luego digitalizada para finalmente ser registrada digitalmente en una computadora. 
La digitalización se realiza típicamente mediante un conversor análogo digital, comúnmente denominado A/C o en inglés ADC, que significa Analog to Digital Converter. 
Luego la señal puede ser procesada en esa misma computadora o en otra más apropiada para esa función. 
En muchos casos antes de proceder a la digitalización se realiza un acondicionamiento de la señal, es decir un procesamiento todavía en el “mundo analógico”! En primer lugar se puede acondicionar la señal, es decir amplificar la señal a niveles apropiados para nuestro digitalizador y filtrar el ruido. 
También es muy recomendable (como veremos luego) filtrar las señales antes de digitalizarlas para reducir problemas de generación de alias (que llamaremos “aliasing”), es decir filtraremos las frecuencias que nuestro sistema no sea capaz de digitalizar correctamente por ser excesivamente altas. 
Finalmente tengamos en cuenta que cada vez más trasductores poseen las etapas de procesamiento analógico y de digitalización incorporadas en el propio dispositivo. 
El sistema en definitiva es el mismo pero no tendremos acceso físico a las etapas intermedias.

+++

## consecuencias de la digitazación

- Los valores están cuantizados (solo toman valores discretos)
- Solo disponemos datos a tiempos discretos  $t_i=i\times\Delta t$
- Solo disponemos de una longitud finita de datos

```{code-cell}
t=np.linspace(0, 20, 5100, endpoint=True) # hacer otra señal
x=np.sin(2*np.pi*0.5*t)*2
qx=np.round(x)
er=qx-x
```

```{code-cell}
fig, ax=plt.subplots(2,1, figsize=(10,6))
ax[0].step(t, x, 'b', lw=2, label='señal continua', where='post')
ax[0].step(t, qx, 'r', lw=1, label='señal cuantizada', where='post')
ax[0].set_xlabel('time [seg]')
ax[0].set_ylabel('amplitud señal')

ax[0].grid()
ax[0].legend()
ax[1].step(t, er, where='post')
ax[1].set_ylabel('error')
ax[1].set_xlabel('time [seg]')
ax[1].grid()
```

### Notas del orador

Entonces, cuales son las consecuencias de digitalizar una señal analógica? 
Principalmente hay tres modificaciones respecto de la señal original: 
- los valores se encuentran cuantizados, 
- solo disponemos de valores a tiempos discretos
- finalmente solo disponemos de una longitud finita de datos.

Los últimos dos aspectos causan que varíe la información temporal que podemos extraer de la señal, dando lugar a limitaciones en el rango de frecuencias que podemos detectar a partir de las mediciones. 

Comenzaremos analizando el primer aspecto, que es causado por la resolución limitada de los conversores analógico digitales. 
La resolución de un conversor se expresa como la cantidad de bits que utiliza para cubrir todo el rango de la señal de entrada. 
En general los conversores más rápidos pueden tener una resolución de solo 8 bits mientras que los más precisos pueden superar los 24 bits.
El resultado de la cuantización es el redondeo de la medición hacia los valores discretos que el conversor es capaz de devolver. 
De esta forma la cuantización pude ser  considerada, bajo ciertas condiciones, como una fuente adicional de error aleatorio. 
El error es la diferencia entre el valor digitalizado y el analógico. 
Obviamente que la importancia de este error depende de la resolución del conversor, es decir la cantidad de bits, y del tamaño de la señal respecto del rango de entrada del conversor. 
Si la señal es fluctuante y la fluctuación suficientemente mayor a la resolución del conversor, como en la figura, el error tendrá una distribución uniforme entre -1/2 delta y 1/2 delta, donde delta es la resolución del conversor. 
La distribución de probabilidad en este rango va a ser además uniforme. 
La resolución muchas veces se expresa como el valor de entrada que corresponde al bit menos significativo, LSB en inglés. 
Por ejemplo, en un conversor con un rango de entrada de 10 V y una resolución de 12 bits, el bit menos significativo es 10V/1024 = 0,0098V.  
La desviación estándar del error de cuantización se calcula como la resolución dividido raíz cuadrada de 12, pueden hacer la cuenta realizando la integral entre -0,5 y 0,5 de x^2. Cualquier duda sobre este tema lo hablamos por el chat o luego en Meet.

+++

## Error de cuantización para señales "constantes"

```{code-cell}
t=np.linspace(0, 20, 5100, endpoint=True) # hacer otra señal
x=np.sin(2*np.pi*0.5*t)*0.4+0.7
qx=np.round(x)

fig, ax=plt.subplots(1,1, figsize=(10,3))
ax.step(t, x, 'b', lw=2, label='señal análogica', where='post')
ax.step(t, qx, 'r', lw=1, label='señal cuantizada', where='post')
ax.set_xlabel('time [seg]')
ax.grid()
```

```{code-cell}
print(f"El valor medio de la señal analógica es: {np.mean(x)},\n"+
      f"el valor medio de la señal cuantizada es: {np.mean(qx)},\n"+
      f"y el error es: {np.mean(qx)-np.mean(x)}")
```

```{code-cell}
t=np.linspace(0, 20, 5100, endpoint=True) # hacer otra señal
x=np.sin(2*np.pi*0.5*t)*0.4+0.7+np.random.uniform(low=-0.5, high=0.5, size=t.shape[0])
qx=np.round(x)

fig, ax=plt.subplots(1,1, figsize=(10,3))
ax.step(t, x, 'b', lw=2, label='señal continua', where='post')
ax.step(t, qx, 'r', lw=1, label='señal cuantizada', where='post')
ax.set_xlabel('time [seg]')
ax.grid()
```

```{code-cell}
print(f"El valor medio de la señal continua es: {np.mean(x)},\n"+
      f"el valor medio de la señal cuantizada es: {np.mean(qx)},\n"+
      f"y el error es: {np.mean(qx)-np.mean(x)}")
```

```{code-cell}

```

### Notas del orador

Hay un caso en que la cuantización puede generar un error mayor a uno sobre raíz de doce: cuando una señal es constante o al menos tiene fluctuaciones menores a la resolución del conversor. 
En este caso el error es del orden de la mitad de la cuantización. 
En la figura de la izquierda vemos un caso de una señal que fluctúa pero dentro del rango de cuantización. 
Para este ejemplo asumimos que la cuantización es a números enteros, aunque por supuesto los niveles de cuantización variarán dependiendo de cada situación. 
Si calculamos el error como la diferencia entre el valor medio de la señal cuantizada y el valor medio de la señal original , tenemos en este caso, de -0,22. 
Si bien normalmente queremos reducir a un mínimo el ruido en una señal, en este caso el agregado de ruido uniforme con un rango entre -0,5 y 0,5 permite obtener una mayor alternancia entre los valores cuantificados por encima y debajo de la señal analógica, resultando, en promedio, en una mejor representación de la señal original! 
Como resultado el error del valor medio se reduce a 0,032! Algunas placas de adquisición poseen la opción de agregar ruido blanco a la señal de entrada para lograr esta mejora.

+++

## ejercicio
- Generar una señal entre 0 y 5 de al menos 1000 elementos. (puede ser una senoidal o cualquier otra señal fuctuante que se les ocurra, que tenga muchos ciclos)
- graficar la señal
- calcular la desviación estandard
- cuantizar esa señal a valores enteros
- graficar la nueva señal
- calcular la desviación estandard

Responder:
¿Se cumple que la cuantización aporta $\sigma_q=\dfrac{\Delta}{\sqrt{12}}$?

+++

### Notas del orador

Para fijar conocimientos vamos a hacer una prueba sencilla. La pueden hacer en Python usando nunpy. 
Generen una señal con precisión “double” y luego la cuantifican, por ejemplo con la función “round”. 
Estiman la desviación estándar antes y después y ven si la diferencia corresponde a delta dividido raiz de 12. 
Fíjense que la desviación estándar de la señal y el error de cuantización se suman cuadráticamente!

+++

### solución del problema anterior

```{code-cell}
import scipy as sc

dta = 0.001
Ta=20
Na = int(Ta/dta)
ta=np.linspace(0,Ta,Na+1)
ta=ta[:-1]

f1=1.2
f2=3.15
noise = np.random.uniform(-0.5,0.5, Na)
sa_disc = np.sin(2*np.pi*f1*ta)+ np.sin(2*np.pi*f2*ta) + noise
sa_disc = 5* (sa_disc-np.min(sa_disc))/(np.max(sa_disc)-np.min(sa_disc))
sa = sc.interpolate.interp1d(ta, sa_disc)   # sa(a) es una función que le entra a y saca un valor interpolado 
                                            # linealmente entre los punto de ta que si conoce. Una locura!


sd1=np.std(sa_disc)
sd2=np.std(np.round(sa_disc))
sd3=np.sqrt(sd2**2-sd1**2)
sd4=np.sqrt(1/12)

print(f"desv.std. con ruido continua: {sd1} \n"+
      f"desv std. con ruido cuatizada: {sd2}\n"+
      f"desv. std. diferencia: {sd3}\nteórico: {sd4}")
```

## Digitalización de señales
- los valores están cuantizados
- solo disponemos de datos a tiempos discretos.
- solo disponemos de una longitud finita de datos

### Notas del orador

Entonces ya vimos el problema que introduce la cuantización de los valores y vamos a seguir con los otros problemas que genera la digitalización. 
Ahora vamos a pensar en el segundo punto, que solo dispondremos de datos a tiempos discretos.

+++

## Digitalización de señales 

Ejemplo

```{code-cell}
ta = 0.001 # sample time
Ta=20  # total signal time
Na = int(Ta/dta)+1 # +1 para agregar el punto final
ta=np.linspace(0,Ta,Na, endpoint=True) # agreo el punto final

f1=0.5
f2=0.05
noise = np.random.uniform(-0.2,0.2, Na)
atraso=.5
sa_disc = np.sin(2*np.pi*f1*(ta+atraso))+ np.sin(2*np.pi*f2*(ta+atraso)) + noise
sa = sc.interpolate.interp1d(ta, sa_disc)   # sa(a) es una función que le entra a y saca un valor interpolado 
                                            # linealmente entre los punto de ta que si conoce. Una locura!


_, ax = plt.subplots(1,1, figsize=(10,4))
ax.plot(ta, sa(ta))
ax.set_xlabel("tiempo [seg]")
ax.set_ylabel("Amplitid de la señal ruidosa")
ax.set_title("Señal ruidosa")
ax.grid()
```

### Notas del orador

Supongamos entonces un caso de una señal periódica con dos componentes de diferentes frecuencias y algo de ruido “blanco”. 
A partir de esta señal vamos a pensar qué limitaciones puedo encontrar durante el proceso de digitalización y cuánto afecta a la información que poseía la señal original.

Durante el curso se espera que cada uno siga los ejemplos copiando las líneas y ejecutándolas en Python. De esta forma se espera que cada uno pueda probar algunas modificaciones y ver en el momento los efectos.

Como obviamente no podemos generar señales analógicas en el entorno de Python, utilizaré una señal con una resolución alta en tiempo y en magnitud, haciendo las veces de señal analógica.  
Luego probaremos qué sucede cuando muestreamos esta señal, simulando el proceso de digitalización.

Nuestra señal de alta resolución la llamaremos “sub a”. 
En este ejemplo tomamos una señal de 20 segundos de duración, con una resolución temporal de 1 ms y los valores serán de una precisión doble. 
La primera señal que vamos a utilizar se compone de dos senoidales con frecuencias de 0.5 Hz y de 0.05 Hz mas ruido blanco. 
Se llama ruido blanco a una señal aleatoria que pose un espectro con una distribución uniforme en todas las frecuencias. (FALTA EXPLICAR QUE CARAJO ES EL ESPECTRO DE POTENCIAS)
En `numpy` se puede generar desde el módulo `random` con la función `uniform` y los parámetros de valores máximos y mínimos esperados. En este ejemple usamos los valores entre 0 y 1 y una cantidad de elementos N_a. 
No coloco unidades en el eje vertical porque en este caso no me interesa qué tipo de señal estoy procesando.
Vemos en esta figura que tenemos un solo ciclo completo de la frecuencia menor y 10 de la frecuencia mayor.

+++

### Alta resolución temporal

```{code-cell}
fs1=3  # muestreo a una frecuencia multiplo de la señal que generé para evitar la interpolación
dts1=1/fs1 
ts1=np.linspace(0, Ta, int(20/dts1)+1, endpoint=True) # incluye el 20
#ts1=ts1[:-1] # ahora ya no incluye el 20
sd1=sa(ts1)

f, ax = plt.subplots(1, 1, figsize=(8,4))
ax.plot(ta, sa(ta))
ax.grid()
ax.set_xlabel('Time [s]')
ax.plot(ts1, sd1, 'ko' )
```

### Notas del orador

Ahora veamos qué sucede si digitalizamos la señal. 
Por ahora suponemos que no perdemos precisión pero sí resolución temporal. 
En este caso la frecuencia de muestreo, f sub d, es de 3 muestras por segundo. 
Las muestras en S sub d las obtenemos mediante la función interp1, que en realidad es excesivamente costosa para lo que estamos haciendo pero en este caso estoy sacrificando eficiencia para ser mas claro, creo. 
Eso nos da unos pocos puntos por ciclo de la frecuencia mas alta (6), pero más que suficientes para seguir la evolución de la señal. 
Obviamente parte del ruido blanco sigue existiendo en la medición, ya que ninguno de los puntos estará exactamente sobre la señal pura que obtendríamos sin agregar el ruido en S_a.

+++

## Limite de detección

```{code-cell}
fs1=1  # muestreo a una frecuencia multiplo de la señal que generé para evitar la interpolación
dts1=1/fs1 
ts1=np.linspace(0, Ta, int(20/dts1)+1) # incluye el 20
#ts1=ts1[:-1] # ahora ya no incluye el 20
sd1=sa(ts1)

f, ax = plt.subplots(1, 1, figsize=(8,4))
ax.plot(ta, sa(ta))
ax.grid()
ax.set_xlabel('Time [s]')
ax.plot(ts1, sd1, 'ko' )
```

Teorema del mustreo y concusión de la frecuencia máxima que se puede reconstruir usando este teorema.

+++

### Notas del orador
Ahora si continuamos reduciendo la frecuencia de muestreo f sub d hasta hacerla 1, vemos que todos los puntos caen aproximadamente sobre la funcion senoidal correspondiente a la frecuencia más baja. 
Seguimos viendo el efecto del ruido ya que los puntos no caen exactamente sobre esa función, pero hemos perdido totalmente la información correspondiente a la fluctuación senoidal de frecuencia más alta. 
Notemos que la frecuencia de muestreo (o de digitalización) es el doble de la frecuencia de esa senoidal. 
Es decir, para poder ver una componente de cierta frecuencia tenemos que utilizar una frecuencia de muestreo mayor al doble. 
A esto se le llama el teorema del muestreo, que básicamente estipula que para conservar la información de una señal de una frecuencia dada se debe muestrear con al menos el doble de la frecuencia de interés.
Puesto de esta forma, un tanto aproximada, pareciera que la frecuencia de muestreo debería ser mucho mayor al doble de la frecuencia que quiero conservar para que la reconstrucción realmente funcione. 
Esto es cierto para una señal como la que tenemos en la figura!!!!! Pero el teorema de muestreo considera señales de una longitud temporal infinita y por lo tanto la información para la reconstrucción se compila de una cantidad de datos infinitos, por lo cual el limite está impuesto exactamente por la frecuencia de Nyquist.

+++

## Aliasing

```{code-cell}
fs2=.7 # muestreo a una frecuencia multiplo de la señal que generé para evitar la interpolación
dts2=1/fs2 
ts2=np.linspace(0, Ta, int(Ta/dts2)+1) # incluye el 20
sd2 = sa(ts2)

f, ax = plt.subplots(1, 1, figsize=(8,4))
ax.plot(ta, sa(ta))
ax.grid()
ax.set_xlabel('Time [s]')
ax.plot(ts2, sd2, 'yo' )
```

### Notas de orador

La siguiente pregunta es “qué sucede si reduzco aún más la frecuencia de muestreo?” 
Ahora vamos a reducir aún más la frecuencia de muestreo, a un valor de 0,7 muestras por segundo. 
Ahora las muestras vuelven a mostrar información relacionada con ambas componentes, la de 0.05 Hz y la de 0.5 Hz. 
Sin embargo no podemos reconstruir la señal de alta frecuencia a partir de estos datos. 
De hecho vamos a ver que podemos ajustar los puntos con una señal construida a partir de dos senoidales pero una de ellas de una frecuencia menor.

+++

## Aliasing (cont.)

Puedo ajustar los puntos con f3-f_d, es decir, reemplazo la frecuencia más alta por su “espejo” (cambia la fase también 180º ó π)

```{code-cell}
fs3=.5 # muestreo a una frecuencia multiplo de la señal que generé para evitar la interpolación
dts3=1/fs3 
ts3=np.linspace(0, Ta, int(Ta/dts3)+1) # incluye el 20
sd3 = sa(ts3)

s_al=np.sin(2*np.pi*ta*(f1-fs3))+np.sin(2*np.pi*ta*f2)+1

f, ax = plt.subplots(1, 1, figsize=(8,3))
ax.plot(ta, sa(ta))
ax.plot(ts3, sd3, 'ok')
ax.plot(ta, s_al, 'r' )
ax.grid()
ax.set_xlabel('Time [s]');
```

## Notas del orador

Si bien los puntos se pueden ajustar bien mediante la señal original, obviamente, también se pueden ajustar mediante una nueva función compuesta por la frecuencia menor, de 0,05 Hz y otra menor a la original de 0,5 Hz. 
De hecho la nueva componente es menor también a la frecuencia de Nyquist y es f1 – f_d. 
De hecho esta frecuencia es negativa, lo cual puede interpretarse como un cambio de fase de 180° o 2π. 
Evidentemente para poder continuar este análisis vamos a tener que utilizar una herramienta matemática que nos permita ver qué pasa con los componentes de la señal cuando es muestreada. 
Esa herramienta es la Transformada de Fourier. Continuaremos entonces hablando sobre la Transformada de Fourier y luego volveremos sobre este tema pero utilizando la Transformada de Fourier como herramienta.

+++

### Ejercicios

- Correr los “scripts” de Matlab de las filminas anteriores pero con las siguientes modificaciones:
    - Modificar la fase a cada una de las funciones seno que constituyen la señal que simula ser analógica y ver qué sucede con los diferentes muestreos.
    - Agregar a la señal una componente cosenoidal con frecuencia igual a la tasa de muestreo f sub.
    - Realizar algunas pruebas modificando las frecuencias f1, f2 y f sub d.

+++

### Notas del orador

Antes de continuar les pido que corran los “scripts” de las filminas anteriores en Python. 
La primera prueba que deben realizar es agregar una fase a cada una de las funciones seno que constituyen la señal que simula ser analógica y ver qué sucede. 
Luego agregar a la señal una componente cosenoidal con frecuencia igual a la tasa de muestreo f sub d.
También deberán realizar algunas pruebas modificando las frecuencias f1, f2 y f sub d.

```{code-cell}

```
