clear;
clc;
close all;
global filter_param thetas;

% PRINT = true;
PRINT = false;

%% 1st order system
tf = 25; %simulation time
plant_param = [1 2]';
filter_param = [1]';
N = length(plant_param)/2; % system order
thetas = [flip(plant_param(1:N))' (flip(filter_param-plant_param(N+1:end)))']';

%First set
dc_1 = 1;
W_1 = 1;
A_1 = 0;

gain_P0_1 = 1;
P0_1 = gain_P0_1*eye(2*N);
p0_1 = reshape(P0_1,length(P0_1)^2,1);

uf0_1 = zeros(N,1);
yf0_1 = zeros(N,1);
theta0_1 = zeros(2*N,1);

%Second set
dc_2 = 1;
W_2 = 1;
A_2 = 5;

gain_P0_2 = 100;
P0_2 = gain_P0_2*eye(2*N);
p0_2 = reshape(P0_1,length(P0_1)^2,1);

uf0_2 = ones(N,1);
yf0_2 = ones(N,1);
theta0_2 = ones(2*N,1);

run sim01_ls.m;

%% 2nd order system
tf = 100; %simulation time
plant_param = [1 1 4 4]';
% plant_param = [1 .1 .4 .04]';
filter_param = [2 1]';
N = length(plant_param)/2; % system order
thetas = [flip(plant_param(1:N))' (flip(filter_param-plant_param(N+1:end)))']';

%First set
dc_1 = 0;
W_1 = 5*rand(1,2);
A_1 = zeros(1,length(W_1));
A_1(1) = 30;
A_1(2) = 25;

gain_P0_1 = 1;
P0_1 = gain_P0_1*eye(2*N);
p0_1 = reshape(P0_1,length(P0_1)^2,1);

uf0_1 = zeros(N,1);
yf0_1 = zeros(N,1);
theta0_1 = zeros(2*N,1);

%Second set
dc_2 = 0;
W_2 = W_1;
A_2 = zeros(1,length(W_2));
A_2(1) = 30;
A_2(2) = 25;

gain_P0_2 = 100;
P0_2 = gain_P0_2*eye(2*N);
p0_2 = reshape(P0_1,length(P0_1)^2,1);

uf0_2 = ones(N,1);
yf0_2 = ones(N,1);
theta0_2 = ones(2*N,1);

run sim02_ls.m;

%% 3rd order system
tf = 100; %simulation time
plant_param = [1 3/5 9/100 3/2 3/4 1/8]';
filter_param = [3 3 1]';
N = length(plant_param)/2; % system order
thetas = [flip(plant_param(1:N))' (flip(filter_param-plant_param(N+1:end)))']';

%First set
dc_1 = 0;
W_1 = 5*rand(1,5);
A_1 = zeros(1,length(W_1));
A_1(1) = 10;
A_1(2) = 5;

gain_P0_1 = 1;
P0_1 = gain_P0_1*eye(2*N);
p0_1 = reshape(P0_1,length(P0_1)^2,1);

uf0_1 = zeros(N,1);
yf0_1 = zeros(N,1);
theta0_1 = zeros(2*N,1);

%Second set
dc_2 = 0;
W_2 = W_1;
A_2 = zeros(1,length(W_2));
A_2(1) = 30;
A_2(2) = 25;
A_2(3) = 20;
A_2(4) = 18;
A_2(5) = 16;

gain_P0_2 = 100;
P0_2 = gain_P0_2*eye(2*N);
p0_2 = reshape(P0_1,length(P0_1)^2,1);

uf0_2 = ones(N,1);
yf0_2 = ones(N,1);
theta0_2 = ones(2*N,1);

run sim03_ls.m;
