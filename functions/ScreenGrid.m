function timestamp_flip = ScreenGrid(expinfo, when, Marker, flip, has_fixation)

if ~exist('Marker','var') || isempty(Marker)
    Marker = 0;
end

if ~exist('has_fixation','var') || isempty(has_fixation)
    has_fixation = 1;
end

if ~exist('flip','var') || isempty(flip)
    flip = 0;
end


% vertikale Linien von unten nach oben 
Screen('DrawLine', expinfo.window ,expinfo.Colors.black , expinfo.xCenter-1.5*expinfo.GridSize, expinfo.yCenter - 1.5*expinfo.GridSize,expinfo.xCenter-1.5*expinfo.GridSize, expinfo.yCenter + 1.5*expinfo.GridSize ,2);
Screen('DrawLine', expinfo.window ,expinfo.Colors.black , expinfo.xCenter-0.5*expinfo.GridSize, expinfo.yCenter - 1.5*expinfo.GridSize, expinfo.xCenter-0.5*expinfo.GridSize,expinfo.yCenter + 1.5*expinfo.GridSize,2);
Screen('DrawLine', expinfo.window ,expinfo.Colors.black , expinfo.xCenter+0.5*expinfo.GridSize, expinfo.yCenter - 1.5*expinfo.GridSize,  expinfo.xCenter+0.5*expinfo.GridSize, expinfo.yCenter + 1.5*expinfo.GridSize ,2);
Screen('DrawLine', expinfo.window ,expinfo.Colors.black , expinfo.xCenter+1.5*expinfo.GridSize, expinfo.yCenter - 1.5*expinfo.GridSize,  expinfo.xCenter+1.5*expinfo.GridSize, expinfo.yCenter + 1.5*expinfo.GridSize ,2);

% horizontale Linien von links nach rechts 
Screen('DrawLine', expinfo.window ,expinfo.Colors.black ,expinfo.xCenter-1.5*expinfo.GridSize, expinfo.yCenter - 1.5*expinfo.GridSize, expinfo.xCenter+1.5*expinfo.GridSize, expinfo.yCenter - 1.5*expinfo.GridSize ,2);
Screen('DrawLine', expinfo.window ,expinfo.Colors.black , expinfo.xCenter-1.5*expinfo.GridSize, expinfo.yCenter - 0.5*expinfo.GridSize, expinfo.xCenter+1.5*expinfo.GridSize,  expinfo.yCenter - 0.5*expinfo.GridSize ,2);
Screen('DrawLine', expinfo.window ,expinfo.Colors.black , expinfo.xCenter-1.5*expinfo.GridSize, expinfo.yCenter + 0.5*expinfo.GridSize, expinfo.xCenter+1.5*expinfo.GridSize,  expinfo.yCenter + 0.5*expinfo.GridSize ,2);
Screen('DrawLine', expinfo.window ,expinfo.Colors.black, expinfo.xCenter-1.5*expinfo.GridSize, expinfo.yCenter + 1.5*expinfo.GridSize, expinfo.xCenter+1.5*expinfo.GridSize, expinfo.yCenter + 1.5*expinfo.GridSize ,2);

%Screen('Flip',expinfo.window);
if has_fixation
    Screen('DrawText', expinfo.window ,'+',expinfo.xCenter-0.25*expinfo.GridSize ,expinfo.yCenter-0.50*expinfo.GridSize, expinfo.Colors.black);
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

