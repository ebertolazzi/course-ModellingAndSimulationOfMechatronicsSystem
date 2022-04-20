% Matlab code for the Course: Modelling and Simulation Mechatronics System (2020)
% by Enrico Bertolazzi and Francesco Biral
% Dipartimento di Ingegneria Industriale
% Università degli Studi di Trento
% email: enrico.bertolazzi@unitn.it

%% Initialize by cleaning memory and widows
clear all;
close all;
clc;

%% Initialize parameters of the model and instantiate model class
m1    = 1.5;
m2    = 1.5;
iz1   = 1.1;
iz2   = 1.1;
R     = 0.1;
H     = 0.05;
L     = 0.1;
alpha = -pi/4;
X30   = 0.2;
k     = 7.5;
c     = 1.0;
T     = -0.05;
ode   = ScotchYoke( m1, m2, iz1, iz2, R, H, L, alpha, X30, k, c , T);

%% Initialize the solver class
solver_1 = ExplicitEuler();
solver_2 = ImplicitEuler();
solver_3 = RK4();

LEGEND = {'ExplicitEuler', 'ImplicitEuler','RK4'};

solver_1.setODE(ode);
solver_2.setODE(ode);
solver_3.setODE(ode);

%% Select the range and the sampling point for the numerical solution
Tmax = 15.0;
h    = 0.1;
tt   = 0:h:Tmax;

%% Set consistent initial conditions
angle     = pi/4;
speed     = 0.0;

x2_0 = (cos(angle)*R*cos(alpha) - sin(alpha)*(-sin(angle)*R + H))/cos(alpha);
s_0 = (sin(angle)*R - H)/cos(alpha);
theta_0 = angle;
x2_dot0 = R*speed*(sin(alpha)*cos(angle) - cos(alpha)*sin(angle))/cos(alpha);
s_dot0 = speed*cos(angle)*R/cos(alpha);
theta_dot0 = speed;
lambda_10 = -cos(alpha)*R*m2*(cos(angle)*iz1*speed^2 + sin(angle)*T)/((cos(angle)^2*R^2*m2 - R^2*m2 - iz1)*cos(alpha) + sin(alpha)*cos(angle)*sin(angle)*R^2*m2);
lambda_20 = -sin(alpha)*R*m2*(cos(angle)*iz1*speed^2 + sin(angle)*T)/((cos(angle)^2*R^2*m2 - R^2*m2 - iz1)*cos(alpha) + sin(alpha)*cos(angle)*sin(angle)*R^2*m2);
ini        = [ x2_0; s_0; theta_0; ...
               x2_dot0; s_dot0; theta_dot0; ...
               lambda_10; lambda_20 ];

%% Compute numerical solution
sol_1 = solver_1.advance( tt, ini );
sol_2 = solver_2.advance( tt, ini );
sol_3 = solver_3.advance( tt, ini );

%% Extract solution
x2_1    = sol_1(1,:);
s_1     = sol_1(2,:);
theta_1 = sol_1(3,:);

x2_2    = sol_2(1,:);
s_2     = sol_2(2,:);
theta_2 = sol_2(3,:);

x2_3    = sol_3(1,:);
s_3     = sol_3(2,:);
theta_3 = sol_3(3,:);

%% Plot the solution
h = figure();
x0 = 0;
y0 = 0;
close all;
hold on;
xc1 = R*cos(0:pi/100:2*pi);
yc1 = R*sin(0:pi/100:2*pi);
axis_lim = R*1.5;
xc2 = -axis_lim:0.05:axis_lim;
yc2 = 0.0*(-axis_lim:0.05:axis_lim);
axis equal
plot( x2_1, H*ones(length(x2_1)), '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( x2_2, H*ones(length(x2_2)), '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( x2_3, H*ones(length(x2_3)), '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( [X30, X30], [-R, R], '-k', 'MarkerSize', 6, 'Linewidth', 4 );
plot( xc1, yc1, '-r', 'Linewidth', 1 );
plot( xc2, yc2, '-r', 'Linewidth', 1 );
plot( yc2, xc2, '-r', 'Linewidth', 1 );
title('x,y');

h = figure();
plot( tt, x2_1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, x2_2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, x2_3, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(LEGEND);
title('x_2');

h = figure();
plot( tt, theta_1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, theta_2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, theta_3, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(LEGEND);
title('theta');

%% Make animation of the solution
if true
  figure('Position', [1 1 1200 400]);
  for k=1:5:length(tt)
    subplot(1,3,1);
    ode.plot( tt(k), sol_1(:,k));
    title(LEGEND{1});
    subplot(1,3,2);
    ode.plot( tt(k), sol_2(:,k));
    title(LEGEND{2});
    subplot(1,3,3);
    ode.plot( tt(k), sol_3(:,k));
    title(LEGEND{3});
    drawnow limitrate;
    pause(0.01);
  end
end

%% Compute solutions activating projection
sol_1 = solver_1.advance( tt, ini, true, true );
sol_2 = solver_2.advance( tt, ini, true, true );
sol_3 = solver_3.advance( tt, ini, true, true );

%% Extract computed solution
x2_1    = sol_1(1,:);
s_1     = sol_1(2,:);
theta_1 = sol_1(3,:);

x2_2    = sol_2(1,:);
s_2     = sol_2(2,:);
theta_2 = sol_2(3,:);

x2_3    = sol_3(1,:);
s_3     = sol_3(2,:);
theta_3 = sol_3(3,:);

%% Plot the solution
h = figure();
x0 = 0;
y0 = 0;
close all;
hold on;
xc1 = R*cos(0:pi/100:2*pi);
yc1 = R*sin(0:pi/100:2*pi);
axis_lim = R*1.5;
xc2 = -axis_lim:0.05:axis_lim;
yc2 = 0.0*(-axis_lim:0.05:axis_lim);
axis equal
plot( x2_1, H*ones(length(x2_1)), '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( x2_2, H*ones(length(x2_2)), '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( x2_3, H*ones(length(x2_3)), '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( [X30, X30], [-R, R], '-k', 'MarkerSize', 6, 'Linewidth', 4 );
plot( xc1, yc1, '-r', 'Linewidth', 1 );
plot( xc2, yc2, '-r', 'Linewidth', 1 );
plot( yc2, xc2, '-r', 'Linewidth', 1 );
title('x,y');

h = figure();
plot( tt, x2_1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, x2_2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, x2_3, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(LEGEND);
title('x_2');

h = figure();
plot( tt, theta_1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, theta_2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, theta_3, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(LEGEND);
title('theta');

%% Make animation of the solution
if true
  figure('Position', [1 1 1200 400]);
  for k=1:5:length(tt)
    subplot(1,3,1);
    ode.plot( tt(k), sol_1(:,k));
    title(LEGEND{1});
    subplot(1,3,2);
    ode.plot( tt(k), sol_2(:,k));
    title(LEGEND{2});
    subplot(1,3,3);
    ode.plot( tt(k), sol_3(:,k));
    title(LEGEND{3});
    drawnow limitrate;
    pause(0.01);
  end
end
