function y=convolucion(u,h)
%======================================
% y=convolucion(u,h)
% "u" y "h" deben ser vectores columna
%======================================
c=[h;zeros(length(u)-1,1)];
r=[h(1) zeros(1,length(u)-1)];
H=toeplitz(c,r);
y=H*u;
nu=[0:1:length(u)-1];
nh=[0:1:length(h)-1];
ny=[0:1:length(y)-1];
subplot(311)
stem(nu,u)
ylabel('u(n)')
subplot(312)
stem(nh,h)
ylabel('h(n)')
subplot(313)
stem(ny,y)
ylabel('y(n)=u(n)*h(n)')
xlabel('Indice n')