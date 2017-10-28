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
disp('Script para simular o exemplo 9')
disp(' ')
disp('Caso: Planta ............. n = 1')
disp('      Grau relativo ..... n* = 1')
disp('      Parâmetros ........ np = 2')
disp(' ')
disp('Algoritmo: MRAC direto')
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

gamma = [2 0; 0 2];

uf0 = [0 0 0]';
yf0 = [0 0 0]';
ym0 = 0;
theta0 = zeros(6,1);

%-----------------------
thetas = [plant_param(1:3)' filter_param-plant_param(4:6)']' 

%-----------------------
clf;
tf = 25;

init = [ym0 theta0 uf0 yf0];

options = odeset('OutputFcn','odeplot');
[T,X] = ode23s('gradiente',tf,init,options);

ym     = X(1);
theta = X(2:7);
uf = X(8:10);
yf = X(11:13);

phi = [uf' yf']'
y = thetas'*phi;

yhat = theta'*phi;

epsilon = yhat - y;
e =  y - ym;
r = dc + a.*sin(w.*T);
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
plot(T,theta1,T,theta2);grid;shg
legend('\theta_1','\theta_2','Location','SouthEast')
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

