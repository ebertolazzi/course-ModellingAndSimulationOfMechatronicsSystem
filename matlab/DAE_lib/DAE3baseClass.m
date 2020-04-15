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
classdef DAE3baseClass < handle
  properties (SetAccess = protected, Hidden = true)
    name;
    npv; % number of position/velocity coordinates
    nc;  % number of constraints
  end

  methods (Abstract)
    %
    %  Abstract functions defining an index-3 DAE
    %
    %  p' = v
    %  M(t,p) v' + Phi_p(t,p)^T lambda = f( t, p, v )
    %  Phi_p(t,p) = 0
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    M( self, t, p )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Phi( self, t, p )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    dPhiDt( self, t, p )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Phi_p( self, t, p )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    f( self, t, p, v )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d Phi(t,q) / dt     = Phi_q(t,q) v
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
    B( self, t, p, v )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end

  methods
    function self = DAE3baseClass( name, npv, nc )
      self.name = name;
      self.npv  = npv;
      self.nc   = nc;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function [n,m] = getDim( self )
      n = self.npv; % number of position/velocity coordinates
      m = self.nc;  % number of constraints
    end
  end
end
