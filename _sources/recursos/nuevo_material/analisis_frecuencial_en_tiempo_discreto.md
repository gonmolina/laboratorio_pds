---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.1
---

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

# Análisis frecuencial de señales en tiempo discreto

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

## Serie de Fourier de Señales en Tiempo Discreto

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

Sea $x(n)$ **una señal periódica** con período $N$, es decir:

$$x(n)=x(n+N), \qquad \forall n$$

La representación de $x(n)$ en **serie de Fourier** puede
expresarse como:

```{admonition} Serie de Fourier
$$
\begin{equation}
x(n)=\sum_{k=0}^{N-1}c_k e^{j\frac{2\pi kn}{N}}
\end{equation}
$$(eq1)

donde los ${c_k}$ son los coeficientes de Fourier.

```

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

Para derivar la expresión de $c_k$ usamos la identidad

$$
\sum_{k=0}^{N-1}e^{j\frac{2\pi kn}{N}}=\left\{
\begin{array}{ll}
N & k=0,\pm N, \pm 2N, \cdots\\
0 & \text{c.o.c}
\end{array}
\right.
$$

+++ {"editable": true, "slideshow": {"slide_type": "subslide"}}

Reemplazando en [](eq1), tenemos:

$$x(n)e^{-j\frac{2\pi ln}{N}}=\sum_{k=0}^{N-1}c_ke^{j\frac{2\pi (k-l)n}{N}}$$

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

Sumando sobre $n$:

$$
\begin{align*}
  \sum_{n=0}^{N-1}x(n)e^{-j\frac{2\pi ln}{N}}& =
  \sum_{n=0}^{N-1}\sum_{k=0}^{N-1}c_ke^{j\frac{2\pi (k-l)n}{N}}\\
& = \sum_{k=0}^{N-1}c_k\sum_{n=0}^{N-1}e^{j\frac{2\pi (k-l)n}{N}}\\
& = Nc_l 
\end{align*}
$$

+++ {"editable": true, "slideshow": {"slide_type": "subslide"}}

Luego

```{admonition} Coeficientes de la Serie de Fourier
$$c_l=\frac{1}{N}\sum_{n=0}^{N-1}x(n)e^{-j\frac{2\pi ln}{N}}\quad \text{con } l=0,1,\cdots,N-1$$
```

+++ {"editable": true, "slideshow": {"slide_type": "subslide"}}

- Como las componentes en frecuencia

$$S_k =  e^{-j\frac{2\pi kn}{N}}$$

son periódicas con período $N$, entonces los coeficientes de Fourier $c_k$ 
son también periódicos cuando se calculan más allá del rango $k=0, 1, \cdots, N-1$. 

Se tiene entonces:

$$c_{k+N}=c_k$$

Es decir, ${c_k}$ es una secuencia periódica con periodo fundamental $N$.

+++ {"editable": true, "slideshow": {"slide_type": "subslide"}}

Tenemos entonces que el espectro de una señal $x(n)$ que es
periódica con período $N$, es una secuencia periódica con
período $N$.

```{note}
Cualquier secuencia de $N$ muestras de
la señal o de su espectro provee una descripción completa
de la señal en el dominio temporal o frecuencial.
```

- Si bien ${c_k}$ es una secuencia periódica nos concentraremos 
en un solo período en el rango $k = 0 , 1 , \cdots , N-1$.
En el dominio frecuencial esto implica cubrir el rango de
frecuencias:

$$0\leq \omega_k=\frac{2\pi k}{N}< 2\pi \quad \text{con } k=0,1, 2, \cdots, N-1$$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

### Espectro de Densidad de Potencia de Señales Periódicas en Tiempo Discreto

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

La potencia media de una señal periódica de período $N$ es:

$$
 \begin{align*}
 P_x=\frac{1}{N}\sum_{n=0}^{N-1} |x(n)|^2&=\frac{1}{N}\sum_{n=0}^{N-1}x(n)x^*(n)\\
         &=\frac{1}{N}\sum_{n=0}^{N-1}x(n) \left[\sum_{k=0}^{N-1}c_k^*e^{-j\frac{2\pi k n}{N}}\right]\\
         &=\frac{1}{N}\sum_{k=0}^{N-1} c_k^*\left[\sum_{n=0}^{N-1}x(n)e^{-j\frac{2\pi k n}{N}}\right]\\
         &=\frac{1}{N}\sum_{k=0}^{N-1} c_k^*c_k=\frac{1}{N}\sum_{k=0}^{N-1} |c_k|^2
 \end{align*}
$$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

```{admonition} Espectro de Densidad de Potencia
La secuencia $|ck|^2$ , $k = 0 , 1 , \cdots, N-1$ se denomina
**Espectro de Densidad de Potencia**
```

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

- La energía de la señal $x(n)$ en un período es:

```{admonition} Energía en un período   
$$E_n=\sum_{n=0}^{N-1}|x(n)|^2=N\sum_{n=0}^{N-1}|c_k|^2$$
```

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

- Si la señal $x(n)$ es real, entonces:

```{admonition} Simetría de la serie de Fourier
$$ 
c_k^*=c_k \implies \left\{
\begin{array}{cc}
|c_{-k}|&=|c_{k}|\\
-\angle c_{-k}&=\angle c_{k}\\
\end{array}
\right.
$$
```

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

### Ejemplos

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

- $$x(n)=\cos\sqrt{2}\pi n$$

$$ \omega_0=\sqrt 2 \pi \implies f_0=\frac{1}{\sqrt{2}}$$

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

- Como $f_0$ no es un número racional, $x(n)$ no es periódica $\implies$
No puede expandirse en series de Fourier. La señal posee
sin embargo un espectro que consiste de una única
componente de frecuencia $\omega=\omega_0=\sqrt{2}\pi$

+++ {"editable": true, "slideshow": {"slide_type": "subslide"}}

- $$x(n)=\cos\frac{\pi n}{3}$$

$$ \omega_0=\frac{\pi}{3} \implies f_0=\frac{1}{6}$$

$x(n)$ es periódica con período fundamental $N = 6$

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

Los coeficientes de Fourier resultan:

$$c_k=\frac{1}{6}\sum_{n=0}^{5} x(n)e^{-j\frac{2\pi kn}{6}}, \quad k=0,1,\cdots,5$$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

## Transformada de Fourier en Tiempo Discreto

La DTFT (Discrete Time Fourier Transform) de una señal $x(n)$ de **energía finita** se define como:

```{admonition} Transformada de Fourier en Tiempo Discreto

$$X(\omega)\triangleq \sum_{n=-\infty}^{\infty}x(n)e^{-j\omega n}$$

```

+++ {"editable": true, "slideshow": {"slide_type": "fragment"}}

- $X(\omega)$ representa el contenido frecuencial de una señal $x(n)$; y se denomina espectro de $x(n)$
- Como el rango de frecuencias para una señal en tiempo discreto es $(-\pi, \pi), X(\omega)$ resulta periódica de período $2\pi$.

+++ {"editable": true, "slideshow": {"slide_type": "subslide"}}

En efecto,

$$X(\omega+2\pi)=\sum_{n=-\infty}^{\infty}x(n)e^{-j(\omega+2\pi)n}=\sum_{n=-\infty}^{\infty}x(n)e^{-j(\omega n+2\pi)n}.\underbrace{e^{-j2\pi n}}_{=1}=X(\omega)$$

+++ {"editable": true, "slideshow": {"slide_type": "slide"}}

- Como $X(\omega)$ es una función de la variable $\omega$, admite una expansión en series de Fourier, siempre que se verifiquen las condiciones de Dirichlet.

De la definición anterior de $X(\omega)$ vemos que los coeficientes de Fourier son:

$$c_n=x(-n)$$

Si se conoce $X(\omega)$, la señal $x(n)$ puede entonces recuperarse como:

```{admonition} Transformada de Fourier Inversa en Tiempo Discreto

$$x(n)=c_{-n}=\frac{1}{2\pi}\int_{-\pi}^{\pi} X(\omega)e^{j\omega n}d\omega$$

```

+++ {"editable": true, "slideshow": {"slide_type": ""}}

### Convergencia de la DFTF

Definamos:

$$X_N(\omega)=\sum_{n=-N}^{N}x(n)e^{-j\omega n}$$

Decimos que $X_N(\omega)$ **converge uniformemente** a $X(\omega)$, para todo $\omega$, cuando $N\rightarrow \infty$, si 

$$\lim_{N\rightarrow\infty} |X(\omega)-X_N(\omega)|=0$$

+++ {"editable": true, "slideshow": {"slide_type": ""}}

La convergencia uniforme de $X_N(\omega)$ queda garantizada si:

$$\sum_{n=-\infty}^{\infty} |x(n)| < \infty$$

En efecto se verifica entonces:

$$|X(\omega)| = \left| \sum_{n=-\infty}^{\infty} x(n)e^{-j\omega n}\right|\leq \sum_{n=-\infty}^{\infty} \left|x(n)\right|\leq \infty$$

Por lo que esta es una condición **suficiente** para existencia de la transformada discreta de Fourier.

+++ {"editable": true, "slideshow": {"slide_type": ""}}

Algunas secuencias no son absolutamente sumables, pero son cuadrado sumables, es decir son de energía finita:

$$E_{x}=\sum_{n=-\infty}^{\infty} \left|x(n)\right|^{2}\leq \infty$$

que es una condición más débil que la anterior (la anterior implica esta pero no al revés)

Para poder definir la DTFT de estas señales, la condición de convergencia uniforme se debe relajar a **convergencia en media cuadrática**:

$$\lim_{N\rightarrow \infty} \int_{-\pi}^{\pi}\left|X(\omega)-X_N(\omega)\right|^2 dw=0$$

Es decir, la energía  del error $|X(\omega)-X_N(\omega)|$ tiende a cero, pero no necesariamente el error tiende a cero para cada $\omega$.

- De esta forma podemos ampliar la clase de señales que tiene DFTF para incluir señales de energía finita.

+++ {"editable": true, "slideshow": {"slide_type": ""}}

### Ejemplo DTFT cuadrada

Supongamos que la señal $x(n)$ tiene DFTF,

$$
X(\omega)=\left\{
\begin{array}{ll}
1, &\quad |\omega|\leq \omega_c\\ 
0, &\quad \omega_c < |\omega| \leq \pi 
\end{array}
\right.
$$

Recordemos que $|X(\omega)|$ es periódica con período $2\pi$.

La transformada inversa resulta

$$x(n)=\frac{1}{2\pi}\int_{-\pi}^{\pi}X(\omega)e^{j\omega n}d\omega=
\frac{1}{2\pi}\int_{-\omega_c}^{\omega_c}e^{j\omega n}d\omega
=\frac{\sin(\omega_c n)}{\pi n}, \quad \text{con } n \neq 0$$

$$x(n)=\frac{1}{2\pi}\int_{-\omega_c}^{\omega_c}d\omega=\frac{\omega_c}{\pi}, \quad\text{con } n=0$$

+++ {"editable": true, "slideshow": {"slide_type": ""}}

Se puede verificar que $x(n)$ no es absolutamente sumable pero es cuadrado sumable.

+++

En efecto:

$$
\sum_{n=-\infty}^{\infty} |x(n)|=
\frac{\omega_c}{\pi}+2\sum_{n=1}^{\infty} \frac{\omega_c}{\pi}\left|\frac{\sin(\omega_c n)}{\omega_c n}\right|
\leq \frac{\omega_c}{\pi}+\underbrace{\frac{2}{\pi}\sum_{n=1}^{\infty}\frac{1}{n}}_{\text{diverge}}
$$

+++

Además: 

$$
\sum_{n=-\infty}^{\infty} |x(n)|^2=
\frac{\omega_c^2}{\pi^2}+2\sum_{n=1}^{\infty} \frac{\omega_c^2}{\pi^2}\left|\frac{\sin(\omega_c n)}{\omega_c n}\right|^2
\leq \frac{\omega_c^2}{\pi^2}+\underbrace{\frac{2}{\pi^2}\sum_{n=1}^{\infty}\frac{1}{n^2}}_{\text{converge}}
$$

+++

Concluimos entonces que la DTFT $X(\omega)$ de $x(n)$ converge en media cuadrática, pero no converge uniformemente punto a punto (en las discontinuidades).

Para ver esto en mayor detalle consideremos la suma finita 

$$
X_N(\omega)=\sum_{n=-N}^{N}\frac{\sin(\omega_cn)}{\pi n} e^{-j\omega n }
$$

para distintos valores de $N$ crecientes. 

Vemos que existe una oscilación en frecuencia $\omega=\omega_c$.
Cuando $N$ aumenta, la oscilación es mas rápida y cuando $N\rightarrow\infty$ la oscilación converge al punto de discontinuidad $\omega=\omega_c$, pero su amplitud no va a cero. Este fenómeno oscilatorio de $X_N(\omega)$ se denomina fenómeno de Gibbs.

+++

### Espectro de Densidad de Energía de Señales Aperiódicas 

La energía de la señal $x(n)$ es:
 

$$\begin{align}
E_x=\sum_{n=-\infty}^{\infty} \left|x(n)\right|^2 &= \sum_{n=-\infty}^{\infty} x(n)x^*(n)\\
&= \sum_{n=-\infty}^{\infty} x(n)\left[\frac{1}{2\pi}\int_{-\pi}^{\pi} X^*(\omega)e^{-j\omega n}d\omega\right]\\
&= \frac{1}{2\pi}\int_{-\pi}^{\pi} X^*(\omega)\left[\sum_{n=-\infty}^{\infty} x(n)e^{-j\omega n}\right]d\omega\\
&= \frac{1}{2\pi}\int_{-\pi}^{\pi} \left|X(\omega)\right|^2d\omega\\
\end{align}
$$

```{admonition} Identidad de Parseval para señales aperiódicas
$$
E_x= \frac{1}{2\pi}\int_{-\pi}^{\pi} \left|X(\omega)\right|^2d\omega
$$
```

- $X(\omega)$ es, en general una función a valores complejos que puede expresar como:

$$X(\omega)=|X(\omega)|e^{j\theta(\omega)}$$

+++

donde:

$$
\begin{align*}
  \left|X(\omega)\right|:&\quad \text{Espectro de magnitud}\\
  \theta(\omega)=\angle\omega:&\quad \text{Espectro de magnitud}
\end{align*}
$$


- $S_{xx}(\omega)=|X(\omega)|^2$ se denomina **Espectro de densidad de energía** de $x(n)$. $S_{xx}(\omega)$ no contiene información de la fase.
- Si $x(n)$ es una señal real, entonces:

$$
X^{*}(\omega)=X(\omega)\implies \left\{
    \begin{align*}
        |X(-\omega)|&=|X(\omega)|\\
        \angle X(-\omega)&=-\angle X(\omega)\\
        S_{xx}(-\omega)&=S_{xx}(\omega)
    \end{align*}
    \right.
$$

- Basados en las propiedades anteriores de simetría podemos concluir que para una señal real basta con conocer $X(\omega)$ en e rango de frecuencias $0\leq \omega\leq\pi$ para que $x(n)$ (señal real) quede completamente determinada.

+++

### Ejemplo: densidad espectral de energía de una señal exponencial

Calcule y grafique el espectro de densidad de energía $S_{xx}(\omega)$ de la señal:

$$x(\omega)=a^{n}\mu(n), \quad 0<a<1$$

La DTFT de $x(n)$ resulta:

$$
\begin{align*}
    X(\omega)&=\sum_{n=-\infty}^{\infty}x(n)e^{-j\omega n}=\sum_{n=-\infty}^{\infty}a^ne^{-j\omega n}\\
    &=\sum_{n=-\infty}^{\infty}\left(ae^{-j\omega}\right)^n=\frac{1}{1-ae^{-j\omega}}\\
\end{align*}
$$

+++

Luego 

$$
\begin{align*}
S_{xx}&=\left|X(\omega)\right|^2=\left|\frac{1}{1+a\cos(\omega)+ja\sin(\omega)}\right|^2\\
&=\frac{1}{\left(1-\cos(\omega)\right)^2+a^2\sin^2(\omega)}\\
&=\frac{1}{1+a^2-2a\cos(\omega)}
\end{align*}
$$

Implementamos un código de Python que utilice el resultado obtenido para calcular $S_{xx}$.

```{code-cell} ipython3
import numpy as np
import matplotlib.pyplot as plt

def espectro1(w, a=0.8):
    return 1/(1+a**2-2*a*np.cos(w))
```

La función anterior nos devuelve el valor de $S_{xx}$ para un $\omega$ y un $a$ dado (por defecto $a=0.8$).

En el siguiente bloque de código calculamos $S_{xx}$ para valores de $\omega$ distribuidos de manera lineal entre $-\pi$ y $\pi$ y los graficamos.

```{code-cell} ipython3
import numpy as np
omega=np.linspace(-np.pi, np.pi, 1001, endpoint=True)

sxx1=np.empty(omega.shape)

for i, w in enumerate(omega):
    sxx1[i]=espectro1(w)

plt.plot(omega, sxx1)
plt.ylabel(r"$S_{xx}$")
plt.xlabel(r"$\omega$")
plt.grid();
```

### Ejemplo: densidad espectral de energía de una señal cuadrada

Determine la DTFT y el espectro de densidad de energía de la señal:

$$
x(n)=\left\{ 
    \begin{align*}
      A, &\quad 0\leq n \leq L-1\\
      0, &\quad \text{c.o.c.}
    \end{align*}
    \right.
$$

La DTFT resulta: 

$$
 \begin{align*}
    X(\omega)&=\sum_{n=-\infty}^{\infty}x(n)e^{-j\omega n} = A\sum_{n=0}^{L-1}e^{-j\omega n}\\
    & =A\sum_{n=0}^{L-1}\left(e^{-j\omega}\right)^n=A\frac{1-e^{-j\omega L}}{1-e^{-j\omega}} \\
    & =A\frac{e^{-j\omega L/2}e^{j\omega L/2}-e^{-j\omega L/2}e^{-j\omega L/2}}{e^{-j\omega /2}e^{j\omega /2}-e^{-j\omega /2}e^{-j\omega /2}} \\
    & =A\frac{e^{-j\omega L/2}}{-j\omega /2}\frac{\sin(\omega L/2)}{\sin(\omega /2)}\\
    & =Ae^{-j\omega (L-1)/2}\frac{\sin(\omega L/2)}{\sin(\omega /2)}\\
 \end{align*}
$$

El espectro de densidad de energía resulta:

$$S_{xx}=|X(\omega)|^2 = A^2 \frac{\sin^2(\omega L/2)}{\sin^2(\omega/2)}$$

```{code-cell} ipython3
def espectro2(w, L=10, A=1):
    sxx=(A**2)*(np.sin(w*L/2)**2)/(np.sin(w/2)**2)
    xw=A*(np.exp(-1j*w*(L-1)/2))*np.sin(w*L/2)/np.sin(w/2)
    return sxx, np.abs(xw), np.angle(xw)

omega=np.linspace(-np.pi, np.pi, 1000, endpoint=True) # uso mil puntos y evito la evaluación en w=0, que queda dividiendo por 0

shape=omega.shape[0], 3 # las tuplas se definen con comas, el paréntesis no es necesario
sxx21=np.empty(shape)
sxx22=np.empty(shape)
sxx23=np.empty(shape)

for i, w in enumerate(omega):
    sxx21[i,:]=espectro2(w, L=10)
    sxx22[i,:]=espectro2(w, L=20)
    sxx23[i,:]=espectro2(w, L=100)
```

```{code-cell} ipython3
fig, ax=plt.subplots(3,1, figsize=(6,6))
ax[0].set_title("Espectro de densidad de energía")
ax[0].plot(omega, sxx21[:,0], label="L=10")
ax[0].legend()
ax[1].plot(omega, sxx22[:,0], label="L=20")
ax[1].legend()
ax[2].plot(omega, sxx23[:,0], label="L=100")
ax[2].legend()
ax[2].set_xlabel(r"$\omega$")
for i in ax:
    i.grid()
```

```{code-cell} ipython3
fig, ax=plt.subplots(3,1, figsize=(6,6))
ax[0].set_title("Espectro de amplitud")
ax[0].plot(omega, sxx21[:,1], label="L=10")
ax[0].legend()
ax[1].plot(omega, sxx22[:,1], label="L=20")
ax[1].legend()
ax[2].plot(omega, sxx23[:,1], label="L=100")
ax[2].legend()
ax[2].set_xlabel(r"$\omega$")
for i in ax:
    i.grid()
```

```{code-cell} ipython3
fig, ax=plt.subplots(3,1, figsize=(6,6))
ax[0].set_title("Espectro de fase")
ax[0].plot(omega, sxx21[:,2], label="L=10")
ax[0].legend()
ax[1].plot(omega, sxx22[:,2], label="L=20")
ax[1].legend()
ax[2].plot(omega, sxx23[:,2], label="L=100")
ax[2].legend()
ax[2].set_xlabel(r"$\omega$")
for i in ax:
    i.grid()
```

Podemos notar que pendiente abrupta en la fase se da en $\pm \frac{2\pi}{L}$ y que los máximos de amplitud son valores iguales a $L.A$.

+++

### Propiedades de la DTFT
- Linealidad

$$ a_1 x_1(n)+a_2x_2(n) \longleftrightarrow a_1X_1(\omega)+a_2X_2(\omega)$$

- Corrimiento temporal

$$ x(n-k) \longleftrightarrow e^{-j\omega k}X(\omega)$$

- Inversión en el tiempo

$$ x(-n) \longleftrightarrow X(-\omega)$$

- Convolución de 2 secuencias

$$ x_1(n)*x_2(n) \longleftrightarrow X_1(\omega).X_2(\omega)$$

- Corrimiento en frecuencia

$$ e^{j\omega_0n}x(n) \longleftrightarrow X(\omega-\omega_0)$$

- Modulación

$$x(n)\cos\omega_0 \longleftrightarrow \frac{1}{2}\left[X(\omega+\omega_0)+X(\omega-\omega_0)\right]$$

- Multiplicación de dos secuencias (teorema de ventaneo)

$$ x_1(n).x_2(n) \longleftrightarrow \frac{1}{2\pi}\int_{\pi}^{\pi}X_1(\lambda)X_2(\omega-\lambda)d\lambda$$

- Diferenciación en el dominio frecuencial

$$nx(n) \longleftrightarrow \frac{dX(\omega)}{d\omega}$$

- Teorema de correlación

$$r_{x_1x_2}(n)\longleftrightarrow X_1(\omega)X_2(-\omega)$$

- Caso particular: Wiener-Khintchine

$$r_{xx}(l)\longleftrightarrow S_{xx}(\omega)$$

**El espectro de densidad de energía de una señal de energía finita es la transformada de Fourier en Tiempo Discreto de su secuencia de autocorrelación.**


```{admonition} Teorema de Parseval

$$\sum_{n=\infty}^{\infty}x_1(n)x^*_2(n)=\frac{1}{2}\int_{-\pi}^{\pi}X_1(\omega)X_2^*(\omega)d\omega$$

```

+++

### DTFT de Señales Periódicas

Si se admiten como posibles transformadas los **impulsos**, puede ampliarse la clase de funciones en tiempo que son transformables Fourier para incluir a las funciones periódicas.

Consideremos la señal periódica senoidal

$$x(n)=e^{j\omega_0}n$$

Su transformada de Fourier (calculada aplicando la definición) resulta:

$$X(\omega)=\sum_{n=-\infty}^{\infty}e^{j\omega_0n}e^{j\omega n}=\sum_{n=-\infty}e^{-j(\omega-\omega_0)n}$$

Puede probarse que resulta un tren de impulsos de la forma:

$$X(\omega)=2\pi\sum_{l=-\infty}^{\infty}\delta(\omega-\omega_0-2\pi l)$$


Para ver esto, basta con calcular la Transformada Inversa y verificar que es igual a $x(n)$. En efecto

$$
\begin{align*}
  \frac{1}{2}\int_{-\pi}^{\pi}X(\omega)e^{j\omega n}d\omega&=\int_{-\pi}^{\pi}\sum_{l=-\infty}^{\infty}\delta(\omega-\omega_0-2\pi l)e^{j\omega n}dw\\
  &=\int_{-\pi}^{\pi}e^{j\omega n}\delta(\omega-\omega_0-2\pi l)d\omega\\
  &=e^{j(\omega_0+2\pi l)n}\\
  &=e^{j\omega_0 n}\\
  &=x(n)
\end{align*}
$$

+++

En el pasaje del segundo renglón se usó el hecho de que siempre existe un indice $l$ de manera que la frecuencia $(\omega_0+2\pi l)$ cae en el intervalo $[\pi, -\pi]$.

Consideremos ahora una señal $x(n)$ periódica con período $N$, representada con su Serie de Fourier

$$x(n)=\sum_{k=0}^{N-1}c_{k}e^{j\dfrac{2\pi kn}{N}}$$

Su transformada de Fourier resulta entonces:

$$
X(\omega)=2\pi\sum_{k=0}^{N-1}c_k\sum_{l=-\infty}^{\infty}\delta\left(\omega\dfrac{2\pi k}{N}-2\pi l\right)
$$

Es decir que la Transformada de Fourier de una señal periódica puede calcularse en forma directa a partir de sus coeficientes de Fourier $c_k$.

+++

### Ejemplo señal senoidal

$$x(n)=\cos\omega_0n=\frac{1}{2}e^{j\omega_0n}+\frac{1}{2}e^{-j\omega_0n}$$

La transformada de Fourier resulta entonces:

$$X(\omega)=\pi\sum_{l=-\infty}^{\infty}\delta(\omega-\omega_0-2\pi l)+\pi \sum_{l=\infty}^{\infty}\delta(\omega+\omega_0-2\pi l)$$

### Ejemplo tren de impulsos

$$x(n)=\sum_{k=-\infty}^{\infty}\delta(n-kN)$$

Los coeficientes de Fourier resultan

$$c_k=\frac{1}{N}\sum_{n=0}^{N-1}x(n)e^{-j\dfrac{2\pi k n}{N}}=\frac{1}{N}; \quad \forall k$$

por lo que la Transformada de Fourier resulta:

$$X(\omega)=\frac{2\pi}{N}\sum_{k=0}^{N-1}\sum_{l=-\infty}^{\infty}\delta\left(\omega-\frac{2\pi k}{N}-2\pi l\right)$$
