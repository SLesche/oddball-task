%% Name of the experiment %%
% It is good practice to give a short desctiption of your experiment
clear all; % Start the experiment with empty workspace
clc; % Clear command windo w

% Create Folder for B Up Files if it does not exist
if ~exist('data', 'dir')
    mkdir data
end

% location for data backup
addpath('functions', 'instructions', 'data');   
%% Enter Subject & Session ID + further    Info if needed %%
% Define a task name
TaskName = 'Oddball Task';
start_from = 1; % Add later block if something crashed
is_eeg_connected = 0; % Test local = 0; test in lab = 1;
test_run = 0;

% Define variables to be specified when the experiment starts.
vars = {'sub','sex','name'};
% The following variables can be specified:
    % Subject ID = 'sub'
    % Session Number = 'ses'
    % Test Run = 'test'
    % Instruction Language = 'lang'
    % Run practive = 'prac'
    % Subject's Age = 'age'
    % Subject's Gender = 'gender'
    % Subject's Sex = 'sex'

% Run provideInfo function. This opens up a dialoge box asking for the
% specified information. For all other variables default values are used.
expinfo = promptProvideInfo(TaskName,vars);

expinfo.send_markers = is_eeg_connected; %% For testing on local

clearvars TaskName vars % clean up workspace
% expinfo = getBio(expinfo);
%% Allgemeine Einstellungen & Start von PTB %%

% Open PTB windown
expinfo = startPTB(expinfo,expinfo.testExp); 

% Read in Exp Settings. This is only to keep your wrapper code tidy and
% structured. All Settings for the Experiment should be specified in this
% funtion. Rarely you will perform complex programming in this function.
% Rather you will define variables or experimental factors, etc.
expinfo = getExpSettings(expinfo);
% Set priority for PTB processes to ensure best possible timing
topPriorityLevel = MaxPriority(expinfo.window);
Priority(topPriorityLevel);
isPractice = 0;
expinfo = getMarkers(expinfo, isPractice);

% Write Demo data to folder
writetable(cell2table({expinfo.subject, expinfo.subjectName, expinfo.subjectSex, expinfo.counterbal_left_right},"VariableNames",["subject_id" "subject_name" "subject_sex" "counterbal_condition"]),[expinfo.DataFolder,'Subject_',num2str(expinfo.subject),'control_backup', '.csv']);

setMarker(expinfo, expinfo.Marker.MatlabStart)

%% 1.General Instructions
displayInstruction(expinfo, expinfo.InstFolder, 'welcome')

%% Experimental Blocks
blocks = struct();
blocks.block_num = 1:4;
blocks.n_targets = zeros(1, max(blocks.block_num)) - 2;
blocks.response = zeros(1, max(blocks.block_num)) - 2;
blocks.rt = zeros(1, max(blocks.block_num)) - 2;
blocks.acc = zeros(1, max(blocks.block_num)) - 2;

if test_run
    blocks.n_practice_trials = [1, 0, 1, 0];
    blocks.n_exp_trials = [1, 1, 1, 1];
else
    blocks.n_practice_trials = [10, 0, 10, 0];
    blocks.n_exp_trials = [10, 10, 10, 10];
end

expinfo.blocks = blocks;

for block_num = start_from:max(expinfo.blocks.block_num)
    %% Init Variables
    expinfo = getMarkers(expinfo, block_num);
    n_exp_trials = expinfo.blocks.n_exp_trials(block_num);
    n_practice_trials = expinfo.blocks.n_practice_trials(block_num);
    
    practice_mat = zeros(n_practice_trials, 1);
    
    practice_mat(:, 1) = generateOddballBlock(n_practice_trials, expinfo.targetProbability)';
    
    trial_mat = zeros(n_exp_trials, 1);

    trial_mat(:, 1) = generateOddballBlock(n_exp_trials, expinfo.targetProbability);
    
    ExpTrials = makeTrials(trial_mat, expinfo, block_num);

    if n_practice_trials > 0
        repeat_practice = 1;

        PracTrials = makeTrials(practice_mat, expinfo, block_num);
    else
        repetition_practice = 0;
    end
    
    repetition_num = 1;

    %% Practice Blocks
    while repeat_practice
        % Show instruction Slide
        displayInstruction(expinfo, expinfo.InstFolder, 'instructions_resp_c');
    
        % Loop through practice trials
        setMarker(expinfo, expinfo.Marker.PracStart)
        
        for itrial = 1:n_practice_trials
            PracTrials = DisplayStandardTrial(expinfo, PracTrials, itrial, block_num, 1, repetition_num);
        end

        n_targets = sum(practice_mat, 1);

        [acc, response, correct, rt] = getResponseNTargets(expinfo, n_targets);
        
        Data = table(block_num, correct, response, acc, rt);

        writetable(Data,[expinfo.DataFolder,'Oddball_Subject_',num2str(expinfo.subject),'Prac_Block_', num2str(block_num), '_', num2str(repetition_num), '.csv']);
    
        setMarker(expinfo, expinfo.Marker.PracEnd)
        
        % Show instruction Slide
        last_response = displayInstruction(expinfo, expinfo.InstFolder, 'instructions_resp_c', 1);
        
        %last_response = 1;
        if last_response == 9
            practice_mat = zeros(n_practice_trials, 1);
    
            practice_mat = generateOddballBlock(n_practice_trials, expinfo.targetProbability)';

            if n_practice_trials > 0
                PracTrials = makeTrials(practice_mat, expinfo, block_num);
            end

            repetition_num = repetition_num +1;
        else
            repeat_practice = 0;
            repetition_num = 1;
        end
    end

    %% Experimental Block
    setMarker(expinfo, expinfo.Marker.BlockStart)
    
    pause_50 = 0;
    %{
    if n_exp_trials > 30
        pause_50 = 1;
    else
        pause_50 = 0;
    end
    %}

    if pause_50
        for itrial = 1:ceil(n_exp_trials / 2)
            ExpTrials = DisplayStandardTrial(expinfo, ExpTrials, itrial, block_num, 0);
        end
        setMarker(expinfo, expinfo.Marker.BreakStart);
           
        Break=[expinfo.InstFolder '/half_break.jpg']; % Eine Folie, dass Exp startete und Aufgabenbeschreibung
        ima=imread(Break);
        dImageWait(expinfo,ima);
       
        setMarker(expinfo, expinfo.Marker.BreakEnd);

        for itrial = ceil(n_exp_trials/2) + 1:n_exp_trials
            ExpTrials = DisplayStandardTrial(expinfo, ExpTrials, itrial, block_num, 0);
        end
    else
        for itrial = 1:n_exp_trials
            ExpTrials = DisplayStandardTrial(expinfo, ExpTrials, itrial, block_num, 0);
        end
    end

    [acc, response, correct, rt] = getResponseNTargets(expinfo, n_targets);
        
    Data = table(block_num, correct, response, acc, rt);

    writetable(Data,[expinfo.DataFolder,'Oddball_Subject_',num2str(expinfo.subject),'Exp_Block_', num2str(block_num), '_', num2str(repetition_num), '.csv']);

    %% For last trial ITI
    WaitSecs(expinfo.MinITIduration+rand(1)*expinfo.ITIjitter);
    
    setMarker(expinfo, expinfo.Marker.BlockEnd)

    % Show Block End Slide
    displayInstruction(expinfo,expinfo.InstFolder, 'end_block');
end

%% End Experiment
   
setMarker(expinfo, expinfo.Marker.ExpEnd);
% Display one final slide telling the participant that the experiment is
% finished.
ExpEnd=[expinfo.InstFolder '/ExpEnd.jpg'];
ima=imread(ExpEnd, 'jpg');
dImageWait(expinfo,ima);
            

% io64(expinfo.ioObj, expinfo.PortAddress, expinfo.Marker.ExpEnd);
% WaitSecs(0.1);
% io64(expinfo.ioObj, expinfo.PortAddress,0);% Stop Writing to Output Port

Priority(0); % Reset priority to low level
closeexp(expinfo.window); % Close the experiment


%% End of Script
% This script was programmed by Gidon T. Frischkorn, as part of a
% template for MATLAB experiments. If you have any questions please contact
% me via mail: gidon.frischkorn@psychologie.uni-heidelberg.de
