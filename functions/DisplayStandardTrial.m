function Trial = DisplayStandardTrial(expinfo, Trial, expTrial, block_num, isPractice, repetition_num)

if ~exist('repetition_num', 'var')
    repetition_num = 1;
end

%% Trial Procedure
is_target = Trial(expTrial).isTarget;
if is_target
    Trial(expTrial).time_ITI = ScreenFlip(expinfo,[],expinfo.Marker.ITITarget, 0,0);
else
    Trial(expTrial).time_ITI = ScreenFlip(expinfo,[],expinfo.Marker.ITINonTarget, 0, 0);
end

next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_ITI,Trial(expTrial).ITI);

if is_target
    Trial(expTrial).time_FIX = ScreenFlip(expinfo,next_flip,expinfo.Marker.FixTarget, 0, 1);
else
    Trial(expTrial).time_FIX = ScreenFlip(expinfo,next_flip,expinfo.Marker.FixNonTarget, 0, 1);
end

next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_FIX,Trial(expTrial).FIX);

if is_target
    Trial(expTrial).time_memset = TextCenteredOnPos(expinfo,expinfo.TargetStim,expinfo.XPos(5),expinfo.YPos(5), expinfo.Colors.black , next_flip, Trial(expTrial).StimMarkerTarget);
else
    Trial(expTrial).time_memset = TextCenteredOnPos(expinfo,expinfo.NonTargetStim,expinfo.XPos(5),expinfo.YPos(5), expinfo.Colors.black , next_flip, Trial(expTrial).StimMarkerNonTarget);
end

next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_memset,Trial(expTrial).StimDuration);

if Trial(expTrial).hasResponse        
    % Get Answer from participant
    [ACC, response, correct, RT] = getResponseOddball(expinfo, is_target);
    
    % Assign values to dynamically constructed field names
    Trial(expTrial).oddball_acc = ACC;
    Trial(expTrial).oddball_rt = RT;
    Trial(expTrial).oddball_istarget = is_target;
    Trial(expTrial).oddball_response = response;
    Trial(expTrial).oddball_correct = correct;

    if Trial(expTrial).(field_rt) < expinfo.MinRT
        WaitSecs(expinfo.MinRT-Trial(expTrial).(field_rt));
    end
    clearScreen(expinfo);
else
    clearScreen(expinfo,next_flip);
end

SaveTable = orderfields(Trial);
Data = struct2table(SaveTable,'AsArray',true);

if isPractice == 1
    writetable(Data,[expinfo.DataFolder,'Subject_',num2str(expinfo.subject),'Prac_Block_', num2str(block_num), '_', num2str(repetition_num), '.csv']);
else
    writetable(Data,[expinfo.DataFolder,'Subject_',num2str(expinfo.subject),'Exp_Block_', num2str(block_num), '_', num2str(repetition_num),'.csv']);
end
%
% % Clear Screen for ITI
% WaitSecs(Trial(expTrial).ITI);
%
%

end

%% End of Function
% This function was programmed by Gidon T. Frischkorn, as part of a
% template for MATLAB experiments. If you have any questions please contact
% me via mail: gidon.frischkorn@psychologie.uni-heidelberg.de