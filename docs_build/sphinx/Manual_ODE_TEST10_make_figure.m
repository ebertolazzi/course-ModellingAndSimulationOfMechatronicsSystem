% load the DoubleSlider model in the variable ode
close all;
clear all;

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
solver  = ExplicitEuler(); % initialize solver
solver.setODE(ode);        % Attach ode to the solver

Tmax = 10.0;
h    = 0.1;
tt   = 0:h:Tmax;

angle     = pi/2;
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

sol = solver.advance( tt, ini, true, true );
x2    = sol(1,:);
s     = sol(2,:);
theta = sol(3,:);
% sample a circle and plot (the constraint)
x0 = 0;
y0 = 0;
close all;
hold on;
xc1 = R*cos(0:pi/100:2*pi);
yc1 = R*sin(0:pi/100:2*pi);
axis_lim = R*1.5;
xc2 = -axis_lim:0.05:axis_lim;
yc2 = 0.0*(-axis_lim:0.05:axis_lim);
plot( xc1, yc1, '-r', 'Linewidth', 1 );
plot( xc2, yc2, '-r', 'Linewidth', 1 );
plot( yc2, xc2, '-r', 'Linewidth', 1 );
plot( x2, H*ones(length(x2)), '-ob', 'MarkerSize', 6, 'Linewidth', 2 );
plot( x2+L, H*ones(length(x2)), '-og', 'MarkerSize', 6, 'Linewidth', 2 );
plot( [X30, X30], [-R, R], '-k', 'MarkerSize', 6, 'Linewidth', 4 );
axis equal;
title('x,y');
save_png('./images/Manual_ODE_TEST10_fig1');

%close all;
hold off
ode.animate_plot( tt, sol, 10, 1 );
ode.make_movie( './images/Manual_ODE_TEST10_mov1.mp4', tt, sol, 1 );
