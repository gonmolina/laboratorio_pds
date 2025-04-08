---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.7
kernelspec:
  display_name: dsp
  language: python
  name: python3
---

# Trabajo Análisis Frecuencial de Señales

## Objetivos

- Estudiar el uso de la Transformada de Fourier en Tiempo Discreto (DTFT)
- Implementación en Python de algoritmos de cálculo de la Transformada de Fourier en Tiempo Discreto
- Estudio de la performance de los diferentes tipos de ventanas.

## Estudio de la DTFT

Se puede calcular en forma exacta si la señal es finita y se puede calcular la suma de la serie de Fourier. En general, se calcula de forma aproximada mediante la Transformada de Fourier Discreta (DFT) que es una versión discreta de la DTFT.

## Definición de la DTFT
Para una señal en tiempo discreto $x[n]$ la DTFT se define como:

$$ X(\omega) = \sum_{n=-\infty}^{\infty} x[n] e^{-j \omega n}; \quad -\pi\leq\omega\leq\pi $$

$X(\omega)$ es una función a valores complejos y periódica de período fundamental $2\pi$.

### Problemas de cálculo de la DTFT

- No es posible usar la expresión anterior para calcular la DTFT para señales de longitud infinita, ya que Python solo puede manipular un numéro finitos de valores.

```{admonition} Excepción
:class: caution

Caso en que pueda obtenerse una expresión analítica de la DTFT, que pueda usarse para el cómputo.
```

+++

### Problemas de cálculo de DTFT

La DTFT es una función continua de la frecuencia en el intervalo $[-\pi, \pi)$. Para el cálculo con Python esto representa un problema de muestreo en frecuencia. 

```{important} 
Realiza el cálculo en un número finito de puntos en el intervalo de frecuencias $[-\pi, \pi]$ para obtener una aproximación suave de la DTFT. 
```

Generalmente se toman frecuencias equiespaciadas en el intervalo $[-\pi, \pi)$, es decir:

$$\omega_k = \frac{2\pi k}{N}; \quad k = 0, 1, \ldots, N-1$$

donde $N$ es el número de puntos en frecuencia. Con lo que resulta:

$$
\begin{align*}
X(\omega_k) & = \sum_{n=-\infty}^{\infty} x(n) e^{-j \omega_k n}\\
& = \sum_{n=-\infty}^{\infty} x(n) e^{-j \frac{2\pi k}{N}n}; \quad k = 0, 1, \ldots, N-1
\end{align*}
$$

Esta expresión todavía no es calculable, salvo par señales de longitud finita. En este caso, si la señal es de longitud finita $L$, tenemos:

$$
\begin{align*}
X(\omega_k) = &= \sum_{n=0}^{L-1} x(n) e^{-j \omega_k n}\\
&= \sum_{n=0}^{L-1} x(n) e^{-j \frac{2\pi k}{N}n}; \quad k = 0, 1, \ldots, N-1
\end{align*}
$$

+++

Evaluando la expresión anterior para $k = 0, 1, \ldots, N-1$ se obtiene una aproximación de la DTFT en $N$ puntos en el intervalo $[-\pi, \pi)$:

$$X(\omega_0)= x(0)e^{-j\omega_00} + x(1)e^{-j\omega_01} + \ldots + x(L-1)e^{-j\omega_0(L-1)}$$

$$X(\omega_1)= x(0)e^{-j\omega_10} + x(1)e^{-j\omega_11} + \ldots + x(L-1)e^{-j\omega_1(L-1)}$$

$$X(\omega_2)= x(0)e^{-j\omega_20} + x(1)e^{-j\omega_21} + \ldots + x(L-1)e^{-j\omega_2(L-1)}$$

$$\vdots$$

$$X(\omega_{N-1})= x(0)e^{-j\omega_{N-1}0} + x(1)e^{-j\omega_{N-1}1} + \ldots + x(L-1)e^{-j\omega_{N-1}(L-1)}$$

+++

Escribiendo en forma matricial la expresión anterior se obtiene:

$$
\begin{bmatrix}
X(\omega_0)\\
X(\omega_1)\\
\vdots\\
X(\omega_{N-1})
\end{bmatrix}
=
\begin{bmatrix}
e^{-j\omega_00} & e^{-j\omega_01} & \ldots & e^{-j\omega_0(L-1)}\\
e^{-j\omega_10} & e^{-j\omega_11} & \ldots & e^{-j\omega_1(L-1)}\\
\vdots & \vdots & \ddots & \vdots\\
e^{-j\omega_{N-1}0} & e^{-j\omega_{N-1}1} & \ldots & e^{-j\omega_{N-1}(L-1)}
\end{bmatrix}
\begin{bmatrix}
x(0)\\
x(1)\\
\vdots\\
x(L-1)
\end{bmatrix}
$$

+++

## Problema 1

Implementar una función que calcule la DTFT de una señal en tiempo discreto. La función debe tener la siguiente forma:

```python
def dtft(x, N):
    """
    Cálculo de la DTFT de una señal en tiempo discreto
    
    Parámetros
    - x: np.array. Señal en tiempo discreto
    - N: int. Número de puntos en frecuencia
    
    Retorna
    - X: np.array. DTFT de la señal x
    - w: np.array. Frecuencias en el intervalo [-pi, pi)
    """
    

```

```{code-cell} ipython3
import numpy as np
import matplotlib.pyplot as plt
from scipy.io.matlab import loadmat
from scipy.fft import fft, fftshift, fftfreq
from scipy.signal.windows import hann, hamming, boxcar
import os
%matplotlib widget
```

```{code-cell} ipython3
cwd=os.getcwd()
def dtft(x, N=None):
    """
    Cálculo de la DTFT de una señal en tiempo discreto
    
    Parámetros
    - x: np.array. Señal en tiempo discreto
    - N: int. Número de puntos en frecuencia
    
    Retorna
    - X: np.array. DTFT de la señal x
    - w: np.array. Frecuencias en el intervalo [-pi, pi)
    """

    L=len(x)
    N=len(x) if N==None else N
    k=np.linspace(0, N, N, endpoint=False)
    k=k.reshape((N,1))
    w=2*np.pi*k/N
    n=np.linspace(0,L,L, endpoint=False)
    n=n.reshape((1,L))
    return (np.exp(-1j*(w@n)))@x, w
```

```{code-cell} ipython3
mat_file= loadmat(os.path.join(cwd, "clases", "data1.mat"))
t=mat_file['t']
y=mat_file['y']
fs=mat_file['Fs'][0,0]
```

```{code-cell} ipython3
print(f"dimensiones de y es {y.shape}")
print(f"la frecuencia de muestreo es {fs}")
print(f"la dimension de t es {t.shape}")
```

```{code-cell} ipython3
X, w=dtft(y)
```

```{code-cell} ipython3
f=w*fs/(2*np.pi)
f1=fftfreq(y.shape[0], 1/fs)
```

```{code-cell} ipython3
plt.figure()
plt.plot(fftshift(f1),fftshift(np.abs(X)))
```

```{code-cell} ipython3
dim=[10, 20, 100]

for i in dim:
    hann_win=hann(i)
    hamming_win=hamming(i)
    rect_win=boxcar(i)
    Hann, f1=dtft(hann_win, 2048)
    Hamming,f2=dtft(hamming_win, 2048)
    Rect,f3=dtft(rect_win, 2048)

    f, ax=plt.subplots(2,1)
    ax[0].set_title(f"Analisis ventanas de tamaño {i} para 2048 valores de frecuencia")
    ax[0].plot(hann_win, label="hann")
    ax[0].plot(hamming_win, label="hamming", ls="--")
    ax[0].plot(rect_win, label="Rectangular",ls=":")
    ax[0].legend()
    ax[1].plot(f1*fs/(np.pi*2), np.abs(Hann), label="hann")
    ax[1].plot(f2*fs/(np.pi*2), np.abs(Hamming), ls= "--", label="hamming")
    ax[1].plot(f3*fs/(np.pi*2), np.abs(Rect), ls=":", label="Rectangular")
    ax[1].legend()
```

```{code-cell} ipython3
w=hamming(12000)
N=2**13
print(f"N es igual a {N}")
yw=y[:6000].reshape(12000)*w.reshape(12000)
Yw=fft(yw, N)
fw=fftfreq(N, 1/fs)
```

```{code-cell} ipython3
yw.shape
```

```{code-cell} ipython3
f, ax=plt.subplots(1,1,figsize=(7,3))
ax.plot(fftshift(fw), fftshift(np.abs(Yw)))
```

## Problema 2
Comparación de las diferentes ventanas utilizadas normalmente para el truncamiento de señales de duración infinita. Estudiar las siguientes ventanas:
- Rectangular (`boxcar`)
- Hann (`hann`)
- Hamming (`hamming`)

Utilizar 3 dimensiones de ventanas diferentes (10, 20, 100) y comparar las formas de cada una en el dominio del tiempo y en el dominio de la frecuencia. Para el dominio de frecuencias, calcularlas usando 2048 puntos en el intervalo $[-\pi, \pi)$.

## Problema 3
Utilizar la función `fft` de Python del paquete `scipy` para realizar los mismos cálculos del Problema 2. Comparar los resultados obtenidos con la función `dtft` implementada en el Problema 1.

## Problema 4

El archivo de datos `data.mat` contiene un vector $x$ que consiste de las muestras de una señal inmersa en ruido, muestreada con una frecuencia de $F_s=1$ KHz. 
Se asume que el ruido es blanco Gaussiano. 
Usar la función fft de Matlab para calcular y graficar la DTFT de la señal $x$, usando una ventana de longitud apropiada.
Estudiar el uso de diferentes ventanas y de longitudes de ventana.
