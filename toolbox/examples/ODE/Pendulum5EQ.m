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
classdef Pendulum5EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    ell;
    gravity;
  end
  methods
    function self = Pendulum5EQ( ell, gravity )
      self@DAC_ODEclass('Pendulum5E');
      self.ell     = ell;
      self.gravity = gravity;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function ode = f( self, t, Z )
      x      = Z(1);
      y      = Z(2);
      u      = Z(3);
      v      = Z(4);
      lambda = Z(5);
      g      = self.gravity;
      ell    = self.ell;
      ode    = zeros(5,1);
      ode(1) = u;
      ode(2) = v;
      ode(3) = -lambda*x;
      ode(4) = -lambda*y-g;
      ode(5) = -(4*lambda*(x*u+y*v)+3*v*g)/(x^2+y^2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DfDx( self, t, Z )
      x      = Z(1);
      y      = Z(2);
      u      = Z(3);
      v      = Z(4);
      lambda = Z(5);
      g      = self.gravity;
      ell    = self.ell;
      jac      = zeros(5,5);
      jac(1,3) = 1;
      jac(2,4) = 1;
      jac(3,1) = -lambda;
      jac(3,5) = -x;
      jac(4,2) = -lambda;
      jac(4,5) = -y;

      tmp  = x ^ 2 + y ^ 2;
      tmp2 = tmp^2;
      tmp3 = ( 6 * g * v) / tmp2;
      tmp4 = x ^ 2 - y ^ 2;
      xy   = x*y;

      jac(5,1) = lambda*( 8 * v * xy + 4 * u * tmp4 ) / tmp2 + tmp3 * x;
      jac(5,2) = lambda*( 8 * u * xy - 4 * v * tmp4 ) / tmp2 + tmp3 * y;
      jac(5,3) = -4 * lambda * x / tmp;
      jac(5,4) = (-4 * y * lambda - 3 * g) / tmp;
      jac(5,5) = -4*(x * u+y * v) / tmp;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
      tt = 0:pi/30:2*pi;
      xx = self.ell*cos(tt);
      yy = self.ell*sin(tt);
      hold off;
      plot(xx,yy,'LineWidth',2,'Color','red');
      x  = Z(1);
      y  = Z(2);
      LL = 1-self.ell/hypot(x,y);
      x0 = LL*x;
      y0 = LL*y;
      hold on;
      L = 1.5*self.ell;
      drawLine(-L,0,L,0,'LineWidth',2,'Color','k');
      drawLine(0,-L,0,L,'LineWidth',2,'Color','k');
      drawAxes(2,0.25,1,0,0);
      drawLine(x0,y0,x,y,'LineWidth',8,'Color','b');
      drawCOG( 0.1*self.ell, x0, y0 );
      fillCircle( 'r', x, y, 0.1*self.ell );
      axis([-L L -L L]);
      axis equal;
    end
  end
end
