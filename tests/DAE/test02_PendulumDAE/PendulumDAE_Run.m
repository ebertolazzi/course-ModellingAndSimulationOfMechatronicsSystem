%% Prepare worspace

clc;
clear all; %#ok<CLALL>
close all;

%% Instantiate system object

% Pendulum parameters
m = 1.0;  % mass (kg)
l = 1.0;  % length (m)
g = 9.81; % gravity (m/s^2)

% Initial conditions
theta_0  = -1.0-pi/2;
omega_0  = -1.0;
x_0      = l*cos(theta_0);
y_0      = l*sin(theta_0);
u_0      = -omega_0*sin(theta_0);
v_0      = omega_0*cos(theta_0);
lambda_0 = (u_0^2+v_0^2-y_0*g)/(x_0^2+y_0^2);
X_0      = [x_0; y_0; u_0; v_0; lambda_0];

ODE = PendulumDAE(m, l, g, X_0);

%% Initialize the solver and set the ODE

explicit_solver = {
  ... % 'ExplicitEuler',    ...
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
  'RadauIIA3',        ...
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
  eval(strcat(['solver', solver_name{i}, '.set_ode(ODE);']));
end

%% Integrate the system of ODE

% Set integration interval
d_t   = 0.05;
t_ini = 0.0;
t_end = 5.0;
T_vec = t_ini:d_t:t_end;

% Solve the system of ODEs for each solver
for i = 1:length(solver_name)

  % Solve the system of ODEs
  eval(strcat(['[X_', solver_name{i}, ', T_', solver_name{i}, '] =', ...
    'solver', solver_name{i}, '.solve( T_vec, X_0 );']));

  % Calculate energy of the solution
  eval(strcat(['H_' solver_name{i}, ' = ODE.H( X_', solver_name{i}, ', T_', solver_name{i}, ' );']));

end

%% Plot results

linewidth = 1.1; %#ok<NASGU>
title_str = 'Test 1 -- Pendulum ODE (Linear)'; %#ok<NASGU>

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$x$ (m)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(1,:), ''LineWidth'', linewidth );']));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$y$ (m)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(2,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$u$ (m/s)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(3,:), ''LineWidth'', linewidth );']));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$v$ (m/s)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(4,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$\lambda$ (--)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(5,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$h_0$ (m)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', sqrt(X_', solver_name{i}, '(1,:).^2 + X_', solver_name{i}, '(2,:).^2), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$h_1$ (m$^2$/s)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(1,:).*X_', solver_name{i}, '(3,:) + X_', solver_name{i}, '(2,:).*X_', solver_name{i}, '(4,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$\theta$ (rad)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', atan2(X_', solver_name{i}, '(2,:), X_', solver_name{i}, '(1,:)), ''LineWidth'', linewidth );']));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$E$ (J)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', H_', solver_name{i}, '(1,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

%% Integrate the system of ODE (using projection)

% Solve the system of ODEs for each solver
for i = 1:length(solver_name)

  % Solve the system of ODEs
  eval(strcat(['[X_', solver_name{i}, ', T_', solver_name{i}, '] =', ...
    'solver', solver_name{i}, '.solve( T_vec, X_0 );']));

  % Calculate energy of the solution
  eval(strcat(['H_' solver_name{i}, ' = ODE.H( X_', solver_name{i}, ', T_', solver_name{i}, ' );']));

end

%% Plot results

linewidth = 1.1;
title_str = 'Test 1 -- Pendulum ODE (Linear)';

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$x$ (m)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(1,:), ''LineWidth'', linewidth );']));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$y$ (m)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(2,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$u$ (m/s)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(3,:), ''LineWidth'', linewidth );']));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$v$ (m/s)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(4,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$\theta$ (rad)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', atan2(X_', solver_name{i}, '(2,:), X_', solver_name{i}, '(1,:)), ''LineWidth'', linewidth );']));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$\lambda$ (--)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(5,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$h_0$ (m)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', sqrt(X_', solver_name{i}, '(1,:).^2 + X_', solver_name{i}, '(2,:).^2), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$h_1$ (m$^2$/s)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', X_', solver_name{i}, '(1,:).*X_', solver_name{i}, '(3,:) + X_', solver_name{i}, '(2,:).*X_', solver_name{i}, '(4,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

figure();
hold on; grid on; grid minor;
% title(title_str);
xlabel('$t$ (s)');
ylabel('$E$ (J)');
for i = 1:length(solver_name)
  eval(strcat(['plot( T_', solver_name{i}, ', H_', solver_name{i}, '(1,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'northwest');
hold off;

%% That's All Folks!
