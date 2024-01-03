%   X - input data.
%   T - target data.
clc;
clear all;
[X,T]=input(" enter dataset");
x = X;
t = T;
% For a list of all training functions type: help nntrain
trainFcn = 'traingdx';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 10;
net = patternnet(hiddenLayerSize, trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 1/100;
net.divideParam.testRatio = 19/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network
y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y)
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
view(net)

% Plots
figure;
plot(tr.epoch, tr.perf);
xlabel('Epoch');
ylabel('Performance (Error)');
title('Training Performance');
figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, ploterrhist(e)
% figure, plotconfusion(t,y)
% figure, plotroc(t,y)

