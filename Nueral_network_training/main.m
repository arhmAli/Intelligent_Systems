clc;
clear all;
[X,T]=simpleclass_dataset;
train_input=X(:,1:700);
train_target=T(:,1:700);

test_input=X(:,701:end);
test_target=T(:,701:end);