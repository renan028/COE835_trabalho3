%======================================================================
%
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo
%
%  Gradiente  : n  = 2     Second order plant
%               n* = 1     Relative degree
%               np = 4     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%======================================================================
function dx=gradiente02(t,x)

global filter_param dc A W gamma thetas;

theta = x(1:4);
uf = x(5:6);
yf = x(7:8);

%--------------------------
r = dc;
for i=1:length(A)
    r = r + A(i)*sin(W(i)*t);
end

phi = [uf' yf']';
y = thetas'*phi;

u = r;
duf = [uf(2:end)' u-(flip(filter_param)'*uf)]';
dyf = [yf(2:end)' y-(flip(filter_param)'*yf)]';


yhat = theta'*phi;

epsilon = yhat - y;

m2 = 1 + phi'*phi;

dtheta = -gamma*phi*epsilon/m2;

%--------------------------
dx = [dtheta' duf' dyf']';    %Translation

%---------------------------
