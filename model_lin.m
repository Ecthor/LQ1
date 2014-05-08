function [A,B,C,G,R,r,Q,q,H] = model_lin(xs,us,ws)
%wyznacza model liniowy
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