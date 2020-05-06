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
solver_EE = ExplicitEuler();
solver_IE = ImplicitEuler();
solver_H  = Heun();

solver_EE.setODE(ode);
solver_IE.setODE(ode);
solver_H.setODE(ode);

Tmax = 10;
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
sol_EE = solver_EE.advance( tt, ini );
sol_IE = solver_IE.advance( tt, ini );
sol_H  = solver_H.advance( tt, ini );
fprintf('done\n');

x_EE = sol_EE(1,:);
y_EE = sol_EE(2,:);

x_IE = sol_IE(1,:);
y_IE = sol_IE(2,:);

x_H = sol_H(1,:);
y_H = sol_H(2,:);

h = figure();
set(h,'WindowStyle','docked');
xx = ell*cos(0:pi/100:2*pi);
yy = ell*sin(0:pi/100:2*pi);
plot( x_EE, y_EE, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on
plot( x_IE, y_IE, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( x_H,  y_H,  '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( xx, yy, '-', 'Linewidth', 1, 'Color', 'black' );
axis equal
legend({'Explicit Euler', 'Implicit Euler','Heun','constraint'});
title('x,y');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, x_EE, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, x_IE, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, x_H,  '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend({'Explicit Euler', 'Implicit Euler','Heun'});
title('x');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, y_EE, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
plot( tt, y_IE, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
plot( tt, y_H,  '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend({'Explicit Euler', 'Implicit Euler','Heun'});
title('y');
