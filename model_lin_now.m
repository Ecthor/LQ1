function [D, ud, xd, An, Bn, Cn, Gn, Qn, Rn] = model_lin_now(A,B,C,G,R,r,Q,q,H,n)
%wyznacza nowy model liniowy
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
