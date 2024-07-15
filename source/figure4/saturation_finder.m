%%% This function finds the saturation point for the KHI growth
% saturation_y is the defined KHI strength at saturation
% saturation_x is the first time where saturation_y is reached

function [saturation_threshold, threshold_crossing_time, param] = saturation_finder(nev,plt)
    signal = pertubation_signal(nev);
    time = (0:10:1800);
    [saturation_threshold, threshold_crossing_time, param] = fitSigmoidAndFindSaturation(time, signal,plt);
end