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
T_max = 10;
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
v = [0];
%
% Advance
%
lambda = @(x,y,u,v) (y*g - (u^2 + v^2 ))/(x^2+y^2);
dt     = 0.01;
while t(end) < T_max
  x0 = x(end);
  y0 = y(end);
  u0 = u(end);
  v0 = v(end);
  x1 = x0 + dt*( u0 );
  y1 = y0 + dt*( v0 );
  u1 = u0 + dt*( lambda(x0,y0,u0,v0)*x0 );
  v1 = v0 + dt*( lambda(x0,y0,u0,v0)*y0 - g );
  % append solution
  t(end+1) = t(end) + dt;
  x(end+1) = x1;
  y(end+1) = y1;
  u(end+1) = u1;
  v(end+1) = v1;
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
plot( x, y, 'o-', 'LineWidth', 2, 'Color', 'blue' );
axis equal

subplot(3,1,2);
% plot a red circle with the exact solution
plot( t, x.^2+y.^2-ell^2, 'o-', 'LineWidth', 1, 'Color', 'red' );

subplot(3,1,3);
% plot a red circle with the exact solution
E = (1/2)*(u.^2+v.^2)+g*y;
plot( t, E, 'o-', 'LineWidth', 1, 'Color', 'red' );
