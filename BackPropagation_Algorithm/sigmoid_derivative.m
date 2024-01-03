function y_prime = sigmoid_derivative(y)
    y_prime = y .* (1 - y);
end