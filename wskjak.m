function [jk]=wskjak(xn,u,n,m)
% xn - stan x[k+1]
% u - sterowanie u[k]
% n - rozmiar wektora stanu
% m - rozmiar wektora sterowania
if u < 0.4
    g=0.4;
elseif u < 1
    g=u;
else
    g=1;
end
 
jk = 0.1 * g^2 * xn(1)^2 + xn(2)^2 + 0.1 * u(1)^2;