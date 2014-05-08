function [con_neq,con_eq]=cona(xx,n,V0)
% n - rozmiar stanu xx - stan-sterowanie V0 -  oczekiwana wartosc zaklocenia
s=size(xx);
m=s(1)-n;
u=xx(n+1:n+m);
xn=xx(1:n);
con_neq=[]; 
% brak ogr nierownosciowych
con_eq=transf(xn,u,V0,n,m)-xn;
