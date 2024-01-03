function y = step_func(p, w, theta)
    if sum(p .* w) - theta >=0
        y = 1;
    else
        y = 0;
    end
end
