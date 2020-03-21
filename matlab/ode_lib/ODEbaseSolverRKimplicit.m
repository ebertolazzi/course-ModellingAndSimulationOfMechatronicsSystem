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
classdef ODEbaseSolverRKimplicit < ODEbaseSolver
  properties (SetAccess = protected, Hidden = true)
    x0;
    t0;
    dt;
    tol;
    A; % tableau
    b;
    c;
  end
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = ODEbaseSolverRKimplicit( solverName, A, b, c )
      self@ODEbaseSolver( solverName );
      self.tol = 1e-8;
      self.A   = A;
      self.b   = b;
      self.c   = c;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  for the implicit RK methods
    %
    %  x(k+1) = x(k) + sum(j) b(j) * K(k)
    %
    %  K(i) = h*f( t(k) + c(i) * dt, x(k) + sum(j) A(i,j) K(j) ), i=1..s
    %
    %  define the nonlinear system
    %
    %                  / K(1) - h * f( t(k)+c(1)*dt, x(k) + sum(j) A(1,j) K(j) ) \
    %  residual( K ) = | ....                                                    |
    %                  \ K(s) - h * f( t(k)+c(s)*dt, x(k) + sum(j) A(s,j) K(j) ) /
    %
    %
    function R = stepResidual( self, K )
      ns  = length(self.c);
      nx  = length(self.x0);
      R   = zeros(ns*nx,1);
      idx = 1:nx;
      for i=1:ns
        tmp = self.x0;
        jdx = 1:nx;
        for j=1:ns
          tmp = tmp + self.A(i,j) * K(jdx);
          jdx = jdx + nx;
        end
        ti     = self.t0 + self.c(i) * self.dt;
        R(idx) = K(idx) - self.dt * self.odeClass.f( ti, tmp );
        idx    = idx + nx;
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  Jacobian o the residual
    %
    %  D residual( K ) / DK
    %
    function JR = stepResidualJacobian( self, K )
      ns  = length(self.c);
      nx  = length(self.x0);
      JR  = eye(ns*nx);
      idx = 1:nx;
      for i=1:ns
        tmp = self.x0;
        jdx = 1:nx;
        for j=1:ns
          tmp = tmp + self.A(i,j) * K(jdx);
          jdx = jdx + nx;
        end
        ti = self.t0 + self.c(i) * self.dt;
        jdx = 1:nx;
        for j=1:ns
          JR(idx,jdx) = JR(idx,jdx) - self.dt * self.odeClass.DfDx( ti, tmp );
          jdx = jdx + nx;
        end
        idx = idx + nx;
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function K = solveStepByNewton( self )
      ns = length( self.c );
      K0 = self.dt * self.odeClass.f( self.t0, self.x0 );
      K  = repmat( K0(:), ns, 1);
      fun = @(K) self.stepResidual( K );
      jac = @(K) self.stepResidualJacobian( K );
      [K,ierr] = NewtonSolver( fun, jac, K );
      if ierr ~= 0
        fprintf( 1, 'solveStepByNewton do not converge ierr = %d\n', ierr );
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  Perform an implicit step by solving residual( x, x0 ) = 0
    %
    function x1 = step( self, t0, x0, dt )
      self.t0 = t0;
      self.x0 = x0;
      self.dt = dt;
      ns  = length(self.c);
      nx  = length(x0);
      K   = self.solveStepByNewton();
      x1  = x0 + reshape( K, nx, ns ) * self.b(:);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end

end
