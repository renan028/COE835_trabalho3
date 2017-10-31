%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  Least-square  : n  = 3     Third order plant
%                  n* = 1     Relative degree
%                  np = 6     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%----------------------------------------------------------------------
clear;
clc;

disp('-------------------------------')
disp('Script para simular o algoritmo Least-square')
disp(' ')
disp('Caso: Planta ............. n = 3')
disp('      Grau relativo ..... n* = 1')
disp('      Parâmetros ........ np = 6')
disp(' ')
disp('Algoritmo: Gradiente')
disp(' ')
disp('-------------------------------')

global filter_param dc a w thetas;

plant_param = [1 3/5 9/100 3/2 3/4 1/8]';
filter_param = [3 3 1]';

P0 = eye(6);
p0 = reshape(P0,length(P0)^2,1);

dc = 1;
a  = 5;
w  = 1;


uf0 = [0 0 0]';
yf0 = [0 0 0]';
theta0 = zeros(6,1);

%-----------------------
thetas = [plant_param(1:3)' (filter_param-plant_param(4:6))']'; 

%-----------------------
clf;
tf = 30;

init = [theta0' uf0' yf0' p0']';

options = odeset('OutputFcn','odeplot');
[T,X] = ode23s('ls03',tf,init,options);

theta = X(:,1:6)';
uf = X(:,7:9)';
yf = X(:,10:12)';

phi = [uf' yf']';
y = thetas.'*phi;

yhat = dot(theta, phi);

epsilon = yhat - y;
r = dc + a*sin(w.*T) + a*sin(2*w.*T) + a*sin(3*w.*T) +  a*sin(4*w.*T);
modtt = sqrt(sum(theta'.^2,2))';

figure(1)
clf
thetas = thetas.* ones(6,length(T));
plot(T,theta(1,:),T,theta(2,:),T,theta(3,:),T,theta(4,:),T,theta(5,:), ...
T,theta(6,:), T,thetas(1,:),T,thetas(2,:),T,thetas(3,:),T,thetas(4,:), ...
T,thetas(5,:), T,thetas(6,:));grid;shg
legend('\theta_1','\theta_2','\theta_3','\theta_4','\theta_5', ...
'\theta_6', '\theta_{1s}', '\theta_{2s}','\theta_{3s}','\theta_{4s}', ...
'\theta_{5s}','\theta_{6s}','Location','SouthEast')
print -depsc2 ls03theta

figure(2)
clf
plot(T,modtt);grid;shg
legend('|\theta|','Location','SouthEast')
print -depsc2 ls03modtt

figure(3)
clf
plot(T,epsilon);grid;shg
legend('\epsilon','Location','SouthEast')
print -depsc2 ls03epsilon

%---------------------------------------------------------------------

