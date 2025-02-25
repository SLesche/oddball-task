function [ACC, response, correct, RT] = getResponseOddball(expinfo, Trial, expTrial)
    % Initialize variables
    tic; % Start internal MATLAB stopwatch
    start = GetSecs; % Get the current system time
    response = -2; % Default response indicating no valid response

    if Trial(expTrial).isTarget
        correct = Trial(expTrial).targetKey;
    else
        correct = Trial(expTrial).nonTargetKey;
    end

    ACC = -2; % Default accuracy indicating timeout
    RT = expinfo.MaxRT; % Default reaction time to maximum allowed time
    wrongkey = 0; % Flag for incorrect key press

    % Loop until maximum reaction time is exceeded
    while toc < expinfo.MaxRT
        [keyIsDown, time, keyCode] = KbCheck; % Check for key press
        
        if keyIsDown
            % Identify the key pressed
            response = KbName(keyCode);
            disp("Keypress registered");

            % Check if the experiment should be aborted
            if strcmp(response, expinfo.AbortKey)
                closeexp(expinfo.window);
                return; % Terminate the function
            end

            % Evaluate the response
            if strcmp(response, correct)
                ACC = 1;
                setMarker(expinfo, expinfo.Marker.CorrRespProbe); % Send correct response marker

                RT = time - start; % Calculate reaction time
                break; % Exit the loop
            elseif ismember(response, [Trial(expTrial).targetKey, Trial(expTrial).nonTargetKey]) & ~strcmp(response, correct)
                ACC = 0;
                setMarker(expinfo, expinfo.Marker.IncorrRespProbe);
                RT = time - start; % Calculate reaction time
                break; % Exit the loop
            else
                wrongkey = 1;
            end
        end
    end

    % Handle cases where no valid key press was registered within MaxRT
    if response == -2
        ACC = -2; % Indicate timeout
        RT = expinfo.MaxRT; % Default reaction time to max allowed
        setMarker(expinfo, expinfo.Marker.IncorrRespProbe); % Send incorrect response marker
    elseif wrongkey
        ACC = -3; % Indicate wrong key press
    end

    % Clear keyboard buffer
    FlushEvents();
end
