%%% This Script draws the GEMINI modeling volume 

%% 0 - Define path to "figure1"
workpath = '/Users/akv020/Projects/Dataverse/source/figure1';
cd(workpath)

%% 1 - Define coordinates for relevant cities

% Define coordinates for relevant cities
skibotn = [69.38976025279854, 20.266842112064637];
origin = [skibotn, 0]; 
[x_skibotn, y_skibotn, z_skibotn] = latlon2local(skibotn(1), skibotn(2), 0, origin);

tromso = [69.65443048865711, 18.95303583245478];
[x_tromso, y_tromso, z_tromso] = latlon2local(tromso(1), tromso(2), 0, origin);

kiruna = [67.85178411022663, 20.229081180345766];
[x_kiruna, y_kiruna, z_kiruna] = latlon2local(kiruna(1), kiruna(2), 0, origin);

sodankyla = [67.41867217463184, 26.590009140770327];
[x_sodankyla, y_sodankyla, z_sodankyla] = latlon2local(sodankyla(1), sodankyla(2), 0, origin);

kaiseniemi = [68.2824652228173, 19.450762996589663];
[x_kaiseniemi, y_kaiseniemi, z_kaiseniemi] = latlon2local(kaiseniemi(1), kaiseniemi(2), 0, origin);

karesuvanto = [68.44881706477989, 22.480177182503134];
[x_karesuvanto, y_karesuvanto, z_karesuvanto] = latlon2local(karesuvanto(1), karesuvanto(2), 0, origin);

% Define colors for each location
C_skibotn = [0.7350, 0.0780, 0.1840];
C_tromso = [0.9290, 0.6940, 0.1250];
C_kiruna = [0.4660, 0.7740, 0.1880];
C_kaiseniemi = [0.4940, 0.1840, 0.5560];
C_sodankyla = [0, 0.4470, 0.7410];
C_karesuvanto = [0.7410, 0.4470, 0.1880];

%% 2 - Load data
x = ncread("ne_3d_sample.nc","x");
y = ncread("ne_3d_sample.nc","y");
z = ncread("ne_3d_sample.nc","z");
ne = ncread("ne_3d_sample.nc","ne");

VNE = log10(permute(ne, [2, 1, 3]));
[X, Y, Z] = meshgrid(x, y, z);

%% 3 - Draw modelling volume
FIG = figure('units', 'centimeters', 'position', [0, 0, 25.0, 37.0]);
boxcolor = [0, 0.4470, 0.7410];
fa = 0.1; 
fz = 26; 
lw = 6;
cmin = log10(4e10);
cmax = log10(8e11);

% Plot the volume slice
slice(X, Y, Z, VNE, x(1), x(512), z(24))
colormap(inferno)
shading flat
hold on
clim([cmin cmax])

% Draw the cube representing the modeling volume
drawcube([-250 250], [-250 250], [80 1000], 75, [boxcolor fa], 2);
xlim([-300 300])
ylim([-300 300])
zlim([1 1000])
set(gca, 'fontsize', fz)
campos([3.7318 -4.1805 4.0955] * 1e3)
grid on
set(gca, 'zscale', 'log')

% Plot the positions of the cities
h(1) = plot3(x_skibotn / 1e3, y_skibotn / 1e3, 1, 's', 'color', C_skibotn, 'LineWidth', 10);
h(2) = plot3(x_tromso / 1e3, y_tromso / 1e3, 1, 's', 'color', C_tromso, 'LineWidth', 10);
h(3) = plot3(x_kiruna / 1e3, y_kiruna / 1e3, 1, 's', 'color', C_kiruna, 'LineWidth', 10);
h(4) = plot3(x_kaiseniemi / 1e3, y_kaiseniemi / 1e3, 1, 's', 'color', C_kaiseniemi, 'LineWidth', 10);
h(5) = plot3(x_sodankyla / 1e3, y_sodankyla / 1e3, 1, 's', 'color', C_sodankyla, 'LineWidth', 10);
h(6) = plot3(x_karesuvanto / 1e3, y_karesuvanto / 1e3, 1, 's', 'color', C_karesuvanto, 'LineWidth', 10);

% Add legend and labels
legend(h, {'Skibotn', 'Troms{\o}', 'Kiruna', 'Kaiseniemi', 'Sodankyl{\"a}', 'Karesuvanto'}, 'Location', [0.586, 0.321, 0.216, 0.143], 'Interpreter', 'latex', 'fontsize', fz);
xlabel('x [km]', 'Interpreter', 'latex', 'fontsize', fz)
ylabel('y [km]', 'Interpreter', 'latex', 'fontsize', fz)
zlabel('z [km]', 'Interpreter', 'latex', 'fontsize', fz)
set(gca, 'fontsize', fz)
axis image
c = colorbar;
c.Label.String = 'Density [$m^{-3}$]';
c.Label.FontSize = fz;
c.Label.Interpreter = 'latex';
set(c, 'TickLabelInterpreter', 'latex')

% Define annotation properties
dxa = 0.05;
dya = 0.02;
mxa = 0.6;
mya = 0.7;
xa = [mxa + dxa mxa - dxa];
ya = [mya + dya mya - dya];
L = [xa(2) - xa(1) ya(2) - ya(1)];

% Add annotations
a = annotation('textarrow', xa, ya, 'String', '$v_1$, $n_1$', 'interpreter', 'latex');
mxb = mxa - 2 * L(2) + 3 * L(1);
myb = mya - 2 * L(1) + 3 * L(2);
dxb = 0.1;
dyb = 0.04;
xb = [mxb + dxb mxb - dxb];
yb = [myb + dyb myb - dyb];
b = annotation('textarrow', xb, yb, 'String', '$v_2$, $n_2$', 'interpreter', 'latex');
mxc = (mxa + mxb) / 2 + L(1);
myc = (mya + myb) / 2 + L(2);
dxc = -0.04;
dyc = 0.01;
xc = [mxc + dxc mxc - dxc] - 0.03;
yc = [myc + dyc myc - dyc] - 0.03;
c = annotation('textarrow', xc, yc, 'String', '$\ell $ ', 'interpreter', 'latex');
d = annotation('doublearrow', xc, yc);

% Set annotation properties
a.Color = [0.7350, 0.0780, 0.1840];
a.FontSize = fz + 8;
b.Color = [0.7350, 0.0780, 0.1840];
b.FontSize = fz + 8;
c.Color = [0.4660 0.6740 0.1880];
c.FontSize = fz + 8;
d.Color = [0.4660 0.6740 0.1880];
a.LineWidth = lw;
b.LineWidth = lw;
c.LineWidth = lw;
d.LineWidth = lw;

% Set axis tick properties
xticks([-200 0 200])
yticks([-200 0 200])
set(gca, 'TickLabelInterpreter', 'latex') % Set all axes to latex interpreter
