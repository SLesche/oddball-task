function [trial_array] = generateOddballBlock(n_trials, target_probability)      
    % Determine if it's a target or not
    n_targets = ceil(n_trials * target_probability);
    
    jitter = randi([-1 1]);
    
    n_targets = n_targets + jitter;
    
    n_targets = max(0, min(n_targets, n_trials));
    
    trial_array = [ones(1, n_targets), zeros(1, n_trials - n_targets)];
    
    trial_array = trial_array(randperm(n_trials));
end