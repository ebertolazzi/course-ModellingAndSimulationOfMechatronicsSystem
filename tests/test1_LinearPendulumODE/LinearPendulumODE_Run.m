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

ODE = LinearPendulumODE( m, l, g );

%% Initialize the solver and set the ODE

solver_name = {
  'Exact', ...
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

for i = 2:length(solver_name)
  eval(strcat([ 'solver', solver_name{i}, '=', solver_name{i}, '();' ]));
  eval(strcat([ 'solver', solver_name{i}, '.setODE( ODE );' ]));
end

%% Integrate the system of ODE

d_t   = 0.05;
T_ini = 0.0;
T_end = 10.0;
tt = T_ini:d_t:T_end;

theta_0 = 5*pi/180;
omega_0 = 0.0;
X_ini   = [theta_0, omega_0];

for i = 1:length(solver_name)
  eval(strcat([ 'Z', solver_name{i}, ' = solver', solver_name{i}, '.integrate( tt, X_ini, false, false, 20.0e+03 );' ]));
end

%% Calculate exact solution of the ODE

ZExact = ODE.exact( X_ini, tt );

%% Plot results

linewidth = 1.1;

figure();
hold on; grid on; grid minor;
title('Test 1 -- Pendulum ODE (Linear)');
xlabel('$t$(s)');
ylabel('$\omega$(rad/s)');
plot( tt, ZExact(1,:), 'LineWidth', 1.5*linewidth );
for i = 2:length(solver_name)
  eval(strcat([ 'plot( tt, Z', solver_name{i}, '(1,:), ''--'', ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'southwest');
hold off;

figure();
hold on; grid on; grid minor;
title('Test 1 -- Pendulum ODE (Linear)');
xlabel('$t$(s)');
ylabel('$\theta$(rad)');
plot( tt, ZExact(2,:), 'LineWidth', 1.5*linewidth );
for i = 2:length(solver_name)
  eval(strcat([ 'plot( tt, Z', solver_name{i}, '(2,:), ''--'', ''LineWidth'', linewidth );' ]));
end
legend(solver_name, 'Location', 'southwest');
hold off;

%% Animate solution

figure(); hold on;
for i = 1:length(tt)
  subplot(2,3,1);
  ODE.plot( tt(i), ZExact(:,i) );
  title('Exact');
  subplot(2,3,2);
  ODE.plot( tt(i), ZExplicitEuler(:,i) );
  title('Explicit Euler');
  subplot(2,3,3);
  ODE.plot( tt(i), ZImplicitEuler(:,i) );
  title('Implicit Euler');
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
