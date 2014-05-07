function [f]=fun1(xx,n,V0)
% xx - wektor zmiennych decyzyjnych, stan-sterowanie
% n - rozmiar stanu
% V0 - wartosc oczekiwana zaklocenia
s=size(xx);
m=s(1)-n;
xn=xx(1:n); % wyodr�bnienie stanu
u=xx(n+1:n+m); % wyodr�bnienie sterowania
f=wskjak(xn,u,n,m);
