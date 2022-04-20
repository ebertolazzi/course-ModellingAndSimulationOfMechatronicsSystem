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

classdef PendulumDAEbaumgarte < DIAL_ODEsystem
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
  methods (Access = private)
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = bigRHS( this, ~, X )
      g = this.m_g;
      m = this.m_m;

      % Extract states
      u = X(3);
      v = X(4);

      % Evaluate function
      res__2 = -m * g;
      t2 = u ^ 2;
      t3 = v ^ 2;
      res__3 = -2 * t2 - 2 * t3;

      % Store output
      out    = zeros(3,1);
      out(2) = res__2;
      out(3) = res__3;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = JbigRHS( ~, ~, X )
      % Extract states
      u = X(3);
      v = X(4);
  
      % Evaluate function
      res__3_3 = -4 * u;
      res__3_4 = -4 * v;
      
      % Store output
      out      = zeros(3,4);
      out(3,3) = res__3_3;
      out(3,4) = res__3_4;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = bigM( this, ~, X )
      m = this.m_m;

      % Sxtract states
      x = X(1);
      y = X(2);

      % Evaluate function
      res__1_1 = m;
      res__1_3 = 2 * x;
      res__2_2 = m;
      res__2_3 = 2 * y;
      res__3_1 = res__1_3;
      res__3_2 = res__2_3;

      % Store output
      out      = zeros(3,3);
      out(1,1) = res__1_1;
      out(1,3) = res__1_3;
      out(2,2) = res__2_2;
      out(2,3) = res__2_3;
      out(3,1) = res__3_1;
      out(3,2) = res__3_2;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = bigETA( ~, ~, X, mu )
      % Extract states
      x = X(1);
      y = X(2);

      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);

      % Evaluate function
      res__1 = m * mu1 + 2 * x * mu3;
      res__2 = m * mu2 + 2 * y * mu3;
      res__3 = 2 * x * mu1 + 2 * y * mu2;

      % Store output
      out = zeros(3,1);
      out(1) = res__1;
      out(2) = res__2;
      out(3) = res__3;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = JbigETA( ~, ~, ~, mu )
      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);

      % Evaluate function
      res__1_1 = 2 * mu3;
      res__2_2 = res__1_1;
      res__3_1 = 2 * mu1;
      res__3_2 = 2 * mu2;

      % Store output
      out = zeros(3,4);
      out(1,1) = res__1_1;
      out(2,2) = res__2_2;
      out(3,1) = res__3_1;
      out(3,2) = res__3_2;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function this = PendulumDAEbaumgarte( m, l, g )
      neq  = 4;
      ninv = 2;
      this@DIAL_ODEsystem( 'PendulumDAEbaumgarte', neq, ninv );
      this.m_m = m;
      this.m_l = l;
      this.m_g = g;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = f( this, t, X )
      npos = this.m_neqn/2;

      %
      %       / f(q,v,t) \
      % RHS = |          |
      %       \ g(q,v,t) /
      %
      RHS = this.bigRHS( t, X );

      %
      %
      %        / M(q,v,t)  Phi_q(q,t)^T \
      % BIGM = |                        |
      %        \ Phi_q(q,t)     0       /
      %
      BIGM = this.bigM( t, X );
      SOL  = BIGM \ RHS;
    
      % Evaluate function
      out = zeros(2*npos,1);
      out(1:npos)        = X(npos+1:2*npos);
      out(npos+1:2*npos) = SOL(1:npos);
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = DfDx( this, t, X )
      %
      %       / f(q,v,t) \
      % RHS = |          |
      %       \ g(q,v,t) /
      %
      RHS = this.bigRHS( t, X );

      %
      %
      %        / M(q,v,t)  Phi_q(q,t)^T \
      % BIGM = |                        |
      %        \ Phi_q(q,t)     0       /
      %
      BIGM = this.bigM( t, X );

      SOL  = BIGM\RHS;
      JETA = this.JbigETA( t, X, SOL );
      JRHS = this.JbigRHS( t, X );
      JM   = BIGM\(JRHS-JETA);
      
      % Combine all jacobians
      npos = this.m_neqn/2;
      out  = [ zeros(npos,npos) eye(npos); JM(1:npos,:) ];
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = h( this, ~, X )
      l = this.m_l;

      % Extract states
      x = X(1);
      y = X(2);
      u = X(3);
      v = X(4);

      % Evaluate function
      t1 = l ^ 2;
      t2 = x ^ 2;
      t3 = y ^ 2;
      res__1 = -t1 + t2 + t3;
      res__2 = 2 * x * u + 2 * y * v;

      % Store output
      out    = zeros(2,1);
      out(1) = res__1;
      out(2) = res__2;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = DhDx( ~, ~, X )
      % Extract states
      x = X(1);
      y = X(2);
      u = X(3);
      v = X(4);

      % Evaluate function
      res__1_1 = 2 * x;
      res__1_2 = 2 * y;
      res__2_1 = 2 * u;
      res__2_2 = 2 * v;
      res__2_3 = res__1_1;
      res__2_4 = res__1_2;

      % Store output
      out      = zeros(2,4);
      out(1,1) = res__1_1;
      out(1,2) = res__1_2;
      out(2,1) = res__2_1;
      out(2,2) = res__2_2;
      out(2,3) = res__2_3;
      out(2,4) = res__2_4;
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
