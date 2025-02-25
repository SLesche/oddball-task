function Trial = DisplayStandardTrial(expinfo, Trial, expTrial, block_num, isPractice, repetition_num)

if ~exist('repetition_num', 'var')
    repetition_num = 1;
end

%% Trial Procedure
Trial(expTrial).time_ITI = ScreenGrid(expinfo,[],expinfo.Marker.ITI, 0, 1);
next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_ITI,Trial(expTrial).ITI);

% Presentation of Stimulus
for istimulus = 1:Trial(expTrial).MemSetSize
    if expinfo.blocks.dimension(block_num) == 1
        ScreenGridEmpty(expinfo)
    elseif expinfo.blocks.dimension(block_num) == 2
        ScreenGrid2(expinfo)
    end

    Trial(expTrial).time_memset = TextCenteredOnPos(expinfo,num2str(Trial(expTrial).MemSet(istimulus)),expinfo.XPos(Trial(expTrial).MemPos(istimulus)),expinfo.YPos(Trial(expTrial).MemPos(istimulus)), expinfo.Colors.black , next_flip, Trial(expTrial).MemSetMarker(istimulus));
    next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_memset,Trial(expTrial).StimDuration(istimulus));

    if Trial(expTrial).hasMemSetResponse
        % Allow for response to each memory stimulus
        is_odd = mod(Trial(expTrial).MemSet(istimulus), 2);

        current_target_key = Trial(expTrial).targetKey;
        current_non_target_key = Trial(expTrial).nonTargetKey;

        if Trial(expTrial).delayedMemSetResponse
            % Present the target mapping            
            current_target_key = randsample([Trial(expTrial).targetKey, Trial(expTrial).nonTargetKey], 1);
            current_non_target_key = setdiff([Trial(expTrial).targetKey, Trial(expTrial).nonTargetKey], current_target_key);
        
            Trial(expTrial).time_memset_display = ScreenGrid(expinfo, next_flip, Trial(expTrial).StimCheckISIMarker(istimulus)); %show empty Screen
            next_flip = getAccurateFlip(expinfo.window, Trial(expTrial).time_memset_display,Trial(expTrial).delayISI(istimulus));

            DisplayProbeMappingResponse(expinfo, current_target_key, next_flip, Trial(expTrial).StimCheckMarker(istimulus));
            %Trial(expTrial).time_response_memset = TextCenteredOnPos(expinfo, upper_key, expinfo.XPos(8), expinfo.YPos(8), expinfo.Colors.black, next_flip, Trial(expTrial).StimCheckMarker(istimulus));
            %Trial(expTrial).time_response_memset = TextCenteredOnPos(expinfo, lower_key, expinfo.XPos(2), expinfo.YPos(2), expinfo.Colors.black, next_flip, Trial(expTrial).StimCheckMarker(istimulus));
        end
        
        % Get Answer from participant
        [ACC, response, correct, RT] = getresponseMemSet(expinfo, is_odd, current_target_key, current_non_target_key);
        % Construct dynamic field name based on istimulus
        field_acc = sprintf('memset_answer_%d_acc', istimulus);
        field_rt = sprintf('memset_answer_%d_rt', istimulus);
        field_is_odd = sprintf('memset_answer_%d_isodd', istimulus);
        field_response = sprintf('memset_answer_%d_response', istimulus);
        field_correct = sprintf('memset_answer_%d_correct', istimulus);
        
        % Assign values to dynamically constructed field names
        Trial(expTrial).(field_acc) = ACC;
        Trial(expTrial).(field_rt) = RT;
        Trial(expTrial).(field_is_odd) = is_odd;
        Trial(expTrial).(field_response) = response;
        Trial(expTrial).(field_correct) = correct;

        if Trial(expTrial).(field_rt) < expinfo.MinRT
            WaitSecs(expinfo.MinRT-Trial(expTrial).(field_rt));
        end

        if expinfo.blocks.dimension(block_num) == 1
            Trial(expTrial).time_ISI = ScreenGrid(expinfo,[], Trial(expTrial).MemSetISIMarker(istimulus), 0, 0);
        elseif expinfo.blocks.dimension(block_num) == 2
            Trial(expTrial).time_ISI = ScreenGrid(expinfo,[], Trial(expTrial).MemSetISIMarker(istimulus), 0, 1);
        end
        next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_ISI, Trial(expTrial).ISI(istimulus));
    else
        if expinfo.blocks.dimension(block_num) == 1
            Trial(expTrial).time_ISI = ScreenGrid(expinfo,next_flip,Trial(expTrial).MemSetISIMarker(istimulus), 0, 0);
        elseif expinfo.blocks.dimension(block_num) == 2
            Trial(expTrial).time_ISI = ScreenGrid(expinfo,next_flip,Trial(expTrial).MemSetISIMarker(istimulus), 0, 1);
        end
        next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_ISI, Trial(expTrial).ISI(istimulus));
    end
    % Here maybe present questions on memset, then also do getresponse and save
    % that in struct
end

% Presentation of Probe - This may also vary across blocks
% WaitSecs(expinfo.MinISIduration)%include for smooth change of scene

ScreenGridEmpty(expinfo);
Trial(expTrial).time_cue = TextCenteredOnPos(expinfo,'?',expinfo.XPos(5),expinfo.YPos(5), expinfo.Colors.black, next_flip, expinfo.Marker.Cue);
next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_cue, Trial(expTrial).CueDuration);

ScreenGridEmpty(expinfo);
Trial(expTrial).time_probe = TextCenteredOnPos(expinfo,num2str(Trial(expTrial).Probe), expinfo.XPos(Trial(expTrial).ProbePos),expinfo.YPos(Trial(expTrial).ProbePos),expinfo.Colors.black , next_flip,expinfo.Marker.Probe);
next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_probe, Trial(expTrial).ProbeDuration);

if Trial(expTrial).delayedProbeResponse
    % Present the target mapping            
    current_target_key = randsample([Trial(expTrial).targetKey, Trial(expTrial).nonTargetKey], 1);
    current_non_target_key = setdiff([Trial(expTrial).targetKey, Trial(expTrial).nonTargetKey], current_target_key);
    
    % Reassign for later use
    Trial(expTrial).targetKey = current_target_key;
    
    %disp(["Target key now:", current_target_key])

    Trial(expTrial).nonTargetKey = current_non_target_key;
    
    if Trial(expTrial).delayProbeISI > 0
        Trial(expTrial).time_probemapping_display = ScreenGrid(expinfo, next_flip, expinfo.Marker.ProbeISI, 0, 0); %show empty Screen
        next_flip = getAccurateFlip(expinfo.window, Trial(expTrial).time_probemapping_display,Trial(expTrial).delayProbeISI);
    end
    
    DisplayProbeMappingResponse(expinfo, current_target_key, next_flip, expinfo.Marker.ProbeCheck);
end

if Trial(expTrial).hasProbeResponse
    % Get Answer from participant
    [ACC, response, correct, RT] = getresponseProbe(expinfo, Trial, expTrial);
    Trial(expTrial).probe_answer_ACC = ACC;
    Trial(expTrial).probe_answer_RT = RT;
    Trial(expTrial).probe_answer_is_target = Trial(expTrial).isTarget;
    Trial(expTrial).probe_answer_response = response;
    Trial(expTrial).probe_answer_correct = correct;

    if Trial(expTrial).probe_answer_RT < expinfo.MinRT
        WaitSecs(expinfo.MinRT-Trial(expTrial).probe_answer_RT);
    end
    
    if isPractice == 1 % Show feedback in practice trials
        clearScreen(expinfo);
        if ACC == 1
           Trial(expTrial).time_feed = TextCenteredOnPos(expinfo,'Richtig',0.5*expinfo.maxX,0.5*expinfo.maxY,expinfo.Colors.green);
        elseif ACC == 0
            Trial(expTrial).time_feed= TextCenteredOnPos(expinfo,'Falsch',0.5*expinfo.maxX,0.5*expinfo.maxY,expinfo.Colors.red);
        elseif ACC == -2
            Trial(expTrial).time_feed= TextCenteredOnPos(expinfo,'zu langsam',0.5*expinfo.maxX,0.5*expinfo.maxY,expinfo.Colors.black);
        elseif ACC == -3
           Trial(expTrial).time_feed= TextCenteredOnPos(expinfo,'unerlaubte Taste',0.5*expinfo.maxX,0.5*expinfo.maxY,expinfo.Colors.red);
        end
        next_flip = getAccurateFlip(expinfo.window,Trial(expTrial).time_feed,expinfo.FeedbackDuration);

        clearScreen(expinfo,next_flip);
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