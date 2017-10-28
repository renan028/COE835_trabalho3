%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  MRAC  : n  = 3     First order plant
%          n* = 1     Relative degree
%          np = 6     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%----------------------------------------------------------------------
clear;
clc;

disp('-------------------------------')
disp('Script para simular o algoritmo Gradiente')
disp(' ')
disp('Caso: Planta ............. n = 3')
disp('      Grau relativo ..... n* = 1')
disp('      Parāmetros ........ np = 6')
disp(' ')
disp('Algoritmo: Gradiente')
disp(' ')
disp('-------------------------------')

global filter_param dc a w gamma thetas am km;

am = 1;

plant_param = -5 + 10 * rand(6,1);
filter_param = [3 3 1]';

dc = 1;
a  = 1;
w  = 1;
km= 1;

gamma = 2*eye(6);

uf0 = [0 0 0]';
yf0 = [0 0 0]';
ym0 = 0;
theta0 = zeros(6,1);

%-----------------------
thetas = [plant_param(1:3)' (filter_param-plant_param(4:6))']'; 

%-----------------------
clf;
tf = 25;

init = [ym0 theta0' uf0' yf0']';

options = odeset('OutputFcn','odeplot');
[T,X] = ode23s('gradiente',tf,init,options);

ym     = X(:,1);
theta = X(:,2:7)';
uf = X(:,8:10)';
yf = X(:,11:13)';

phi = [uf' yf']';
y = thetas.'*phi;

yhat = theta.'*phi;

epsilon = yhat - y;
e =  y - ym;
r = dc + a*sin(w.*T) + a*sin(2*w.*T) + a*sin(3*w.*T) + a*sin(4*w.*T);
modtt = theta'*theta;

figure(1)
clf
subplot(211)
plot(T,r,T,ym,T,y);grid;shg
legend('r','y_m','y','Location','SouthEast')
print -depsc2 fig01a

figure(2)
clf
subplot(211)
plot(T,theta);grid;shg
legend('\theta','Location','SouthEast')
print -depsc2 fig01b

figure(3)
clf
subplot(211)
plot(T,e);grid;shg
legend('e','Location','SouthEast')
print -depsc2 fig01c

figure(4)
clf
subplot(211)
plot(T,modtt);grid;shg
legend('|\theta|','Location','SouthEast')
print -depsc2 fig01d

%---------------------------------------------------------------------

