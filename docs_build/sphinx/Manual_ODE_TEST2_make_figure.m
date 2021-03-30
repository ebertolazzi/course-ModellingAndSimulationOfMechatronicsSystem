% load the Pendulum model in the variable ode
close all;
ell     = 2;
gravity = 9.81;
ode     = Pendulum5EQ( ell, gravity );
solver  = ExplicitEuler(); % initialize solver
solver.setODE(ode);        % Attach ode to the solver

Tmax = 15;
h    = 0.05;
tt   = 0:h:Tmax;

theta0  = pi/6;
omega0  = 0;
x0      = ell*sin(theta0);
y0      = -ell*cos(theta0);
u0      = 0;
v0      = 0;
lambda0 = -(y0*gravity+u0^2+v0^2)/(x0^2+y0^2);
ini     = [x0;y0;u0;v0;lambda0];

sol = solver.advance( tt, ini );
x   = sol(1,:);
y   = sol(2,:);
% sample a circle and plot (the constraint) 
xx = ell*cos(0:pi/100:2*pi);
yy = ell*sin(0:pi/100:2*pi);
close all;
plot( xx, yy, '-r', 'Linewidth', 1 );
hold on
axis equal
plot( x, y, '-o', 'MarkerSize', 6, 'Linewidth', 2, 'Color', 'blue' );
title('x,y');
save_png('./images/Manual_ODE_TEST2_fig1');

close all;
hold off
%ode.animate_plot( tt, sol, 10, 1 );
ode.make_movie( './images/Manual_ODE_TEST2_mov1.mp4', tt, sol, 1 );
