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
classdef Pendulum5EQ < ODEbaseClass
  properties (SetAccess = protected, Hidden = true)
    ell;
    gravity;
  end
  methods
    function self = Pendulum5EQ( ell, gravity )
      self@ODEbaseClass('Pendulum5E');
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

      jac(5,1) = ((4 * lambda * u * x ^ 2) + 0.6e1 * (0.4e1 / 0.3e1 * y * lambda + g) * v * x - (4 * lambda * u * y ^ 2)) / ((x ^ 2 + y ^ 2) ^ 2);
      jac(5,2) = (8 * lambda * u * x * y - 4 * lambda * v * x ^ 2 + 4 * y ^ 2 * lambda * v + 6 * g * v * y) / (x ^ 2 + y ^ 2) ^ 2;
      jac(5,3) = -4 * lambda * x / (x ^ 2 + y ^ 2);
      jac(5,4) = (-4 * y * lambda - 3 * g) / (x ^ 2 + y ^ 2);
      jac(5,5) = (-4 * x * u - 4 * y * v) / (x ^ 2 + y ^ 2);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = DfDt( self, t, x )
      res = zeros(5,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = exact( self, t0, x0, t )
      res = [];
    end
  end
end
