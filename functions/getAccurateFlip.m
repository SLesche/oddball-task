% This function computes accurate timestamps for the next flip. This
% ensures accuracte timing for your experiment.

function [when_flip] = getAccurateFlip(window,lastflip,when_nextflip)

ifi = Screen('GetFlipInterval', window);
waitframes = round(when_nextflip/ifi);
when_flip = lastflip + (waitframes - 0.1) * ifi;

end

%% End of Function
% This function was programmed by Gidon T. Frischkorn, as part of a
% template for MATLAB experiments. If you have any questions please contact
% me via mail: gidon.frischkorn@psychologie.uni-heidelberg.de