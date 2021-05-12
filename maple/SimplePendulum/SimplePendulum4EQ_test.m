%
% Matlab code for the Course:
%
%     Modelling and Simulation of Mechatronics System
%
% by
% Enrico Bertolazzi and Francesco Biral
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
%

close all;
%set(0,'DefaultFigureWindowStyle','docked');

% load the Pendulum model in the variable ode
mass    = 1;
ell     = 2;
gravity = 9.81;
ode     = SimplePendulum4EQ( mass, ell, gravity );

% initialize solver
solver_1 = Heun();
solver_2 = Heun3();

NAMES = {'Heun', 'Heun3'};

solver_1.setODE(ode);
solver_2.setODE(ode);

Tmax = 20;
h    = 0.1;
tt   = 0:h:Tmax;
% setup initial condition
theta0 = pi/3;
omega0 = 0;
x0     = ell*sin(theta0);
y0     = -ell*cos(theta0);
u0     = 0;
v0     = 0;

ini = [x0;y0;u0;v0];
fprintf('advance with ODE\n');
sol_1 = solver_1.advance( tt, ini );
sol_2 = solver_2.advance( tt1, ini );
fprintf('done\n');

x_1 = sol_1(1,:);
y_1 = sol_1(2,:);

x_2 = sol_2(1,:);
y_2 = sol_2(2,:);

h = figure();
set(h,'WindowStyle','docked');
xx = ell*cos(0:pi/100:2*pi);
yy = ell*sin(0:pi/100:2*pi);
plot( x_1, y_1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on
plot( x_2, y_2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( xx, yy, '-', 'Linewidth', 1, 'Color', 'black' );
axis equal
legend({NAMES{:},'constraint'});
title('x,y');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, x_1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt1, x_2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES);
title('x');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, y_1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt1, y_2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES);
title('y');
