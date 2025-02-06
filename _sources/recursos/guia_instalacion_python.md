# Guía de instalación de las herramientas computacionales

## Descargar Miniforge

Miniforge es una herramientas de gestión de paquetes y entornos de Python.
Los entornos de Python nos brindan las posibilidad de instalar todas las bibliotecas que utilicemos para nuestro propósitos particulares, en nuestro caso resolver los problemas de la materias de control, sin interferir con otras instalaciones de Python que se tengan en el sistema operativo o para otros propósitos.

El link de descarga es el siguientes

- [Miniforge](https://github.com/conda-forge/miniforge/releases)

Seguir el enlace de  y elegir la última versión disponible para su sistema operativo.

Si ya se cuenta con una instalación de Anaconda, entonces ya se dispone del gestor de entornos utilizado, y se puede obviar tanto este paso como el siguiente.

## Instalar Miniforge

Seguir las recomendaciones por defecto dadas por el instalador. 
Durante el proceso de instalación en windows se presentarán varios un cuadros de diálogos. 
En general es conveniente aceptar las opciones recomendadas por defecto. La mismas incluyen:  
- Instalar miniforge solo para el usuario actual 
- Dejar el directorio de instalación por defecto
Cuando aparece el cuadro de dialogo de las opciones avanzadas de instalación seleccionar solo:
- la opción de crear los atajos en el menú de inicio
- la opción de registrar el  Python de miniforge como default para el usuario  
Una vez terminada la instalación tendremos Python instalado en nuestro sistema. 
Además tendremos en el menú de inicio una carpeta
que se llama `Miniforge3` con un item dentro `Miniforge Prompt`, el cual abriremos para continuar con la instalación de las herramientas del curso.


## Instalación de las herramientas especificas del curso

Para continuar con la instalación necesitaremos descargar el archivo [dyc.yml](https://drive.google.com/file/d/1KPSj-89Q4wTa5ifQvaCoa0_ohCtBXUGf/view?usp=sharing) haciendo click sobre el enlace anterior. Una vez descargado, dirigirse con la consola de Anaconda Powershell Prompt abierta a la carpeta de descargas donde se encuentra el archivo `dyc.yml` descargado anteriormente. En general, para dirigirse a esta carpeta debemos tipear

```bash
cd ~\Downloads\
```

Para verificar que el archivo se encuentre ahí, podemos tipear:

```bash
dir dyc.yml
```

Si nos encontramos en la carpeta donde está el archivo este deberá aparecer luego del comando anterior.

Finalmente para instalar todas las herramientas necesarias en el curso debemos ejecutar en este comando:

```bash
conda env create --file dyc.yml
```

Una vez terminado este paso tendremos instaladas todas las herramientas necesarias para la materia. Este paso puede tardar un tiempo largo dependiendo de la velocidad de conexión.

Finalmente, tendremos todas las herramientas del curso preparadas para ser utilizadas en nuestras computadoras personales.

## Interfaces de programación

Los cuadernos se pueden ver/ejecutar en cualquier entorno de desarrollo de python con soporte a los cuadernos de Jupyter. Los recomendados para este curso son:
- Jupyter Lab: es un editor web que se encuentra instalado con las herramientas del curso
- Visual Studio Code: es un editor de código abierto mantenido por Microsoft que permite ver y ejecutar cuadernos de Jupyter. Se puede descargar muy fácilmente de la web.
- Otras opciones:
    - Spyder: se puede instalar mediante desde el `Miniforge Prompt` con los siguientes comandos 
    ```bash
    mamba activate dyc
    mamba install spyder
    ```
    Este entorno de desarrollo provee una interface muy parecida a la de Matlab lo cuál es una ventaja para quien está acostumbrado a este software, pero es mucho más pesado que los anteriores.
    - PyCharm: Entorno profesional para desarrollo de Python que tiene una versión sin costo con algunas limitaciones.

## Otras herramientas necesarias/utiles

### PRBS Generatos

Es una paquete de Python para generar señales pseudo aleatorias binarias. Actualmente está en desarrollo, pero puede descargarse una versión de pruebas desde el repositorio de pruebas de paquetes Python. Para instalarlo en sus maquines pueden hacerlo abriendo el `Prompt Miniforge` y ejecutando:

```bash
pip install -i https://test.pypi.org/simple/ prbs-generator
```

Una vez instalado, podemos generar una onda pseudo aleatoria binaria con el siguiente código:

```python
from prbs.prbs import prbs
signal=prbs(1000, 12)
```
Esto genera una señal pseudo aleatoria de dimensión 1000 con valores en multiplicidad $n.12$ con $n=1\ldots$, resultando en un espectro plano en las frecuencias $\left[0,\dfrac{F_s}{2.12}\right]$, siendo $F_s$ la frecuencia de muestro.

