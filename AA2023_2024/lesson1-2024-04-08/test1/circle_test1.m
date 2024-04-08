%
% Solve the ODE
%
% x' = -y
% y' = x
%
% using explicit Euler
%
% x(k+1) = x(k)-dt*y(k)
% y(k+1) = y(k)+dt*x(k)
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
dt = 0.01;
while t(end) < T_max
  t1 = t(end) + dt;
  x1 = x(end) - dt*y(end);
  y1 = y(end) + dt*x(end);
  % append solution
  t(end+1) = t1;
  x(end+1) = x1;
  y(end+1) = y1;
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
