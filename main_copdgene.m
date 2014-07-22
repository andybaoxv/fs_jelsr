% This script runs jelsr on COPDGene dataset

%% Parameter Settings
ReducedDim = 4;
% 1.5 ~ 2.4
alpha = 2;
% 1e-2 ~ 1e-1
beta = 1e-2;

%% Load COPDGene dataset
addpath('~/dataset/COPDGene/data_train_con/');
data_train_con = csvread('data_train_con.csv');
case_id_train = textread('id_train.csv','%s');
features_name_con = textread('features_name_con.csv','%s');

% Normalization of original dataset
data = normalization(data_train_con);

%% Construct similarity matrix for data
options.KernelType = 'Gaussian';
options.t = optSigma(data);
W_ori = constructKernel(data,[],options);
disp(['Kernel Construction Finished']);

%% Apply joint embedding learning and sparse regression algorithm
tic
[W_compute, Y, obj] = jelsr(data, W_ori, ReducedDim,alpha,beta);
toc
