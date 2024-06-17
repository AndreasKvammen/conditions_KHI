function [saturation_threshold, threshold_crossing_time, param, fitted_signal, signal] = fitSigmoidAndFindSaturation(time, signal_input,plt)
    % Sigmoid function definition
    sigmoid = @(b,x) b(1) ./ (1 + exp(-b(2)*(x-b(3))));
    
    % Determine a rough estimate of the saturation point
    % For example, you might use a heuristic such as the point where the 
    % signal reaches a certain percentage of the final value in the dataset
    signal_log = log10(signal_input);
    signal = signal_log - min(signal_log);
    final_value = max(signal);
    saturation_estimate_idx = find(signal >= 0.9 * final_value, 1, 'first');
    
    % If no such point is found (signal never reaches 90% of the final value),
    % use the maximum signal as the saturation point
    if isempty(saturation_estimate_idx)
        saturation_estimate_idx = length(signal);
    end
    
    % Use the data up to the estimated saturation point for fitting
    time_fit = time(1:end);
    signal_fit = signal(1:end);
    
    % Initial guess for the parameters [a, b, c]
    initial_guess = [final_value, 0.1, 100];
    
    % Set the bounds for the parameters
    lower_bounds = [0, 0, 0];
    upper_bounds = [final_value*10, 1, 2*max(time_fit)];
    
    % Fit sigmoid function to the pre-saturation data using lsqcurvefit
    options = optimset('Display','off');
    [param, ~] = lsqcurvefit(sigmoid, initial_guess, time_fit, signal_fit, lower_bounds, upper_bounds, options);
    
    % Use the optimized parameters to plot the fit
    fitted_signal = sigmoid(param, time);
    
    % Find the saturation threshold which is the parameter 'a'
    saturation_threshold = param(1);
    
    % Find the first time where the signal exceeds the saturation threshold
    threshold_crossing_time = time(find(signal >= 0.9*saturation_threshold, 1, 'first'));

    if plt
        if ~isempty(threshold_crossing_time)
            % Plotting
            figure;
            hold on;
            scatter(time, signal, 'filled'); % Plot the original signal data
            plot(time, fitted_signal, 'r', 'LineWidth', 2); % Plot the fitted curve
            yline(saturation_threshold, '-b','LineWidth', 2); % Horizontal line for saturation threshold
            xline(threshold_crossing_time, '--k','LineWidth', 2); % Vertical line at threshold crossing
            xline(param(end), '--k','LineWidth', 2); % Vertical line at threshold crossing
            yline(0.9*saturation_threshold, '--k','LineWidth', 2); % Vertical line at threshold crossing

            xlabel('Time (s)');
            ylabel('Signal Strength');
            title('Sigmoid Fit to KHI Perturbation Strength');
            legend('Data', 'Sigmoid Fit', 'Saturation','Saturation Threshold', 'Threshold Crossing', 'Location', 'Best');
            hold off;
        end
    end

    fitted_signal = fitted_signal + min(signal_log);
end
