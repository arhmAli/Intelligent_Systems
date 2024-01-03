clc;
clear all;

% Assuming you have digit_small_dataset.mat file with variables X and T
load('digit_small_dataset.mat');

% Assuming X is your input data (cell array) and T is your target data
x = cell2mat(X')';  % Convert cell array to a matrix

% Number of features in your dataset (28x28 = 784 for each image)
numFeatures = size(x, 2);

t = T';

% For a list of all training functions type: help nntrain
trainFcn = 'traingdx';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);

% Configure network inputs and outputs based on the dataset
net.inputs{1}.size = numFeatures;
net.outputs{2}.size = size(t, 1);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 1/100;
net.divideParam.testRatio = 19/100;

% Train the Network
[net, tr] = train(net, x, t);

% Test the Network
y = net(x);
e = gsubtract(t, y);
performance = perform(net, t, y);

tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind) / numel(tind);

% View the Network
view(net);

% Plots
figure;
plot(tr.epoch, tr.perf);
xlabel('Epoch');
ylabel('Performance (Error)');
title('Training Performance');
figure, plotperform(tr);

% Add more plotting code if needed
