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
classdef BiralDAE1 < DAE3baseClass
  properties (SetAccess = protected, Hidden = true)
    m;
    gravity;
    ell;
    Iz;
  end

  methods
    function self = BiralDAE1( m, gravity, ell, Iz )
      % 3 pos/vel, 2 constraints
      self@DAE3baseClass('BiralDAE1',3,2);
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
    function rhs = f( self, ~, ~, ~ )
      m       = self.m;
      gravity = self.gravity;
      rhs     = [0;-m*gravity;0];
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
    function rhs = dPhiDt( self, t, pos, vel )
      x     = pos(1);
      y     = pos(2);
      theta = pos(3);
      vx    = vel(1);
      vy    = vel(2);
      omega = vel(3);
      ell   = self.ell;
      rhs   = [ 2*vy + ell*sin(theta)*omega; ...
                2*vx + ell*cos(theta)*omega];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = Phi_p( self, t, p )
      x     = p(1);
      y     = p(2);
      theta = p(3);
      ell   = self.ell;
      % theta1, theta2, x1, y1, x2, y2
      J = [ 0, 2, ell*sin(theta); ...
            2, 0, ell*cos(theta) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
    function rhs = B( self, t, p, v )
      theta = p(3);
      omega = v(3);
      ell   = self.ell;
      rhs   = ell*omega^2*[ -cos(theta); sin(theta) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
