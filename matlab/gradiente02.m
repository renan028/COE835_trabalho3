%======================================================================
%
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo
%
%  Gradiente  : n  = 2     First order plant
%               n* = 1     Relative degree
%               np = 4     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%======================================================================
function dx=gradiente02(t,x)

global filter_param dc a w gamma thetas;

theta = x(1:4);
uf = x(5:6);
yf = x(7:8);

%--------------------------
r = dc + a*sin(w*t) + a*sin(2*w*t)+ a*sin(3*w*t) + a*sin(4*w*t);

phi = [uf' yf']';
y = thetas'*phi;

u = r;
duf = [uf(2)' u-(flip(filter_param)'*uf)]';
dyf = [yf(2)' y-(flip(filter_param)'*yf)]';


yhat = theta'*phi;

epsilon = yhat - y;

m2 = 1 + phi'*phi;

dtheta = -gamma*phi*epsilon/m2;

%--------------------------
dx = [dtheta' duf' dyf']';    %Translation

%---------------------------
