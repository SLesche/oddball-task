% This function clears the screen by overriding the current screen with a
% filled rectangle of a specified color. Optionally a timestamp for the
% flip "when" can be provided

function  timestamp_flip = clearScreen(expinfo,when,Marker)

if ~exist('Marker','var') || isempty(Marker)
    Marker = 0;
end

Screen('FillRect',expinfo.window,expinfo.Colors.bgColor);

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


% Tell PTB no more drawing commands will be issued until the next flip
Screen('DrawingFinished', expinfo.window);

if ~exist('when','var') || isempty(when)
    % Flip window immediately
    timestamp_flip = Screen('Flip',expinfo.window);

else
    % Flip synced to timestamp entered
    timestamp_flip = Screen('Flip',expinfo.window,when);

end

%% End of Function
% This function was programmed by Gidon T. Frischkorn, as part of a
% template for MATLAB experiments. If you have any questions please contact
% me via mail: gidon.frischkorn@psychologie.uni-heidelberg.de