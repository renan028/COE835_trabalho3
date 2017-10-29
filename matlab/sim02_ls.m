%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  Least-square  : n  = 2     Second order plant
%                  n* = 1     Relative degree
%                  np = 4     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%----------------------------------------------------------------------
clear;
clc;

disp('-------------------------------')
disp('Script para simular o algoritmo LeastSquare')
disp(' ')
disp('Caso: Planta ............. n = 1')
disp('      Grau relativo ..... n* = 1')
disp('      Parâmetros ........ np = 2')
disp(' ')
disp('Algoritmo: Gradiente')
disp(' ')
disp('-------------------------------')

global filter_param dc a w thetas;

P0 = eye(4);
p0 = reshape(P0,length(P0)^2,1);

plant_param = [1 1 4 4]';
filter_param = [2 1]';

dc = 1;
a  = 5;
w  = 1;

uf0 = [0 0]';
yf0 = [0 0]';
theta0 = zeros(4,1);

%-----------------------
thetas = [plant_param(1:2)' (filter_param-plant_param(3:4))']'; 

%-----------------------
clf;
tf = 200;

init = [theta0' uf0' yf0' p0'];

options = odeset('OutputFcn','odeplot');
[T,X] = ode23s('ls02',tf,init,options);

theta = X(:,1:4)';
uf = X(:,5:6)';
yf = X(:,7:8)';

phi = [uf' yf']';
y = thetas.'*phi;

yhat = dot(theta, phi);

epsilon = yhat - y;
r = dc + a*sin(w.*T) + a*sin(2*w.*T)+ a*sin(3*w.*T) + a*sin(4*w.*T);
modtt = sqrt(sum(theta'.^2,2))';


figure(1)
clf
thetas = thetas.* ones(4,length(T));
plot(T,theta,T,thetas);grid;shg
legend('\theta','\theta_s','Location','SouthEast')
print -depsc2 ls01theta

figure(2)
clf
plot(T,modtt);grid;shg
legend('|\theta|','Location','SouthEast')
print -depsc2 ls01modtt

figure(3)
clf
plot(T,epsilon);grid;shg
legend('\epsilon','Location','SouthEast')
print -depsc2 ls01eps

%---------------------------------------------------------------------

