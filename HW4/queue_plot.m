%% Ex. 1, case a

load('degg1.mat')

% mean_dl_gg = mean(delay_gg, 2);
% mean_rho_gg = mean(rho_est_gg, 2);
% ci_dl_gg = 1.96*std(delay_gg, 0, 2)/sqrt(size(delay_gg, 2));
% ci_rho_gg = 1.96*std(rho_est_gg, 0, 2)/sqrt(size(delay_gg, 2));

load('../HW3/code/queueB.mat') % to make it as in the previous homework

figure, errorbar(rho_vec_gg(2:end), mean_dl_gg(2:end), ci_dl_gg(2:end)), hold on,
errorbar(rho_vec_gg(2:end), m_delay_geo(2:end), std_delay_geo(2:end))
grid on, title('Case a'), xlabel('\rho'),
ylabel('mean total delay in time units'),
legend('Simulated results', 'Results from slotted queue simulation of previous HW')
xlim([0.48, 0.92])

%% Ex. 1, case b
clear
load('demg1.mat')

% mean_dl = mean(delay_mg, 2);
% mean_rho = mean(rho_est_mg, 2);
% ci_dl = 1.96*std(delay_mg, 0, 2)/sqrt(size(delay_mg, 2));
% ci_rho = 1.96*std(rho_est_mg, 0, 2)/sqrt(size(delay_mg, 2));

% Compute theoretical results
m_y = 1.5;
s_y_2 = 0.25;
b = 0.5;
for i = 1:length(rho_vec_mg)
    lambda_y = rho_vec_mg(i)/m_y; % in seconds
    theo_dl(i) = m_y/2 + (m_y + lambda_y*s_y_2)/(2*(1-lambda_y*m_y));
end

figure, errorbar(rho_vec_mg(1:end-1), mean_dl(1:end-1), ci_dl(1:end-1)), hold on,
plot(rho_vec_mg(1:end-1), theo_dl(1:end-1))
grid on, title('Case b'), xlabel('\rho'),
ylabel('mean total delay in time units'),
legend('Simulated results', 'Theoretical results for MG1')

figure, errorbar(rho_vec_mg, mean_rho, ci_rho), grid on, title('Case b'), xlabel('\rho'),
ylabel('Estimated \rho')

%% Ex. 1, case MM1
clear
load('demm1.mat')

% mean_dl = mean(delay_mm, 2);
% mean_rho = mean(rho_est_mm, 2);
% ci_dl = 1.96*std(delay_mm, 0, 2)/sqrt(size(delay_mm, 2));
% ci_rho = 1.96*std(rho_est_mm, 0, 2)/sqrt(size(delay_mm, 2));

% Compute theoretical results. Let \lambda = 1, then rho = 1/mu, m_s =
% 1/(mu(1 - lambda/mu) = 1/(1-rho)
theo_dl_mm1 = 1./(1-rho_vec_mm);

figure, errorbar(rho_vec_mm(1:end-1), mean_dl(1:end-1), ci_dl(1:end-1)), hold on,
plot(rho_vec_mm(1:end-1), theo_dl_mm1(1:end-1))
grid on, title('Case b'), xlabel('\rho'),
ylabel('mean total delay in time units'),
legend('Simulated results', 'Theoretical results for MM1')

figure, errorbar(rho_vec_mm, mean_rho, ci_rho), grid on, title('Case b'), xlabel('\rho'),
ylabel('Estimated \rho')


