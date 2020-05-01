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
%%addpath('../ode_lib');
classdef Pendulum2EQ < ODEbaseClass
  properties (SetAccess = protected, Hidden = true)
    ell;
    gravity;
  end
  methods
    function self = Pendulum2EQ( ell, gravity )
      self@ODEbaseClass('Pendulum2EQ');
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
    function res = DfDt( self, t, x )
      res = zeros(2,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = exact( self, t0, x0, t )
      res = []; % no exact solution
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
