%======================================================================
%
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo
%
%  Least-square  : n  = 1     First order plant
%                  n* = 1     Relative degree
%                  np = 2     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%======================================================================
function dx = ls01(t,x)

global filter_param ref_dc ref_ampl ref_w thetas;

theta = x(1:2);
uf = x(3);
yf = x(4);
p = x(5:end);
P = reshape(p,sqrt(length(p)),sqrt(length(p)));

%--------------------------
r = ref_dc + ref_ampl*sin(ref_w*t) + ref_ampl*sin(2*ref_w*t);

phi = [uf' yf']';
y = thetas'*phi;

u = r;
duf = [ u - flip(filter_param)'*uf ]';
dyf = [ y - flip(filter_param)'*yf ]';

yhat = theta'*phi;

epsilon = yhat - y;

m2 = 1 + phi'*P*phi;

dtheta = -P*phi*epsilon/m2;
dP = -P*(phi*phi')*P/m2;
dp = reshape(dP,length(dP)^2,1);

%--------------------------
dx = [dtheta' duf' dyf' dp']';    %Translation

%---------------------------
