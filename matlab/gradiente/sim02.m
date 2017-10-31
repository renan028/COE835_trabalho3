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

disp('-------------------------------')
disp('Script para simular o algoritmo Gradiente')
disp(' ')
disp('Caso: Planta ............. n = 2')
disp('      Grau relativo ..... n* = 1')
disp('      Parametros ........ np = 4')
disp(' ')
disp('Algoritmo: Gradiente')
disp(' ')
disp('-------------------------------')

global dc A W gamma thetas;

clf;
sim_str = strcat('sim0',num2str(N),'_');
% options = odeset('OutputFcn','odeplot');
options = '';

%---------------------Simulation 1 (default)
theta0 = theta0_1;
uf0 = uf0_1;
yf0 = yf0_1;
dc = dc_1;
A = A_1;
W = W_1;
gamma = gamma_1*eye(2*N);

init = [theta0' uf0' yf0']';
[T_1,X_1] = ode23s('gradiente02',tf,init,options);

theta_1 = X_1(:,1:4)';
tiltheta_1 = theta_1 - thetas.*ones(2*N,length(theta_1));
uf_1 = X_1(:,5:6)';
yf_1 = X_1(:,7:8)';
phi_1 = [uf_1' yf_1']';
y_1 = thetas.'*phi_1;
yhat_1 = dot(theta_1, phi_1);
epsilon_1 = yhat_1 - y_1;
modtt_1 = sqrt(sum(theta_1'.^2,2))';
r_1 = dc;
for i=1:length(A)
    r_1 = r_1 + A(i)*sin(W(i)*T_1);
end

% %---------------------Simulation 2 (gamma)
% changed = 1;
% 
% theta0 = theta0_1;
% uf0 = uf0_1;
% yf0 = yf0_1;
% dc = dc_1;
% A = A_1;
% W = W_1;
% gamma = gamma_2*eye(2*N);
% 
% init = [theta0' uf0' yf0']';
% [T_2,X_2] = ode23s('gradiente02',tf,init,options);
% 
% theta_2 = X_2(:,1:4)';
% tiltheta_2 = theta_2 - thetas.*ones(2*N,length(theta_2));
% uf_2 = X_2(:,5:6)';
% yf_2 = X_2(:,7:8)';
% phi_2 = [uf_2' yf_2']';
% y_2 = thetas.'*phi_2;
% yhat_2 = dot(theta_2, phi_2);
% epsilon_2 = yhat_2 - y_2;
% modtt_2 = sqrt(sum(theta_2'.^2,2))';
% r_2 = dc;
% for i=1:length(A)
%     r_2 = r_2 + A(i)*sin(W(i)*T_2);
% end
% 
% plot_gradiente;

%---------------------Simulation 3 (r)
% changed = 2;
% 
% theta0 = theta0_1;
% uf0 = uf0_1;
% yf0 = yf0_1;
% dc = dc_2;
% A = A_2;
% W = W_2;
% gamma = gamma_1*eye(2*N);
% 
% init = [theta0' uf0' yf0']';
% [T_2,X_2] = ode23s('gradiente02',tf,init,options);
% 
% theta_2 = X_2(:,1:4)';
% tiltheta_2 = theta_2 - thetas.*ones(2*N,length(theta_2));
% uf_2 = X_2(:,5:6)';
% yf_2 = X_2(:,7:8)';
% phi_2 = [uf_2' yf_2']';
% y_2 = thetas.'*phi_2;
% yhat_2 = dot(theta_2, phi_2);
% epsilon_2 = yhat_2 - y_2;
% modtt_2 = sqrt(sum(theta_2'.^2,2))';
% r_2 = dc;
% for i=1:length(A)
%     r_2 = r_2 + A(i)*sin(W(i)*T_2);
% end
% 
% plot_gradiente;

%---------------------Simulation 4 (theta0)
changed = 3;

theta0 = theta0_2;
uf0 = uf0_1;
yf0 = yf0_1;
dc = dc_1;
A = A_1;
W = W_1;
gamma = gamma_1*eye(2*N);

init = [theta0' uf0' yf0']';
[T_2,X_2] = ode23s('gradiente02',tf,init,options);

theta_2 = X_2(:,1:4)';
tiltheta_2 = theta_2 - thetas.*ones(2*N,length(theta_2));
uf_2 = X_2(:,5:6)';
yf_2 = X_2(:,7:8)';
phi_2 = [uf_2' yf_2']';
y_2 = thetas.'*phi_2;
yhat_2 = dot(theta_2, phi_2);
epsilon_2 = yhat_2 - y_2;
modtt_2 = sqrt(sum(theta_2'.^2,2))';
r_2 = dc;
for i=1:length(A)
    r_2 = r_2 + A(i)*sin(W(i)*T_2);
end

plot_gradiente;

%------------------------------------------------

