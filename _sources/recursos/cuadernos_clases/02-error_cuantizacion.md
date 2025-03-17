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

# Ejercicio de error de cuantización


- Generar una señal entre 0 y 5 de al menos 1000 elementos. (puede ser una senoidal o cualquier otra señal fuctuante que se les ocurra, que tenga muchos ciclos)
- graficar la señal
- calcular la desviación estandard
- cuantizar esa señal a valores enteros
- graficar la nueva señal
- calcular la desviación estandard

```{code-cell} ipython3
import numpy as np
import scipy as sc
import matplotlib.pyplot as plt
%matplotlib widget
```

```{code-cell} ipython3
f=200
T1=1
N=10000
t=np.linspace(0,T1, N, endpoint=False)
x1=np.sin(2*np.pi*f*t)*10+10

f,ax=plt.subplots(1,1, figsize=(7,4))
ax.plot(t, x1)
ax.set_xlabel("tiempo")
ax.set_ylabel('amplitud')
ax.set_xlim([0.1, 0.2])
ax.grid();
```

```{code-cell} ipython3
std_x1=np.std(x1)
print(f"standard deviation de x1: {std_x1}")
```

```{code-cell} ipython3
x1q=np.round(x1)

f,ax=plt.subplots(1,1, figsize=(7,4))
ax.plot(t, x1q)
ax.set_xlabel("tiempo")
ax.set_ylabel('amplitud')
ax.set_xlim([0.1, 0.2])
ax.grid();
```

```{code-cell} ipython3
std_x1q=np.std(x1q)
print(f"standard deviation de x1q: {std_x1q}")
```

```{code-cell} ipython3
error=x1-x1q
mean_error=np.mean(error)
print(error)
print(mean_error)
mean_square_error=np.sum((error-mean_error)**2)/N
print(f"varianza del error: {mean_square_error}")
print(f"varianza del error: {np.std(error)**2}")
print(f"varianza teórica del error calculada: {1**2/12}")
```

```{code-cell} ipython3

f,ax=plt.subplots(1,1, figsize=(7,4))
ax.plot(t, error)
ax.set_xlabel("tiempo")
ax.set_ylabel('amplitud')
ax.set_xlim([0.1, 0.2])
ax.grid();
```

```{code-cell} ipython3
print(1/12)
print(std_x1q-std_x1)
```

```{code-cell} ipython3
plt.close("all")
```

```{code-cell} ipython3
x1.dtype
```

```{code-cell} ipython3
r
```

```{code-cell} ipython3

```
