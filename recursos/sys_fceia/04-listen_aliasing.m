F1=440  % Nota "La" (440 Hz)
F2=440*1.5;  % Nota una quinta justa superior:  "Mi" (660 Hz)
Fs=10000;  % Frecuencia de muestreo adecuada
t=[0:1/Fs:2-1/Fs]';  % duracion de las se�ales 2 seg.
x1a=cos(2*pi*F1*t);
x2a=cos(2*pi*F2*t);
xa=[x1a;x2a];        % duracion total 2+2=4 seg
Fsi=1050;   %  frecuencia de muestreo incorrecta para X2a
n=[0:1:2*Fsi-1]';
x1=cos(2*pi*F1*n/Fsi);
x2=cos(2*pi*F2*n/Fsi);
x=[x1;x2];
%=============================
% Escuchemos la se�al original
%=============================
sound(xa,Fs)
%================================
% Escuchemos la se�al muestreada
% con frecuencia incorrecta Fsi
%================================
sound(x,Fsi)
%============================================
% Que nota aparece por el aliasing ?
% Es un "Sol" 1 tono debajo del "La" 440 Hz ?
%============================================