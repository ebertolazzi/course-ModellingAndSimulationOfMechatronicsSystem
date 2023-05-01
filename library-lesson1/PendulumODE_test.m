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

ODE = PendulumODE( m, l, g, X_0 );

%% Initialize the solver and set the ODE

explicit_solver          = { @ExplicitEuler, @ExplicitMidpoint, @Heun2, @Wray3, @Heun3, @Ralston2, @Ralston3, @Ralston4, @RK3, @RK4, @RK38, @SSPRK3 };
implicit_solver          = { @CrankNicolson, @GaussLegendre2, @GaussLegendre4, @GaussLegendre6, @ImplicitEuler, @ImplicitMidpoint, @LobattoIIIA2, @LobattoIIIA4, @LobattoIIIB2, @LobattoIIIB4, @LobattoIIIC2, @LobattoIIIC4, @LobattoIIICS2, @LobattoIIICS4, @LobattoIIID2, @LobattoIIID4, @RadauIA3, @RadauIA5, @RadauIIA3, @RadauIIA5, @SunGeng5 };
explicit_embedded_solver = { @BogackiShampine23, @CashKarp45, @DormandPrince54, @Fehlberg12, @Fehlberg45I, @Fehlberg45II, @Fehlberg78, @HeunEuler21, @Merson34, @Verner65, @Zonnenveld45 };
implicit_embedded_solver = { @GaussLegendre34, @GaussLegendre56, @LobattoIIIA12, @LobattoIIIA34, @LobattoIIIB12, @LobattoIIIB34, @LobattoIIIC12, @LobattoIIIC34 };

solver1 = GaussLegendre56();
%solver2 = explicit_solver{12}();
%solver2 = implicit_solver{21}();
%solver2 = explicit_embedded_solver{11}();
solver2 = implicit_embedded_solver{8}();

solver1.set_system( ODE );
solver2.set_system( ODE );

%% Integrate the system of ODE

% Set integration interval
d_t   = 0.05;
t_ini = 0.0;
t_end = 5.0;
T_vec = t_ini:d_t:t_end;
% T_vec = at which time the numerical solution is sampled
% X_0   = initial condition

fprintf('\n\nrun solver N.1\n');
solver1.info
[x1_out, ~, t1_out] = solver1.solve( T_vec, X_0 );

fprintf('\n\nrun solver N.2\n');
solver2.info
[x2_out, ~, t2_out] = solver2.solve( T_vec, X_0 );
% return x, x' and t

% Calculate energy of the solution
Energy1 = ODE.h( x1_out );
Energy2 = ODE.h( x2_out );

% extract results
theta1 = x1_out(1,:);
omega1 = x1_out(2,:);

theta2 = x2_out(1,:);
omega2 = x2_out(2,:);

%% Plot results

fmt1 = {'LineWidth', 3, 'Color', 'blue' };
fmt2 = {'LineWidth', 2, 'Color', 'red' };

figure();
subplot(3,1,1);
  hold off
  plot( t1_out, theta1, fmt1{:} );
  hold on
  plot( t2_out, theta2, fmt2{:} );
  hold on;
  grid on;
  grid minor;
  xlabel('$t$ (s)');
  ylabel('$\theta$ (rad)');

subplot(3,1,2);
  hold off;
  plot( t1_out, omega1, fmt1{:} );
  hold on
  plot( t2_out, omega2, fmt2{:} );
  grid on;
  grid minor;
  xlabel('$t$ (s)');
  ylabel('$\omega$ (rad/s)');

subplot(3,1,3);
  hold off
  plot( t1_out, Energy1, fmt1{:} );
  hold on
  plot( t2_out, Energy2, fmt2{:} );
  grid on;
  grid minor;
  xlabel('$t$ (s)');
  ylabel('$E$');
