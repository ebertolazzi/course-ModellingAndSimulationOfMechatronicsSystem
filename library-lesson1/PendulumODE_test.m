clc;
clear all;
close all;

%% Instantiate system object

% Pendulum parameters
m = 1.0;  % mass (kg)
l = 1.0;  % length (m)
g = 9.81; % gravity (m/s^2)

% Initial conditions
theta_0 = -1.0;
omega_0 = -1.0;
X_0     = [theta_0; omega_0];

ODE = PendulumODE(m, l, g, X_0);

%% Initialize the solver and set the ODE

solver1 = ExplicitEuler();
%solver2 = ImplicitEuler();
solver2 = Heun2();
%solver = DormandPrince54();
solver1.set_ode( ODE );
solver2.set_ode( ODE );

%% Integrate the system of ODE

% Set integration interval
d_t   = 0.05;
t_ini = 0.0;
t_end = 5.0;
T_vec = t_ini:d_t:t_end;
% T_vec = at which time the numerical solution is sampled
% X_0   = initial condition

[x1_out, t1_out] = solver1.solve( T_vec, X_0 );
[x2_out, t2_out] = solver2.solve( T_vec, X_0 );

% Calculate energy of the solution
Energy1 = ODE.H( x1_out );
Energy2 = ODE.H( x2_out );

%% Plot results

figure();
hold on; grid on; grid minor;
% title(title_str);
subplot(3,1,1);
xlabel('$t$ (s)');
ylabel('$\theta$ (rad)');
hold off
plot( t1_out, x1_out(1,:), 'LineWidth', 2 );
hold on
plot( t2_out, x2_out(1,:), 'LineWidth', 2 );

subplot(3,1,2);
xlabel('$t$ (s)');
ylabel('$\omega$ (rad/s)');
hold off;
plot( t1_out, x1_out(2,:), 'LineWidth', 2 );
hold on
plot( t2_out, x2_out(2,:), 'LineWidth', 2 );

subplot(3,1,3);
xlabel('$t$ (s)');
ylabel('$E$');
hold off
plot( t1_out, Energy1, 'LineWidth', 2 );
hold on
plot( t2_out, Energy2, 'LineWidth', 2 );
