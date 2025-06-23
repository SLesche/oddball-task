% This function loads all settings for the experiment

function expinfo = getExpSettings(expinfo)
    %% Get Date an time for this session
    expinfo.DateTime = datetime('now');
    
    expinfo.DateTime.Format = 'dd-MMM-yyyy';
    expinfo.Date = cellstr(expinfo.DateTime);
    expinfo.Date = expinfo.Date{1};
    
    expinfo.DateTime.Format = 'hh:mm:ss';
    expinfo.Time = cellstr(expinfo.DateTime);
    expinfo.Time = expinfo.Time{1};
    %expinfo.ifi = Screen('GetFlipInterval', expinfo.window);
    %% Specify Stimulus and Text properties (Size, Position, etc.)
    expinfo.stimulussize = 40; % in Pixel bzw. Point
    
    
    %% Initiate Input Output settings for Markers
    if expinfo.send_markers
        expinfo.ioObj = io64;
        expinfo.IOstatus = io64(expinfo.ioObj);
        expinfo.PortAddress = hex2dec('E010');
        io64(expinfo.ioObj, expinfo.PortAddress, 0); % Stop Writing to Output Port
    end
    
    %% Secify number of general instruction slides
    expinfo.InstStopGenerally = 3;
    expinfo.ExpStopPrac = 2;
    
    %% Timing - fixed in all trials
    expinfo.Fix_Duration =0; % Dauer des Fixationskreuzes zu Beginn eines Trials
    expinfo.Fixjitter = 0;
        
    % expinfo.MinISIduration = 0.4; % Minimale Dauer des Inter-Stimulus-Intervalls (ISI)
    % expinfo.ISIjitter = 0.2; % ISI Jitter = Intervall in dem das ISI variieren darf

    % expinfo.MinMemSetDelayISI = expinfo.MinISIduration;
    % expinfo.MemSetDelayISIjitter = expinfo.ISIjitter;
    
    expinfo.MaxRT = 3;
    expinfo.MinRT = 1;
    expinfo.StimDuration = 1; 
    expinfo.Stimjitter = 0;
    
    % expinfo.ProbeDuration =expinfo.MinRT; 
    % expinfo.Probejitter = 0;

    % expinfo.MinProbeDelayISI = expinfo.MinISIduration;
    % expinfo.ProbeDelayISIjitter = expinfo.ISIjitter;

    expinfo.MinITIduration = 1.4; % Minimale Dauer des Inter-Trial-Intervalls (ITI)
    expinfo.ITIjitter =0.2; %ITI Jitter
    expinfo.maxiter =1000;
    
    expinfo.RespFeedback = 0.3;
    expinfo.CueDuration = 1.8;
    expinfo.Cuejitter = 0.4;
    expinfo.FeedbackDuration = 0.8;
    expinfo.waitingtime=0.2;
    
    %% Specify Response Keys used in the experiment
    expinfo.LeftKey = 'c';
    expinfo.RightKey = 'm';

    if strcmp(expinfo.counterbal_left_right, 'left')
        expinfo.targetKey = expinfo.LeftKey;
        expinfo.nonTargetKey = expinfo.RightKey;
    elseif strcmp(expinfo.counterbal_left_right, 'right')
        expinfo.targetKey = expinfo.RightKey;
        expinfo.nonTargetKey = expinfo.LeftKey;
    else
        error("Ill defined counterbalace operation")
    end

    expinfo.AbortKey = 'q';
    expinfo.RepeatKey = 'r';
    expinfo.StartKey = 'space';
    
    %% Defining trials to be conducted
    % Specify how many trials should be conducted
    expinfo.TargetStim = '7';
    expinfo.NonTargetStim = '3';
    expinfo.targetProbability = 0.2;

    %% Colors
    expinfo.Colors.bgColor = [140 140 140]; % white
    expinfo.Colors.green =  [0 178 30];
    expinfo.Colors.red = [255 25 32];
    expinfo.Colors.gray =  [140 140 140];
    expinfo.Colors.black = [0 0 0];
    expinfo.Colors.blue = [0 0 255];
    
    
    %% Size of Grid
    expinfo.GridSize1 = 0.25;
    expinfo.GridSize2 = 0.41665;
    expinfo.GridSize3 = 0.58325;
    expinfo.bottomEdge = 100;
    expinfo.GridSize = 45;
    expinfo.respbox = 50;
    expinfo.distance = 50;
    
    %% Stimulus Positions in Grid
    
    expinfo.XPos1 = [(expinfo.xCenter - expinfo.GridSize)];
    expinfo.YPos1 =[(expinfo.yCenter + expinfo.GridSize)]; 
    expinfo.XPos2 = [expinfo.xCenter];
    expinfo.YPos2 = [(expinfo.yCenter + expinfo.GridSize)]; 
    expinfo.XPos3 = [(expinfo.xCenter + expinfo.GridSize) ];
    expinfo.YPos3 =  [(expinfo.yCenter + expinfo.GridSize)]; 
    expinfo.XPos4 = [(expinfo.xCenter - expinfo.GridSize)];
    expinfo.YPos4 = [ expinfo.yCenter]; 
    expinfo.XPos5 = [expinfo.xCenter];
    expinfo.YPos5 =[expinfo.yCenter]; 
    expinfo.XPos6 = [(expinfo.xCenter + expinfo.GridSize)];
    expinfo.YPos6 = [expinfo.yCenter]; 
    expinfo.XPos7 = [(expinfo.xCenter - expinfo.GridSize) ];
    expinfo.YPos7 =[(expinfo.yCenter - expinfo.GridSize)]; 
    expinfo.XPos8 = [expinfo.xCenter ];
    expinfo.YPos8 = [(expinfo.yCenter - expinfo.GridSize)]; 
    expinfo.XPos9 = [(expinfo.xCenter + expinfo.GridSize)];
    expinfo.YPos9 = [(expinfo.yCenter - expinfo.GridSize)]; 
    expinfo.XPos = [expinfo.XPos1 expinfo.XPos2 expinfo.XPos3 expinfo.XPos4 expinfo.XPos5 expinfo.XPos6 expinfo.XPos7 expinfo.XPos8 expinfo.XPos9];
    expinfo.YPos = [expinfo.YPos1 expinfo.YPos2 expinfo.YPos3 expinfo.YPos4 expinfo.YPos5 expinfo.YPos6 expinfo.YPos7 expinfo.YPos8 expinfo.YPos9];
    
    %% Outgrid Range from central Point
    
    expinfo.RangeFromCentral = 20;
    %% Fonts
    expinfo.Fonts.textFont  = expinfo.Fonts.sansSerifFont;
    %% Specify Instruction folder
    % expinfo.InstFolder      = 'instructions/'; % Defined from
    % PromptProvideInfos
    expinfo.InstExtension   = '.JPG';
    expinfo.DataFolder      = 'data/';
end 
%% End of Function