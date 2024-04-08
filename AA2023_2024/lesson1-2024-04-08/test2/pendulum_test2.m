%
% Solve the pendulum ODE
%
% theta' = omega
% omega' = -g/ell * sin(theta)
%
% using Collatz scheme
%
% theta(k+1/2) = theta(k)+(dt/2)*omega(k)
% omega(k+1/2) = omega(k)-(dt/2)*(g/ell)*sin(theta(k))
%
% theta(k+1) = theta(k)+dt*omega(k+1/2)
% omega(k+1) = omega(k)-dt*(g/ell)*sin(theta(k+1/2))
%
T_max = 20;
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
  theta1 = theta(end)+(dt/2)*omega(end);
  omega1 = omega(end)-(dt/2)*(g/ell)*sin(theta(end));
  theta2 = theta(end)+dt*omega1;
  omega2 = omega(end)-dt*(g/ell)*sin(theta1);
  % append solution
  t(end+1)     = t(end) + dt;
  theta(end+1) = theta2;
  omega(end+1) = omega2;
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
