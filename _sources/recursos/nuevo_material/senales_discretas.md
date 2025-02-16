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
---
editable: true
slideshow:
  slide_type: skip
---
import scipy as sc
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
```

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

## Señales en tiempo discreto 

Están definidas sólo en valores discretos de tiempo. Los instantes de tiempo no necesariamente están equiespaciados.

- En general, las señales en Tiempo Discreto (TD) aparecen cuando se muestrea una señal analógica, es decir, cuando se toman muestras de la señal a instantes
discretos de tiempo.
- Si los instantes de tiempo están equiespaciados, el muestreo se denomina **periódico** o **uniforme**.


```{figure} muestreador_ideal.png
:align: center
:width: 50% 
:name: muestreador

Muestreador ideal
```

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

- $F_s$: frecuencia de muestreo [Hz]
- $T=\frac{1}{F_s}$: período de muestreo [seg]
- consideramos *muestreo periódico o uniforme* $\implies$ intervalos entre muestras sucesivas constante

```{important}

Las variables $t$ y $n$ están relacionadas de acuerdo a:

$$t=nT=\frac{n}{F_s}$$
```

- Por lo tanto, la frecuencia $F$ (o $\Omega$) de una señal periódica en Tiempo Continuo, estará relacionada con la frecuencia $f$ (o $\omega$) de la correspondiente señal muestreada.

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

- Consideremos que

$$x_a(t)=A\cos(2\pi Ft+\theta)$$

es muestreada a $F_s=\frac{1}{T}$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

entonces se tiene 

$$
\begin{align*}
x(n)\triangleq x_a(nT)&=A\cos(2\pi FnT+\theta)\\
&=A\cos\left(\dfrac{2\pi nF}{F_s}+\theta\right)\\
&=A\cos(2\pi fn+\theta)
\end{align*}
$$

donde:

$$
\begin{align*}
  \Omega&=2\pi F\\
  \omega&=2\pi f\\ 
        &=\frac{\Omega}{F_s}=\Omega T
\end{align*}
$$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

```{important}

$$f=\frac{F}{F_s} \qquad \omega=\frac{\Omega}{F_s}=\Omega T$$


donde $f$ es **la frecuencia normalizada o relativa**.
```

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

## Periodicidad de una señal en tiempo discreto

En contraste con las señales sinusoidales en Tiempo Continuo, las señales senoidales en tiempo discreto verifican:

- Una señal sinusoidal en Tiempo Discreto es periódica si y sólo si su frecuencia $f$ es un numero racional.
    Por definición $x(n)$ es periódica si y solo si $\exists$ $N>0$ tal que: 
    
    $$x(n+N)=x(n)\quad \forall n$$

   que se verifica si y sólo si:
   
   $$2\pi fN=2\pi k \iff f=\frac{k}{N}$$

    El menor valor de $N$ que verifica esta propiedad se denomina **período fundamental**.

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

   Para determinar el período fundamental $N$ de una senoide discreta, expresamos $f$ como cociente de dos números enteros primos relativos. Entonces el período $N$ es el denominador de esta expresión.

   $$f_1=\frac{30}{60}\qquad \text{próxima a} \qquad f_2=\frac{29}{60}$$
   
   $$N_1=2 \qquad \text{muy distinta} \qquad N_2=60$$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

## Aliasing

Señales sinusoidales en Tiempo Discreto cuyas frecuencias están separadas un múltiplo entero de $2\pi$ son idénticas. 

$$\cos\left[(\omega + 2\pi)n+\theta\right] = \cos\left[\omega n + 2\pi n + \theta\right] = \cos\left[\omega n + \theta\right]$$

Como consecuencia todas las secuencias de sinusoides 

$$x_k(n)=A\cos(\omega_k n+\theta)$$

donde: $\omega_k=\omega+2\pi k$ son **indistinguibles (idénticas)**.

+++ {"editable": true, "slideshow": {"slide_type": ""}}

En particular, una sinusoide con frecuencia en el rango $|\omega| >\pi$ será equivalente a una sinusoide en el rango $|\omega| \leq \pi ( | f |\leq 0.5)$ y se la denomina un alias de la sinusoide en el rango $|\omega| \leq \pi.$

+++ {"editable": true, "slideshow": {"slide_type": ""}}

```{important}
El rango fundamental de frecuencias de señales en TD es entonces:

$$\pi\leq\omega\leq\pi$$
$$-0.5\leq f \leq 0.5$$

```

+++ {"editable": true, "slideshow": {"slide_type": "notes"}}

Mientras que las señales en tiempo continuo es:

$$-\infty\leq\Omega\leq\infty$$
$$-\infty\leq F\leq\infty$$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

- La máxima frecuencia de oscilación de una senoide en tiempo discreto es $\omega=\pi$ (o $f=0.5$)
Consideremos que:

$$f=\frac{F}{F_s}$$

y que $f_{max}=0.5$, que resulta que la máxima frecuencia $F_{max}$ de la señal que en tiempo discreto muestrearse con una frecuencia $F_s$ sin que se produzca aliasing es:

$$f_{max}=\frac{1}{2}=\frac{F_{max}}{F_s} \implies$$ 

```{important}

$$F_{max}=\frac{F_s}{2}$$

```

+++ {"editable": true, "slideshow": {"slide_type": "notes"}}

En otras palabras, para evitar que se produzca aliasing y de esa forma poder reconstruir una seañal a partir de las muestras debemos seleccionar:

$$F_s>2F_{max}$$

donde $F_{max}$ es la máxima frecuencia contenida en la señal analógica.

+++ {"editable": true, "slideshow": {"slide_type": ""}}

## Teorema de muestreo

```{admonition} Teorema de muestreo

Si la frecuencia más alta contenida en una señal análogica $x_a(t)$ es $F_{max} = B$ y la señal es muestreada con una frecuencia $F_s>F_{max}=2B$, entonces $x_a(t)$ puede ser exactamente recuperada a partir de las muestras como:

$$x_a(t)=\sum_{n=-\infty}^{\infty} x_a\left(\frac{v}{F_s}\right)g\left(t-\frac{n}{F_s}\right)$$
```

+++ {"editable": true, "slideshow": {"slide_type": "notes"}}

donde 

$$x_a(\frac{n}{F_s})\triangleq x_a(nT)=x(n)$$

son las muestras de $x_a(t)$ y $g(t)$ es la función de interpolación definida como

$$g(t)=\frac{\sin(2\pi Bt)}{2\pi Bt}$$

+++ {"editable": true, "slideshow": {"slide_type": ""}}

```{figure} teorema_muestreo.png
:width: 80%
:align: center
:name: teorema_muestreo
:alt: teorema de muestreo

Teorema de muestreo Nyquist-Shannon
```

```{admonition} Tasa de Muestreo de Nyquist-Shannon
:class: note

A $F_N\triangleq 2B$ se la denomina Tasa de muestreo de Nyquist
```

+++ {"editable": true, "slideshow": {"slide_type": ""}}

### Ejemplo

Determinar la tasa de muestreo de Nyquist 

$$x_a(t)=3\cos(50\pi t)+10\sin(300\pi t) -\cos(100\pi t)$$

#### Solución

$$F_1=25 Hz \qquad F_2=150Hz \qquad F_3=50Hz$$

Veamos que $F_{max}=150Hz \implies F_N=300Hz$

Sin embargo, si muestreamos con $F_s=F_N$, las muestras de la componente 

$$10\sin(300\pi t) \qquad \text{resultan}\qquad 10\sin(\pi n)$$

que son idénticamente nulas y obviamente no puede recuperarse la señal a partir de las muestras!!

+++ {"editable": true, "slideshow": {"slide_type": ""}}

### Ejemplo 

Supongamos que desea generar y graficar las señales en tiempo continuo $x_1(t)$ y $x_2(t)$ definidas como:

$$
\begin{align*}
x_1(t)&=\cos(2\pi 50t)\\
x_2(t)&=\cos(2\pi 550t)
\end{align*}
$$

y las correspondientes señales en tiempo discreto que se obtienen muestreandolas con una frecuencia $F_s=500Hz$. Notas que las dos señales tienen la misma señal muestreada


$$
\begin{align*}
x_1(n)&=\cos\left(\frac{2\pi 50n}{500}\right)\\
x_2(n)&=\cos\left(\frac{2\pi 550n}{500}\right)=\cos\left(2\pi n + \frac{2\pi 50 n}{500}\right)=x_1(n)\\
\end{align*}
$$


```{admonition} Nota
:class: important

$x_2(n)$ es un alias de $x_1(n)$.
```

+++ {"editable": true, "slideshow": {"slide_type": ""}}

Veamos el ejemplo en código, y grafiquemoslo:

```{code-cell} ipython3
---
editable: true
slideshow:
  slide_type: ''
---
t=np.linspace(0,0.02, 20001, endpoint=True)
n=np.linspace(0,10, 11, endpoint=True)
x1=np.cos(2*np.pi*50*t)
x2=np.cos(2*np.pi*550*t)
```

```{code-cell} ipython3
---
editable: true
slideshow:
  slide_type: ''
---
x1n=np.cos(2*np.pi*50/500*n)
x2n=np.cos(2*np.pi*550/500*n)
```

```{code-cell} ipython3
---
editable: true
slideshow:
  slide_type: ''
---
f, ax=plt.subplots(1,1, figsize=(8,3))
ax.plot(t, x1, color="b", label=r"$x_1(t)$")
ax.plot(t, x2, color="r", ls="--", label=r"$x_2(t)$")
ax.scatter(n*0.002, x1n, marker="o", facecolor="None", edgecolor="b", s=90, linewidths=2 , label=r"$x_{1n}(t)$") 
ax.scatter(n*0.002, x2n, marker="x", color="r", s=50, linewidths=3, label=r"$x_{2n}(t)$")
plt.legend()
ax.set_xlabel("Tiempo [seg]")
ax.set_ylabel("Amplitud")
ax.set_title("Señales $x_1(t)$ y $x_2(t)$ muestreadas: Aliasing")
ax.grid()
```

```{code-cell} ipython3
---
editable: true
slideshow:
  slide_type: ''
---

```
