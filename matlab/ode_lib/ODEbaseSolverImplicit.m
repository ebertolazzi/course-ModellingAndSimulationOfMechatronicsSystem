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
classdef ODEbaseSolverImplicit < ODEbaseSolver
  properties (SetAccess = protected, Hidden = true)
    x0;
    t0;
    dt;
    tol;
  end
  methods (Abstract)
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  for the implicit methods x(k+1) = Phi( x(k), x(k+1), dt ) 
    %  this function is
    %
    %  residual( x, x0 ) =  x - Phi( x0, x, dt )
    %
    stepResidual( self, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  Jacobian o the residual
    %
    %  D residual( x, x0 ) / Dx =  I - D Phi( x0, x, dt ) / D x
    %
    stepResidualJacobian( self, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = ODEbaseSolverImplicit( solverName )
      self@ODEbaseSolver( solverName );
      self.tol = 1e-8;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  Find x that solve residual( x, x0 ) = 0 by using Newton method
    %
    function x1 = solveStepByNewton( self )
      x1 = self.x0;
      for k=1:10
        F  = self.stepResidual( x1 );
        JF = self.stepResidualJacobian( x1 );
        H  = JF\F;
        x1 = x1 - H;
        if norm(H) < self.tol; break; end
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  Perform an implicit step by solving residual( x, x0 ) = 0
    %
    function x1 = step( self, t0, x0, dt )
      self.t0 = t0;
      self.x0 = x0;
      self.dt = dt;
      x1      = self.solveStepByNewton();
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
