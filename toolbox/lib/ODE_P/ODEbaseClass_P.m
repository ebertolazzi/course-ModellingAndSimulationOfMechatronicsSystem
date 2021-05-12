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
classdef ODEbaseClass_P < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    ninv; % number of invariants (may be 0)
  end

  methods (Abstract)
    %
    %  Abstract functions defining and ODE
    %
    %  x' = f( t, x ) + invariants
    %
    %  h( t, x ) = 0
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  the rhs of the ODE f( t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    f( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  return jacobian Df( t, x ) / Dx
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    DfDx( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  return jacobian Df( t, x ) / Dt
    DfDt( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % the invariant/hidden constraints h( t, x ) = 0
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    h( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  return jacobian Dh( t, x ) / Dx
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    DhDx( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  return jacobian Dh( t, x ) / Dt
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    DhDt( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end

  methods
    function self = ODEbaseClass_P( name, neq, ninv )
      self@DAC_ODEclass( name, neq )
      self.ninv = ninv;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function [neq,ninv] = getDim( self )
      neq  = self.neq;
      ninv = self.ninv;
    end
  end
end
