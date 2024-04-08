%
% Solve the pendulum ODE
%
% theta' = omega
% omega' = -g/ell * sin(theta)
%
% using explicit Euler
%
% theta(k+1) = theta(k)+dt*omega(k)
% omega(k+1) = omega(k)-dt*(g/ell)*sin(theta(k))
%
T_max = 10;
g     = 9.81;
ell   = 2;
%
% mesh point
%
%
% set initial data
%
t     = [0];
theta = [pi/2];
omega = [0];
%
% Advance
%
dt = 0.01;
while t(end) < T_max
  t1 = t(end) + dt;
  theta1 = theta(end)+dt*omega(end);
  omega1 = omega(end)-dt*(g/ell)*sin(theta(end));
  % append solution
  t(end+1)     = t1;
  theta(end+1) = theta1;
  omega(end+1) = omega1;
end
%
% plot
%
close all;
subplot(2,1,1);
% plot a red circle with the exact solution
hold off
plot( t, theta, 'o-', 'LineWidth', 1, 'Color', 'red' );
hold on
plot( t, omega, 'o-', 'LineWidth', 2, 'Color', 'blue' );
title('theta, omega solution');

subplot(2,1,2);
% plot a red circle with the exact solution
E = (1/2)*omega.^2-(g/ell)*cos(theta);
plot( t, E, 'o-', 'LineWidth', 1, 'Color', 'red' );
title('invariant violation');