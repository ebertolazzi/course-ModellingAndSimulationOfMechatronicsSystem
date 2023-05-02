%% Prepare worspace

clc;
clear all; %#ok<CLALL>
close all;

%% Instantiate system object

G   = 1.0; % Gravitational constant
m_1 = 1.0; % Body 1 mass
m_2 = 1.0; % Body 2 mass
m_3 = 1.0; % Body 3 mass

ODE = ThreeBodyProblem(G, m_1, m_2, m_3);

%% Initialize the solver and set the ODE

explicit_solver = {
  'ExplicitEuler',    ...
  ... % 'ExplicitMidpoint', ...
  ... % 'Heun2',            ...
  ... % 'Wray3',            ...
  ... % 'Heun3'             ...
  ... % 'Ralston2',         ...
  ... % 'Ralston3',         ...
  ... % 'Ralston4',         ...
  ... % 'RK3',              ...
  ... % 'RK4',              ...
  ... % 'RK38',             ...
  ... % 'SSPRK3',           ...
};

implicit_solver = {
  ... % 'CrankNicolson',    ...
  ... % 'GaussLegendre2',   ...
  ... % 'GaussLegendre4',   ...
  ... % 'GaussLegendre6',   ...
  ... % 'ImplicitEuler',    ...
  ... % 'ImplicitMidpoint', ...
  ... % 'LobattoIIIA2',     ...
  ... % 'LobattoIIIA4',     ...
  ... % 'LobattoIIIB2',     ...
  ... % 'LobattoIIIB4',     ...
  ... % 'LobattoIIIC2',     ...
  ... % 'LobattoIIIC4',     ...
  ... % 'LobattoIIICS2',    ...
  ... % 'LobattoIIICS4',    ...
  ... % 'LobattoIIID2',     ...
  ... % 'LobattoIIID4',     ...
  ... % 'RadauIA3',         ...
  ... % 'RadauIA5',         ...
  ... % 'RadauIIA3',        ...
  'RadauIIA5',        ...
  ... % 'SunGeng5',         ...
};

explicit_embedded_solver = {
  ... % 'BogackiShampine23', ...
  ... % 'CashKarp45',        ...
  ... % 'DormandPrince45',   ...
  ... % 'Fehlberg12',        ...
  ... % 'Fehlberg45I',       ...
  ... % 'Fehlberg45II',      ...
  ... % 'Fehlberg78',        ...
  ... % 'HeunEuler21',       ...
  ... % 'Merson45',          ...
  ... % 'Verner65',          ...
  ... % 'Zonnenveld45',      ...
};

implicit_embedded_solver = {
  ... % 'GaussLegendre34', ...
  ... % 'GaussLegendre56', ...
  ... % 'LobattoIIIA12',   ...
  ... % 'LobattoIIIA34',   ...
  ... % 'LobattoIIIB12',   ...
  ... % 'LobattoIIIB34',   ...
  ... % 'LobattoIIIC12',   ...
  ... % 'LobattoIIIC34',   ...
};

solver_name = [ ...
  explicit_solver, ...
  implicit_solver, ...
  explicit_embedded_solver, ...
  implicit_embedded_solver, ...
  ];

for i = 1:length(solver_name)
  eval(strcat(['solver', solver_name{i}, '=', solver_name{i}, '();']));
  eval(strcat(['solver', solver_name{i}, '.set_ode( ODE );']));
end

%% Integrate the system of ODE

% Set integration interval
d_t   = 0.005;
t_ini = 0.0;
t_end = 6.32591398*2;
T_vec = t_ini:d_t:t_end;

% Set initial conditions
infinity_solution = true;

if (infinity_solution == true)

  x_1 =  0.97000436;
  x_2 = -0.97000436;
  x_3 =  0.0;
  y_1 = -0.24308753;
  y_2 =  0.24308753;
  y_3 =  0.0;
  u_1 =  0.93240737/2;
  u_2 =  0.93240737/2;
  u_3 = -0.93240737;
  v_1 =  0.86473146/2;
  v_2 =  0.86473146/2;
  v_3 = -0.86473146;

else

  x_1 =  0.97000436;
  x_2 = -0.97000436;
  x_3 =  0.0;
  y_1 = -0.24308753;
  y_2 =  0.24308753;
  y_3 =  0.0;
  u_1 =  0.93240737/5;
  u_2 =  0.93240737/10;
  u_3 = -0.93240737;
  v_1 =  0.86473146/5;
  v_2 =  0.86473146/10;
  v_3 = -0.86473146;

end

X_ini = [x_1, x_2, x_3, y_1, y_2, y_3, u_1, u_2, u_3, v_1, v_2, v_3];

% Solve the system of ODEs for each solver
for i = 1:length(solver_name)
  eval(strcat(['solver', solver_name{i}, '.enable_verbose();']));
  eval(strcat(['solver', solver_name{i}, '.enable_projection();']));
  eval(strcat(['[X_', solver_name{i}, ', T_', solver_name{i}, '] =', ...
    'solver', solver_name{i}, '.solve( T_vec, X_ini );']));
end

%% Plot results

linewidth = 1.1;
title_str = 'The Three Body Problem';

figure();
hold on; grid on; grid minor;
title(title_str);
xlabel('$x$');
ylabel('$y$');
xlim([-1.5, 1.5]);
ylim([-1.5, 1.5]);
axis equal;
for i = 1:length(solver_name)
  eval(strcat(['plot( ', ...
    'X_', solver_name{i}, '(1,:), ', ...
    'X_', solver_name{i}, '(4,:), ', ...
    '''--'', ''LineWidth'', linewidth);']));
  eval(strcat(['plot( ', ...
    'X_', solver_name{i}, '(2,:), ', ...
    'X_', solver_name{i}, '(5,:), ', ...
    '''--'', ''LineWidth'', linewidth);']));
  eval(strcat(['plot( ', ...
    'X_', solver_name{i}, '(3,:), ', ...
    'X_', solver_name{i}, '(6,:), ', ...
    '''--'', ''LineWidth'', linewidth);']));
end
legend(solver_name, 'Location', 'southwest');
hold off;

%% Generate logo

generate_logo = false;

if (generate_logo == true)

  % Select solver
  solver_id = 1;

  % Set figure
  linewidth = 10.0;

  figure();
  hold on;
  xlim([-1.1, 1.1]);
  ylim([-1.1, 1.1]);
  axis equal;
  axis off;
  eval(strcat(['plot(', ...
    'X_', solver_name{solver_id}, '(3,:), ', ...
    'X_', solver_name{solver_id}, '(6,:), ', ...
    '''-'', ''LineWidth'', linewidth, ', ...
    '''Color'', ''#7E2F8E'');']));
  eval(strcat(['plot(', ...
    'X_', solver_name{solver_id}, '(3,end), ', ...
    'X_', solver_name{solver_id}, '(6,end), ', ...
    '''o'', ''MarkerSize'', 35, ''Color'', ''#7E2F8E'',' ...
    '''MarkerFaceColor'', ''#7E2F8E'');']));
  hold off;

end


%% Animate solution

animate_solution = true;

if (animate_solution == true)

  % Select solver
  solver_id = 1;

  % Set figure
  figure(); hold on;
  hold on; grid on; grid minor;
  title(title_str);
  xlabel('$x$');
  ylabel('$y$');
  xlim([-1.5, 1.5]);
  ylim([-1.5, 1.5]);
  axis equal;

  % Set colors
  color_map = [ ...
    0.0000, 0.4470, 0.7410; ...
    0.8500, 0.3250, 0.0980; ...
    0.9290, 0.6940, 0.1250];

  % Execution speed
  speed = 10;

  % Select trace length [0, 1]
  trace_id = 0.0;

  % Plot the initial trace of masses
  plt_t1 = plot(X_ini(1), X_ini(4), '--', 'Color', color_map(1,:), ...
    'LineWidth', linewidth);
  plt_t2 = plot(X_ini(2), X_ini(5), '--', 'Color', color_map(2,:), ...
    'LineWidth', linewidth);
  plt_t3 = plot(X_ini(3), X_ini(6), '--', 'Color', color_map(3,:), ...
    'LineWidth', linewidth);

  % Plot the initial point of masses
  plt_m1 = plot(X_ini(1), X_ini(4), 'o', 'MarkerSize', 10, ...
    'Color', color_map(1,:), 'MarkerFaceColor', color_map(1,:));
  plt_m2 = plot(X_ini(2), X_ini(5), 'o', 'MarkerSize', 10, ...
    'Color', color_map(2,:), 'MarkerFaceColor', color_map(2,:));
  plt_m3 = plot(X_ini(3), X_ini(6), 'o', 'MarkerSize', 10, ...
    'Color', color_map(3,:), 'MarkerFaceColor', color_map(3,:));

  % Animate solution with for loop
  for i = 1:ceil(length(eval(strcat(['T_', solver_name{solver_id}]))))

    tic;

    % Update masses
    plt_m1.XData = eval(strcat(['X_', solver_name{solver_id}, '(1,i)']));
    plt_m1.YData = eval(strcat(['X_', solver_name{solver_id}, '(4,i)']));
    plt_m2.XData = eval(strcat(['X_', solver_name{solver_id}, '(2,i)']));
    plt_m2.YData = eval(strcat(['X_', solver_name{solver_id}, '(5,i)']));
    plt_m3.XData = eval(strcat(['X_', solver_name{solver_id}, '(3,i)']));
    plt_m3.YData = eval(strcat(['X_', solver_name{solver_id}, '(6,i)']));

    % Update trace
    plt_t1.XData = eval(strcat(['X_', solver_name{solver_id}, '(1,1:i)']));
    plt_t1.YData = eval(strcat(['X_', solver_name{solver_id}, '(4,1:i)']));
    plt_t2.XData = eval(strcat(['X_', solver_name{solver_id}, '(2,1:i)']));
    plt_t2.YData = eval(strcat(['X_', solver_name{solver_id}, '(5,1:i)']));
    plt_t3.XData = eval(strcat(['X_', solver_name{solver_id}, '(3,1:i)']));
    plt_t3.YData = eval(strcat(['X_', solver_name{solver_id}, '(6,1:i)']));


    % Set figure limits
    xlim([-1.5, 1.5]);
    ylim([-1.5, 1.5]);
    drawnow;

    time = toc;
    pause(min(0.0, max(0.0, ...
      eval(strcat(['T_', solver_name{solver_id}, '(1,i)']))/speed - time)) ...
      );
  end
  legend(solver_name{solver_id}, 'Location', 'southwest');
  hold off;

end

%% That's All Folks!
