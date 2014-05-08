function lq1()

%Katarzyna Olszewska, £ukasz Korpal
n = 2; %rozmiar wektora stanu
m = 1; %rozmiar wektora sterowania
w0 = [0.1]; %wektor zaklocen

xx0 = [1;2;3]; %pkt poczatkowy optymalizacji
xx=fmincon(@(x)fun1(x,n,w0),xx0,[],[],[],[],[],[],@(x)cona(x,n,w0));



xs = xx(1:n);
us = xx((n+1):(n+m));

disp('Fmincon:');
disp(xx);
%   x1= -5.5489
%   x2= -0.1905
%   u=  3.9121

disp('Sprawdzenie:')
disp(transf(xx(1:n),xx(n+1:n+m),w0,n,m) - xs);

% Oblicza model liniowy
[A,B,C,G,R,r,Q,q,H] = model_lin(xs,us, w0)


% Podstawienie, by wskaznik zawiera³ tylko R i Q
[D,ud,xd,An,Bn,Cn,Gn,Qn,Rn] = model_lin_now(A,B,C,G,R,r,Q,q,H,n);


% Optymalne sterowanie
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


%zbieznosc wskaznika jakosc
figure(1);
plot(J);

%zbieznosc stanu
figure(2);
surf(xa);




end

%model liniowy wstepny
function [A,B,C,G,R,r,Q,q,H] = model_lin(xs,us,ws)

C = [0;0];

if us(1) < 0.4
    g=0.4;
elseif us(1) < 1
    g=us(1);
else
    g=1;
end
q = [0.2*g^2*xs(1); 2*xs(2)];

A = [1.8, 0; 0.3*(1 - us(1)),0.2];  % przy xs
B = [0.01; -0.3*xs(1)];         % przy us 
G = [1; 0]; %przy vs

r = 0.2 * us(1);
R = [0.5*0.2];
Q = [0.5*0.2*g^2 , 0 ; 0 , 1];
H = [0, 0];

end

%model liniowy 
function [D, ud, xd, An, Bn, Cn, Gn, Qn, Rn] = model_lin_now(A,B,C,G,R,r,Q,q,H,n)

%ze skryptu
D = -0.5*inv(R)*H;
xd = inv(2*Q - 0.5*H'*inv(R)*H)*(0.5*H'*inv(R)*r - q);
ud = - 0.5*inv(R)*(r + H*xd);

An = inv(eye(n) - B*D)*A;
Bn = inv(eye(n) - B*D)*B;
Gn = inv(eye(n) - B*D)*G;
Cn = inv(eye(n) - B*D)*(C - xd + A*xd + B*ud);

Qn = D'*R*D + Q + D'*H;
Rn = R;

end


%optymalne sterowanie
function [S, T] = ster_opt(An, Bn, Cn, Qn, Rn, n)

[F,S] = dlqr(An, Bn, Qn, Rn);
T = 2*Cn'*S*(eye(n)-Bn*inv(Bn'*S*Bn+Rn)*Bn'*S)*An*inv(eye(n)-An+Bn*inv(Bn'*S*Bn+Rn)*Bn'*S*An);

end