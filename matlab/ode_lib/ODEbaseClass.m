%
% Matlab code for the Course:
%
%     Modelling and Simulation Mechatronics System
%
% by
% Enrico Bertolazzi
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
classdef ODEbaseClass < handle
  properties (SetAccess = protected, Hidden = true)
    name;
  end

  methods (Abstract)
    %
    %  Abstract functions defining and ODE
    %
    %  x' = f( t, x )
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    f( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  return jacobian Df( t, x ) / Dx 
    %
    DfDx( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  return jacobian Df( t, x ) / Dt
    %
    DfDt( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  return exact solution x(t) such that x(t0) = x0
    %  if exact solution is not available define the function that return NaN
    %
    exact( self, t0, x0, t )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end

  methods
    function self = ODEbaseClass( name )
      self.name = name;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
