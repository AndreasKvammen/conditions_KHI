%%% This script plots the KHI growth

%% 1 - Define paths
workpath = '/Users/akv020/Projects/conditions_KHI/source/Figure3';

%% 2 - Load data
cd(workpath)
load('pertubation_growth.mat')

%% 3 - Define data arrays
timeKHI = linspace(0, 30, 181);

%% 4 - Define simulation markers
for i = 1:numel(files)
    filename = files(i).name;
    density = str2num(filename(1));
    velocity_1 = str2num(filename(11));
    velocity_2 = str2num(filename(12));
    velocity_3 = str2num(filename(13));
    
    if density == 5
        if velocity_3 == 8 && velocity_2 == 0
            KHIstring = ['$n_p = 5 \times 10^{11}\, \mathrm{m}^{-3}$', ' $\Delta v$ = 0.', num2str(velocity_3), ' km/s'];
        else 
            KHIstring = ['$n_p = 5 \times 10^{11}\,  \mathrm{m}^{-3}$', ' $\Delta v$ = ', num2str(velocity_2), '.', num2str(velocity_3), ' km/s'];
        end
    elseif density == 1
        if velocity_1 == 8 && velocity_2 == 0
            KHIstring = ['$n_p = 1 \times 10^{11}\,  \mathrm{m}^{-3}$', ' $\Delta v$ = 0.', num2str(velocity_2), '.', num2str(velocity_1), ' km/s'];
        else 
            KHIstring = ['$n_p = 1 \times 10^{11}\,  \mathrm{m}^{-3}$', ' $\Delta v$ = ', num2str(velocity_1), '.', num2str(velocity_2), ' km/s'];
        end
    else
        if velocity_1 == 8 && velocity_2 == 0
            KHIstring = ['$n_p = 1 \times 10^{12}\,  \mathrm{m}^{-3}$', ' $\Delta v$ = 0.', num2str(velocity_2), '.', num2str(velocity_1), ' km/s'];
        else 
            KHIstring = ['$n_p = 1 \times 10^{12}\,  \mathrm{m}^{-3}$', ' $\Delta v$ = ', num2str(velocity_1), '.', num2str(velocity_2), ' km/s'];
        end
    end

    KHI{i} = KHIstring;
end

%% 5 - Plot KHI growth
FIG = figure('units', 'centimeters', 'position', [0, 0, 37.0, 39.0]);
sx = 0.045;
sy = 0.065;
fz = 18;
lw = 3;
colors = {[0.6350, 0.0780, 0.1840], [0.4660, 0.6740, 0.1880], [0, 0.4470, 0.7410]};

% Subplot for perturbation strength for l = 2 km
subplot_tight(3, 2, 1, [sx, sy])
hold on
for i = 10:12
    plot(timeKHI, KHI_growth(i, :), '-.', 'Color', colors{i-9}, 'linewidth', lw)
end
for i = 1:3
    plot(timeKHI, KHI_growth(i, :), '-', 'Color', colors{i}, 'linewidth', lw)
end
for i = 19:21
   plot(timeKHI, KHI_growth(i, :), '--', 'Color', colors{i-18}, 'linewidth', lw)
end
title('a) perturbation strength for $\ell$ = 2 km', 'Interpreter', 'latex', 'fontsize', fz, 'FontWeight', 'normal')
set(gca, 'fontsize', fz)
legend({KHI{10:12}, KHI{1:3}, KHI{19:21}}, 'Interpreter', 'latex', 'Location', 'Southeast')
grid on 
set(gca, 'XTickLabel', [])
ylabel('Perturbation', 'Interpreter', 'latex', 'fontsize', fz)
set(gca, 'YScale', 'log')
xlim([0 30])
ylim([5e-3 3e0])
yaxisproperties= get(gca, 'YAxis');
yaxisproperties.TickLabelInterpreter = 'latex';
set(gca,'FontSize',fz)

% Subplot for perturbation strength for l = 6 km
subplot_tight(3, 2, 3, [sx, sy])
hold on
for i = 13:15
    plot(timeKHI, KHI_growth(i, :), '-.', 'Color', colors{i-12}, 'linewidth', lw)
end
for i = 4:6
    plot(timeKHI, KHI_growth(i, :), '-', 'Color', colors{i-3}, 'linewidth', lw)
end
for i = 22:24
    plot(timeKHI, KHI_growth(i, :), '--', 'Color', colors{i-21}, 'linewidth', lw)
end
grid on
title('c) perturbation strength for $\ell$ = 6 km', 'Interpreter', 'latex', 'fontsize', fz, 'FontWeight', 'normal')
set(gca, 'XTickLabel', [])
ylabel('Perturbation', 'Interpreter', 'latex', 'fontsize', fz)
set(gca, 'YScale', 'log')
xlim([0 30])
ylim([5e-3 3e0])
yaxisproperties= get(gca, 'YAxis');
yaxisproperties.TickLabelInterpreter = 'latex';
set(gca,'FontSize',fz)

% Subplot for perturbation strength for l = 10 km
subplot_tight(3, 2, 5, [sx, sy])
hold on
for i = 16:18
    plot(timeKHI, KHI_growth(i, :), '-.', 'Color', colors{i-15}, 'linewidth', lw)
end
for i = 7:9
    plot(timeKHI, KHI_growth(i, :), '-', 'Color', colors{i-6}, 'linewidth', lw)
end
for i = 25:27
    plot(timeKHI, KHI_growth(i, :), '--', 'Color', colors{i-24}, 'linewidth', lw)
end
xlim([0 30])
ylim([5e-3 3e0])
grid on
set(gca, 'YScale', 'log')
ylabel('Perturbation', 'Interpreter', 'latex', 'fontsize', fz)
title('e) perturbation strength for $\ell$ = 10 km', 'Interpreter', 'latex', 'fontsize', fz, 'FontWeight', 'normal')
xlabel('Time [min]', 'Interpreter', 'latex', 'fontsize', fz)
xaxisproperties= get(gca, 'XAxis');
xaxisproperties.TickLabelInterpreter = 'latex';
yaxisproperties= get(gca, 'YAxis');
yaxisproperties.TickLabelInterpreter = 'latex';
set(gca,'FontSize',fz)

%% 6 - Define simulation markers for spatial growth
load('spatial_growth.mat')
for i = 1:numel(files)
    KHIspatial(i, :) = round(-idx(i, :));
end

%% 7 - Plot spatial growth
% Subplot for spatial growth for l = 2 km
subplot_tight(3, 2, 2, [sx, sy])
hold on
yyaxis left
set(gca, 'YTickLabel', [])
ylim([0 220])
grid on
yyaxis right
for i = 10:12
    plot(timeKHI, KHIspatial(i, :), '-.', 'Color', colors{i-9}, 'linewidth', lw)
end
for i = 1:3
    plot(timeKHI, KHIspatial(i, :), '-', 'Color', colors{i}, 'linewidth', lw)
end
for i = 19:21
    plot(timeKHI, KHIspatial(i, :), '--', 'Color', colors{i-18}, 'linewidth', lw)
end
title('b) spatial growth for $\ell$ = 2 km', 'Interpreter', 'latex', 'fontsize', fz, 'FontWeight', 'normal')
ylim([0 220])
ylabel('Extent EW [km]', 'Color', 'k', 'fontsize', fz, 'Interpreter', 'latex')
set(gca, 'XTickLabel', [])
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
yaxisproperties= get(gca, 'YAxis');
yaxisproperties(2).TickLabelInterpreter = 'latex';
set(gca,'FontSize',fz)

% Subplot for spatial growth for l = 6 km
subplot_tight(3, 2, 4, [sx, sy])
hold on
yyaxis left
set(gca, 'YTickLabel', [])
ylim([0 220])
grid on
yyaxis right
for i = 13:15
    plot(timeKHI, KHIspatial(i, :), '-.', 'Color', colors{i-12}, 'linewidth', lw)
end
for i = 4:6
    plot(timeKHI, KHIspatial(i, :), '-', 'Color', colors{i-3}, 'linewidth', lw)
end
for i = 22:24
    plot(timeKHI, KHIspatial(i, :), '--', 'Color', colors{i-21}, 'linewidth', lw)
end
ylim([0 220])
grid on
title('d) spatial growth for $\ell$ = 6 km', 'Interpreter', 'latex', 'fontsize', fz, 'FontWeight', 'normal')
ylabel('Extent EW [km]', 'Color', 'k', 'fontsize', fz, 'Interpreter', 'latex')
set(gca, 'XTickLabel', [])
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
yaxisproperties= get(gca, 'YAxis');
yaxisproperties(2).TickLabelInterpreter = 'latex';
set(gca,'FontSize',fz)

% Subplot for spatial growth for l = 10 km
subplot_tight(3, 2, 6, [sx, sy])
hold on
yyaxis left
set(gca, 'YTickLabel', [])
ylim([0 220])
grid on
yyaxis right
for i = 16:18
    plot(timeKHI, KHIspatial(i, :), '-.', 'Color', colors{i-15}, 'linewidth', lw)
end
for i = 7:9
    plot(timeKHI, KHIspatial(i, :), '-', 'Color', colors{i-6}, 'linewidth', lw)
end
for i = 25:27
    plot(timeKHI, KHIspatial(i, :), '--', 'Color', colors{i-24}, 'linewidth', lw)
end
ylim([0 220])
grid on
title('f) spatial growth for $\ell$ = 10 km', 'Interpreter', 'latex', 'fontsize', fz, 'FontWeight', 'normal')
xlabel('Time [min]', 'fontsize', fz, 'Interpreter', 'latex')
ylabel('Extent EW [km]', 'Color', 'k', 'fontsize', fz, 'Interpreter', 'latex')
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
xaxisproperties= get(gca, 'XAxis');
xaxisproperties.TickLabelInterpreter = 'latex';
yaxisproperties= get(gca, 'YAxis');
yaxisproperties(2).TickLabelInterpreter = 'latex';
set(gca, 'FontSize', fz)
