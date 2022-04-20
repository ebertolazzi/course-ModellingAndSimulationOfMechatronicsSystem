% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%                                                                     %
% The DIAL project - Course of MECHATRONICS SYSTEM SIMULATION         %
%                                                                     %
% Copyright (c) 2020, Davide Stocco and Enrico Bertolazzi, Francesco  %
% Biral                                                               %
%                                                                     %
% The DIAL project and its components are supplied under the terms of %
% the open source BSD 2-Clause License. The contents of the DIAL      %
% project and its components may not be copied or disclosed except in %
% accordance with the terms of the BSD 2-Clause License.              %
%                                                                     %
% URL: https://opensource.org/licenses/BSD-2-Clause                   %
%                                                                     %
%    Davide Stocco                                                    %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: davide.stocco@unitn.it                                   %
%                                                                     %
%    Enrico Bertolazzi                                                %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: enrico.bertolazzi@unitn.it                               %
%                                                                     %
%    Francesco Biral                                                  %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: francesco.biral@unitn.it                                 %
%                                                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%% Prepare worspace

clc;
clear all; %#ok<CLALL> 
close all;

%% Make plot fancier

set(0,     'DefaultFigureWindowStyle',        'normal');
set(0,     'defaultTextInterpreter',          'latex' );
set(groot, 'defaultAxesTickLabelInterpreter', 'latex' );
set(groot, 'defaulttextinterpreter',          'latex' );
set(groot, 'defaultLegendInterpreter',        'latex' );
set(0,     'defaultAxesFontSize',             18      );

%% Instantiate system object

m = 1.0;  % (kg)
l = 1.0;  % (m)
g = 9.81; % (m/s^2)

ODE = PendulumDAE( m, l, g );

%% Initialize the solver and set the ODE

solver_name = {
  ... % Explict methods
  'Collatz', ...
  'ExplicitEuler', ...
  'ExplicitMidpoint', ...
  'Heun2', ...
  'Heun3', ...
  'Ralston2', ...
  'Ralston3', ...
  'Ralston4', ...
  'RK3', ...
  'RK4', ...
  'RK38', ...
  'SSPRK3', ...
  ... % Implict methods
  'CrankNicolson', ...
  'GaussLegendre2', ...
  'GaussLegendre4', ...
  'GaussLegendre6', ...
  'ImplicitEuler', ...
  'ImplicitMidpoint', ...
  'LobattoIIIA2', ...
  'LobattoIIIA4', ...
  'LobattoIIIB2', ...
  'LobattoIIIB4', ...
  'LobattoIIIC2', ...
  'LobattoIIIC4', ...
  'LobattoIIICS2', ...
  'LobattoIIICS4', ...
  'LobattoIIID2', ...
  'LobattoIIID4', ...
  'RadauIA3', ...
  'RadauIA5', ...
  'RadauIIA3', ...
  'RadauIIA5' ...
};

for i = 1:length(solver_name)
  eval(strcat([ 'solver', solver_name{i}, '=', solver_name{i}, '();' ]));
  eval(strcat([ 'solver', solver_name{i}, '.setODE( ODE );' ]));
end

%% Integrate the system of ODE

d_t   = 0.01;
T_ini = 0.0;
T_end = 3.0;
tt = T_ini:d_t:T_end;

theta0  = pi/2;
vel     = -2;
x0      = l*sin(theta0);
y0      = -l*cos(theta0);
u0      = vel*cos(theta0);
v0      = vel*sin(theta0);
lambda0 = (u0^2+v0^2-y0*g)/(x0^2+y0^2);
X_ini   = [x0;y0;u0;v0;lambda0];

for i = 1:length(solver_name)
  eval(strcat([ 'Z', solver_name{i}, ' = solver', solver_name{i}, '.integrate( tt, X_ini, false, false, 20.0e+03 );' ]));
end

%% Plot results

linewidth = 1.1;

figure();
hold on; grid on; grid minor;
title('Test 1 -- Pendulum DAE');
xlabel('$t$(s)');
ylabel('$y$(rad/s)');
for i = 1:length(solver_name)
  eval(strcat([ 'plot( tt, Z', solver_name{i}, '(1,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'southwest');
hold off;

figure();
hold on; grid on; grid minor;
title('Test 1 -- Pendulum DAE (Non Linear)');
xlabel('$t$(s)');
ylabel('$x$(rad)');
for i = 1:length(solver_name)
  eval(strcat([ 'plot( tt, Z', solver_name{i}, '(2,:), ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'southwest');
hold off;

%% Plot solution

figure();
hold on; grid on; grid minor;
legend_vec = {};
title('Test 3 -- Pendulum DAE (Non Linear)');
plot( tt, ZExplicitEuler(1,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Explicit Euler'});
plot( tt, ZImplicitEuler(1,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Implicit Euler'});
plot( tt, ZCollatz(1,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Collatz'});
plot( tt, ZHeun2(1,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Heun2'});
plot( tt, ZRK4(1,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'RK4'});
plot( tt, ZGaussLegendre6(1,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'GaussLegendre6'});
legend(legend_vec);
hold off;

figure();
hold on; grid on; grid minor;
legend_vec = {};
title('Test 3 -- Pendulum DAE (Non Linear)');
plot( tt, ZExplicitEuler(2,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Explicit Euler'});
plot( tt, ZImplicitEuler(2,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Implicit Euler'});
plot( tt, ZCollatz(2,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Collatz'});
plot( tt, ZHeun2(2,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'Heun2'});
plot( tt, ZRK4(2,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'RK4'});
plot( tt, ZGaussLegendre6(2,:), 'LineWidth', linewidth );
legend_vec = union(legend_vec, {'GaussLegendre6'});
legend(legend_vec);
hold off;

figure();
hold on; grid on; grid minor;
legend_vec = {};
title('Test 3 -- Pendulum DAE (Non Linear)');
xx = l*cos(0:pi/100:2*pi);
yy = l*sin(0:pi/100:2*pi);
plot( xx, yy, '-r', 'Linewidth', 1 );
plot( ZExplicitEuler(1,:), ZExplicitEuler(2,:), '-o' );
legend_vec = union(legend_vec, {'Explicit Euler'});
plot( ZImplicitEuler(1,:), ZImplicitEuler(2,:), '-o' );
legend_vec = union(legend_vec, {'Implicit Euler'});
plot( ZCollatz(1,:), ZCollatz(2,:), '-o' );
legend_vec = union(legend_vec, {'Collatz'});
plot( ZHeun2(1,:), ZHeun2(2,:), '-o' );
legend_vec = union(legend_vec, {'Heun2'});
plot( ZRK4(1,:), ZRK4(2,:), '-o' );
legend_vec = union(legend_vec, {'RK4'});
plot( ZGaussLegendre6(1,:), ZGaussLegendre6(2,:), '-o' );
legend_vec = union(legend_vec, {'GaussLegendre6'});
legend(legend_vec);
hold off;

%% Animate solution

figure(); hold on;
for i = 1:length(tt)
  subplot(2,3,1);
  ODE.plot( tt(i), ZExplicitEuler(:,i) );
  title('Explicit Euler');
  subplot(2,3,2);
  ODE.plot( tt(i), ZImplicitEuler(:,i) );
  title('Implicit Euler');
  subplot(2,3,3);
  ODE.plot( tt(i), ZCollatz(:,i) );
  title('Collatz');
  subplot(2,3,4);
  ODE.plot( tt(i), ZHeun2(:,i) );
  title('Heun2');
  subplot(2,3,5);
  ODE.plot( tt(i), ZRK4(:,i) );
  title('RK4');
  subplot(2,3,6);
  ODE.plot( tt(i), ZGaussLegendre6(:,i) );
  title('GaussLegendre6');
  drawnow limitrate;
end
hold off;
