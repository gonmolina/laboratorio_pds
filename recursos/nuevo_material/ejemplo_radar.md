---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.6
kernelspec:
  display_name: dsp
  language: python
  name: python3
---

# Ejemplo radar


Modelo:  $y(n) = \alpha  x(n-D) + w(n)$

Donde:
- $x(n)$: señal transmitida
- $y(n)$: señal recibida
- $w(n)$: señal de ruido
- $\alpha$: coeficiente de atenuación
- $D$: retardo

```{code-cell}
from prbs.prbs import prbs
from scipy.signal import correlate
from numpy.random import normal
from numpy import hstack, zeros
import matplotlib.pyplot as plt
%matplotlib widget
```

```{code-cell}
x= prbs(1000, 12)       # señal pseudo aleatoria binaria
x[x==0]=-1
rxx=correlate(x,x)      # autocorrelacion de x(n)
Ex=sum(x**2)           # energia de la señal x(n)

print(f"La energía de la señal es {Ex}")

f,ax=plt.subplots(2,1)
ax[0].plot(x)
ax[0].set_ylabel(r'$x(n)$')
ax[0].set_xlabel(r'indice $n$" ')
ax[1].plot(rxx)
ax[1].set_ylabel(r'rxx($l$)')
ax[1].set_xlabel(r'indice $l$ ')
for i in ax:
    i.grid()
f.tight_layout()
```

```{code-cell}
alpha=0.3; # coeficiente de atenuacion
w=normal(0, 1, (1000,))     # ruido blanco Gaussiano de media 0 y desviación standard unidad

f,ax=plt.subplots(1,1)
ax.plot(w)
ax.set_ylabel(r'w($n$)')
ax.set_xlabel(r'indice $n$ ')
ax.grid()
f.tight_layout()
```

```{code-cell}
y=alpha * hstack((zeros((100, ), dtype=int), x[0:-100]))+w    # señal recibida

Ey=sum(y**2)           # energia de la señal x(n)
print(f"La energía de la señal es {Ey}")

f,ax=plt.subplots(1,1)
ax.plot(y)
ax.set_ylabel(r'y($n$)')
ax.set_xlabel(r'indice $n$ ')
ax.grid()
f.tight_layout()
```

```{code-cell}
ryx = correlate(y,x)                                           # correlacion cruzada

f,ax=plt.subplots(1,1)
ax.plot(ryx)
ax.set_ylabel(r'ryx($l$)')
ax.set_xlabel(r'indice $l$ ')
ax.grid()
f.tight_layout()
```

## Instalación del paquete generador de señales prbs

Es un paquete que está en una etapa muy temprana de desarrollo, por lo que se encuentra en un 'repositorio' de pruebas de paquetes de python. Para instalarlo puede usar el siguiente comando:

```bash
python -m pip install -i https://test.pypi.org/simple/ prbs-generator
```
El código lo pueden encontrar en un repositorio de Gitlab [siguiendo este link](https://gitlab.com/gonmolina/python-prbs-generator)
