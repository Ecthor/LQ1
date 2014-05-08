function [S, T] = ster_opt(An, Bn, Cn, Qn, Rn, n)
%wyznacza optymalne sterowanie
[F,S] = dlqr(An, Bn, Qn, Rn);
T = 2*Cn'*S*(eye(n)-Bn*inv(Bn'*S*Bn+Rn)*Bn'*S)*An*inv(eye(n)-An+Bn*inv(Bn'*S*Bn+Rn)*Bn'*S*An);

end