%
% Matlab code for the Course:
%
%     Modelling and Simulation of Mechatronics System
%
% by
% Enrico Bertolazzi
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
%
% Compare with results in:
%
% https://archimede.dm.uniba.it/~testset/report/chemakzo.pdf
%
addpath('../matlab');
addpath('../matlab/ode');
addpath('../matlab/ode_lib');
addpath('../matlab/ode_lib/explicit');
addpath('../matlab/ode_lib/implicit');

close all;
%set(0,'DefaultFigureWindowStyle','docked');

% load the Pendulum model in the variable ode
ell     = 2;
gravity = 9.81;
ode     = Pendulum5EQ( ell, gravity );

% initialize solver
solver_H  = Heun();
solver_H3 = Heun3();
solver_CN = CrankNicolson();

NAMES = {'Heun', 'Heun3','Crank Nicolson'};

solver_H.setODE(ode);
solver_H3.setODE(ode);
solver_CN.setODE(ode);

Tmax = 20;
h    = 0.05;
tt   = 0:h:Tmax;
% setup initial condition
theta0  = pi/6;
omega0  = 0;
x0      = ell*sin(theta0);
y0      = -ell*cos(theta0);
u0      = 0;
v0      = 0;
lambda0 = -(y0*gravity+u0^2+v0^2)/(x0^2+y0^2);

ini     = [x0;y0;u0;v0;lambda0];
fprintf('advance with ODE\n');
sol_H  = solver_H.advance( tt, ini );
sol_H3 = solver_H3.advance( tt, ini );
sol_CN = solver_CN.advance( tt, ini );
fprintf('done\n');

x_H = sol_H(1,:);
y_H = sol_H(2,:);

x_H3 = sol_H3(1,:);
y_H3 = sol_H3(2,:);

x_CN = sol_CN(1,:);
y_CN = sol_CN(2,:);

h = figure();
set(h,'WindowStyle','docked');
xx = ell*cos(0:pi/100:2*pi);
yy = ell*sin(0:pi/100:2*pi);
plot( x_H, y_H, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on
plot( x_H3, y_H3, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( x_CN, y_CN,  '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( xx, yy, '-', 'Linewidth', 1, 'Color', 'black' );
axis equal
legend({NAMES{:},'constraint'});
title('x,y');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, x_H, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, x_H3, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, x_CN, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES);
title('x');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, y_H, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, y_H3, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, y_CN, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES);
title('y');
