%----------------------------------------------------------------------
%
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo 
%
%  Least-square  : n  = 1     First order plant
%                  n* = 1     Relative degree
%                  np = 2     Adaptive parameters
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

global filter_param ref_dc ref_ampl ref_w thetas;

P0 = eye(2);
p0 = reshape(P0,length(P0)^2,1);

plant_param = [1 2]';
filter_param = [1]';

ref_dc = 1;
ref_ampl  = 5;
ref_w  = 1;

uf0 = 0;
yf0 = 0;
theta0 = zeros(2,1);

%-----------------------
thetas = [ plant_param(1)' (filter_param-plant_param(2))' ]'; 

%-----------------------
clf;
tf = 1000;

init = [theta0' uf0' yf0' p0']';

options = odeset();
[T,X] = ode23s('ls01',tf,init,options);

theta = X(:,1:2)';
uf = X(:,3)';
yf = X(:,4)';

phi = [uf' yf']';
y = thetas.'*phi;

yhat = dot(theta, phi);

epsilon = yhat - y;
r = ref_dc + ref_ampl*sin(ref_w.*T);
modtt = sqrt(sum(theta'.^2,2))';

figure(1)
clf
thetas = thetas.* ones(2,length(T));
err_theta = theta - thetas;
plot(T,err_theta);grid;shg
leg1 = legend('\tilde{\theta}');
set(leg1,'Interpreter','latex');
print -depsc2 ls01theta

figure(2)
clf
plot(T,modtt);grid;shg
leg2 = legend('|\theta|','Location','SouthEast')
print -depsc2 ls01modtt

figure(3)
clf
plot(T,epsilon);grid;shg
legend('\epsilon','Location','SouthEast')
print -depsc2 ls01eps
