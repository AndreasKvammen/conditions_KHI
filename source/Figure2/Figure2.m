%%% This script plots the evolution of the fastest simulation

%% 1 - Define paths
workpath = '/Users/akv020/Projects/conditions_KHI/source/Figure2';

%% 2 - Load data
cd(workpath)
load('Ne11_L02_V18.mat')

%% 3 - Define times to plot
[signal] = pertubation_signal(nev);
idxx = 7:24;

%% 4 - Estimate spatial growth
for i = 1:31
    vne = nev(:,:,i);
    dne = max(vne, [], 2) - min(vne, [], 2);
    nemax = max(vne(:));
    nemin = min(vne(:));
    ne_th = (nemax - nemin) * 0.1;
    idxs = find(dne > ne_th);

    if isempty(idxs)
        idx(i) = east(round(length(east)/2));
    else
        idx(i) = east(idxs(1));
    end
end

%% 5 - Plot evolution
FIG = figure('units', 'centimeters', 'position', [0, 0, 36.0, 39.0]);
sx = 0.045;
sy = 0.065;
fz = 18;
lw = 3;
colormap(inferno)
alf = 'a':'z';

for i = 1:length(idxx)
    subplot_tight(7, 3, i, [sx, sy])
    imagesc(nort, east, log10(squeeze(nev(:,:,idxx(i)))))

    % Set labels and properties for specific subplots
    if any(i == [1, 4, 7, 10, 13, 16])
        ylabel('East [km]', 'interpreter', 'latex');
        yaxisproperties = get(gca, 'YAxis');
        yaxisproperties.TickLabelInterpreter = 'latex';
    else
        set(gca, 'YTick', [])
    end

    if i > 15
        xlabel('North [km]', 'interpreter', 'latex');
        xaxisproperties = get(gca, 'XAxis');
        xaxisproperties.TickLabelInterpreter = 'latex';
    else
        set(gca, 'XTick', [])
    end

    % Set colorbar for the first subplot
    if i == 1
        c = colorbar;
        c.Location = 'South';
        c.Ticks = [10.5 10.7 10.9 11.1];
        c.FontSize = fz;
        c.Label.String = 'Density [$m^{-3}$]';
        c.Label.Position = [10.817143143245152, -2.672727368094684, 0];
        c.Label.Interpreter = 'latex';
        set(c, 'TickLabelInterpreter', 'latex')
    end

    % Set plot title
    title([alf(i), ') time: ', num2str((idxx(i)-1) * 10), ' s'], 'fontsize', fz, 'interpreter', 'latex', 'FontWeight', 'normal')
    clim([10.4 11.2])
    set(gca, 'fontsize', fz)
end

%% 6 - Plot the perturbation strength
subplot_tight(7, 3, [19 20 21], [sx, sy + 0.01])
yyaxis left
plot((0:10:(length(signal)-1) * 10), signal, 'LineWidth', lw, 'color', [0, 0.4470, 0.7410])
xlim([0 300])
set(gca, 'yscale', 'log')
set(gca, 'Ytick', [0.01 0.1 1])
xlabel('Time [s]', 'interpreter', 'latex');
ylabel('Perturbation', 'interpreter', 'latex');
grid on
set(gca, 'ycolor', [0, 0.4470, 0.7410])
ylim([5e-3 3e0])
xaxisproperties = get(gca, 'XAxis');
xaxisproperties.TickLabelInterpreter = 'latex';
yaxisproperties = get(gca, 'YAxis');
yaxisproperties(1).TickLabelInterpreter = 'latex';
set(gca, 'fontsize', fz)

%% 7 - Calculate and plot the EW growth
[signal] = pertubation_signal(nev);
yyaxis right
spatial = round(-idx);
plot((0:10:(length(spatial)-1) * 10), spatial, 'LineWidth', lw, 'color', [0.6350, 0.0780, 0.1840])
ylabel('EW extent [km]', 'interpreter', 'latex');
text(10, 25, 's)', 'FontSize', fz, 'interpreter', 'latex');
set(gca, 'ycolor', [0.6350, 0.0780, 0.1840])
ylim([-2 30])
yaxisproperties(2).TickLabelInterpreter = 'latex';
set(gca, 'fontsize', fz)
