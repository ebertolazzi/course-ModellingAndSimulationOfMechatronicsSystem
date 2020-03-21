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
classdef ODEbaseSolverRKexplicit < ODEbaseSolver
  properties (SetAccess = protected, Hidden = true)
    A; % tableau
    b;
    c;
  end
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = ODEbaseSolverRKexplicit( solverName, A, b, c )
      self@ODEbaseSolver( solverName );
      self.A = A;
      self.b = b;
      self.c = c;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  for the explicit RK methods
    %
    %  x(k+1) = x(k) + sum(j) b(j) * K(k)
    %
    %  K(i) = h*f( t(k) + c(i) * dt, x(k) + sum(j) A(i,j) K(j) ), i=1..s
    %
    function x1 = step( self, t0, x0, dt )
      nx     = length( x0 );
      ns     = length( self.c );
      tt     = t0 + dt * self.c;
      K      = zeros( nx, ns );
      K(:,1) = dt * self.odeClass.f( tt(1), x0 );
      for i=2:ns
        tmp = x0;
        for j=1:i-1
          tmp = tmp + self.A(i,j) * K(:,j);
        end
        K(:,i) = dt * self.odeClass.f( tt(i), tmp );
      end
      x1 = x0;
      for i=1:ns
        x1 = x1 + self.b(i) * K(:,i);
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end

end
