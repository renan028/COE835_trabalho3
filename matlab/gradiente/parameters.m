clear;
clc;
close all;
global filter_param thetas;

PRINT = true;
% PRINT = false;

%% 1st order system
tf = 25; %simulation time
plant_param = [1 2]';
filter_param = [1]';
N = length(plant_param)/2; % system order
thetas = [flip(plant_param(1:N))' (flip(filter_param-plant_param(N+1:end)))']';

%First set
dc_1 = 1;
W_1 = 1;
A_1 = 5;

gamma_1 = 10;

uf0_1 = zeros(N,1);
yf0_1 = zeros(N,1);
theta0_1 = zeros(2*N,1);

%Second set
dc_2 = 1;
W_2 = 1;
A_2 = 0;

gamma_2 = 5;

uf0_2 = ones(N,1);
yf0_2 = ones(N,1);
theta0_2 = ones(2*N,1);

run sim01.m;

%% 2nd order system
tf = 1000; %simulation time
plant_param = [1 1 4 4]';
% plant_param = [1 .1 .4 .04]';
filter_param = [2 1]';
N = length(plant_param)/2; % system order
thetas = [flip(plant_param(1:N))' (flip(filter_param-plant_param(N+1:end)))']';

%First set
dc_1 = 0;
%W_1 = 5*rand(1,2);
W_1 = [0.63493 4.5669];
A_1 = zeros(1,length(W_1));
A_1(1) = 10;
A_1(2) = 25;

gamma_1 = 10;

uf0_1 = zeros(N,1);
yf0_1 = zeros(N,1);
theta0_1 = zeros(2*N,1);

%Second set
dc_2 = 0;
W_2 = W_1;
A_2 = zeros(1,length(W_2));
A_2(1) = 10;
A_2(2) = 0;

gamma_2 = 5;

uf0_2 = ones(N,1);
yf0_2 = ones(N,1);
theta0_2 = ones(2*N,1);

run sim02.m;

%% 3rd order system
tf = 1000; %simulation time
plant_param = [1 1 1 1 1 1]';
filter_param = [3 3 1]';
N = length(plant_param)/2; % system order
thetas = [flip(plant_param(1:N))' (flip(filter_param-plant_param(N+1:end)))']';

%First set
dc_1 = 0;
W_1 = 5*rand(1,3);
W_1 = [0.53326 4.8095 0.023171];

A_1 = zeros(1,length(W_1));
A_1(1) = 10;
A_1(2) = 10;
A_1(3) = 10;

gamma_1 = 10;

uf0_1 = zeros(N,1);
yf0_1 = zeros(N,1);
theta0_1 = zeros(2*N,1);

%Second set
dc_2 = 0;
W_2 = W_1;
A_2 = zeros(1,length(W_2));
A_2(1) = 10;
A_2(2) = 10;
%A_2(4) = 18;
%A_2(5) = 16;

gamma_2 = 5;

uf0_2 = ones(N,1);
yf0_2 = ones(N,1);
theta0_2 = ones(2*N,1);

run sim03.m;
