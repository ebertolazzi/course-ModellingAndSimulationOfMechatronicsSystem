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
classdef PendulumDAE < DAE3baseClassImplicit
  properties (SetAccess = protected, Hidden = true)
    m;
    ell;
    gravity;
  end
  methods
    function self = PendulumDAE( mass, gravity, ell )
      self@DAE3baseClassImplicit('PendulumDAE',2,1);
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
    function rhs = Phi( self, t, pos )
      x   = pos(1);
      y   = pos(2);
      ell = self.ell;
      rhs = x^2 + y^2 - ell^2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = Phi_t( self, t, pos )
      rhs = zeros(1,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = Phi_q( self, t, pos )
      x = pos(1);
      y = pos(2);
      J = 2*[x,y];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiL_q( self, t, pos, lambda )
      H = 2*lambda(1)*eye(2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiV_q( self, t, pos, v_dot )
      H = 2*[ v_dot(1), 0; ...
              0,        v_dot(2) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = W_q( self, t, pos, v_dot )
      J = zeros(2,2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce( self, t, pos, vel )
      m       = self.m;
      gravity = self.gravity;
      rhs     = [ 0; -m*gravity ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_q( self, t, pos, vel )
      rhs = zeros(2,2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_v( self, t, pos, vel )
      rhs = zeros(2,2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - b(t,q,v)
    function rhs = b( self, t, pos, vel )
      vx  = vel(1);
      vy  = vel(2);
      rhs = -2*(vx^2+vy^2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = b_q( self, t, pos, vel )
      rhs = zeros(1,2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = b_v( self, t, pos, vel )
      vx  = vel(1);
      vy  = vel(2);
      rhs = -4*eye(2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, pos )
      x  = pos(1);
      y  = pos(2);
      dL = 1-self.ell/hypot(x,y);

      x0 = x*dL;
      y0 = y*dL;

      hold off;
      drawLine(-1.2,0,1.2,0,'LineWidth',2,'Color','k');
      hold on;
      drawLine(0,-1.2,0,1.2,'LineWidth',2,'Color','k');
      drawAxes(2,0.25,1,0,0);

      %drawPoint(1,0.25,x,0);
      %drawPoint(1,0.25,0,y);
      drawLine(x0,y0,x,y,'LineWidth',8,'Color','r');
      drawCOG( 0.1, x0, y0 );
      drawDonut( 0.05, 0.1, x, y );
    end
  end
end
