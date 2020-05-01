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
classdef Pendulum3D_DAE < DAE3baseClassImplicit
  properties (SetAccess = protected, Hidden = true)
    m;
    ell;
    gravity;
  end
  methods
    function self = Pendulum3D_DAE( mass, gravity, ell )
      self@DAE3baseClassImplicit('Pendulum3D_DAE',3,1);
      self.m       = mass;
      self.gravity = gravity;
      self.ell     = ell;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function Mass = M( self, t, pos )
      m    = self.m;
      Mass = [ m, 0, 0; ...
               0, m, 0; ...
               0, 0, m];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = Phi( self, t, pos )
      x   = pos(1);
      y   = pos(2);
      z   = pos(3);
      ell = self.ell;
      rhs = x^2+y^2+z^2-ell^2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = Phi_t( self, t, pos )
      J = zeros(1,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = Phi_q( self, t, pos )
      x = pos(1);
      y = pos(2);
      z = pos(3);
      J = 2*[x,y,z];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiL_q( self, t, pos, lambda )
      H = 2*lambda(1)*eye(3);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiV_q( self, t, pos, v_dot )
      H = 2*[ v_dot(1), 0,        0; ...
              0,        v_dot(2), 0; ...
              0,        0,        v_dot(3) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = W_q( self, t, pos, v_dot )
      J = zeros(3,3);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce( self, t, pos, vel )
      m       = self.m;
      gravity = self.gravity;
      rhs     = [0;0;-m*gravity];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_q( self, t, pos, vel )
      rhs     = zeros(3,3);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_v( self, t, pos, vel )
      rhs     = zeros(3,3);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
    function rhs = b( self, t, pos, vel )
      rhs = -2*dot(vel,vel);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
    function rhs = b_q( self, t, pos, vel )
      rhs = zeros(1,3);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
    function rhs = b_v( self, t, pos, vel )
      rhs = -4*vel;
    end
  end
end
