%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  Gradient  : n  = 2     Second order plant
%              n* = 1     Relative degree
%              np = 4     Adaptive parameters
%
%                                                        Ramon R. Costa
%                                                        30/abr/13, Rio
%----------------------------------------------------------------------
clear;
clc;

disp('-------------------------------')
disp('Script para simular o algoritmo Gradiente')
disp(' ')
disp('Caso: Planta ............. n = 2')
disp('      Grau relativo ..... n* = 1')
disp('      Parâmetros ........ np = 4')
disp(' ')
disp('Algoritmo: Gradiente')
disp(' ')
disp('-------------------------------')

global filter_param dc a w gamma thetas;

% plant_param = [1 1 4 4]';
% filter_param = [2 1]';
plant_param = [1.5 3 2 3]';
filter_param = [1 1]';

dc = 1;
a  = 2;
w  = 1;

gamma = 100*eye(4);

uf0 = [0 0]';
yf0 = [0 0]';
theta0 = zeros(4,1);

%-----------------------
thetas = [plant_param(1:2)' (filter_param-plant_param(3:4))']'; 

%-----------------------
clf;
tf = 5000;

init = [theta0' uf0' yf0']';

options = odeset();
[T,X] = ode23s('gradiente02',tf,init,options);

theta = X(:,1:4)';
uf = X(:,5:6)';
yf = X(:,7:8)';

phi = [uf' yf']';
y = thetas.'*phi;

yhat = dot(theta, phi);

epsilon = yhat - y;
r = dc + 1*sin(T) + 2*sin(2*T);
% r = dc + a*sin(w.*T) + a*sin(2*w.*T)+ a*sin(3*w.*T) + a*sin(10*w.*T);
modtt = sqrt(sum(theta'.^2,2))';


figure(1)
clf
thetas = thetas.* ones(4,length(T));
err_theta = theta - thetas;
plot(T,err_theta);grid;shg
legend('\tilde{\theta}','Location','SouthEast')
print -depsc2 gradiente02theta

figure(2)
clf
plot(T,modtt);grid;shg
legend('|\theta|','Location','SouthEast')
print -depsc2 gradiente02modtt

figure(3)
clf
plot(T,epsilon);grid;shg
legend('\epsilon','Location','SouthEast')
print -depsc2 gradiente02epsilon

%---------------------------------------------------------------------

