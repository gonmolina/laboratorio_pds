---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.1
---

# Correlación en tiempo discreto

## Correlación de señales en tiempo discreto

- la correlación de dos señales mide el grado de similitud de las mismas.
- aplicaciones en radar, sonar, comunicaciones digitales, reconocimiento de voz, etc.


### Ejemplo: radar

$$y(n)=\alpha x(n-D)+W(n)$$

donde $\alpha$ es el factor de atenuación, $W(n)$ es un ruido aditivo, $D$ es el retardo de la transmisión/recepción.


**Problema de radar**: determinar si existe un blanco, y si existe determinar el retardo $D$ que permite determinar la distancia.

- Si la componente de ruido es muy grande, la simple inspección de $y(n)$ no permitirá determinar si existe un blanco.
- Sin embargo, la correlación permitirá extraer esta información de $y(n)$

+++

## Secuencia de auto-correlación y correlación cruzada

Supongamos dos señales $x(n)$ e $y(n)$ de energía finita. La **secuencia de correlación cruzada** de las dos señales se define como:

$$r_{xy}(l)=\sum_{n=-\infty}^{\infty}x(n)y(n-l)\quad l=0,\pm 1, \pm 2, \ldots$$

o equivalentemente

$$r_{xy}(l)=\sum_{n=-\infty}^{\infty}x(n+l)y(n), \quad l=\pm 1, \pm 2, \ldots$$

- El orden de los subíndices en $r_{xy}(l)$ indica la dirección en que la primer señal es desplazada con respecto a la otra.

Similarmente se definen 

$$r_{yx}(l)=\sum_{n=-\infty}^{\infty}y(n)x(n-l)\quad l=0,\pm 1, \pm 2, \ldots$$

o equivalentemente

$$r_{yx}(l)=\sum_{n=-\infty}^{\infty}y(n+l)x(n), \quad l=\pm 1, \pm 2, \ldots$$

Es fácil verificar que

$$r_{xy}(l)=r_{yx}(-l)$$

por lo que $r_{xy}(l)$ provee exactamente la misma información que $r_{yx}(l)$.

Puede probarse que:

$$r_{xy}=x(l)y(-l)$$

- En el caso especial de $x(n)=y(n)$, se tiene la secuencia de autocorrelación de $x(n)$.

$$r_{xx}(l)=\sum_{n=-\infty}^{\infty}x(n)x(n-l)\quad l=0,\pm 1, \pm 2, \ldots$$

o equivalentemente

$$r_{xx}(l)=\sum_{n=-\infty}^{\infty}x(n+l)x(n), \quad l=\pm 1, \pm 2, \ldots$$

Si $x(n)$ e $y(n)$ son señales de duración finita $N$, resulta

$$r_{xy}(l)=\sum_{n=i}^{N-|k|-1}x(n)y(n-l)$$

y

$$r_{xx}(l)=\sum_{n=i}^{N-|k|-1}x(n)x(n-l)$$

donde:

$$
\begin{align*}
  i=l, k=0 &\quad \text{para } l\geq 0\\
  i=0, k=l &\quad \text{para } l<0
\end{align*}
$$


## Correlación de señales de potencia

- Para señales de potencia $x(n)$ e $y(n)$ la **correlación cruzada** se define 

$$r_{xy}(l)=\lim_{M\rightarrow \infty} \frac{1}{2M+1}\sum_{n=-M}^{M}x(n)y(n-l)$$

- Si $x(n)=y(n)$ resulta la **autocorrelación de la señal de potencia**

$$r_{xx}(l)=\lim_{M\rightarrow \infty} \frac{1}{2M+1}\sum_{n=-M}^{M}x(n)x(n-l)$$

- En particular, si $x(n)$ e $y(n)$ son **señales periódicas con período $N$**, estas dos últimas relaciones pueden computarse en un período.

$$r_{xy}(l)=\frac{1}{N}\sum_{n=0}^{N-1}x(n)y(n-l)$$

$$r_{xx}(l)=\frac{1}{N}\sum_{n=0}^{N-1}x(n)x(n-l)$$


- Es fácil ver que en esta caso $r_{xy}(l)$ y $r_{xx}(l)$ resultan secuencias periódicas de período $N$.

+++

## Secuencias de correlación de Entrada/Salida


La respuesta a una entrada arbitraria $u(n)$ es

$$
\begin{align*}
y(n)&=h(n)*u(n)\\
&=\sum_{k=-\infty}^{\infty}h(k)u(n-k)
\end{align*}
$$

La correlación entre la entrada y la salida es:

$$
\begin{align*}
  r_{yu}(l)&=y(l)*u(-l)\\
  &=h(l)*u(l)*u(-l)\\
  &=h(l)*r_{uu}(l)
\end{align*}
$$

Por lo que resulta:

$$r_{yu}(l)=h(l)*r_{uu}(l)$$

+++

- La relación anterior se puede emplear para la estimación de un número finito de términos de la respuesta al impulso ${h(n)}$ a partir dek cómputo de las secuencias de correlación entrada salid $r_{yu}(l)$ y de la autocorrelación de la entrada $r_{uu}(l)$.

- La autocorrelación de la salida resulta:

$$
\begin{align*}
r_{yy}(l)&=y(l)*y(-l)\\
&=[h(l)*u(l)]*[h(-l)*u(-l)]\\
&=[h(l)*h(-l)]*[u(l)*u(-l)]\\
&=r_{hh}(l)*r_{uu}(l)
\end{align*}
$$

**Nota** $r_{hh}(l)$ existe si el sistema es estable

+++

## Propiedades de la autocorrelación

- Simetría par

$$
\begin{align*}
r_{xx}(l)&=\sum_{n=-\infty}^{\infty}x(n+l)x(n)\\
&=\sum_{m=-\infty}^{\infty}x(m)x(m-l)
&=r_{xx}(-l)
\end{align*}
$$

donde se hizo el cambio de variables $m=n+l$.


- Autocorrelación y Energía de la señal

Calculemos la autocorrelación para $l=0$

$$r_{xx}=\sum_{n=-\infty}^{\infty}x(n+0)x(n)=\sum_{n=-\infty}^{\infty}x(n)^2=E_x$$

que es la **energía de la señal**.


- Autocorrelación de una señal periódica

Sea $x(n)$ una señal periódica con periodo $N$, es decir se verifica que:

$$x(n)=x(n+N)$$

Luego, la autocorrelación resulta

$$
\begin{align*}
  r_{xx}(l+N)&=\frac{1}{N}\sum_{n=0}^{N-1}x(n+N+l)x(n)\\
  &=\frac{1}{N}\sum_{n=0}^{N-1}x(n+l)x(n)\\
  &=r_{xx}(l)
\end{align*}
$$

Es decir, es periódica con periodo N.
