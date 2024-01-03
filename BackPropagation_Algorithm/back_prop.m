clear all;
clc
x1 = [1 0 1 0];
x2 = [1 1 0 0];
Yd = [0 1 1 0];
a = 0.5;

w1 = 0.5;w11=[];%bascially w13
w2 = 0.9;w22=[];%w14
w3 = 0.4;w33=[]; %w23
w4 = 1;   w44=[];%w24
w5 = -1.2;w55=[];%w35
w6 = 1.1;w66=[]; %w45
t3 = 0.8;%theta 3
t4 = -0.1;%theta 4
t5 = 0.3;%theta 5

esum = 1;
j = 1;
epoch = 0;
while true
    for i = 1:size(Yd)
        Y3 = 1 / (1 + exp(-(w1 * x1(i) + w3 * x2(i) - t3)));
        Y4 = 1 / (1 + exp(-(w2 * x1(i) + w4 * x2(i) - t4)));
        Y5 = 1 / (1 + exp(-(w5 * Y3 + w6 * Y4 - t5)));
        
        e(i) = Yd(i) - Y5;
        sig5 = Y5 * (1 - Y5) * e(i);
        sig3 = Y3 * (1 - Y3) * sig5 * w5;
        sig4 = Y4 * (1 - Y4) * w6 * sig5;
        
        dw1 = a * sig3 * x1(i);
        % dw1=a*y5*(1-y5)*e(i)
        dw2 = a * sig4 * x1(i);
        dw3 = a * sig3 * x2(i);
        dw4 = a * sig4 * x2(i);
        dw5 = a * sig5 * Y3;
        dw6 = a * sig5 * Y4;
        dt3 = a * sig3 * (-1);
        dt4 = a * sig4 * (-1);
        dt5 = a * sig5 * (-1);
        
        w1 = w1 + dw1; w11(i, j) = w1;
        w2 = w2 + dw2; w22(i, j) = w2;
        w3 = w3 + dw3; w33(i, j) = w3;
        w4 = w4 + dw4; w44(i, j) = w4;
        w5 = w5 + dw5; w55(i, j) = w5;
        w6 = w6 + dw6; w66(i, j) = w6;
        
        t3 = t3 + dt3;
        t4 = t4 + dt4;
        t5 = t5 + dt5;
    end
    
    err_array(esum) = rms(e);
    j = j + 1;
    epoch = epoch + 1;
    
    if err_array(esum) < 0.01
        break;
    end
    
    esum = esum + 1;
end

% Plotting the variation of the cost function
figure;
t = 1:1:epoch;
plot(t, err_array, 'b', 'LineWidth', 2);
title('Graph showing variation of cost function during the training process');
xlabel('Epoch');
ylabel('Error');

% Plotting the variation in weights during the complete training process
figure;
plot(1:j-1, w11(1, :), 'b', 1:j-1, w22(1, :), 'g', 1:j-1, w33(1, :), 'r', 1:j-1, w44(1, :), 'c', 1:j-1, w55(1, :), 'm', 1:j-1, w66(1, :), 'y', 'LineWidth', 2);
legend('w1', 'w2', 'w3', 'w4', 'w5', 'w6');
title('Variation in weights during training process');
xlabel('Epoch');
ylabel('Weight Value');
fprintf("The number of epoch are %d",epoch)
