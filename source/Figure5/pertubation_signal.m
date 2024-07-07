%%% This fucntion calculates the pertubation of a simulation frame along a
%%% slice at 0 km EW

function [signal] = pertubation_signal(nev)
    slice_idx = round(size(nev,1)/2);
    ne = squeeze(nev(slice_idx,:,:));
    maxne = squeeze(mean(nev(end,:,:)))';
    minne = squeeze(mean(nev(1,:,:)))';
    maenne = (maxne + minne)/2;
    amp_ne = max(ne) - min(ne);
    signal = (amp_ne)./maenne;
end