function ScreenGrid2(expinfo)


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
Screen('DrawText', expinfo.window ,'+',expinfo.xCenter-0.25*expinfo.GridSize ,expinfo.yCenter-0.50*expinfo.GridSize, expinfo.Colors.black);


end

% Screen('Flip', expinfo.window);
% Wait for a keystroke and then close the screen
% ListenChar(-1);
% KbStrokeWait;
% sca;
% ListenChar(); 

