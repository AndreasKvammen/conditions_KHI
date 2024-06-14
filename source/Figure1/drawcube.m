function h = drawcube(X, Y, Z, dV, lc, lw)
% DRAWCUBE Draws a cube defined by the given boundaries with specified properties.
%
% Inputs:
%   X  - Range in the X direction [X_min, X_max]
%   Y  - Range in the Y direction [Y_min, Y_max]
%   Z  - Range in the Z direction [Z_min, Z_max]
%   dV - Step size for creating the mesh grid
%   lc - Line color for the cube edges
%   lw - Line width for the cube edges
%
% Output:
%   h  - Handle to the line object representing the cube

% Create mesh grids for the cube faces
x = (X(1):dV:X(2));
y = (Y(1):dV:Y(2));
z = (Z(1):dV:Z(2));

% Generate the mesh grids for the six faces of the cube
[X1, Y1, Z1] = meshgrid(x([1 end]), y, z);
X1 = permute(X1, [2 1 3]); 
Y1 = permute(Y1, [2 1 3]); 
Z1 = permute(Z1, [2 1 3]);
[X2, Y2, Z2] = meshgrid(x, y([1 end]), z);
[X3, Y3, Z3] = meshgrid(x, y, z([1 end]));
X3 = permute(X3, [3 1 2]); 
Y3 = permute(Y3, [3 1 2]); 
Z3 = permute(Z3, [3 1 2]);

% Add NaN values to create breaks in the lines (for visual separation)
X1(end+1,:,:) = NaN; Y1(end+1,:,:) = NaN; Z1(end+1,:,:) = NaN;
X2(end+1,:,:) = NaN; Y2(end+1,:,:) = NaN; Z2(end+1,:,:) = NaN;
X3(end+1,:,:) = NaN; Y3(end+1,:,:) = NaN; Z3(end+1,:,:) = NaN;

% Combine all coordinates
X_combined = [X1(:); X2(:); X3(:)];
Y_combined = [Y1(:); Y2(:); Y3(:)];
Z_combined = [Z1(:); Z2(:); Z3(:)];

% Draw the cube using line objects
h = line(X_combined, Y_combined, Z_combined);

% Set the line properties
set(h, 'Color', lc, 'LineWidth', lw, 'LineStyle', '-')

end
