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
%>      ode = ODE_derived_class() % create an instance of a ODE
%>      res = ode.f(t,x);
%>
classdef ODEbaseClass < handle
  properties (SetAccess = protected, Hidden = true)
    %> the name of the ODE, used in warning/error messages
    name;
  end

  methods (Abstract)
    %>
    %>  Abstract functions. The derived function must define the ODE
    %>  \f$ x' = f( t, x ) \f$
    %>
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    f( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %>  Abstract functions. The derived function must return 
    %>  the jacobian \f$ \partial f( t, x ) / \partial x \f$
    %>
    DfDx( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %>  Abstract functions. The derived function must return 
    %>  the jacobian \f$ \partial f( t, x ) / \partial t \f$
    %>
    DfDt( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Abstract functions. The derived function must return the 
    %> exact solution \f$ x(t) \f$ of the ODE \f$ x' = f( t, x ) \f$
    %> such that \f$ x(t_0) = x_0 \f$.
    %> If exact solution is not available the derived function that return `[]`
    %>
    exact( self, t0, x0, t )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end

  methods
    function self = ODEbaseClass( name )
      %> Construct object with stored `name`
      self.name = name;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
