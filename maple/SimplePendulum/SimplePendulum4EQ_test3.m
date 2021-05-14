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
%ode.setBaumgarte( 1, 4 );

% initialize solver
solver = CrankNicolson();

NAMES = {'CrankNicolson'};

solver.setODE(ode);

Tmax = 400;
h    = 0.025;
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
sol = solver.advance( tt, ini );
fprintf('done\n');

%ode.make_movie( 'SimplePendulum4EQ.avi', tt, sol, 1 );

x = sol(1,:);
y = sol(2,:);

h = figure();
set(h,'WindowStyle','docked');
xx = ell*cos(0:pi/100:2*pi);
yy = ell*sin(0:pi/100:2*pi);
plot( xx, yy, '-', 'Linewidth', 2, 'Color', 'black' );
hold on
plot( x, y, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
axis equal
legend('constraint',NAMES{:});
title('x,y');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, x, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES{:});
title('x');

h = figure();
set(h,'WindowStyle','docked');

plot( tt, y, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES{:});
title('y');


h = figure();
set(h,'WindowStyle','docked');

plot( tt, x.^2+y.^2-ell^2, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
legend(NAMES{:});
title('constraint violation');
