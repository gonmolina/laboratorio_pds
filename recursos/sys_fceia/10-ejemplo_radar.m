%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problema del RADAR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Modelo:  y(n) = alpha * x(n -D) + w(n)
%
% x(n): se�al transmitida
% y(n): se�al recibida
% w(n): se�al de ruido
% alpha: coeficiente de atenuacion
% D: retardo
% 
x= idinput(1000,'prbs',[0 0.08],[-1 1]);  % se�al pseudo aleatoria binaria
rxx=xcorr(x,x); % autocorrelacion de x(n)
Ex=sum(x.^2); % energia de la se�al x(n)
L=[-999:1:999]';
subplot(211)
plot(x)
ylabel('x(n)')
xlabel('indice "n" ')
subplot(212)
plot(L,rxx)
ylabel('rxx(l)')
xlabel('indice "l" ')
alpha=0.7; % coeficiente de atenuacion
w=randn(1000,1); % ruido blanco Gaussiano
y=alpha*[zeros(100,1);x(1:length(x)-100)]+w; %se�al recibida
ryx = xcorr(y,x); % correlacion cruzada
figure
plot(L,ryx)
ylabel('ryx(l)')
xlabel('indice "l" ')