%% Prepare worspace

clc;
clear all; %#ok<CLALL>
close all;

% Plot settings
set(0,     'DefaultFigurePosition', [5000, 5000, 560, 420]);
set(0,     'DefaultFigureWindowStyle',        'normal');
set(0,     'defaultTextInterpreter',          'latex' );
set(groot, 'defaultAxesTickLabelInterpreter', 'latex' );
set(groot, 'defaulttextinterpreter',          'latex' );
set(groot, 'defaultLegendInterpreter',        'latex' );
set(0,     'defaultAxesFontSize',             18      );

%% Instantiate system object

% parameters
g = 9.81;

% Initial conditions
theta_0  = 0.01;
omega_0  = 0;
x1      = cos(theta_0);
y1      = sin(theta_0);
x2      = x1 - cos(theta_0);
u1      = -sin(theta_0)*omega_0;
v1      = cos(theta_0)*omega_0;
u2      = u1 + sin(theta_0)*omega_0;

lambda1 = (2*x2^2*y1*g - 2*x2^2*u1^2 - 2*x2^2*v1^2 - 3*x2*y1*x1*g + 3*x2*u1^2*x1 + 2*x2*u1*u2*x1 + 3*x2*v1^2*x1 - x2*u2^2*x1 - 2*y1^2*u1*u2 + y1^2*u2^2 + y1*x1^2*g - u1^2*x1^2 - 2*u1*u2*x1^2 - v1^2*x1^2 + u2^2*x1^2)/(2*(y1^2*x1^2 - 2*y1^2*x1*x2 + 2*y1^2*x2^2 + x1^4 - 2*x1^3*x2 + x1^2*x2^2));
lambda2 = (x2*y1*x1*g - x2*u1^2*x1 - x2*v1^2*x1 + 2*y1^2*u1*u2 - y1^2*u2^2 + 2*u1*u2*x1^2 - u2^2*x1^2)/(2*(y1^2*x1^2 - 2*y1^2*x1*x2 + 2*y1^2*x2^2 + x1^4 - 2*x1^3*x2 + x1^2*x2^2));

X_0  = [x1; y1; x2; u1; v1; u2; lambda1; lambda2];

ODE = Mechanism();

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

solver_name = { ...
  implicit_solver{4}, ...
  implicit_embedded_solver{2}, ...
};

solver = cell(length(solver_name),1);
for k = 1:length(solver_name)
  solver{k} = IndigoSolver(solver_name{k});
  solver{k}.set_system( ODE );
end

%% Integrate the system of ODE

% Set integration interval
d_t   = 0.01;
t_ini = 0.0;
t_end = 5.0;
T_vec = t_ini:d_t:t_end;

X = {};
T = {};
H = {};

% Solve the system of ODEs for each solver
for i = 1:length(solver_name)

  % Solve the system of ODEs
  solver{i}.disable_projection();
  [X{i},~, T{i}] = solver{i}.solve( T_vec, X_0 );

  % Calculate contraints violations
  H{i} = ODE.h( X{i}, [], T{i} );

end

%% Plot results

linewidth = 1.1;
title_str = 'Test 1 -- Pendulum ODE'; %#ok<NASGU>

figure();
  hold on;
  grid on;
  grid minor;
  % title(title_str);
  xlabel('$t$ (s)');
  ylabel('position x,y');
  for i = 1:length(solver_name)
    t  = T{i};
    x1 = X{i}(1,:);
    y1 = X{i}(2,:);
    x2 = X{i}(3,:);
    y2 = X{i}(4,:);
    plot( t, x1, t, y1, t, x2, t, y2, 'LineWidth', linewidth );
  end
  legend(solver_name, 'Location', 'northwest');
  hold off;

figure();
  hold on;
  grid on;
  grid minor;
  % title(title_str);
  xlabel('$t$ (s)');
  ylabel('$H$ (/)');
  for i = 1:length(solver_name)
    t  = T{i};
    h1 = H{i}(1,:);
    h2 = H{i}(2,:);
    h3 = H{i}(3,:);
    h4 = H{i}(4,:);
    h5 = H{i}(5,:);
    h6 = H{i}(6,:);
    plot( t, h1, t, h2,'LineWidth', linewidth );
  end
  legend(solver_name, 'Location', 'northwest');
  hold off;

%% Integrate the system of ODE (using projection)

X = {};
T = {};
H = {};

% Solve the system of ODEs for each solver
for i = 1:length(solver_name)

  % Solve the system of ODEs
  solver{i}.enable_projection();
  [X{i},~,T{i}] = solver{i}.solve( T_vec, X_0 );

  % Calculate energy of the solution
  H{i} = ODE.h( X{i}, [], T{i} );
end

%% Plot results

linewidth = 1.1;
title_str = 'Test 1 -- Pendulum ODE';

figure();
  hold on;
  grid on;
  grid minor;
  % title(title_str);
  xlabel('$t$ (s)');
  ylabel('$\theta$ (rad)');
  for i = 1:length(solver_name)
    plot( T{i}, X{i}(1,:), 'LineWidth', linewidth );
  end
  legend(solver_name, 'Location', 'northwest');
  hold off;

figure();
  hold on;
  grid on;
  grid minor;
  % title(title_str);
  xlabel('$t$ (s)');
  ylabel('$\omega$ (rad/s)');
  for i = 1:length(solver_name)
    plot( T{i}, X{i}(2,:), 'LineWidth', linewidth );
  end
  legend(solver_name, 'Location', 'northwest');
  hold off;

figure();
  hold on;
  grid on;
  grid minor;
  % title(title_str);
  xlabel('$t$ (s)');
  ylabel('$E$ (J)');
  for i = 1:length(solver_name)
    plot( T{i}, X{i}(1,:).^2+X{i}(2,:).^2, 'LineWidth', linewidth );
  end
  legend(solver_name, 'Location', 'northwest');
  hold off;

%% That's All Folks!
