%%% This function calculates the perturbation of a simulation frame along a
%%% slice at 0 km EW

function [signal] = pertubation_signal(nev)
    % Calculate the index of the slice at 0 km EW
    slice_idx = round(size(nev, 1) / 2);
    
    % Extract the slice at the calculated index
    ne = squeeze(nev(slice_idx, :, :));
    
    % Calculate the mean plasma density at the top and bottom of the frame
    maxne = squeeze(mean(nev(end, :, :)))';
    minne = squeeze(mean(nev(1, :, :)))';
    
    % Calculate the average plasma density between the top and bottom
    maenne = (maxne + minne) / 2;
    
    % Calculate the amplitude of the perturbation
    amp_ne = max(ne) - min(ne);
    
    % Calculate the perturbation signal
    signal = amp_ne ./ maenne;
end