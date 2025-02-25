function [ACC, response, correct, RT] = getresponseMemSet(expinfo, is_odd, target_key, non_target_key)
    % Initialize variables
    tic; % Start internal MATLAB stopwatch
    start = GetSecs; % Get the current system time
    response = -2; % Default response indicating no valid response
    if is_odd
        correct = non_target_key;
    else
        correct = target_key;
    end
    ACC = -2; % Default accuracy indicating timeout
    RT = expinfo.MaxRT; % Default reaction time to maximum allowed time
    wrongkey = 0; % Flag for incorrect key press

    % Loop until maximum reaction time is exceeded
    while toc < expinfo.MaxRT
        [keyIsDown, time, keyCode] = KbCheck; % Check for key press
        
        if keyIsDown
            % Identify the key pressed
            pressedKey = KbName(keyCode);
            response = pressedKey;
            % disp("Keypress registered");

            % Check if the experiment should be aborted
            if strcmp(pressedKey, expinfo.AbortKey)
                closeexp(expinfo.window);
                return; % Terminate the function
            end

            % Evaluate the response
            if ismember(response, [target_key non_target_key]) && strcmp(response, correct)
                ACC = 1;
                setMarker(expinfo, expinfo.Marker.CorrRespMemSet); % Send correct response marker

                RT = time - start; % Calculate reaction time
                break

            elseif ismember(response, [target_key non_target_key]) && ~strcmp(response, correct)
                ACC = 0;
                setMarker(expinfo, expinfo.Marker.IncorrRespMemSet);

                RT = time - start; % Calculate reaction time
                break
            else
                  % If an unrelated or wrong key is pressed
                wrongkey = 1;
            end
        end
    end

    % Handle cases where no valid key press was registered within MaxRT
    if response == -2
        ACC = -2; % Indicate timeout
        RT = expinfo.MaxRT; % Default reaction time to max allowed
        setMarker(expinfo, expinfo.Marker.IncorrRespMemSet); % Send incorrect response marker
    elseif wrongkey
        ACC = -3; % Indicate wrong key press
    end

    % Clear keyboard buffer
    FlushEvents();
end
