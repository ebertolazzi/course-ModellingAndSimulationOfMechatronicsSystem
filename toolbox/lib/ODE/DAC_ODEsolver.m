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
classdef DAC_ODEsolver < handle
  properties (SetAccess = protected, Hidden = true)
    %>
    %> Should contain the name of the numerical method used
    %>
    solverName; 
    %>
    %> The object storing the ODE
    %>
    odeClass;
  end

  methods (Abstract)
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Generic advancing step for a generic numerical methods.
    %>
    %> Given `x0` = \f$ \mathbf{x}(t_0) \f$ and an advancing
    %> time step `dt` = \f$ \Delta t\f$
    %> return the approximation of \f$ \mathbf{x}(t_0+\Delta t) \f$.
    %>
    step( self, x0, t0, dt )
  end

  methods
    function self = DAC_ODEsolver( solverName )
      self.solverName = solverName;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Return the name of the numerical method used to advance solution
    %>
    function name = getName( self )
      name = self.solverName;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Set the ODE class used in the advancing step
    %>
    function setODE( self, odeClass )
      self.odeClass = odeClass;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Solve the problem
    %>
    %> \f[ \left\{\begin{array}{ll}
    %>  \textrm{minimize}   &  \frac{1}{2}\left(\mathbf{x}-\widetilde{\mathbf{x}}\right)^2 \\[1em]
    %>  \textrm{subject to} &  \mathbf{h}( t, \mathbf{x} ) = \mathbf{0}
    %> \end{array}\right. \f]
    %>
    %> Given the Lagrangian
    %>
    %> \f[
    %> L( \mathbf{x}, \boldsymbol{\lambda} ) = 
    %> \frac{1}{2}\left(\mathbf{x}-\widetilde{\mathbf{x}}\right)^2+
    %> \boldsymbol{\lambda} \cdot \mathbf{h}( t, \mathbf{x} )
    %> \f]
    %>
    %> Solve the problem
    %>
    %> \f[ \left\{\begin{array}{rcl}
    %> \mathbf{x}+\dfrac{\partial \mathbf{h}(t,\mathbf{x})}{\partial\mathbf{x}}^T
    %> \boldsymbol{\lambda} &=& \widetilde{\mathbf{x}}\\[1em]
    %> \mathbf{h}(t,\mathbf{x}) &=& \mathbf{0}
    %> \end{array}\right. \f]
    %>
    %> **Solution algorithm**
    %>
    %> Using the Taylor expansion
    %>
    %> \f[ \mathbf{h}( t, \mathbf{x} ) +
    %> \dfrac{\partial \mathbf{h}(t,\mathbf{x})}{\partial\mathbf{x}} \delta\mathbf{x}
    %> + \mathcal{O}\left( ||\delta\mathbf{x}||^2 \right) = \mathbf{0}
    %> \f]
    %>
    %> define the iterative method
    %>
    %> \f[ \mathbf{x}_{k+1} = \mathbf{x}_k + \delta\mathbf{x} \f]
    %>
    %> where \f$ \delta\mathbf{x} \f$ is the solution of the linear system
    %>
    %> \f[
    %> \left[\begin{array}{cc}
    %> \mathbf{I} & \dfrac{\partial \mathbf{h}(t,\mathbf{x})}{\partial\mathbf{x}}^T \\[1em]
    %> \dfrac{\partial \mathbf{h}(t,\mathbf{x})}{\partial\mathbf{x}}  & \mathbf{0}
    %> \end{array}\right]
    %> \left[\begin{array}{c}
    %> \delta\mathbf{x} \\[1em]
    %> \boldsymbol{\lambda}
    %> \end{array}\right]
    %> = 
    %> \left[\begin{array}{c}
    %> \widetilde{\mathbf{x}}-\mathbf{x}_k \\[1em]
    %> -\mathbf{h}(t_k,\mathbf{x}_k)
    %> \end{array}\right]
    %> \f]
    %>
    function x = project( self, t, xtilde )
      % get number of equations and number of invariants 
      [neq,ninv] = self.odeClass.getDims();
      x = xtilde;
      if ninv > 0
        tol = max(1,norm(xtilde,inf))*sqrt(eps);
        for k=1:10
          %
          %  /       I       DhDx( t_k, x_k )^T \ /   dx   \   / xtilde - x_k  \
          %  |                                  | |        | = |               |
          %  \ DhDx( t_k, x_k )     0           / \ lambda /   \ -h( t_k, x_k) /
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
    %>
    %> Compute approximate solution on a series of point given by the
    %> vector `t` = \f$ [t_0, t_1, \ldots, t_n] \f$
    %> starting at initial point `x0` =  \f$ x_0 \f$.
    %>
    %> - `t` vector of sampling points 
    %> - `x0` initial point
    %> - `optional1` if true apply projection to invariants at each step
    %> - `optional2` if true activate vebose mode and print advancing messages
    %> - `optional3` maxabs, if \f$ || \mathbf{x} ||_{\infty} \f$ is greater than maxabs computation is interrupted
    %>
    %> return a matrix `length(x0) x length(t)` with the solution.
    %>
    %> **Usage**
    %>
    %> \rst
    %>
    %> .. code-block:: matlab
    %>
    %>    sol = obj.advance( t, x0 );
    %>    plot( t, sol(1,:) ); % plot the first component of the solution
    %>
    %>    % advance with projection on invariants activated
    %>    sol = obj.advance( t, x0, true );
    %>
    %>    % advance with projection on invariants inactiva and verbose
    %>    sol = obj.advance( t, x0, false, true );
    %>
    %> \endrst
    %>
    function x = advance( self, t, x0, varargin )
      neq = self.odeClass.getNeq();
      if neq ~= length(x0)
        error('length(x0) = %d expected %d\n',length(x0),neq);
      end
      if nargin > 3
        do_projection = varargin{1};
      else
        do_projection = false;
      end
      if nargin > 4
        verbose = varargin{2};
      else
        verbose = false;
      end
      if nargin > 5
        maxabs = varargin{3};
      else
        maxabs = 1e3;
      end
      x      = zeros(neq,length(t));
      x(:,1) = x0(:);
      pp     = 0;
      nn     = length(t)-1;
      for k=1:nn
        if verbose
          newpp = ceil(100*k/nn);
          if newpp > pp+4
            pp = newpp;
            fprintf('%3d%%\n',pp);
          end
        end
        DT = t(k+1)-t(k);
        if do_projection
          % advance solution
          xtilde = self.step( t(k), x(:,k), DT );
          % project solution to the invariants
          xnew = self.project( t(k+1), xtilde );
        else
          % advance solution
          xnew = self.step( t(k), x(:,k), DT );
        end
        xinf = norm(xnew,inf);
        if xinf > maxabs
          fprintf('At t(%d)=%g ||x||_inf = %g, computation interrupted\n',k,t(k),xinf);
          break;
        end
        x(:,k+1) = xnew;
      end
    end
  end
end
