---
jupytext:
  formats: ipynb,md:myst
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.13
    jupytext_version: 1.16.7
kernelspec:
  display_name: Python 3
  language: python
  name: python3
---

# Función transferencia

+++ {"slideshow": {"slide_type": "slide"}}

## Modelos de sistemas lineales e invariantes en el tiempo

La forma típica de representar un sistema lineal e invariante en el tiempo (LTI) SISO, es mediante el uso de la transformada de Laplace.

Sea un sistema con condiciones iniciales nulas, entonces el sistema se puede expresar matemáticamente como:

$$\frac{Y(s)}{U(s)}=H(s)$$

donde $Y(s)$ es la transformada de Laplace de la salida $y(t)$ para una entrada arbitraria $u(t)$, cuya transformada de Laplace es $U(s)$. 

Notar que con esta definición, lo que se transforma al dominio de Laplace son las **señales** de entrada y salida. No es un sistema.

+++

```{admonition} Importante
:class: important

- Se puede demostrar **que** $H(s)$ **es la respuesta del sistema a una señal de entrada impulso unitario** $\delta(t)$.
- Para sistemas Lineales Invariantes en el Tiempo (LTI), la relación $\dfrac{Y(s)}{U(s)}$ se mantiene constante para todo $U(s)$.
```

+++

### Obtención de la función transferencia de un sistema:

La función transferencia de un sistema se puede obtener de varias formas:

1. Aplicando la definición, es decir, aplicando $u(t)$ para medir $y(t)$, transformar ambas señales al dominio de Laplace y luego obtener $H(s)=\dfrac{Y(s)}{U(s)}$. Esto no es práctico.
1. Aplicar un impulso $u(t)=\rho(t)$ y hacer las transformada de Laplace de la respuesta. Es un caso particular del método anterior haciendo que $U(s)=1$.
1. A partir de las ecuaciones temporales que dominan la dinámica del sistema se resuelve $\dfrac{Y(s)}{U(s)}$. Esta es la forma en que por lo general se obtienen las funciones transferencias de los sistemas en forma analítica.


```{admonition} Importante
:class: important

En general los sistemas dinámicos en el dominio temporal se describen matemáticamente a partir de ecuaciones diferenciales. 
Es importante notar, que en el dominio transformado de Laplace estas ecuaciones diferenciales se transforman en ecuaciones algebraicas, resultando en un tratamiento matemático más sencillo.
```
+++

## Ejemplo: Sistema electromecánico (motor eléctrico)

### Desarrollo

Supongamos CI nulas, es decir $i_a(t=0)=0$ y $(\theta_m(t=0)=0)$ entonces de las ecuaciones del motor obtenidas en ejemplos anteriores y aplicando la transformada de Laplace, tenemos:

$$ 
\left\{\begin{array}{c}
s~I_a(s) = \frac{1}{L_a} E_a(s) -\frac{ R_a}{L_a} I_a(s) -  \frac{K_b}{L_a} s~\Theta_m(s)  \\
s^2~\Theta_m(s) =   \frac{K_t}{J_m} I_a(s) - \frac{D_m}{J_m}s~\Theta_m(s) - \frac{1}{J_m} T_r(s)
\end{array}\right.
$$

+++

agrupando las variables y despejando de la segunda ecuación la corriente $I_a(s)$:

$$ 
\begin{aligned}
\left(s+ \frac{ R_a}{L_a}\right)I_a(s) &= \frac{1}{L_a} E_a(s) - \frac{K_b}{L_a} s~\Theta_m(s)  \\
 I_a(s) &= \frac{J_m}{K_t}\left(s^2+ \frac{D_m}{J_m}s\right)~\Theta_m(s) + \frac{1}{K_t} T_r(s)
\end{aligned}
$$

+++

Este sistema tiene 2 entradas, la entrada que podemos controlar $E_a(s)$ y la entrada de perturbación $T_r(s)$, por ser un sistema LTI podemos hallar las FTs de la siguiente forma:

$$ 
\left(s+ \frac{ R_a}{L_a}\right)\frac{J_m}{K_t}\left(s^2+ \frac{D_m}{J_m}s\right)\Theta_m(s) + \left(s+ \frac{ R_a}{L_a}\right)\frac{1}{K_t} T_r(s) = \frac{1}{L_a} E_a(s) - \frac{K_b}{L_a} s\Theta_m(s) 
$$

luego,

$$ 
\left(\left(s+ \frac{ R_a}{L_a}\right)~\frac{J_m}{K_t}\left(s^2+ \frac{D_m}{J_m}s\right)+\frac{K_b}{L_a} s\right)\Theta_m(s)  = \frac{1}{L_a} E_a(s) - \left(s+ \frac{ R_a}{L_a}\right)\frac{1}{K_t} T_r(s)
$$

+++

luego considerando $T_r=0$, obtenemos la FT desde la entrada $E_a$ a la salida $\Theta_m$:

$$ 
\frac{\Theta_m(s)} {E_a(s)}  = \frac{\frac{1}{L_a}}{\left(s+ \frac{ R_a}{L_a}\right)\frac{J_m}{K_t}\left(s^2+ \frac{D_m}{J_m}s\right)+\frac{K_b}{L_a} s}  
$$

finalmente si consideramos que $E_a=0$, hallamos la FT desde la entrada de perturbación $T_r$ a la salida $\Theta_m$:

$$
\frac{\Theta_m(s)} {T_r(s)}  =- \frac{\left(s+ \frac{ R_a}{L_a}\right)\frac{1}{K_t} }{\left(s+ \frac{ R_a}{L_a}\right)\frac{J_m}{K_t}\left(s^2+ \frac{D_m}{J_m}s\right)+\frac{K_b}{L_a} s}
$$

+++ {"slideshow": {"slide_type": "slide"}}


