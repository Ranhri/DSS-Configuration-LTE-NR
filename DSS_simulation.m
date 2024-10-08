% DSS Simulation between LTE and 5G NR
clear all; clc;

% Configuration parameters
total_bandwidth = 100; % Total bandwidth available (MHz)
lte_percentage = 50;    % Percentage of bandwidth allocated to LTE initially
nr_percentage = 50;     % Percentage of bandwidth allocated to NR initially

% Time and traffic simulation
simulation_time = 100;  % Total time (seconds)
lte_traffic = randi([20 80], 1, simulation_time);  % LTE traffic demand (Mbps)
nr_traffic = randi([20 80], 1, simulation_time);   % NR traffic demand (Mbps)

% Bandwidth allocation
lte_bandwidth = zeros(1, simulation_time);
nr_bandwidth = zeros(1, simulation_time);

for t = 1:simulation_time
    % Dynamic spectrum sharing logic based on traffic demand
    total_traffic = lte_traffic(t) + nr_traffic(t);
    
    if total_traffic <= total_bandwidth
        % Allocate bandwidth based on traffic demand
        lte_bandwidth(t) = (lte_traffic(t) / total_traffic) * total_bandwidth;
        nr_bandwidth(t) = (nr_traffic(t) / total_traffic) * total_bandwidth;
    else
        % Max out bandwidth and allocate based on priority or fairness
        lte_bandwidth(t) = min(lte_traffic(t), (lte_percentage / 100) * total_bandwidth);
        nr_bandwidth(t) = min(nr_traffic(t), (nr_percentage / 100) * total_bandwidth);
    end
end

% Plot results
time = 1:simulation_time;
figure;
plot(time, lte_bandwidth, 'b', 'DisplayName', 'LTE Bandwidth');
hold on;
plot(time, nr_bandwidth, 'r', 'DisplayName', 'NR Bandwidth');
xlabel('Time (s)');
ylabel('Bandwidth (MHz)');
legend;
title('Dynamic Spectrum Sharing: LTE vs 5G NR');
grid on;

% Throughput analysis
lte_avg_bandwidth = mean(lte_bandwidth);
nr_avg_bandwidth = mean(nr_bandwidth);
fprintf('Average LTE Bandwidth: %.2f MHz\n', lte_avg_bandwidth);
fprintf('Average NR Bandwidth: %.2f MHz\n', nr_avg_bandwidth);
