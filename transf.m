function [xn]=transf(x,u,w,n,m)
% x - stan x[k]
% u - sterowanie u[k]
% w - zak³ócenie w[k]
% n - rozmiar stanu
% m - rozmiar sterowania
% xn - nowy stan x[k+1]
xn=zeros(n,1);
xn(1)=1.8*x(1)+w(1)+4.3;
xn(2)=0.2*x(2) + 0.3*x(1)*(1-u(1))-5;
