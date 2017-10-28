%======================================================================
%
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo
%
%  Gradiente  : n  = 3     First order plant
%               n* = 1     Relative degree
%               np = 6     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%======================================================================
function dx=gradiente(t,x)

global filter_param dc a w gamma am km thetas;

ym     = x(1);
theta = x(2:7);
uf = x(8:10);
yf = x(11:13);

%--------------------------
r = dc + a*sin(w*t) + a*sin(2*w*t) + a*sin(3*w*t) + a*sin(4*w*t);

phi = [uf' yf']';
y = thetas'*phi;
omega = [ y y y r r r]';

u = theta.'*omega;
duf = [uf(2:3)' u-(flip(filter_param)'*uf)]';
dyf = [yf(2:3)' y-(flip(filter_param)'*yf)]';


yhat = theta'*phi;

epsilon = yhat - y;

dym = -am*ym + km*r;

m2 = 1 + phi'*phi;

dtheta = -gamma*phi*epsilon/m2;

%--------------------------
dx = [dym dtheta' duf' dyf']';    %Translation

%---------------------------
