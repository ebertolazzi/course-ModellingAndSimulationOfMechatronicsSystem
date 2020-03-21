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
function [x,ierr] = NewtonSolver( fun, jac, X0, varargin )
  ierr = 0;
  x    = X0 ;
  if any(isnan(X0))
    fprintf(1, 'NewtonSolver: Bad initial point!\n' ) ;
    ierr = 1;
    return;
  end

  tol     = 1e-8;
  maxiter = 50;

  if nargin > 3
    tol = varargin{1};
  end
  if nargin > 4
    maxiter = varargin{2};
  end

  for niter=1:maxiter
    % direction search
    F  = feval( fun, x );
    JF = feval( jac, x );
    % check if finished
    if norm(F,inf)<tol
      return;
    end
    % evaluate direction search
    d  = JF\F;
    nd = norm(d,2);
    % do line search
    ok    = false;
    alpha = 1;
    for subiter=1:50
      x1 = x - alpha * d;
      if all(isfinite(x1))
        d1 = JF\feval( fun, x1 );
        if norm(d1,2) < sqrt(1-alpha/2)*nd
          ok = true;
          break;
        end
      end
      alpha = alpha/2;
    end
    if ~ok
      fprintf(1, 'NewtonSolver: alpha = %g Failed linesearch!\n', alpha  );
      ierr = 2;
      break;
    end
    x = x1;
    %fprintf(1, 'NewtonSolver[%d]: ||F||_inf = %14g, alpha = %g\n', niter, norm(F,inf), alpha );
    if norm(d,inf)<tol
      return;
    end
  end
end
