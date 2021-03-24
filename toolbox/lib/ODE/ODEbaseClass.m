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
classdef ODEbaseClass < handle
  properties (SetAccess = protected, Hidden = true)
    name; %> the name of the ODE, used in warning/error messages
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
    %> \param self matlab sintactic sugar, ignore it
    %> \param t0   \f$ t_0 \f$
    %> \param x0   \f$ x_0 \f$
    %> \param t    \f$ t \f$
    %>
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
      %> Delete object
    end
  end
end
