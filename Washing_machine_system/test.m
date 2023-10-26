% Define input and output membership functions
Mass_of_cloth = {'Light', 'Medium', 'Heavy'};
Type_of_dirt = {'NotGreasy', 'MedGreasy', 'Greasy'};
Dirtiness_of_cloths = {'Small', 'Med', 'Large'};
Sensitivity_of_cloth = {'Less', 'Med', 'VerySensitive'};
Washing_speed = {'VerySlow', 'Slow', 'Medium', 'Fast', 'VeryFast'};
Rinse_time = {'VeryShort', 'Short', 'Avg', 'Long', 'VeryLong'};

% Initialize an empty cell array to store the rules
rules = cell(81, 1);
rule_idx = 1;

% Generate all possible combinations of input membership functions
for i = 1:length(Mass_of_cloth)
    for j = 1:length(Type_of_dirt)
        for k = 1:length(Dirtiness_of_cloths)
            for l = 1:length(Sensitivity_of_cloth)
                % Define the input values for this rule
                input_rule = {
                    Mass_of_cloth{i}, 
                    Type_of_dirt{j}, 
                    Dirtiness_of_cloths{k}, 
                    Sensitivity_of_cloth{l}
                };
                
                % Determine the appropriate output values based on expert analysis
                % Replace the following lines with your own logic
                % Example:
                output_washing_speed = determine_washing_speed(input_rule{:});
                output_rinse_time = determine_rinse_time(input_rule{:});
                
                % Define the rule text with the determined output values
                rule_text = sprintf('IF Mass_of_cloth is %s AND Type_of_dirt is %s AND Dirtiness_of_cloths is %s AND Sensitivity_of_cloth is %s THEN Washing_speed is %s AND Rinse_time is %s.', ...
                                    input_rule{:}, output_washing_speed, output_rinse_time);
                
                % Store the rule in the cell array
                rules{rule_idx} = rule_text;
                rule_idx = rule_idx + 1;
            end
        end
    end
end

% Display all generated rules
for rule_idx = 1:length(rules)
    disp(rules{rule_idx});
end

% Sample functions to determine output values
function output_washing_speed = determine_washing_speed(Mass_of_cloth, Type_of_dirt, Dirtiness_of_cloths, Sensitivity_of_cloth)
    % Replace with your logic to determine washing speed
    % Example: Determine washing speed based on input values
    output_washing_speed = 'Medium';
end

function output_rinse_time = determine_rinse_time(Mass_of_cloth, Type_of_dirt, Dirtiness_of_cloths, Sensitivity_of_cloth)
    % Replace with your logic to determine rinse time
    % Example: Determine rinse time based on input values
    output_rinse_time = 'Avg';
end
