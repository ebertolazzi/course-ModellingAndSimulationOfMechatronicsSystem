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
%> Implementation of ODE for testing order
%>
%> \rst
%> .. math::
%> 
%>   \begin{cases}
%>      x' = x+y  & \quad x(0)=0 \\
%>      y' = -x+y & \quad y(0)=1
%>   \end{cases}
%>
%> \endrst
%
classdef test2eq < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
  end
  methods
    function self = test2eq()
      neq  = 2;
      ninv = 0;
      self@DAC_ODEclass('text2eq',neq,ninv);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function ode = f( self, t, Z )
      x      = Z(1);
      y      = Z(2);
      ode    = zeros(2,1);
      ode(1) = x+y;
      ode(2) = -x+y;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DfDx( self, t, Z )
      jac = [ 1, 1; -1, 1];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function ode = h( self, t, Z )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DhDx( self, t, Z )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = exact( self, t )
      res = [ exp(t).*sin(t); exp(t).*cos(t) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
    end
  end
end
