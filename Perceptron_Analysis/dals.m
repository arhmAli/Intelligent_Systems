clear all;

% Input data
input_data = [0 0; 0 1; 1 0; 1 1];
and_output = [0; 0; 0; 1];
or_output = [0; 1; 1; 1];
xor_output = [0; 1; 1; 0];

% Perceptron Training Algorithm
max_error = 1e-4;
alpha_values = [0.1, 0.2, 0.3, 0.4, 0.5];

fprintf("AND Logic:\n");
train_and_plot(input_data, and_output, max_error, alpha_values, 'AND Logic');

fprintf("\nOR Logic:\n");
train_and_plot(input_data, or_output, max_error, alpha_values, 'OR Logic');

fprintf("\nXOR Logic:\n");
train_and_plot(input_data, xor_output, max_error, alpha_values, 'XOR Logic');

function train_and_plot(input_data, output, max_error, alpha_values, logic_gate)
    figure;

    for alpha = alpha_values
        w = rand(1, 2) - 0.5; % initial weights in the range [-0.5, 0.5]
        theta = rand - 0.5; % initial threshold in the range [-0.5, 0.5]

        error_history = [];
        w1_history = [];
        w2_history = [];

        error = max_error + 1;
        iterations = 0;
        max_iterations = 1000; % Limit iterations for XOR
        while error > max_error && iterations < max_iterations
            error = 0;
            for i = 1:size(input_data, 1)
                x = input_data(i, :);
                y = output(i);
                actual_output = step_function(sum(x .* w) - theta);
                e = y - actual_output;
                error = error + e^2;
                w = w + alpha * e * x;
                theta = theta - alpha * e;
            end

            iterations = iterations + 1;
            error_history(iterations) = sqrt(error / size(input_data, 1));
            w1_history(iterations) = w(1);
            w2_history(iterations) = w(2);
        end

        subplot(3, 1, 1);
        plot(1:iterations, error_history, 'LineWidth', 2);
        xlabel('Epoch');
        ylabel('ERMS');
        title(['Epoch vs ERMS (' logic_gate ')']);

        subplot(3, 1, 2);
        plot(1:iterations, w1_history, 'LineWidth', 2);
        xlabel('Epoch');
        ylabel('Weight w1');
        title(['Epoch vs w1 (' logic_gate ')']);

        subplot(3, 1, 3);
        plot(1:iterations, w2_history, 'LineWidth', 2);
        xlabel('Epoch');
        ylabel('Weight w2');
        title(['Epoch vs w2 (' logic_gate ')']);

        fprintf("Alpha: %.1f, Iterations: %d\n", alpha, iterations);
        fprintf("Final weights: w1 = %.4f, w2 = %.4f\n", w(1), w(2));
        fprintf("Final threshold: theta = %.4f\n", theta);
    end
end

function out = step_function(x)
    if x >= 0
        out = 1;
    else
        out = 0;
    end
end
