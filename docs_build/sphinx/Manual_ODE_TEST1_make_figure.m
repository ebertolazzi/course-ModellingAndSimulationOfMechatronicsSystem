% load the Pendulum model in the variable ode
close all;
ell     = 2;
gravity = 9.81;
ode     = Pendulum2EQ( ell, gravity );
solver  = ExplicitEuler(); % initialize solver
solver.setODE(ode);        % Attach ode to the solver

Tmax = 15;
h    = 0.05;
tt   = 0:h:Tmax;

theta0  = pi/6;
omega0  = 0;
ini     = [theta0;omega0];

sol = solver.advance( tt, ini );
theta = sol(1,:);
omega = sol(2,:);
x = ell*sin(theta);
y = -ell*cos(theta);
% sample a circle and plot (the constraint) 
xx = ell*cos(0:pi/100:2*pi);
yy = ell*sin(0:pi/100:2*pi);
close all;
plot( xx, yy, '-r', 'Linewidth', 1 );
hold on
axis equal
plot( x, y, '-o', 'MarkerSize', 6, 'Linewidth', 2, 'Color', 'blue' );
title('x,y');
save_png('./images/Manual_ODE_TEST1_fig1');

close all;
hold off
plot( tt, theta, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
legend('Explicit Euler');
title('theta');
save_png('./images/Manual_ODE_TEST1_fig2');

close all;
hold off
plot( tt, omega, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
legend('Explicit Euler');
title('omega');
save_png('./images/Manual_ODE_TEST1_fig3');

close all;
hold off
%ode.animate_plot( tt, sol, 10, 1 );
ode.make_movie( './images/Manual_ODE_TEST1_mov1.mp4', tt, sol, 1 );
