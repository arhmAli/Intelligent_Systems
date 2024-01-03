% Step 1: Initialization
num_inputs = 5;  % Number of neuron inputs
num_iterations = 1000;  % Maximum number of iterations
learning_rate = 0.1;  % Learning rate
forgetting_rate = 0.1;  % Forgetting rate
theta = 0.5;  % Threshold for neuron activation
steady_state_threshold = 1e-6;  % Threshold for steady state

% Initialize synaptic weights to small random values
synaptic_weights = randn(1, num_inputs) * 0.1;

% Step 2-4: Activation, Learning, Iteration
for p = 1:num_iterations
    % Step 2: Activation
    input_pattern = randn(1, num_inputs);  % Example input pattern (replace with your data)
    neuron_output = sum(input_pattern .* synaptic_weights) - theta;

    % Step 3: Learning
    delta_weights = forgetting_rate * neuron_output * (learning_rate * (theta - neuron_output) * input_pattern);

    synaptic_weights = synaptic_weights + delta_weights;

    % Step 4: Iteration
    % Continue until the synaptic weights reach their steady state values
    if p > 1 && max(abs(delta_weights)) < steady_state_threshold
        disp(['Reached steady state at iteration ', num2str(p)]);
        break;
    end
end

% Display the final learned synaptic weights
disp('Final Learned Synaptic Weights:');
disp(synaptic_weights);
