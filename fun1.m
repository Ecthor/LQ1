function [f]=fun1(xx,n,V0)
% n - rozmiar stanu xx - stan-sterowanie V0 -  oczekiwana wartosc zaklocenia
s=size(xx);
m=s(1)-n;
xn=xx(1:n); % wyodrêbnienie stanu
u=xx(n+1:n+m); % wyodrêbnienie sterowania
f=wskjak(xn,u,n,m);
