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
%> 
%> ODE base class describing an ODE
%>
%> *Usage*
%>
%> \rst
%>
%> .. code-block:: matlab
%>
%>      ode = ODE_derived_class() % create an instance of a ODE
%>      res = ode.f(t,x);
%>
%> \endrst
%>
classdef DAC_ODEclass < DAC_base_class
  % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  methods (Abstract)
    %>
    %>  The derived function must define the r.h.s. of the ODE
    %>  \f$ x' = f( t, x ) \f$
    %>  \f$ x \f$ are the states of the model described by the ODE
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    f( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %>  The derived function must return 
    %>  the jacobian of the r.h.s. of the ODE:
    %>  \f$ \partial f( t, x ) / \partial x \f$
    %>  used only in implicit methods
    %>
    DfDx( self, t, x )
  end
  % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  methods
    function self = DAC_ODEclass( name, neq )
      self@DAC_base_class( name, neq )
    end
  end
end
