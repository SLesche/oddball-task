function [ACC, response, correct, RT] = getResponseNTargets(expinfo, n_targets)

    % Initialize variables
    tic; % Start internal MATLAB stopwatch
    response = -2; % Default response indicating no valid response
    ACC = -2; % Default accuracy indicating timeout
    RT = expinfo.MaxRT; % Default reaction time to maximum allowed time
    correct = n_targets;

    message = 'Wie oft ist der Zielstimulus aufgetreten? Ihre Antwort: ';

    % Get user input
    response = Ask(expinfo.window, message, expinfo.Colors.black, expinfo.Colors.bgColor, ...
                   'GetChar', [], 'center');

    % Convert response to number and check for validity
    response = str2double(response); 

    if isnan(response)  % Handle invalid responses
        response = -1; % Assign a default invalid response value
    end

    % Compute reaction time
    RT = toc;

    % Determine accuracy and send marker
    if response == n_targets
        ACC = 1;
        setMarker(expinfo, expinfo.Marker.CorrResponseOpenQuestion); % Correct marker
        feedbackMessage = 'Richtig!';
    else
        ACC = 0;
        setMarker(expinfo, expinfo.Marker.IncorrResponseOpenQuestion);
        feedbackMessage = sprintf('Falsch. "3" wurde %d mal präsentiert.', n_targets);
    end

    % Display feedback
    DrawFormattedText(expinfo.window, feedbackMessage, 'center', 'center', expinfo.Colors.black);
    Screen('Flip', expinfo.window);
    WaitSecs(1.5); % Display the message for 1.5 seconds

    % Clear keyboard buffer
    FlushEvents();
end
