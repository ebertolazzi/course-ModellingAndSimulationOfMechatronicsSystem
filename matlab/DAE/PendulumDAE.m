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
    function J = Phi_q( self, t, pos )
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
