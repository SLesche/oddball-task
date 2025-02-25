function [trial_array] = generateOddballBlock(n_trials, target_probability)      
    % Determine if it's a target or not
    trial_array = rand(1, n_trials) < target_probability;
end