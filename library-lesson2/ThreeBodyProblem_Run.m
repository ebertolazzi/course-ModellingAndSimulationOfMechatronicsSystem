%% Prepare worspace

clc;
clear all;
close all;

%% Instantiate system object

G   = 1.0; % Gravitational constant
m_1 = 1.0; % Body 1 mass
m_2 = 1.0; % Body 2 mass
m_3 = 1.0; % Body 3 mass

%% ODE describing threee body system
ODE = ThreeBodyProblem(G, m_1, m_2, m_3);

%% Initialize the solver and set the ODE


explicit_solver = {
  'ExplicitEuler',    ...
  'ExplicitMidpoint', ...
  'Heun2',            ...
  'Wray3',            ...
  'Heun3'             ...
  'Ralston2',         ...
  'Ralston3',         ...
  'Ralston4',         ...
  'RK3',              ...
  'RK4',              ...
  'RK38',             ...
  'SSPRK3',           ...
};

implicit_solver = {
  'CrankNicolson',    ...
  'GaussLegendre2',   ...
  'GaussLegendre4',   ...
  'GaussLegendre6',   ...
  'ImplicitEuler',    ...
  'ImplicitMidpoint', ...
  'LobattoIIIA2',     ...
  'LobattoIIIA4',     ...
  'LobattoIIIB2',     ...
  'LobattoIIIB4',     ...
  'LobattoIIIC2',     ...
  'LobattoIIIC4',     ...
  'LobattoIIICS2',    ...
  'LobattoIIICS4',    ...
  'LobattoIIID2',     ...
  'LobattoIIID4',     ...
  'RadauIA3',         ...
  'RadauIA5',         ...
  'RadauIIA3',        ...
  'RadauIIA5',        ...
  'SunGeng5',         ...
};

explicit_embedded_solver = {
  'BogackiShampine23', ...
  'CashKarp45',        ...
  'DormandPrince45',   ...
  'Fehlberg12',        ...
  'Fehlberg45I',       ...
  'Fehlberg45II',      ...
  'Fehlberg78',        ...
  'HeunEuler21',       ...
  'Merson45',          ...
  'Verner65',          ...
  'Zonnenveld45',      ...
};

implicit_embedded_solver = {
  'GaussLegendre34', ...
  'GaussLegendre56', ...
  'LobattoIIIA12',   ...
  'LobattoIIIA34',   ...
  'LobattoIIIB12',   ...
  'LobattoIIIB34',   ...
  'LobattoIIIC12',   ...
  'LobattoIIIC34',   ...
};

solver = Indigo(explicit_solver{1});
%solver = implicit_embedded_solver{2}();
solver.set_system( ODE );

%% Integrate the system of ODE

% Set integration interval
%d_t   = 0.005;
d_t   = 0.01;
t_ini = 0.0;
t_end = 6.32591398*2;
T_vec = t_ini:d_t:t_end;

% Set initial conditions
infinity_solution = true;

if (infinity_solution)
  x0 = [ 0.97000436,-0.97000436, 0.0 ];
  y0 = [-0.24308753, 0.24308753, 0.0 ];
  u0 = [ 0.93240737/2, 0.93240737/2, -0.93240737];
  v0 = [ 0.86473146/2, 0.86473146/2, -0.86473146];
else
  x0 = [ 0.97000436, -0.97000436, 0.0 ];
  y0 = [-0.24308753, 0.24308753, 0.0];
  u0 = [ 0.93240737/5, 0.93240737/10, -0.93240737];
  v0 = [ 0.86473146/5, 0.86473146/10,-0.86473146];
end

X_ini = [x0, y0, u0, v0];

% Solve the system of ODEs for each solver
solver.enable_projection();

fprintf('\n\nrun solver\n');
solver.info
[ sol, ~, t ] = solver.solve( T_vec, X_ini );

%% Plot results

linewidth = 2.5;
title_str = 'The Three Body Problem';

% extract solution
x = sol(1:3,:);
y = sol(4:6,:);
u = sol(7:9,:);
v = sol(10:12,:);

figure();
  hold on;
  grid on;
  grid minor;
  title(title_str);
  xlabel('$x$');
  ylabel('$y$');
  xlim([-1.5, 1.5]);
  ylim([-1.5, 1.5]);
  axis equal;
  plot( x(1,:), y(1,:), '-', 'LineWidth', linewidth);
  plot( x(2,:), y(2,:), '-', 'LineWidth', linewidth);
  plot( x(3,:), y(3,:), '-', 'LineWidth', linewidth);
  %legend(solver_name, 'Location', 'southwest');
  hold off;

%% Animate solution

animate_solution = true;

if (animate_solution)

  % Set figure
  figure('Position',[1 1 1200 800]);
  hold on;
  grid on;
  grid minor;
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
  speed = 2;

  % Select trace length [0, 1]
  trace_id = 0.0;

  % Plot the initial trace of masses
  plt_t1 = plot(x0(1), y0(1), '--', 'Color', color_map(1,:), 'LineWidth', linewidth);
  plt_t2 = plot(x0(2), y0(2), '--', 'Color', color_map(2,:), 'LineWidth', linewidth);
  plt_t3 = plot(x0(3), y0(3), '--', 'Color', color_map(3,:), 'LineWidth', linewidth);

  % Plot the initial point of masses
  plt_m1 = plot(x0(1), y0(1), 'o', 'MarkerSize', 10, 'Color', color_map(1,:), 'MarkerFaceColor', color_map(1,:));
  plt_m2 = plot(x0(2), y0(2), 'o', 'MarkerSize', 10, 'Color', color_map(2,:), 'MarkerFaceColor', color_map(2,:));
  plt_m3 = plot(x0(3), y0(3), 'o', 'MarkerSize', 10, 'Color', color_map(3,:), 'MarkerFaceColor', color_map(3,:));

  % Set figure limits
  xlim([-1.7, 1.7]);
  ylim([-1.7, 1.7]);

  % Animate solution with for loop
  fprintf('Animating solution...\n');
  Indigo_progress_bar('_start');

  x1 = x(1,:); y1 = y(1,:);
  x2 = x(2,:); y2 = y(2,:);
  x3 = x(3,:); y3 = y(3,:);

  frames = length(t);
  tic;
  for i = 1:frames

    % Update masses
    set( plt_m1, 'xdata', x1(i), 'ydata', y1(i) );
    set( plt_m2, 'xdata', x2(i), 'ydata', y2(i) );
    set( plt_m3, 'xdata', x3(i), 'ydata', y3(i) );

    % Update trace
    set( plt_t1, 'xdata', x1(1:i), 'ydata', y1(1:i) );
    set( plt_t2, 'xdata', x2(1:i), 'ydata', y2(1:i) );
    set( plt_t3, 'xdata', x3(1:i), 'ydata', y3(1:i) );

    drawnow limitrate;

    % Update progress bar
    Indigo_progress_bar(100*i/frames);

    time = toc;
    p = max(0.0, t(i)/speed - time);
    pause( p );
  end
  hold off;
  Indigo_progress_bar('Animation completed!');

end

%% That's All Folks!
