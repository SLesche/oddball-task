function [expinfo] = getMarkers(expinfo, block_num)
% This is a function that specifies EEG Markers for the experiment and
% saves them into the expinfo object, so that Markers can be accessed
% during the Experiment without any further computational load.

%% Specify Block Markers for Experiment

    Marker.MatlabStart = 1;
    Marker.ExpEnd = 2;
    Marker.BreakStart = 3;
    Marker.BreakEnd = 4;
    
%% Specify Stimulus Markers within each trial
% Markers for different Screens
    
    Marker.PracStart = 60 + block_num;
    Marker.PracEnd = 70 + block_num;
    Marker.BlockStart = 80 + block_num; 
    Marker.BlockEnd = 90 + block_num;

    Marker.FixNonTarget = 40;
    Marker.FixTarget = 50;
    Marker.StimNonTarget = 41;
    Marker.StimTarget = 51; % Marker for task following probe presentation
    Marker.ITINonTarget = 42;
    Marker.ITITarget = 52; % Marker for task following probe presentation

    Marker.CorrRespTarget = 150;
    Marker.IncorrRespTarget = 250;
    Marker.CorrRespNonTarget = 151;
    Marker.IncorrRespNonTarget = 251;
    Marker.CorrResponseOpenQuestion = 152;
    Marker.IncorrResponseOpenQuestion = 252;
    Marker.Miss = 253;
    
    %% Write Markers into expinfo object
    expinfo.Marker = Marker;
end

