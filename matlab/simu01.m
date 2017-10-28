%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  MRAC  : n  = 1     First order plant
%          n* = 1     Relative degree
%          np = 2     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%----------------------------------------------------------------------
clear;
clc;

disp('-------------------------------')
disp('Script para simular o algoritmo Gradiente')
disp(' ')
disp('Caso: Planta ............. n = 1')
disp('      Grau relativo ..... n* = 1')
disp('      Parâmetros ........ np = 2')
disp(' ')
disp('Algoritmo: Gradiente')
disp(' ')
disp('-------------------------------')

global filter_param dc a w gamma thetas am;

am = 1;

plant_param = [1 2]';
filter_param = [1]';

dc = 1;
a  = 5;
w  = 1;

gamma = 10*eye(2);

uf0 = [dc]';
yf0 = [0]';
theta0 = zeros(2,1);

%-----------------------
thetas = [plant_param(1)' (filter_param-plant_param(2))']'; 

%-----------------------
clf;
tf = 25;

init = [theta0' uf0' yf0']';

options = odeset('OutputFcn','odeplot');
[T,X] = ode23s('gradiente01',tf,init,options);

theta = X(:,1:2)';
uf = X(:,3)';
yf = X(:,4)';

phi = [uf' yf']';
y = thetas.'*phi;

yhat = dot(theta, phi);

epsilon = yhat - y;
r = dc + a*sin(w.*T);
modtt = sqrt(sum(theta'.^2,2))';


figure(1)
clf
thetas = thetas.* ones(2,length(T));
plot(T,theta,T,thetas);grid;shg
legend('\theta','\theta_s','Location','SouthEast')
print -depsc2 fig02

figure(2)
clf
plot(T,modtt);grid;shg
legend('|\theta|','Location','SouthEast')
print -depsc2 fig03

figure(3)
clf
plot(T,epsilon);grid;shg
legend('\epsilon','Location','SouthEast')
print -depsc2 fig04

%---------------------------------------------------------------------

