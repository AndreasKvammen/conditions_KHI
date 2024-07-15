%%% This function calculates the furthest distance of the KHI structures
%%%  to the shear interface

function [y_dist] = y_distance(nev,y,th)
% nev - density volume (x,y,t)
% y - y coordinates
% th - pertubation threshold

% find number of timesteps
istop = size(nev,3);

% loop over all timesteps
for i = 1:istop

    % find pertibation amplitude
    vne = nev(:,:,i);
    dne = max(vne, [], 2) - min(vne, [], 2);
    nemax = max(vne(:));
    nemin = min(vne(:));

    % Use Equation 6 in article to calculate normalized pertubation
    ne_th = (nemax - nemin) * th;
    idxs = find(dne > ne_th);

    % assign distance to y_dist
    if isempty(idxs)
        y_dist(i) = -y(round(length(y)/2));
    else
        y_dist(i) = -y(idxs(1));
    end
end

end