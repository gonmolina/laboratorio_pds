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

```{code-cell} ipython3
import numpy as np
import scipy as sc
import matplotlib.pyplot as plt
%matplotlib widget
```

# Cuaderno clase 1

Vamos a generar una señal senoidal de frecuencia 2kHz y duración 5 segundos muestreada a diferentes tasas de muestreo: 20kHz, 5kHz, 3.5 kHz.

+++

En la proxima celda defino las constantes de muestreo, duración de la señal y cantidad de muestras de la misma

```{code-cell} ipython3
tf=5  # duracion de la señal
fs1=20e3 # frecuencia de muestreo/sampleo
ts1=1/fs1 # tiempo de sampleo 
N1=tf/ts1 # cantidad de muestras

fs2=5e3 # frecuencia de muestreo/sampleo
ts2=1/fs2 # tiempo de sampleo 
N2=tf/ts2 # cantidad de muestras

fs3=3.5e3 # frecuencia de muestreo/sampleo
ts3=1/fs3 # tiempo de sampleo 
N3=tf/ts3 # cantidad de muestras
```

Defino vectores de tiempo en los cuales tomo muestras de la señal

```{code-cell} ipython3
t1=np.linspace(0, tf, num=int(N1+1), endpoint=True)
t2=np.linspace(0, tf, num=int(N2+1), endpoint=True)
t3=np.linspace(0, tf, num=int(N3+1), endpoint=True)
#t1=np.linspace(0, tf, num=int(N1), endpoint=False) # tambien es valido
```

Finalmente defino las señales muestreadas

```{code-cell} ipython3
f=2e3
w=f*2*np.pi

x1=np.sin(w*t1)
x2=np.sin(w*t2)
x3=np.sin(w*t3)
```

Vemos que resulta de las mismas graficandolas en los primeros instantes. Las tres señales se corresponden a la misma señal en continuo pero muestreadas a diferentes tasas de muestreo.

```{code-cell} ipython3
f=plt.figure(figsize=(8,3))
plt.plot(t1,x1, ":x", label="20kHz")
plt.plot(t2,x2, ":x", label="5kHz")
plt.plot(t3,x3, ":x", label="3.5kHz")
plt.legend()
plt.grid()
plt.xlabel("Tiempo [seg]")
plt.ylabel("Amplitud []")
plt.xlim([0,5e-3])
f.tight_layout()
```

Ahora salvamos la señal en un formato de audio que puede ser reproducido por la computadora.

```{code-cell} ipython3
sc.io.wavfile.write('audio1.wav', int(fs1), np.float32(x1))
sc.io.wavfile.write('audio2.wav', int(fs2), np.float32(x2))
sc.io.wavfile.write('audio3.wav', int(fs3), np.float32(x3))
```

¿Cuál(es) de los audios piensan que se escuchan correctamente como un tono de 2kHz?¿Por qué?
