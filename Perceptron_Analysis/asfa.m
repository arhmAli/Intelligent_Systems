clear all;

x1 = [0 0 1 1];
x2 = [0 1 0 1];
yd = [0 0 0 1];
w1 = 0.3;
w2 = -0.1;
theta = 0.2;
alpha = 0.1;
endl = 0;
jj = 1;

% Initialize arrays to store values for plotting
w1_values = [];
w2_values = [];
epoch_values = [];
rmse_values = [];

while (endl == 0)
    total_error = 0;

    for ii = 1:4
        y(ii, jj) = x1(ii) * w1(ii, jj) + x2(ii) * w2(ii, jj) - theta;
        if y(ii, jj) >= 0
            y(ii, jj) = 1;
        else
            y(ii, jj) = 0;
        end
        e(ii, jj) = yd(ii) - y(ii, jj);
        delW1 = alpha * x1(ii) * e(ii, jj);
        delW2 = alpha * x2(ii) * e(ii, jj);
        if ii == 4
            w1(1, jj + 1) = delW1 + w1(ii, jj);
            w2(1, jj + 1) = delW2 + w2(ii, jj);
        else
            w1(ii + 1, jj) = delW1 + w1(ii, jj);
            w2(ii + 1, jj) = delW2 + w2(ii, jj);
        end
        total_error = total_error + e(ii, jj)^2;
    end

    epoch_values(jj) = jj;
    rmse_values(jj) = sqrt(total_error / 4);
    w1_values(jj) = w1(1, jj);
    w2_values(jj) = w2(1, jj);

    % Break the loop if the error is below a certain threshold
    if rmse_values(jj) < 1e-4
        endl = 1;
    end

    jj = jj + 1;
end

fprintf('Number of iterations: %d\n', jj - 1);

figure;

subplot(3, 1, 1);
plot(epoch_values, w1_values, 'b', epoch_values, w2_values, 'r');
xlabel('Epochs');
ylabel('Weights');
legend('w1', 'w2');
title('Weights vs Epoch');

subplot(3, 1, 2);
plot(epoch_values, rmse_values);
xlabel('Epochs');
ylabel('ERMS');
title('ERMS vs Epoch');

subplot(3, 1, 3);
plot(1:length(x1), yd, 'go-', 1:length(x1), y(end, :), 'rx--');
xlabel('Input Samples');
ylabel('Target and Output');
legend('Target', 'Output');
title('Target and Output vs Input Samples');
