% Initialise Constants
clear all; close all; clc; format compact
rng(sum([284675, 284720, 284718])); % !TODO (1)

constants = struct();
constants.M_CART = rand() * 0.1 + 2; % cart mass, kg
constants.M_PEND = 1; % pend mass, kg
constants.DT = 0.01; % sim interval, s
constants.G = 9.8;
constants.CTRL_STEP = 5; % controller period = DT*CTRL_STEP
constants.L_PEND = 1; % pend length, m
constants.KF_CART = 0.3; % cart friction coeff
constants.KF_PEND = 0.4; % pend friction coeff
constants.F_MAX = 50; % max force on cart, N
constants.PHI = (rand() * 2 + 30); % slope angle, deg
constants.T_SET = 1; % settling time, s
constants.T_TOTAL = 5;
constants.GAMMA_SET = 1; % settling angle, deg
constants.DT2 = constants.DT*constants.DT;
constants.S_PHI = sind(constants.PHI);
constants.C_PHI = cosd(constants.PHI);
constants.M_TOTAL = constants.M_CART + constants.M_PEND;
constants.L76 = -constants.L_PEND * 7.0 / 6.0;
constants.MML76 = constants.M_TOTAL * constants.L76;
constants.WEIGHT = constants.G * constants.S_PHI * constants.M_TOTAL;
constants.START_GAMMAS = [-10, -5, 5, 10]; % deg

% Universe of Discourses
constants.P_ERR_UNI = [-20,20]; 
constants.D_ERR_UNI = [-40,40]; 
constants.F_UNI = [-50,50]; 


% Parameters for Trapezium MFs
params = struct();


% p_err MFs
params.P_ERR_NB = [-20 -20 -16 -8];  
params.P_ERR_NS = [-16 -8 -8  0];  
params.P_ERR_ZO = [ -8  0   0  8];  
params.P_ERR_PS = [  0  8   8 16];  
params.P_ERR_PB = [  8 16  20 20];  
% !TODO (2)
params.D_ERR_NB = [-40 -40 -32 -16];  
params.D_ERR_NS = [-32 -16 -16   0];  
params.D_ERR_ZO = [-16   0   0  16];  
params.D_ERR_PS = [  0  16  16  32];  
params.D_ERR_PB = [ 16  32  40  40];  
% !TODO (3)
params.F_NB = [-50 -50 -40 -20];  
params.F_NS = [-40 -20 -20   0];  
params.F_ZO = [-20   0   0  20];  
params.F_PS = [  0  20  20  40];  
params.F_PB = [ 20  40  50  50]; 
% 


fis = initFis(constants, params); % call the function

% plot the MFs
fig1 = figure(1);
set(fig1, 'Visible', 'on')
tiledlayout(1, 3, 'TileSpacing', 'Tight');
fig1.Position = [20, 20, 1600, 240];

nexttile;
plotmf(fis, 'input', 1, 1000);
grid on;

nexttile;
plotmf(fis, 'input', 2, 1000);
grid on;

nexttile;
plotmf(fis, 'output', 1, 1000);
grid on;

% ================= run the simulation for all START_GAMMAS
results = [];
for i = 1:numel(constants.START_GAMMAS)
    r = struct();
    [r.time, r.gamma, r.gamma_vel, ...
        r.force, r.cart_pos, r.cart_vel, ...
        r.settling_time, r.last_p_err] ...
        = simFis(fis, constants, constants.START_GAMMAS(i));
    results = [results, r];
end

% ===================== plot
fig2 = figure(2);
set(fig2, 'Visible', 'on');
fig2.Position = [0, 0, 1200, 720];
tld = tiledlayout(numel(constants.START_GAMMAS), 3, TileSpacing="tight");
title(tld, "Mamdani FIS");
xlabel(tld, "Time (s)");
for i = 1:numel(constants.START_GAMMAS)
    r = results(i);

    nexttile
    plot(r.time, r.gamma)
    start_gamma = constants.START_GAMMAS(i);
    title(sprintf('Gamma (Initial=%.2f)', start_gamma));
    if (~isnan(r.settling_time))
        xline(r.settling_time, '--k');
        text(r.settling_time, sign(start_gamma) * constants.GAMMA_SET, sprintf('t_s = %.3fs', r.settling_time))
    end
    grid on
    xlim([-0.1, r.time(end)])
    if start_gamma > 0; ylim([-constants.GAMMA_SET, inf]);
    else; ylim([-inf, constants.GAMMA_SET]);
    end

    ylabel("$\gamma$ (deg/s)", Interpreter="latex");

    nexttile
    plot(r.time, r.gamma_vel)
    title('Gamma Velocity');
    grid on
    xlim([-0.1, r.time(end)])
    ylabel("$\dot{\gamma}$ (deg/s)", Interpreter="latex");

    nexttile
    plot(r.time, r.force)
    title('Cart Force');
    grid on
    xlim([-0.1, r.time(end)])
    ylabel("$F$ (N)", Interpreter="latex");
end


% Mamfis creation with name p1_mamdani, add input and output variables
function fis = initFis(constants, params)
   
    fis = mamfis('Name', 'p1_mamdani');

    fis = addInput (fis, constants.P_ERR_UNI, 'Name', 'p_err');
    fis = addInput (fis, constants.D_ERR_UNI, 'Name', 'd_err');
    fis = addOutput(fis, constants.F_UNI,     'Name', 'f');

    fis = addMF(fis, 'p_err', 'trapmf', params.P_ERR_NB, 'Name', 'p_err_nb');
    fis = addMF(fis, 'p_err', 'trapmf', params.P_ERR_NS, 'Name', 'p_err_ns');
    fis = addMF(fis, 'p_err', 'trapmf', params.P_ERR_ZO, 'Name', 'p_err_zo');
    fis = addMF(fis, 'p_err', 'trapmf', params.P_ERR_PS, 'Name', 'p_err_ps');
    fis = addMF(fis, 'p_err', 'trapmf', params.P_ERR_PB, 'Name', 'p_err_pb');

    fis = addMF(fis, 'd_err', 'trapmf', params.D_ERR_NB, 'Name', 'd_err_nb');
    fis = addMF(fis, 'd_err', 'trapmf', params.D_ERR_NS, 'Name', 'd_err_ns');
    fis = addMF(fis, 'd_err', 'trapmf', params.D_ERR_ZO, 'Name', 'd_err_zo');
    fis = addMF(fis, 'd_err', 'trapmf', params.D_ERR_PS, 'Name', 'd_err_ps');
    fis = addMF(fis, 'd_err', 'trapmf', params.D_ERR_PB, 'Name', 'd_err_pb');

    fis = addMF(fis, 'f', 'trapmf', params.F_NB, 'Name', 'f_nb');
    fis = addMF(fis, 'f', 'trapmf', params.F_NS, 'Name', 'f_ns');
    fis = addMF(fis, 'f', 'trapmf', params.F_ZO, 'Name', 'f_zo');
    fis = addMF(fis, 'f', 'trapmf', params.F_PS, 'Name', 'f_ps');
    fis = addMF(fis, 'f', 'trapmf', params.F_PB, 'Name', 'f_pb');

  
    % Rule table
    p_terms = ["p_err_nb","p_err_ns","p_err_zo","p_err_ps","p_err_pb"];
    d_terms = ["d_err_nb","d_err_ns","d_err_zo","d_err_ps","d_err_pb"];

    f_grid = [ ...
        "f_pb",  "f_pb",  "f_ps",  "f_ps",  "f_zo";   
        "f_pb",  "f_ps",  "f_ps",  "f_zo",  "f_ns";   
        "f_ps",  "f_ps",  "f_zo",  "f_ns",  "f_ns";   
        "f_ps",  "f_zo",  "f_ns",  "f_ns",  "f_nb";   
        "f_zo",  "f_ns",  "f_ns",  "f_nb",  "f_nb"    
    ];
    
    rules = strings(25,1);
    k = 0;
    for i = 1:5              
        for j = 1:5          
            k = k + 1;
            rules(k) = "p_err==" + p_terms(i) + ...
                       " & d_err==" + d_terms(j) + ...
                       " => f==" + f_grid(i,j);
        end
    end
    
    fis = addRule(fis, rules);

    % Defuzz settings
    fis.AndMethod = 'min';
    fis.OrMethod  = 'max';
    fis.ImplicationMethod = 'min';
    fis.AggregationMethod = 'max';
    fis.DefuzzificationMethod = 'centroid';
end


% Calculate the errors
function [p_err, d_err] = getErrors(gamma, gamma_vel)
    p_err = gamma;      % !TODO (1)
    d_err = gamma_vel;  % !TODO (2)
end


% Evaluate fis
% Extra things added in here
function f = runFis(fis, p_err, d_err, constants)
    % light input gains (tune if needed)
    Kg = 0.9; 
    Kv = 0.5;
    f_delta = evalfis(fis, [Kg*p_err, Kv*d_err]);

    % Cancel slope load: tmp_a subtracts WEIGHT, so we add it here
    f_bias = constants.WEIGHT;  % g*sin(phi)*M_total
    f = f_bias + f_delta;
end



% start_gamma is in degrees.
function [T, PS, PV, F, CS, CV, settling_time, last_p_err] = simFis(fis, constants, start_gamma)
T = 0:constants.DT:constants.T_TOTAL;
CS = nan(size(T));
CV = nan(size(T));
PS = nan(size(T)); % gamma
PV = nan(size(T));
F = nan(size(T));

f = 0;
theta = deg2rad(start_gamma - constants.PHI);
pv = 0;
cs = 0;
cv = 0;

settling_time = nan;
last_p_err = nan;

for i = 1:numel(T)
    C_THETA = cos(theta);
    S_THETA = sin(theta);

    % From euler lagrange formulation
    tmp_a = f - 0.5*pv*pv*S_THETA - constants.WEIGHT - cv*constants.KF_CART;
    tmp_b = -constants.G * (S_THETA*constants.C_PHI + C_THETA*constants.S_PHI) - pv*constants.KF_PEND;
    tmp_denom = constants.MML76 - 0.5*C_THETA*C_THETA;
    ca = (constants.L76*tmp_a + 0.5*C_THETA*tmp_b) / tmp_denom;
    pa = (-C_THETA*tmp_a + constants.M_TOTAL*tmp_b) / tmp_denom;

    % linear approximation
    theta = theta + pv*constants.DT + 0.5*pa*constants.DT2;
    ps = theta + deg2rad(constants.PHI);
    pv = pv + pa*constants.DT;
    cs = cs + cv*constants.DT + 0.5*ca*constants.DT2;
    cv = cv + ca*constants.DT;

    % controller
    if mod(i-1, constants.CTRL_STEP) == 0
        [p_err, d_err] = getErrors(rad2deg(ps), rad2deg(pv));
        p_err = p_err + randn()*1e-4; % corrupt with noise
        d_err = d_err + randn()*1e-4; % corrupt with noise

        if p_err < constants.P_ERR_UNI(1) || p_err > constants.P_ERR_UNI(2) || ...
            d_err < constants.D_ERR_UNI(1) || d_err > constants.D_ERR_UNI(2)
            last_p_err = p_err; 
            settling_time = nan; 
            fprintf("Re-tune: System is unstable and out of universe\n");
            break;
        end

        f = runFis(fis, p_err, d_err, constants);  % Extra added here


        % saturate force like real world system
        f = clip(f, -constants.F_MAX, constants.F_MAX);
    end
    CS(i) = cs;
    CV(i) = cv;
    PS(i) = ps;
    PV(i) = pv;
    F(i) = f;
end

PS = rad2deg(PS);
PV = rad2deg(PV);

% If all variables are within their universes (i.e. not too unstable),
% reevaluate steady_state and settling_time
if (isnan(last_p_err))
    last_p_err = -PS(end); % good enough to use the last value, especially since this will catch any mildly unstable systems.
    for i = numel(T):-1:1
        ps = PS(i);
        if (ps < -constants.GAMMA_SET || ps > constants.GAMMA_SET)
            if (i < numel(T))
                settling_time = T(i+1);
            end
            break
        end
    end
end
end


% helper: clamp value to [lo, hi], Extra added
function y = clip(x, lo, hi)
    y = min(max(x, lo), hi);
end


