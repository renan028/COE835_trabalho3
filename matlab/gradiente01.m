%======================================================================
%
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo
%
%  Gradiente  : n  = 1     First order plant
%               n* = 1     Relative degree
%               np = 2     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%======================================================================
function dx=gradiente01(t,x)

global filter_param dc a w gamma thetas;

theta = x(1:2);
uf = x(3);
yf = x(4);

%--------------------------
r = dc + a*sin(w*t) + a*sin(2*w*t);

phi = [uf' yf']';
y = thetas'*phi;

u = r;
duf = [u-(flip(filter_param)'*uf)]';
dyf = [y-(flip(filter_param)'*yf)]';


yhat = theta'*phi;

epsilon = yhat - y;

m2 = 1 + phi'*phi;

dtheta = -gamma*phi*epsilon/m2;

%--------------------------
dx = [dtheta' duf' dyf']';    %Translation

%---------------------------
