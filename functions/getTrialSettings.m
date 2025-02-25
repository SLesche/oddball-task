function [expinfo] = getTrialSettings(expinfo)
    expinfo.trialSettingsDefined = true;
    expinfo.Fix_Duration = 2;
    expinfo.Fix_jitter = 0.1;
    expinfo.MinISIduration = 1.5;
    expinfo.ISIjitter = 0.1;
    expinfo.Stimjitter = 0.05;
    expinfo.MinTarget = 1;
    expinfo.MaxRT = 6;
    expinfo.MinITIduration =1;
    expinfo.StimDuration = 0.2 ;
    expinfo.ProbeDuration = 0.5;
    expinfo.ITIjitter =0.5;
    expinfo.Fixjitter =0.5;
    
    expinfo.maxIter=1000;
    expinfo.Stimuli = [0:9];
    expinfo.maxsetsize = 7;
    expinfo.conditionInfo=5;
    expinfo.nPracTrials_1=3;
end