function lq1()

%funkcja podstawowa do rozwiazania zad 8-1 LQ1
%Katarzyna Olszewska, £ukasz Korpal

%zaklocenia
w0 = [0.1]; 
%rozmiar stanow
n = 2; 
%rozmiar sterowan
m = 1; 

%pkt poczatkowy optymalizacji
xx0 = [1;2;3]; 

%wyznaczamy pkt optymalny
xx=fmincon(@(x)fun1(x,n,w0),xx0,[],[],[],[],[],[],@(x)cona(x,n,w0));

%na jego podstawie sterowanie i stan
us = xx((n+1):(n+m)); xs = xx(1:n);

disp('Fmincon:');
disp(xx);
%   x1=-5.5489; x2=-0.1905; u=3.9121;
%disp('Sprawdzenie:')
%disp(transf(xx(1:n),xx(n+1:n+m),w0,n,m) - xs);

[A,B,C,G,R,r,Q,q,H] = model_lin(xs,us, w0);
[D,ud,xd,An,Bn,Cn,Gn,Qn,Rn] = model_lin_now(A,B,C,G,R,r,Q,q,H,n);
[S, T] = ster_opt(An, Bn, Cn, Qn, Rn, n);

%symulacja - ustalony stan pocz¹tkowy
xa = [xx(1);xx(2)];
%xa = [-5.5469; -0.5196]
%xa = [-5.5479;-0.3]
amp = 0;

ua = [];
J = [];
x = []; 

%przeprowadzamy symulacje
for k=1:20
    x = xa (:, size(xa,2));
    xp = x - xs;
    xb = xp - xd;
    uop = -inv(Bn'*S*B + Rn)*B'*(0.5*T'+S*(An*xb + Cn));
    uob = uop + D * xb + ud;
    uo = uob + us;
    ua = [ua uo];
    
    
    w = w0 + amp*randn(n,1);
    
    
    xk1 = transf(x,uo,w,n,m);
    xa = [xa xk1];
    J = [J wskjak(xk1,uo,n,m)];
end


disp(J);
disp(xa);

%stany
figure(1);
surf(xa);




end