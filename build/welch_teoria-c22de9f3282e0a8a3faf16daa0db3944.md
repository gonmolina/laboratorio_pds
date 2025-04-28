---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.7
kernelspec:
  display_name: Python 3 (ipykernel)
  language: python
  name: python3
---

# Estimación de la densidad espectral de potencia: método de Welch

## Periodograma estándar: Relación entre N y varianza

El periodograma se define como:

$$\hat P(f)= \frac{1}{N} \left| \sum_{n=0}^{N−1}x[n]e^{−j2\pi fn}\right|^2$$


donde $N$ es el número de muestras.


- Teóricamente, la varianza del periodograma no disminuye al aumentar $N$.
    - Esto se debe a que el periodograma es un **estimador inconsistente**: su varianza no converge a cero incluso con $N\rightarrow\infty$.
    - Aunque el espectro se ve "más suave" porque la resolución frecuencial ($\Delta f=\frac{f_s}{N}$) mejora, la **variabilidad estadística** entre frecuencias cercanas sigue siendo alta.

- En la práctica, al aumentar $N$:
    - Los picos espectrales se vuelven más estrechos (mejor resolución).
    - Pero el "ruido" alrededor de los picos sigue teniendo la misma amplitud relativa.

```{code-cell} ipython3
import numpy as np
import matplotlib.pyplot as plt
import scipy as sc
from scipy.signal import welch, periodogram
```

## Ejemplo en Python

```{code-cell} ipython3
fs = 1000
t_short = np.arange(0, 1, 1/fs)       # 1 segundo (N=1000)
t_long = np.arange(0, 10, 1/fs)        # 10 segundos (N=10000)

# Señal: senoide + ruido
x_short = 0.2*np.sin(2 * np.pi * 50 * t_short) + 0.5 * np.random.randn(len(t_short))
x_long = 0.2*np.sin(2 * np.pi * 50 * t_long) + 0.5 * np.random.randn(len(t_long))

# Periodogramas
f_short, pxx_short = periodogram(x_short, fs=fs)
f_long, pxx_long = periodogram(x_long, fs=fs)

# Gráficos
plt.figure(figsize=(12, 6))
plt.plot(f_short, 10 * np.log10(pxx_short), label='N=1000 (alta varianza)')
plt.plot(f_long, 10 * np.log10(pxx_long), ':',
         label='N=10000 (misma varianza, mejor resolución)')
plt.xlabel('Frecuencia (Hz)')
plt.ylabel('PSD (dB/Hz)')
plt.legend()
plt.grid(True)
plt.show()
```

## Método de Welch: Reducción efectiva de varianza

Welch logra reducir la varianza mediante:

- **División en segmentos**: La señal de $N$ muestras se divide en $K$ segmentos de longitud $L$ (ej. $L=256$).
- **Promediado**: Cada segmento tiene su propio periodograma, y el resultado final es el promedio de todos.

La varianza disminuye aproximadamente como:

$$VarWelch\approx\frac{Var_{Periodograma}}{K}$$

donde $K$ es la cantidad de segmentos.

```{code-cell} ipython3
# Welch con N=10000
f_welch, pxx_welch = welch(x_long, fs=fs, nperseg=1024, noverlap=256)

plt.figure(figsize=(12, 6))
plt.plot(f_long, 10 * np.log10(pxx_long), label='Periodograma (N=10000)')
plt.plot(f_welch, 10 * np.log10(pxx_welch), label='Welch (promediado)')
plt.xlabel('Frecuencia (Hz)')
plt.legend()
plt.grid(True)
plt.show()
```

Resultado:

Welch muestra un fondo mucho más suave porque promedia $K\approx 39$ segmentos (N=10000, L=256, noverlap=128).

+++

## Independencia de la varianza al aumento de $N$ en el Periodograma

El periodograma no reduce la varianza al aumentar $N$ principalmente debido a:

**Independencia espectral**: 
- El periodograma calcula la energía en cada frecuencia de forma independiente. Aunque $N$ aumente, la estimación en $f_1$ no "aprende" de $f_2$.
  
- **Fugas espectrales** (leakage): El enventanado implícito (rectangular) causa interferencia entre frecuencias, aumentando la varianza aparente. Welch mitiga esto:
    - Al usar ventanas (ej. Hann), reduce leakage en cada segmento.
    - El promediado atenúa las fluctuaciones aleatorias.

+++

## Caso especial: Señales sin ruido

Si la señal es determinística y libre de ruido (por ejemplo una senoide pura), aumentar $N$ en el periodograma sí mejora la estimación, porque no hay varianza intrínseca. Pero en aplicaciones reales (ruido presente), Welch es casi siempre mejor.

```{code-cell} ipython3

# Configuración
fs = 1000  # Frecuencia de muestreo
N = 10000  # Número de muestras (10 segundos)
t = np.arange(N) / fs

# Señal: tono débil + ruido fuerte
tono = 0.04 * np.sin(2 * np.pi * 75 * t)  # Tono de 75 Hz (muy pequeño)
rg = np.random.default_rng(seed=12345)
ruido = rg.random(N)                 # Ruido blanco (sigma=1)
x = tono + ruido

# Periodograma estándar
f_per, pxx_per = periodogram(x, fs=fs, nfft=N)

# Welch con parámetros óptimos
f_wel, pxx_wel = welch(x, fs=fs, window="hamming", nperseg=1024, noverlap=512, nfft=1024)

# Gráficos
plt.figure(figsize=(14, 6))

# Periodograma
plt.subplot(2, 1, 1)
plt.semilogy(f_per, pxx_per)
#plt.ylim(1e-8, 1e-1)
#plt.xlim(10, 500)
plt.title('Periodograma estándar\nNo se distingue el tono a 75 Hz')
plt.xlabel('Frecuencia (Hz)')
plt.ylabel('PSD (V²/Hz)')
plt.grid(True)

# Welch
plt.subplot(2, 1, 2)
plt.semilogy(f_wel, pxx_wel)
#plt.ylim(1e-3, 1e-2)
#plt.xlim(10, 500)
plt.title('Método de Welch\nTono visible a 75 Hz (pico)')
plt.xlabel('Frecuencia (Hz)')
plt.grid(True)

plt.tight_layout()
plt.show()
```

## Problemas para los alumnos

### Problema 1
- Generar una onda cudrada de media 0, frecuencia 50 Hz, amplitud máxima 0.1 y de 10 segundos de duración. Agregarle el mismo ruido que tiene la señal del ejemplo.
- Tratar de obtener un Periodograma estándar y con Welch para analizar el contenido armónico de la señal.

### Problema 2

- Generar la siguiente señal.

```python
fs = 1000  # Hz, frecuencia de muestreo
t = np.arange(0, 10, 1/fs)  # 10 segundos
ng = np.random.default_rng(seed=1234)
# Señal: tono débil a 50 Hz + mucho ruido blanco
signal = 0.07 * np.sin(2 * np.pi * 50 * t) + ng.normal(0, 1, len(t))
```

- Analizarlarla haciendo un análisis espectral de potencia mediante un periodograma estándard y mediante un periodograma con el método de Welch.k
- Durante el curse hemos visto una herramienta de maroy utilidad para analizar esta señal. ¿De cual se trata? Escriba una script que la use y la grafique.


   

```{code-cell} ipython3

```
