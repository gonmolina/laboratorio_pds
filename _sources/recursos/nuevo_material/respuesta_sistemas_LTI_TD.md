# Respuesta de Sistemas LTI en Tiempo Discreto

## Sistemas en Tiempo Discreto

```{figure} sistema_TD.png
:width: 80%
:name: rta_lti_td
:alt: rta_lti_td
:align: center

Respuesta de un sistema LTI en TD a entradas arbitrarias
```

$$u(n) \longrightarrow h(n)$$

Sea $H$ un operador entrada salida.

- Hay básicamente dos formas de anaizar la respuesta del sistema a una entrada arbitraria:
1. Resolviendo explícitamente la ecuación que describe el comportamiento entrada-salida. En general esta ecuación será de la forma:

$$y(n)=F[y(n-1), \cdots, y(n-N), u(n), \cdots, u(n-M)]$$

donde $F$ es una función posiblemente no lineal.

Para sistemas LTI, esta relación entrada salida toma la forma general:


$$
y(n)=-\sum_{k=1}^{N}a_k.y(n-k)+\sum_{k=0}^{M}b_k.u(n-k)
$$(eq_diferencias)

donde ${a_k}$ y ${b_k}$ son parámetros constantes.

La forma {eq}`eq_diferencias` se denomina **ecuación en diferencias** (de orden N).

2. Descomponiendo la señal de entrada en la combinación lineal de **señales elementales**, para las cuales sea "fácil" calcular la respuesta del sistema.

Luego, usando la propiedad de linealidad, la respuesta a la entrada arbitraria puede calcularse por **superposición** de las respuestas a las señales elementales.

Supongamos entonces:

$$y_k(n)=H[u_k(n)]$$

Luego:

$$
\begin{align*}
y(n)&=H[u(n)]=H\left[\sum_k c_k.u_k(n)\right]\\
&=\sum_k H\left[c_k.u_k(n)\right]\\
&=\sum_k c_k.H\left[u_k(n)\right]\\
&=\sum_k c_k.y_k(n)
\end{align*}
$$

Una señal elemental que facilita el análisis es el **impulso unitario $\delta(n)$** definido como:

$$
\delta(n)=\left\{
\begin{array}{cc}
1&\quad \text{si } n=0\\
0&\quad \text{si } n\neq 0
\end{array}
\right.
$$

que también es posible escribir como:

$$
\delta(n-k)=\left\{
\begin{array}{cc}
1&\quad \text{si } n=k\\
0&\quad \text{si } n\neq k
\end{array}
\right.
$$

Si adoptamos:

$$u_k(n)=\delta(n-k)$$

debemos encontrar los coeficiente $c_k$ tal que una señal se pueda escribir como:

\begin{align*}
u(n)&=\sum_k c_k.u_k(n)\\
&=\sum_k c_k.\delta(n-k)
\end{align*}

Notando que:

$$x(n)\delta(n-k)=x(k).\delta(n-k)$$

Podemos escribir:

$$
u(n)=\sum_{k=-\infty}^{\infty}u(k).\delta(n-k)
$$

La respuesta del sistema a la entrada $u(n)$ será entonces:

$$
\begin{align*}
y(n)&=H\left[u(n)\right]=H\left[\sum_{k=-\infty}^{\infty} u(k).\delta(k)\right]\\
&=\sum_{k=-\infty}^{\infty} H\left[u(k).\delta(k)\right]\\
&=\sum_{k=-\infty}^{\infty} u(k).H\left[\delta(k)\right]
\end{align*}
$$

Definimos:

$$H\left[\delta(n-k)\right]\triangleq h(n,k)$$

es la respuesta en el instante $n$ al impulso aplicado en $k$.

Con lo que resulta:

$$y(n)=\sum_{k=-\infty}^{\infty}u(k).h(n,k)$$

que es la suma de superposición.

Si el sistema es estacionario:

$$\delta(n) \longrightarrow h(n,0)=h(n)$$

$$\delta(n-k) \longrightarrow h(n,k)=h(n-k)$$

Con lo que resulta:

$$y(n)=\sum_{k=-\infty}^{\infty}u(k).h(n-k)$$

que es la **suma de convolución**.

```{important}
La respuesta de un Sistema Lineal e Invariante en el Tiempo (estacionario) a una entrada $u(n)$ es la convolución entre la entrada y la respuesta al impulso del sistema.
```

Denotamos:

$$u(n)*h(n)=\sum_{k=-\infty}^{\infty}u(k).h(n-k)$$

```{note}
Un sistema lienal e invariante en el tiempo queda completamente caracterizado por su respuesta al impulso $h(n)$.
```

### Ejemplo 1

Se debe determinar la respuesta del sistema FIR (Finite Impulse Response) lineal e invariante en el tiempo con respuesta al impulso:

$$
h(n)={1,2,1,-1}
$$

a la entrada:

$$u(n)={1,2,3,1}$$


## Ejemplo 2

- $h(n)=a^n\mu(n), \quad 0<a<1$i
- $u(n)=\mu(n)$

La respuesta del sistema resulta:

$$
y(n)=h(n)*u(n)=\sum_{k=-\infty}^{\infty} h(k)u(n-k)
$$

Esto nos queda para este caso:

$$y(n)=h(n)*u(n)=\sum_{k=0}^{n} a^k=\frac{1-a^{n+1}}{1-a}\mu(n), \quad \forall n$$

Suma finita de tipo geométrica.


