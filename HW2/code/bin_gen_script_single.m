n = 10^9;
p = 0.000001;

%% CDF Inversion
% rng('default');
% 
% tic;
% 
% X_inv = zeros(experiments, 1);
% c = p/(1-p);
% 
% for j = 1:experiments
%     
%     U = rand();
%     pr = (1-p)^n;
%     F = pr;
%     i = 0;
%     while(U >= F)
%         pr = c*(n - i)*pr/(i + 1);
%         F = F + pr;
%         i = i + 1;
%     end
%     X_inv(j) = i;
%     
% end
% time_inv = toc;
% 
% disp(strcat('Iteration with n=', num2str(n), ' probability =', num2str(p), ' time inv=', num2str(time_inv)))

%% Series of Bernoulli

% rng('default');
% 
% tic;
% 
% X_ber = zeros(experiments, 1);
% for j = 1:experiments
%     
%     X = 0;
%     for i = 1:n
%         u = rand();
%         if(u < p)
%             X = X + 1;
%         end
%     end
%     X_ber(j) = X;
%     
% end
% time_ber = toc;
% 
% disp(strcat('Iteration with n=', num2str(n), ' probability =', num2str(p), ' time ber=', num2str(time_ber)))


%% Strings of zeros of length G(p)

rng('default');

tic;

X_geo = zeros(experiments, 1);
for j = 1:experiments
    % Generation of a geometric rv
    G = floor(log(rand())/log(1-p));
    i = G + 1; % G zeros and a 1
    X = 0;
    % if the string of zeros and the last 1 are longer less than n
    % then there's at least one success in the n trials
    while(i <= n)
        X = X + 1;
        G = floor(log(rand())/log(1-p));
        i = i + G + 1; % another string of G zeros and a 1
    end
    X_geo(j) = X;
end

time_geo= toc;

disp(strcat('Iteration with n=', num2str(n), ' probability =', num2str(p), ' time geo=', num2str(time_geo)))

