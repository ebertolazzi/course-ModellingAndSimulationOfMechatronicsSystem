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
%> Implementation of the ODE (Pendulum)
%>
%> \rst
%> .. math::
%> 
%>   \begin{cases}
%>      \theta' = \omega & \\
%>      \omega' = -\displaystyle\frac{g}{\ell}\sin\theta &
%>   \end{cases}
%>
%> \endrst
%
classdef Pendulum2EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    %> ray of the circle (constraint)
    ell;
    %> gravity constant
    gravity;
  end
  methods
    function self = Pendulum2EQ( ell, gravity )
      self@DAC_ODEclass('Pendulum2EQ');
      self.ell     = ell;
      self.gravity = gravity;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function ode = f( self, t, Z )
      theta  = Z(1);
      omega  = Z(2);
      g      = self.gravity;
      ell    = self.ell;
      ode    = zeros(2,1);
      ode(1) = omega;
      ode(2) = -(g/ell)*sin(theta);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DfDx( self, t, Z )
      theta    = Z(1);
      omega    = Z(2);
      g        = self.gravity;
      ell      = self.ell;
      jac      = zeros(2,2);
      jac(1,2) = 1;
      jac(2,1) = -(g/ell)*cos(theta);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
      theta = Z(1);
      omega = Z(2);
      x  = self.ell*sin(theta);
      y  = -self.ell*cos(theta);
      x0 = 0;
      y0 = 0;
      tt = 0:pi/30:2*pi;
      xx = self.ell*cos(tt);
      yy = self.ell*sin(tt);
      hold off;
      plot(xx,yy,'LineWidth',2,'Color','red');
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
