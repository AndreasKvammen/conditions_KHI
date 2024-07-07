%%% This script visually compares simulations with and without aurora 

%% 1 - Define paths 
workpath = '/Users/akv020/Projects/KHI/source/Figure5';
saturationpath = '/Users/akv020/Projects/KHI/source/saturation';
datapath = '/Users/akv020/Projects/KHI/data/highres';

%% 2 - Load data
cd(datapath)
load('5Ne11_L06_V13.mat')
ne_noaur = nev;

load('5Ne11_L06_V13_aurora_lowflux.mat')
ne_lowflux = nev; 

load('5Ne11_L06_V13_aurora.mat')
ne_highflux = nev; 

%% 4 - Define interesting time periods
time_minutes = [10, 11, 12, 13, 14, 15];  % in minutes
times = (time_minutes * 60) / 10 + 1;  % Convert to indices (t = 1:1:181 for times 0:10:1800 seconds)

%% 5 Plot results
FIG = figure('units','centimeters','position',[0,0,36.0,39.0]);
sx = 0.045;
sy = 0.065;
fz = 18;
lw = 3;
colormap(inferno)
cmin = 10.6;
cmax = 11.9; 
alf = 'a':'z';

for i = 1:length(times)
    t = times(i);
    time_min = time_minutes(i);

    % No aurora
    subplot_tight(7, 3, (i-1)*3 + 1, [sx, sy])
    imagesc(nort, east, log10(squeeze(ne_noaur(:,:,t))))
    shading flat
    title([alf(1 + (i-1)*3), ') Q = 0, t = ', num2str(time_min), ' min'],'fontsize',fz,'interpreter','latex','FontWeight','normal')
    clim([cmin cmax])
    if i == 1
        ylabel('y [km]','fontsize',fz,'interpreter','latex')
        c = colorbar;
        c.Location = 'South';
        c.Ticks = [10.8 11.1 11.4 11.7];
        c.FontSize = fz;
        c.Label.String = 'Denisty [$m^{-3}$]';
        c.Label.Position = [11.25,-2.672727368094684,0];
        c.Label.Interpreter = 'latex';
        set(c,'TickLabelInterpreter','latex')
        yaxisproperties= get(gca, 'YAxis');
        yaxisproperties.TickLabelInterpreter = 'latex';   % tex for y-axis
    end
    ylabel('y [km]','fontsize',fz,'interpreter','latex')
    yaxisproperties= get(gca, 'YAxis');
    yaxisproperties.TickLabelInterpreter = 'latex';   % tex for y-axis
    if i > 5
        xlabel('x [km]','interpreter','latex');
        xaxisproperties= get(gca, 'XAxis');
        xaxisproperties.TickLabelInterpreter = 'latex'; % latex for x-axis
    else
        set(gca,'XTick',[])
    end

    % Low flux aurora
    subplot_tight(7, 3, (i-1)*3 + 2, [sx, sy])
    imagesc(nort, east, log10(squeeze(ne_lowflux(:,:,t))))
    shading flat
    title([alf(2 + (i-1)*3), ') Q = 0.2 mWm$^{-2}$, t = ', num2str(time_min), ' min'],'fontsize',fz,'interpreter','latex','FontWeight','normal')
    clim([cmin cmax])
    if i > 5
        xlabel('x [km]','interpreter','latex');
        xaxisproperties= get(gca, 'XAxis');
        xaxisproperties.TickLabelInterpreter = 'latex'; % latex for x-axis
    else
        set(gca,'XTick',[])
    end
    set(gca,'YTick',[])

    % High flux aurora
    subplot_tight(7, 3, (i-1)*3 + 3, [sx, sy])
    imagesc(nort, east, log10(squeeze(ne_highflux(:,:,t))))
    shading flat
    title([alf(3 + (i-1)*3), ') Q = 0.5 mWm$^{-2}$, t = ', num2str(time_min), ' min'],'fontsize',fz,'interpreter','latex','FontWeight','normal')
    clim([cmin cmax])
    if i > 5
        xlabel('x [km]','interpreter','latex');
        xaxisproperties= get(gca, 'XAxis');
        xaxisproperties.TickLabelInterpreter = 'latex'; % latex for x-axis
    else
        set(gca,'XTick',[])
    end
    set(gca,'YTick',[])
end

%% 6 - Calculate pertubation growth
cd(saturationpath)
colors = {[0.6350, 0.0780, 0.1840],[0.4660, 0.6740, 0.1880],[0, 0.4470, 0.7410]};
growth_noaur = pertubation_signal(ne_noaur);
growth_lowflux = pertubation_signal(ne_lowflux);
growth_highflux = pertubation_signal(ne_highflux);
subplot_tight(7,3,[19 20 21],[sx+0.0, sy+0.01])
yyaxis left
plot(linspace(0,30,181),growth_noaur,'Color',colors{3},'LineWidth',lw,'LineStyle','-')
hold on
plot(linspace(0,30,181),growth_lowflux,'Color',colors{3},'LineWidth',lw,'LineStyle','--')
plot(linspace(0,30,181),growth_highflux,'Color',colors{3},'LineWidth',lw,'LineStyle','-.')
ylabel('Perturbation','fontsize',fz,'interpreter','latex')
xlabel('Time [min]','fontsize',fz,'interpreter','latex')
xaxisproperties= get(gca, 'XAxis');
xaxisproperties.TickLabelInterpreter = 'latex'; % latex for x-axis
yaxisproperties= get(gca, 'YAxis');
yaxisproperties(1).TickLabelInterpreter = 'latex';   % tex for y-axis
grid on
set(gca,'ycolor',colors{3})

set(gca,'Ytick',[0.01 0.1 1])
set(gca,'YScale','log')
xaxisproperties= get(gca, 'XAxis');
xaxisproperties.TickLabelInterpreter = 'latex'; % latex for x-axis
yaxisproperties= get(gca, 'YAxis');
yaxisproperties(2).TickLabelInterpreter = 'latex';   % tex for y-axis
set(gca,'fontsize',fz)
xlim([0 30])
ylim([5e-3 3e0])

%% 7 - Calculate spatial growth
cd(workpath)
load('idx_noaurora.mat')
load('idx_lowflux.mat')
load('idx_highflux.mat')

spatial_noaur = -idx_noaurora;
spatial_lowflux = idx_lowflux;
spatial_highflux = idx_highflux;
yyaxis right
plot(linspace(0,30,181),spatial_noaur,'Color',colors{1},'LineWidth',lw,'LineStyle','-')
hold on
plot(linspace(0,30,181),spatial_lowflux,'Color',colors{1},'LineWidth',lw,'LineStyle','--')
plot(linspace(0,30,181),spatial_highflux,'Color',colors{1},'LineWidth',lw,'LineStyle','-.')
xlim([0 15])
ylim([-5 50])

ylabel('y extent [km]','fontsize',fz,'interpreter','latex')
xlabel('Time [min]','fontsize',fz,'interpreter','latex')
set(gca,'ycolor',colors{1})
grid on
set(gca,'Ytick',[0 25 50])
xaxisproperties= get(gca, 'XAxis');
xaxisproperties.TickLabelInterpreter = 'latex'; % latex for x-axis
yaxisproperties= get(gca, 'YAxis');
yaxisproperties(2).TickLabelInterpreter = 'latex';   % tex for y-axis
% h1 = plot(linspace(35,40,3),linspace(35,40,3),'Color','k','LineWidth',lw);
% h2 = plot(linspace(35,40,3),linspace(35,40,3),'Color','k','LineWidth',lw);
% h3 = plot(linspace(35,40,3),linspace(35,40,3),'Color','k','LineWidth',lw);
txt = 's)';
text(0.3,40,txt,'FontSize',fz,'interpreter','latex');
legend('0 mWm$^{-2}$','0.2 mWm$^{-2}$','0.5 mWm$^{-2}$','Position',[0.12    0.0719    0.1328    0.0631],'fontsize',fz,'interpreter','latex')
set(gca,'fontsize',fz)
