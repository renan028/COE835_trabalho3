%======================================================================
%
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo
%
%  Least-square  : n  = 3     First order plant
%                  n* = 1     Relative degree
%                  np = 6     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%======================================================================
function dx=ls03(t,x)

global filter_param dc a w thetas;

theta = x(1:6);
uf = x(7:9);
yf = x(10:12);
p = x(13:end);
P = reshape(p,sqrt(length(p)),sqrt(length(p)));

%--------------------------
r = dc + a*sin(w*t) + a*sin(2*w*t)+ a*sin(3*w*t) + a*sin(4*w*t);

phi = [uf' yf']';
y = thetas'*phi;

u = r;
duf = [uf(2:3)' u-(flip(filter_param)'*uf)]';
dyf = [yf(2:3)' y-(flip(filter_param)'*yf)]';


yhat = theta'*phi;

epsilon = yhat - y;

m2 = 1 + phi'*P*phi;

dtheta = -P*phi*epsilon/m2;
dP = -P*(phi*phi')*P/m2;
dp = reshape(dP,length(dP)^2,1);

%--------------------------
dx = [dtheta' duf' dyf' dp']';    %Translation

%---------------------------
