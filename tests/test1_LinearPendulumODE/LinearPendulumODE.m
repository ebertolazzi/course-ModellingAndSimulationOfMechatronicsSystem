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

%> Implementation of the Linear Pendulum (2 Equations)
%>
%> \rst
%> .. math::
%> 
%>   \begin{cases}
%>      \theta' = \omega & \\
%>      \omega' = -\displaystyle\frac{g}{\ell}\theta &
%>   \end{cases}
%>
%> \endrst
%
classdef LinearPendulumODE < DIAL_ODEsystem
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
    function this = LinearPendulumODE( m, l, g )
      neq  = 2;
      ninv = 0;
      this@DIAL_ODEsystem( 'LinearPendulumODE', neq, ninv );
      this.m_m = m;
      this.m_l = l;
      this.m_g = g;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = f( this, ~, X )
      out    = zeros(2,1);
      out(1) = X(2);
      out(2) = -this.m_g / this.m_l * X(1);
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = DfDx( this, ~, ~ )
      out      = zeros(2,2);
      out(1,2) = 1.0;
      out(2,1) = -this.m_g / this.m_l;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function h( ~, ~, ~ )
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function DhDx( ~, ~, ~ )
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function plot( this, ~, X )
      x  =  this.m_l*sin(X(1));
      y  = -this.m_l*cos(X(1));
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
    function out = exact( this, x_i, t )
      sqrt_g_l = sqrt(this.m_g / this.m_l);
      out      = zeros(2,length(t));
      out(1,:) = -sqrt_g_l .* x_i(2) .* sin(sqrt_g_l .* t) + x_i(1) * cos(sqrt_g_l .* t);
      out(2,:) = sqrt_g_l .* (sqrt_g_l .* x_i(2) .* cos(sqrt_g_l .* t) - x_i(1) * sin(sqrt_g_l .* t));
    end
    %
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
