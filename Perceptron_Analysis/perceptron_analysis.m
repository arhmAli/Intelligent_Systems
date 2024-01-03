logic_gates = {'AND', 'OR', 'XOR'};
input_values_AND = [0 0; 0 1; 1 0; 1 1];
input_values_OR = [0 0; 0 1; 1 0; 1 1];
input_values_XOR = [0 0; 0 1; 1 0; 1 1];
target_output_AND = [0; 0; 0; 1];
target_output_OR = [0; 1; 1; 1];
target_output_XOR = [0; 1; 1; 0];
learning_rates = [0.1, 0.2, 0.3, 0.4, 0.5];
w_initial = rand(1, 2) - 0.5;
theta_initial = rand - 0.5;
max_epochs = 15;

for gate = 1:length(logic_gates)
    disp(['Training for ' logic_gates{gate} ' gate']);
    if gate == 1
        input_values = input_values_AND;
        target_output = target_output_AND;
    elseif gate == 2
        input_values = input_values_OR;
        target_output = target_output_OR;
    elseif gate == 3
        input_values = input_values_XOR;
        target_output = target_output_XOR;
    end

    for alpha = 1:length(learning_rates)
        w = w_initial;
        theta = theta_initial;
        alpha_value = learning_rates(alpha);
        error_values = [];
        weight_variation = [];
        w1_variation = [];
        w2_variation = [];
        for epoch = 1:max_epochs
            error = 0;
            for p = 1:size(input_values, 1)
                y = step_func(input_values(p, :), w, theta);
                e = target_output(p) - y;
                delta_w = alpha_value * input_values(p, :) * e;
                w = w + delta_w;
                theta = theta - alpha_value * e;
                error = error + abs(e);
            end
            error_values = [error_values error];
            weight_variation = [weight_variation; w];
            w1_variation = [w1_variation w(1)];
            w2_variation = [w2_variation w(2)];
            if error < 1e-4
                break;
            end
        end
        figure(1);
        subplot(3, 1, gate);
        plot(1:epoch, error_values, 'DisplayName', ['Learning rate ' num2str(alpha_value)]);
        hold on;
        xlabel('Epoch');
        ylabel('Error');
        title(['Error vs Epoch for ' logic_gates{gate} ' gate']);
        legend('show');

        figure(2);
        subplot(3, 1, gate);
        plot(1:epoch, w1_variation, 'DisplayName', ['w1, Learning rate ' num2str(alpha_value)]);
        hold on;
        xlabel('Epoch');
        ylabel('Weight Value');
        title(['w1 vs Epoch for ' logic_gates{gate} ' gate']);
        legend('show');

        figure(3);
        subplot(3, 1, gate);
        plot(1:epoch, w2_variation, 'DisplayName', ['w2, Learning rate ' num2str(alpha_value)]);
        hold on;
        xlabel('Epoch');
        ylabel('Weight Value');
        title(['w2 vs Epoch for ' logic_gates{gate} ' gate']);
        legend('show');
    end
end
