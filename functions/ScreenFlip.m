function timestamp_flip = ScreenFlip(expinfo, when, Marker, flip, has_fixation)

if ~exist('Marker','var') || isempty(Marker)
    Marker = 0;
end

if ~exist('has_fixation','var') || isempty(has_fixation)
    has_fixation = 1;
end

if ~exist('flip','var') || isempty(flip)
    flip = 0;
end

% Flip Screen
if ~exist('when','var')
    % Flip window immediately
    timestamp_flip = Screen('Flip',expinfo.window);
    setMarker(expinfo, Marker, 0.05);
elseif isempty(when)
    % Flip window immediately
    timestamp_flip = Screen('Flip',expinfo.window);
    setMarker(expinfo, Marker, 0.05);
else
    % Flip synced to timestamp entered
    timestamp_flip = Screen('Flip',expinfo.window,when);
    setMarker(expinfo, Marker, 0.05);
end


end

% Screen('Flip', expinfo.window);
% Wait for a keystroke and then close the screen
% ListenChar(-1);
% KbStrokeWait;
% sca;
% ListenChar(); 

