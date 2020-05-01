%
% Matlab code for the Course:
%
%     Modelling and Simulation of Mechatronics System
%
% by
% Enrico Bertolazzi
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
%
classdef BiralDAE1 < DAE3baseClassImplicit
  properties (SetAccess = protected, Hidden = true)
    m;
    gravity;
    ell;
    Iz;
  end

  methods
    function self = BiralDAE1( m, gravity, ell, Iz )
      % 3 pos/vel, 2 constraints
      self@DAE3baseClassImplicit('BiralDAE1',3,2);
      self.m       = m;
      self.gravity = gravity;
      self.ell     = ell;
      self.Iz      = Iz;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function Mass = M( self, ~, ~ )
      m    = self.m;
      Iz   = self.Iz;
      Mass = [ m, 0, 0; ...
               0, m, 0; ...
               0, 0, Iz ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = Phi( self, t, pos )
      x     = pos(1);
      y     = pos(2);
      theta = pos(3);
      ell   = self.ell;
      rhs   = [ 2*y - ell*cos(theta); ...
                2*x + ell*sin(theta)];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = Phi_t( self, t, pos )
      rhs = zeros(2,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = Phi_q( self, t, pos )
      x     = pos(1);
      y     = pos(2);
      theta = pos(3);
      ell   = self.ell;
      % theta1, theta2, x1, y1, x2, y2
      J = [ 0, 2, ell*sin(theta); ...
            2, 0, ell*cos(theta) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiL_q( self, t, pos, lambda )
      theta = p(3);
      ell   = self.ell;
      H     = [ 0, 0, 0; ...
                0, 0, 0; ...
                0, 0, ell*(cos(theta)*lambda(1)-sin(theta)*lambda(2)) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiV_q( self, t, pos, v_dot )
      theta = p(3);
      ell   = self.ell;
      H     = ell*[ 0, 0, v_dot(3)*cos(theta); ...
                    0, 0, -v_dot(3)*sin(theta) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce( self, ~, ~, ~ )
      m       = self.m;
      gravity = self.gravity;
      rhs     = [0;-m*gravity;0];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_q( self, ~, ~, ~ )
      rhs = zeros(3,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_v( self, ~, ~, ~ )
      rhs = zeros(3,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - b(t,q,v)
    function rhs = b( self, t, pos, vel )
      theta = pos(3);
      omega = vel(3);
      ell   = self.ell;
      rhs   = ell*omega^2*[ -cos(theta); sin(theta) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - b(t,q,v)
    function rhs = b_q( self, t, pos, vel )
      theta = pos(3);
      omega = vel(3);
      ell   = self.ell;
      rhs   = ell*omega^2*[ 0, 0, sin(theta); ...
                            0, 0, cos(theta) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - b(t,q,v)
    function rhs = b_v( self, t, pos, vel )
      theta = pos(3);
      omega = vel(3);
      ell   = self.ell;
      rhs   = 2*ell*omega*[ 0, 0, -cos(theta); ...
                            0, 0,  sin(theta) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = W_q( self, t, pos, v_dot )
      J = zeros(3,3);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, pos )
      x     = pos(1);
      y     = pos(2);
      theta = pos(3);
      L     = self.ell/2;
      alpha = pi/2-theta;
      x0    = x+L*cos(alpha);
      y0    = y+L*sin(alpha);
      x1    = x-L*cos(alpha);
      y1    = y-L*sin(alpha);

      hold off;
      drawLine(-1.2,0,1.2,0,'LineWidth',2,'Color','k');
      hold on;
      drawLine(0,-1.2,0,1.2,'LineWidth',2,'Color','k');
      drawAxes(2,0.25,1,0,0);

      %drawPoint(1,0.25,x,0);
      %drawPoint(1,0.25,0,y);
      drawLine(x0,y0,x1,y1,'LineWidth',8,'Color','r');
      drawCOG( 0.1, x0, y0 );
      drawCOG( 0.1, x1, y1 );
    end
  end
end
