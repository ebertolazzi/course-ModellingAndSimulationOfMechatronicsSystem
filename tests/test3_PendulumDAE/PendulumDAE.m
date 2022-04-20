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

classdef PendulumDAE < DIAL_ODEsystem
  %
  properties (SetAccess = protected, Hidden = true)
    %
    %> Pendulum mass (kg)
    %
    m_m;
    %
    %> Pendulum length (m)
    %
    m_l;
    %
    %> Gravity acceleration (m/s^2)
    %
    m_g;
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function this = PendulumDAE( m, l, g )
      neq  = 5;
      ninv = 3;
      this@DIAL_ODEsystem( 'PendulumDAE', neq, ninv );
      this.m_m = m;
      this.m_l = l;
      this.m_g = g;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = f( this, ~, X )
      m   = this.m_m;
      g   = this.m_g;

      % Extract states
      x      = X(1);
      y      = X(2);
      u      = X(3);
      v      = X(4);
      lambda = X(5);

      % Evaluate function
      res__1 = u;
      res__2 = v;
      t1 = 0.1e1 / m;
      res__3 = -lambda * t1 * x;
      res__4 = t1 * (-m * g - y * lambda);
      t17 = x ^ 2;
      t18 = y ^ 2;
      res__5 = 0.1e1 / (t17 + t18) * (-3 * v * g * m - 4 * lambda * u * x - 4 * lambda * v * y);

      % Store output
      out    = zeros(5,1);
      out(1) = res__1;
      out(2) = res__2;
      out(3) = res__3;
      out(4) = res__4;
      out(5) = res__5;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = DfDx( this, ~, X )
      m   = this.m_m;
      g   = this.m_g;

      % Extract states
      x      = X(1);
      y      = X(2);
      u      = X(3);
      v      = X(4);
      lambda = X(5);

      % Evaluate function
      res__1_3 = 1;
      res__2_4 = 1;
      t1 = 0.1e1 / m;
      res__3_1 = -lambda * t1;
      res__3_5 = -t1 * x;
      res__4_2 = res__3_1;
      res__4_5 = -t1 * y;
      t5 = v * g;
      t9 = x ^ 2;
      t13 = y ^ 2;
      t17 = v * lambda;
      t22 = t9 + t13;
      t23 = t22 ^ 2;
      t24 = 0.1e1 / t23;
      res__5_1 = t24 * (-4 * u * t13 * lambda + 4 * u * t9 * lambda + 6 * m * x * t5 + 8 * x * y * t17);
      res__5_2 = t24 * (8 * lambda * x * y * u + 6 * m * y * t5 + 4 * t13 * t17 - 4 * t9 * t17);
      t37 = 0.1e1 / t22;
      res__5_3 = -4 * lambda * t37 * x;
      res__5_4 = t37 * (-3 * m * g - 4 * y * lambda);
      res__5_5 = t37 * (-4 * x * u - 4 * y * v);
      
      % Store output
      out      = zeros(5,5);
      out(1,3) = res__1_3;
      out(2,4) = res__2_4;
      out(3,1) = res__3_1;
      out(3,5) = res__3_5;
      out(4,2) = res__4_2;
      out(4,5) = res__4_5;
      out(5,1) = res__5_1;
      out(5,2) = res__5_2;
      out(5,3) = res__5_3;
      out(5,4) = res__5_4;
      out(5,5) = res__5_5;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function res__h = h( this, ~, vars__ )
      m   = this.m_m;
      ell = this.m_l;
      g   = this.m_g;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      lambda = vars__(5);

      % evaluate function
      t1 = ell ^ 2;
      t2 = x ^ 2;
      t3 = y ^ 2;
      res__1 = t1 - t2 - t3;
      res__2 = 2 * x * u + 2 * y * v;
      t8 = u ^ 2;
      t9 = v ^ 2;
      res__3 = 0.1e1 / m * (m * (2 * g * y - 2 * t8 - 2 * t9) + 2 * (t2 + t3) * lambda);

      % store on output
      res__h = zeros(3,1);
      res__h(1) = res__1;
      res__h(2) = res__2;
      res__h(3) = res__3;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = DhDx( this, ~, X )
      m = this.m_m;
      g = this.m_g;

      % Extract states
      x      = X(1);
      y      = X(2);
      u      = X(3);
      v      = X(4);
      lambda = X(5);

      % Evaluate function
      t1 = 2 * x;
      res__1_1 = -t1;
      t2 = 2 * y;
      res__1_2 = -t2;
      res__2_1 = 2 * u;
      res__2_2 = 2 * v;
      res__2_3 = t1;
      res__2_4 = t2;
      t3 = 0.1e1 / m;
      res__3_1 = 4 * lambda * t3 * x;
      res__3_2 = t3 * (2 * m * g + 4 * lambda * y);
      res__3_3 = -4 * u;
      res__3_4 = -4 * v;
      t13 = x ^ 2;
      t14 = y ^ 2;
      res__3_5 = t3 * (2 * t13 + 2 * t14);
      
      % Store output
      out      = zeros(3,5);
      out(1,1) = res__1_1;
      out(1,2) = res__1_2;
      out(2,1) = res__2_1;
      out(2,2) = res__2_2;
      out(2,3) = res__2_3;
      out(2,4) = res__2_4;
      out(3,1) = res__3_1;
      out(3,2) = res__3_2;
      out(3,3) = res__3_3;
      out(3,4) = res__3_4;
      out(3,5) = res__3_5;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function plot( this, ~, X )
      x  = X(1);
      y  = X(2);
      x0 = 0;
      y0 = 0;
      tt = 0:pi/100:2*pi;
      xx = this.m_l*cos(tt);
      yy = this.m_l*sin(tt);
      hold off;
      plot(xx, yy, 'LineWidth', 1.0, 'Color', 'red');
      hold on;
      grid on; grid minor;
      xlabel('$x$(m)');
      ylabel('$y$(m)');
      l = 1.1*this.m_l;
      drawLine(x0, y0, x, y, 'LineWidth', 5, 'Color', 'k');
      drawCOG( 0.1*this.m_l, x0, y0 );
      fillCircle( 'r', x, y, 0.1*this.m_l );
      xlim([-l, l]);
      ylim([-l, l]);
      axis equal;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
