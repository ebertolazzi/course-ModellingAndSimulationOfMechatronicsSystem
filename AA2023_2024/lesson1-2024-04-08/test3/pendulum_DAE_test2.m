%
% Solve the pendulum DAE
%
% x' = u
% y' = v
% u' = lambda*x
% v' = lambda*y - g
% x^2 + y^2 = ell^2
%
% index reduction
% 2 * x * x' + 2 * y * y' = 0 ==> x*u+y*v=0
%
% x'*u + x*u' + y' * v + y * v' = 0 ==> u^2 + v^2 + lambda * ( x^2 + y^2 ) - y * g = 0
%
% Eliminazione lambda ==> lambda(x,y,u,v) = (y*g - (u^2 + v^2 ))/(x^2+y^2)
%
% x' = u
% y' = v
% u' = lambda(x,y,u,v)*x
% v' = lambda(x,y,u,v)*y - g
%
% using explicit Euler
%
% x(k+1) = x(k) + dt*( u(k) )
% y(k+1) = y(k) + dt*( v(k) )
% u(k+1) = u(k) + dt*( lambda(x(k),y(k),u(k),v(k))*x(k) )
% v(k+1) = v(k) + dt*( lambda(x(k),y(k),u(k),v(k))*y - g )
%
T_max = 30;
g     = 9.81;
ell   = 2;
%
% mesh point
%
%
% set initial data
%
t = [0];
x = [ell*cos(0.1*pi)];
y = [-ell*sin(0.1*pi)];
u = [0];
v = [0.1];
%
% Advance
%
lambda = @(x,y,u,v) (y*g - (u^2 + v^2 ))/(x^2+y^2);
dt     = 0.01;
ODE    = @(X) [ X(3); X(4); lambda(X(1),X(2),X(3),X(4))*X(1); lambda(X(1),X(2),X(3),X(4))*X(2)- g];

while t(end) < T_max
  X0 = [ x(end); y(end); u(end); v(end)];
  K1 = dt*ODE(X0);
  K2 = dt*ODE(X0+K1/2);
  K3 = dt*ODE(X0+K2/2);
  K4 = dt*ODE(X0+K3);
  X1 = X0+(1/6)*(K1+K4)+(1/3)*(K2+K3);
  % append solution
  t(end+1) = t(end) + dt;
  x(end+1) = X1(1);
  y(end+1) = X1(2);
  u(end+1) = X1(3);
  v(end+1) = X1(4);
end
%
% plot
%
close all;
subplot(3,1,1);
% plot a red circle with the exact solution
hold off
tt = 0:pi/100:2*pi;
xx = ell*cos(tt);
yy = ell*sin(tt);
plot( xx, yy, '-', 'LineWidth', 1, 'Color', 'red' );

% plot a blue dotted line with the numerical solution
hold on
plot( x, y, '-', 'LineWidth', 2, 'Color', 'blue' );
axis equal
title('xy-trajectory');

subplot(3,1,2);
% plot a red circle with the exact solution
plot( t, x.^2+y.^2-ell^2, '-', 'LineWidth', 1, 'Color', 'red' );
title('constraint violation');

subplot(3,1,3);
% plot a red circle with the exact solution
E = (1/2)*(u.^2+v.^2)+g*y;
plot( t, E, '-', 'LineWidth', 1, 'Color', 'red' );
title('Total Energy');