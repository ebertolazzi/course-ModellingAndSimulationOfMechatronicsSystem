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
gravity = 9.81;
ode     = ParabolicPendulum4EQ( mass, gravity );
eta     = 0.5;
omega   = 10;
ode.setBaumgarte( eta, omega );

% initialize solver
solver = ImplicitEuler();

NAMES = {'ImplicitEuler'};

solver.setODE(ode);

Tmax = 10;
h    = 0.025;
tt   = 0:h:Tmax;
% setup initial condition
theta0 = pi/3;
omega0 = 0;
x0     = 1;
y0     = 1;
u0     = 0;
v0     = 0;

ini = [x0;y0;u0;v0];
fprintf('advance with ODE\n');
sol = solver.advance( tt, ini );
fprintf('done\n');

%
ms = 10;
ode.animate_plot( tt, sol, ms, 10 );

x = sol(1,:);
y = sol(2,:);

% evaluate middle point and direction
xm = x/2;
ym = (x.^2+y)/2;
L  = 2*hypot( x, x.^2-y );
dx = x./L;
dy = (x.^2-y)./L;

x0 = xm-dx;
y0 = ym-dy;
x1 = xm+dx;
y1 = ym+dy;

h = figure();
set(h,'WindowStyle','docked');
xx = -1.2:0.01:1.2;
yy = xx.^2;
plot( xx, yy, '-', 'Linewidth', 2, 'Color', 'black' );
hold on
plot( x1, y1, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
%plot( x0, y0, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
axis equal
legend({'constraint',NAMES{:}});
title('x,y');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, x, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES);
title('x');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, y, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES);
title('y');

err = x.^2+(x.^2-y).^2-1;

h = figure();
set(h,'WindowStyle','docked');

plot( tt, err, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES);
title('err');
