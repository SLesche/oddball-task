function [ACC, response, correct, RT] = getResponseNTargets(expinfo, n_targets)

    % Initialize variables
    tic; % Start internal MATLAB stopwatch
    start = GetSecs; % Get the current system time
    response = -2; % Default response indicating no valid response

    ACC = -2; % Default accuracy indicating timeout
    RT = expinfo.MaxRT; % Default reaction time to maximum allowed time
    
    message = ['Wie oft ist der Zielstimulus aufgetreten?'];
    
    correct = n_targets;

    % Loop until maximum reaction time is exceeded
    response = Ask(window, message,  expinfo.Colors.bgColor,  expinfo.Colors.black, 'GetString',[300 225 1600 600], 'center');
    
    response = str2double(response)
    % Handle cases where no valid key press was registered within MaxRT
    if response == n_targets
        ACC = 1;
        RT = toc;
        setMarker(expinfo, expinfo.Marker.CorrResponseOpenQuestion); % Send incorrect response marker
    else
        ACC = 0;
        RT = toc;
        setMarker(expinfo, expinfo.Marker.IncorrResponseOpenQuestion);
    end

    % Clear keyboard buffer
    FlushEvents();
end
