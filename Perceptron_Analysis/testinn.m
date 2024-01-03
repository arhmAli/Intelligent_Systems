clc;
clear all;

% Define input data and targets for OR gate
input_data_or = [0 0; 0 1; 1 0; 1 1];
or_targets = [0; 1; 1; 1];

% Define input data and targets for XOR gate
input_data_xor = [0 0; 0 1; 1 0; 1 1];
xor_targets = [0; 1; 1; 0];

% Function to train a perceptron and plot the results
train_and_plot(input_data_or, or_targets, 'OR Logic');
train_and_plot(input_data_xor, xor_targets, 'XOR Logic');

function train_and_plot(input_data, targets, logic_gate)
    weight_1 = 0.3;
    weight_2 = -0.1;
    theta = 0.2;   % Adjusted theta value for better convergence
    learning_rate = 0.1;
    max_epochs = 1000; % Maximum number of epochs

    % Initialize arrays to store weights, epochs, and ERMS
    w1_values = [];
    w2_values = [];
    epoch_values = [];
    rmse_values = [];

    epoch = 0;

    while epoch < max_epochs
        total_error = 0;
        output = zeros(size(targets)); % Initialize output array for each epoch

        for i = 1:length(input_data)
            input = input_data(i, :);
            target = targets(i);

            % Calculate the weighted sum
            weighted_sum = input(1,1) * weight_1 + input(1,2) * weight_2 - theta;

            % Apply the step function (activation function)
            if weighted_sum >= 0
                output(i) = 1;
            else
                output(i) = 0;
            end

            % Update the weights using the Perceptron learning rule
            error = target - output(i);
            weight_1 = weight_1 + learning_rate * error * input(1,1);
            weight_2 = weight_2 + learning_rate * error * input(1,2);

            total_error = total_error + error^2;
        end

        epoch = epoch + 1;

        % Calculate RMSE for this epoch
        rmse = sqrt(total_error / length(input_data));

        % Store values for w1, w2, epoch, and RMSE
        w1_values(epoch) = weight_1;
        w2_values(epoch) = weight_2;
        epoch_values(epoch) = epoch;
        rmse_values(epoch) = rmse;

        % Break the loop if the error is below a certain threshold
        if rmse < 1e-4
            break;
        end
    end

    fprintf('%s:\n', logic_gate);
    fprintf('Number of Epochs: %d\n', epoch);
    fprintf('Trained Weights: w1 = %f, w2 = %f\n', weight_1, weight_2);

    % Plot the results
    figure;
    subplot(3, 1, 1);
    plot(epoch_values, rmse_values);
    xlabel('Epochs');
    ylabel('ERMS');
    title(['Epoch vs ERMS (' logic_gate ')']);

    subplot(3, 1, 2);
    plot(epoch_values, w1_values, 'b', epoch_values, w2_values, 'r');
    xlabel('Epochs');
    ylabel('Weights');
    legend('w1', 'w2');

    subplot(3, 1, 3);
    plot(1:length(input_data), targets, 'go-', 1:length(input_data), output, 'rx--');
    xlabel('Input Samples');
    ylabel('Target and Output');
    legend('Target', 'Output');
end
