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
disp('      Parāmetros ........ np = 2')
disp(' ')
disp('Algoritmo: Gradiente')
disp(' ')
disp('-------------------------------')

global filter_param dc a w thetas;

P0 = 100*eye(4);
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
thetas = [flip(plant_param(1:2))' flip((filter_param-plant_param(3:4)))']'; 

%-----------------------
clf;
tf = 5000;

init = [theta0' uf0' yf0' p0'];

options = odeset();
[T,X] = ode23s('ls02',tf,init,options);

theta = X(:,1:4)';
uf = X(:,5:6)';
yf = X(:,7:8)';

phi = [uf' yf']';
y = thetas.'*phi;

yhat = dot(theta, phi);

epsilon = yhat - y;
freq1 = randn; freq2 = randn;
freq3 = randn; freq4 = randn;
r = dc;
% r = dc + a*sin(w.*T);
% r = dc + a*sin(freq1*w.*T) + a*sin(freq2*w.*T);
% r = dc + a*sin(freq1*w.*T) + a*sin(freq2*w.*T) + a*sin(freq3*w.*T) +  a*sin(freq4*w.*T);
modtt = sqrt(sum(theta'.^2,2))';

figure(1)
clf
thetas = thetas.* ones(4,length(T));
err_theta = theta - thetas;
plot(T,err_theta);grid;shg
leg1 = legend('\tilde{\theta}');
set(leg1,'Interpreter','latex');
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

