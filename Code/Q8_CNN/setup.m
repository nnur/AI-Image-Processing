%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% setups paths and reads the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% change the paths below to where the data is stored, and where the library
% is stored 
dataFile   = '/Users/nailanur/Documents/MATLAB/assignment2/Code/Q8_CNN/A1_full.mat';
convnetDir = '/Users/nailanur/Documents/MATLAB/assignment2/matconvnet';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

percentValidation =  30; % percent of training data to use for validation

more off;
addpath(convnetDir);
addpath(strcat(convnetDir,'/examples'));  % directory where the data generated during training is  stored

% fun vl_setupnn.m file
run(fullfile(convnetDir,'matlab','vl_setupnn.m'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reads data 
readDataForCNN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finds the mean image on the validation data
% subtracts it from all samples
normalizeData;


