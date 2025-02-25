function [Trial] = makeTrials(trial_matrix, expinfo, block_num)
    %Informationen einbauen
    n_trials = size(trial_matrix, 1);

    for trial = 1:n_trials
        Trial(trial).TaskDescription = 'Oddball_Task';
        Trial(trial).Subject = expinfo.subject;
        Trial(trial).TrialNum = trial;
        Trial(trial).Block = block_num;
        Trial(trial).isTarget = trial_matrix(trial, 1);
        Trial(trial).targetKey = expinfo.targetKey;
        Trial(trial).nonTargetKey = expinfo.nonTargetKey;
        Trial(trial).hasResponse = 0;
    end

    for trial = 1:n_trials
        for i = 1:Trial(trial).MemSetSize
            %Trial(trial).ISI(i) = expinfo.MinISIduration+rand(1)*expinfo.ISIjitter;
            Trial(trial).StimDuration(i) = expinfo.StimDuration+rand(1)*expinfo.Stimjitter;
        end
    end

    for trial = 1: size(Trial,2)
        Trial(trial).ITI = expinfo.MinITIduration+rand(1)*expinfo.ITIjitter;
        Trial(trial).FIX = expinfo.Fix_Duration+rand(1)*expinfo.Fixjitter;
    end

    for trial = 1: size(Trial,2)
        Trial(trial).FixMarkerNonTarget = expinfo.Marker.FixNonTarget;
        Trial(trial).FixMarkerTarget = expinfo.Marker.FixTarget;
        Trial(trial).StimMarkerNonTarget = expinfo.Marker.StimNonTarget;
        Trial(trial).StimMarkerTarget = expinfo.Marker.StimTarget;
        Trial(trial).ITIMarkerNonTarget = expinfo.Marker.ITINonTarget;
        Trial(trial).ITIMarkerTarget = expinfo.Marker.ITITarget;
    end
end