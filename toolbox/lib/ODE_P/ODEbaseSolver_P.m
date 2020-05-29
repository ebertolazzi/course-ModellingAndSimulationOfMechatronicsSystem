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
classdef ODEbaseSolver_P < handle
  properties (SetAccess = protected, Hidden = true)
    solverName;      % should contain the name of the numerical method used
    odeClass;        % the object storing the ODE with invariants
  end

  methods (Abstract)
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  step is a generic advancing step for a generic numerical methods
    %
    %  given x0 = x(t0) return the approximation of x(t0+dt)
    %
    step( self, x0, t0, dt )
  end

  methods
    function self = ODEbaseSolver_P( solverName )
      self.solverName = solverName;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function name = getName( self )
      name = self.solverName
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function setODE( self, odeClass )
      self.odeClass = odeClass;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  Solve the problem
    %
    %  minimize      1/2 * (x-xtilde)^2
    %  subject to    h( t, x ) = 0
    %
    %  Given the Lagrangian
    %
    %  L( x, lambda ) = 1/2 * (x-xtilde)^2 + lambda * h( t, x )
    %
    %  solve the problem
    %
    %   x + DhDx( t, x )^T lambda = xtilde
    %   h( t, x ) = 0
    %
    %  using the approximation
    %  { h( t_k, x_k ) + DhDx( t_k, x_k ) Dx + O( dx^2 ) = 0 }
    %  define the iterative method
    %
    %  x_{k+1} = x_k + dx
    %
    %  where dx is the solution of the linear system
    %
    %  /       I            DhDx( t_k, x_k )^T \ /   dx   \   / xtilde - x_k  \
    %  |                                       | |        | = |               |
    %  \ DhDx( t_k, x_k )          0           / \ lambda /   \ -h( t_k, x_k) /
    %
    function x = project( self, t, xtilde )
      [neq,ninv] = self.odeClass.getDim();
      x = xtilde;
      if ninv > 0
        tol = max(1,norm(xtilde,inf))*sqrt(eps);
        for k=1:10
          h   = self.odeClass.h( t, x );
          M   = self.odeClass.DhDx( t, x );
          Dxl = [ eye(neq), M.'; M, zeros(ninv,ninv) ] \ [ xtilde - x;-h];
          dx  = Dxl(1:neq);
          x   = x + dx;
          if (max(abs(dx)) < tol) && (max(abs(h)) < tol)
            break;
          end
        end
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  compute approximate solution on a series of point given by the vector t
    %  starting at initial point x0
    %
    function x = advance( self, t, x0 )
      x      = zeros(length(x0),length(t));
      x(:,1) = x0(:);
      for k=1:length(t)-1
        % advance
        xtilde   = self.step( t(k), x(:,k), t(k+1)-t(k) );
        % project solution to the invariants
        x(:,k+1) = self.project( t(k+1), xtilde );
      end
    end
  end
end
