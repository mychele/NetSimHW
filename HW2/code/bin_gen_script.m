
close all;
clc;

%% Implement the generation of a Binomial rv in the three ways we saw in
% class (CDF inversion, using a sequence of n Bernoulli variables,
% using geometric strings of zeros), and then compare the time
% it takes to produce a large number of iid variates

%% BIN(n, p)

experiments = 100000;
begin = 20;
step = 20;
limit = 10000;
time_inv = zeros(limit/step, 5);
time_ber = zeros(limit/step, 5);
time_geo = zeros(limit/step, 5);

p_vec = [0.1, 0.2, 0.3, 0.4, 0.5];
%p_vec = [10^-9, 10^-8, 10^-7, 10^-6, 10^-5];

for n = begin:step:limit
    for k = 1:5
         p = p_vec(k);
%         % CDF Inversion
%         rng('default');
%         
%         tic;
%         
%         X_inv = zeros(experiments, 1);
%         for j = 1:experiments
%             
%             U = rand();
%             c = p/(1-p);
%             pr = (1-p)^n;
%             if (pr == 0)
%                 return;
%             end
%             F = pr;
%             i = 0;
%             while(U >= F)
%                 pr = c*(n - i)*pr/(i + 1);
%                 F = F + pr;
%                 i = i + 1;
%             end
%             X_inv(j) = i;
%             
%         end
%         time_inv(floor(n/step), k) = toc;
%         
%         disp(strcat('Iteration with n=', num2str(n), ' probability =', num2str(p), ' time inv=', num2str(time_inv(floor(n/20), k))))
        
        % Series of Bernoulli
        
        rng('default');
        
        tic;
        
        X_ber = zeros(experiments, 1);
        for j = 1:experiments
            
            X = 0;
            u_vec = rand(n, 1);
            for i = 1:n
                %u = rand();
                if(u_vec(i) < p)
                    X = X + 1;
                end
            end
            X_ber(j) = X;
            
        end
        time_ber(n/step, k) = toc;
        
        disp(strcat('Iteration with n=', num2str(n), ' probability =', num2str(p), ' time ber=', num2str(time_ber(floor(n/20), k))))
        
        
        % Strings of zeros of length G(p)
        
        rng('default');
        
        tic;
        
        X_geo = zeros(experiments, 1);
        for j = 1:experiments
            %Generation of a geometric rv
            G = floor(log(rand())/log(1-p));
            i = G + 1; % G zeros and a 1
            X = 0;
            %if the string of zeros and the last 1 are longer less than n
            %then there's at least one success in the n trials
            while(i <= n)
                X = X + 1;
                G = floor(log(rand())/log(1-p));
                i = i + G + 1; % another string of G zeros and a 1
            end
            X_geo(j) = X;
        end
        
        time_geo(n/step, k) = toc;
        
        disp(strcat('Iteration with n=', num2str(n), ' probability =', num2str(p), ' time geo=', num2str(time_geo(floor(n/20), k))))
        
    end
end

% some plots
figure, plot(begin:step:limit, time_inv)
title('Time to generate 1000 RV with CDF INV')
legend('0.1', '0.2', '0.3', '0.4', '0.5')
figure, plot(begin:step:limit, time_ber)
title('Time to generate 1000 RV with Bernoullis')
legend('0.1', '0.2', '0.3', '0.4', '0.5')
figure, plot(begin:step:limit, time_geo)
title('Time to generate 1000 RV with geometric strings')
legend('0.1', '0.2', '0.3', '0.4', '0.5')

figure
for i = 1:5
    scatter(time_inv(:, i), time_geo(:, i), 10, 'filled', 'DisplayName', strcat('p = ', num2str(p_vec(i))))
    legend('-DynamicLegend')
    hold on
    ylabel('Geometric strings method')
    xlabel('CDF INV method')
    axis([0.024, 0.032, 0.009, 0.018])
end

figure
h(1) = subplot(1, 2, 1);
b1 = boxplot(h(1), [time_inv, time_geo], 'notch', 'on', 'labels', {'CDF inv', 'Geom'});
h(2) = subplot(1, 2, 2);
b2 = boxplot(h(2), [time_inv(:, 2), time_geo(:, 2)], 'notch', 'on', 'labels', {'CDF inv', 'Geom'});

figure
for i = 1:5
    scatter(time_inv(:, i), time_ber(:, i), 'DisplayName', strcat('p = ', num2str(p_vec(i))));
    legend('-DynamicLegend')
    hold on
    ylabel('Bernoulli trials method')
    xlabel('CDF INV method')
end

figure
for i = 1:5
    scatter(time_geo1(:, i), time_ber1(:, i),'DisplayName', strcat('p = ', num2str(p_vec(i))));
    legend('-DynamicLegend')
    hold on
    ylabel('Bernoulli trials method')
    xlabel('Geometric strings method')
end


figure, surf(time_ber, time_inv, time_geo)
ylabel('CDF INV method')
xlabel('Bernoulli trials method')
zlabel('Geometric strings method')

