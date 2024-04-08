%
% Solve the ODE
%
% x' = -y
% y' = x
%
% using Collatz (or improved Euler)
%
% x(k+1/2) = x(k)-dt/2*y(k+1)
% y(k+1/2) = y(k)+dt/2*x(k+1)
% x(k+1)   = x(k)-dt*y(k+1/2)
% y(k+1)   = y(k)+dt*x(k+1/2)
%
%
T_max = 10;
%
% mesh point
%
%
% set initial data
%
t = [0];
x = [1];
y = [0];
%
% Advance
%
dt = 0.1;
while t(end) < T_max
  x1 = x(end) - (dt/2)*y(end);
  y1 = y(end) + (dt/2)*x(end);
  x2 = x(end) - dt*y1;
  y2 = y(end) + dt*x1;
  % append solution
  t(end+1) = t(end) + dt;
  x(end+1) = x2;
  y(end+1) = y2;
end
%
% plot
%
close all;
subplot(2,1,1);
% plot a red circle with the exact solution
hold off
tt = 0:pi/100:2*pi;
xx = cos(tt);
yy = sin(tt);
plot( xx, yy, '-', 'LineWidth', 1, 'Color', 'red' );

% plot a blue dotted line with the numerical solution
hold on
plot( x, y, '-o', 'LineWidth', 2, 'Color', 'blue' );
axis equal
title('x,y trajectory')

subplot(2,1,2);
% plot a blue dotted line with the integral invariant error
hold on
err = x.^2+y.^2-1;
plot( t, err, '-o', 'LineWidth', 2, 'Color', 'blue' );
title('invariant violation');
