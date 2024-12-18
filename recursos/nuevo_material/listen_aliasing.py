#%% 
# Script de ejemplo de como escuchar el aliasing
#
#%%
import numpy as np
from scipy.io.wavfile import write as wavwrite

F1=440              # Nota "La" (440 Hz)
F2=440*1.5          # Nota una quinta justa superior:  "Mi" (660 Hz)
Fs=10000            # Frecuencia de muestreo adecuada
# t=[0:1/Fs:2-1/Fs]'  
t=np.linspace(0,2,2*Fs, endpoint=False) # duracion de las señales 2 seg.
x1a=np.cos(2*np.pi*F1*t, dtype=np.float32)
x2a=np.cos(2*np.pi*F2*t, dtype=np.float32)
xa=np.hstack((x1a, x2a))        # duracion total 2+2=4 seg

#%%
Fsi=1050            #  frecuencia de muestreo incorrecta para X2a
# n=[0:1:2*Fsi-1]'
n=np.linspace(0, 2*Fsi, 2*Fsi, endpoint=False)
x1=np.cos(2*np.pi*F1*n/Fsi, dtype=np.float32);
x2=np.cos(2*np.pi*F2*n/Fsi, dtype=np.float32);
# x=[x1;x2];
x=np.hstack((x1, x2))        # duracion total 2+2=4 seg

#%%
#=============================
# Escuchemos la señal original
# la salvamos en un archivo y la reproducimos con cualquier reproductor
#=============================
wavwrite("señal_ok.wav", Fs, xa)

#%% 
#================================
# Escuchemos la señal muestreada
# con frecuencia incorrecta Fsi
#================================
wavwrite("señal_no_ok.wav", Fsi, x)
#============================================
# Que nota aparece por el aliasing ?
# Es un "Sol" 1 tono debajo del "La" 440 Hz ?
#============================================
# %%
