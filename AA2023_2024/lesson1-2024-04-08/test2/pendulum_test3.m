%
% Solve the pendulum ODE
%
% theta' = omega
% omega' = -g/ell * sin(theta)
%
% using RK4 scheme
%
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
ODE = @(X) [X(2); -g/ell * sin(X(1))];
dt = 0.01;
while t(end) < T_max
  X0 = [theta(end);omega(end)];
  K1 = dt*ODE(X0);
  K2 = dt*ODE(X0+K1/2);
  K3 = dt*ODE(X0+K2/2);
  K4 = dt*ODE(X0+K3);
  X1 = X0+(1/6)*(K1+K4)+(1/3)*(K2+K3);
  % append solution
  t(end+1)     = t(end) + dt;
  theta(end+1) = X1(1);
  omega(end+1) = X1(2);
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
