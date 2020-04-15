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
classdef PendulumDAE < DAE3baseClass
  properties (SetAccess = protected, Hidden = true)
    m;
    ell;
    gravity;
  end
  methods
    function self = PendulumDAE( mass, gravity, ell )
      self@DAE3baseClass('PendulumDAE',2,1);
      self.m       = mass;
      self.gravity = gravity;
      self.ell     = ell;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function Mass = M( self, t, pos )
      m    = self.m;
      Mass = [ m, 0; ...
               0, m ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = f( self, t, pos, vel )
      m       = self.m;
      gravity = self.gravity;
      rhs     = [ 0; -m*gravity ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = Phi( self, t, pos )
      x   = pos(1);
      y   = pos(2);
      ell = self.ell;
      rhs = x^2 + y^2 - ell^2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = dPhiDt( self, t, pos, vel )
      x   = pos(1);
      y   = pos(2);
      vx  = vel(1);
      vy  = vel(2);
      rhs = 2*(x*vx+y*vy);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = Phi_p( self, t, pos )
      x = pos(1);
      y = pos(2);
      J = 2*[x,y];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
    function rhs = B( self, t, pos, vel )
      vx  = vel(1);
      vy  = vel(2);
      rhs = -2*(vx^2+vy^2);
    end
  end
end
