% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%                                                                     %
% The DIAL project - Course of MECHATRONICS SYSTEM SIMULATION         %
%                                                                     %
% Copyright (c) 2020, Davide Stocco and Enrico Bertolazzi, Francesco  %
% Biral                                                               %
%                                                                     %
% The DIAL project and its components are supplied under the terms of %
% the open source BSD 2-Clause License. The contents of the DIAL      %
% project and its components may not be copied or disclosed except in %
% accordance with the terms of the BSD 2-Clause License.              %
%                                                                     %
% URL: https://opensource.org/licenses/BSD-2-Clause                   %
%                                                                     %
%    Davide Stocco                                                    %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: davide.stocco@unitn.it                                   %
%                                                                     %
%    Enrico Bertolazzi                                                %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: enrico.bertolazzi@unitn.it                               %
%                                                                     %
%    Francesco Biral                                                  %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: francesco.biral@unitn.it                                 %
%                                                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%
%> Class container for the system of Ordinary Differential Equations (ODEs)
%> or Differential Algebraic Equations (DAEs) solver
%
classdef DIAL_ODEsolver < handle
  %
  properties (SetAccess = protected, Hidden = true)
    %
    %> Name of the used numerical integration method
    %
    m_solver; 
    %
    %> System of ODEs to be integrated
    %
    m_ode;
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Class constructor
    %
    function this = DIAL_ODEsolver( solver, ~ )
      this.m_solver = solver;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Get the name of the numerical method used to advance solution
    %
    function out = getSolver( this, ~ )
      out = this.m_solver;
    end
   %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Get the system of ODEs to be integrated
    %
    function out = getODE( this, ~ )
      out = this.m_ode;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the name of the numerical method used to integrate the system of ODEs
    %
    function setSolver( this, in, ~ )
      this.m_solver = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the system of ODEs to be integrated
    %
    function setODE( this, in, ~ )
      this.m_ode = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
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
    %
    function out = project( this, t, x_tilde )
      neqn = this.m_ode.getNeqn();
      ninv = this.m_ode.getNinv();
      out    = x_tilde;
      if ninv > 0
        tol = max(1,norm(x_tilde,inf)) * sqrt(eps);
        for k = 1:10
          %
          %  /       I       DhDx( t_k, x_k )^T \ /   dx   \   / x_tilde - x_k \
          %  |                                  | |        | = |               |
          %  \ DhDx( t_k, x_k )     0           / \ lambda /   \  -h(t_k, x_k) /
          %
          h    = this.m_ode.h( t, out );
          DhDx = this.m_ode.DhDx( t, out );
          dxL  = [ eye(neqn), DhDx.'; DhDx, zeros(ninv,ninv) ] \ [ x_tilde-out; -h ];
          dx   = dxL(1:neqn);
          out  = out + dx;
          if max(abs(dx)) < tol && max(abs(h)) < tol
            break;
          end
        end
      end
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Integrate the system of ODEs and calculate the approximate solution:
    %>
    %> - *t*       Time vector
    %> - *x_0*     Initial states value
    %> - *project* [optional, default = false] Apply projection to invariants at each step
    %> - *verbose* [optional, default = false] Activate vebose mode and print integration messages
    %> - *maxabs*  [optional, default = 1.0e3] If \f$ || \mathbf{x} ||_{\infty} \f$ is greater than maxabs computation is interrupted
    %>
    %> Returns a matrix `length(x0) x length(t)` containing the solution
    %>
    %> **Usage**
    %>
    %> \rst
    %> .. code-block:: matlab
    %>
    %>    % Advance without the solution projection on invariants and disabled verbose mode
    %>    sol = obj.advance( t, x_0 );
    %>
    %>    % Advance with the solution projection on invariants and disabled verbose mode
    %>    sol = obj.advance( t, x_0, true );
    %>
    %>    % Advance without the solution projection on invariants and enabled verbose mode
    %>    sol = obj.advance( t, x_0, false, true );
    %>
    %>     % Plot the first component of the solution
    %>     plot( t, sol(1,:) );
    %>
    %> \endrst
    %
    function out = integrate( this, t, x_i, varargin )

      neqn = this.m_ode.getNeqn();
      if neqn ~= length(x_i)
        error( 'DIAL_ODEsolver::integrate( %s ): length(x_i) = %d expected %d', this.m_solver, length(x_i), neqn );
      end
      
      if nargin > 3
        project = varargin{1};
      else
        project = false;
      end
      
      if nargin > 4
        verbose = varargin{2};
      else
        verbose = false;
      end
      
      if nargin > 5
        maxabs = varargin{3};
      else
        maxabs = 1.0e3;
      end
      
      out      = zeros( neqn, length(t) );
      out(:,1) = x_i(:);
      perc     = 0.0;
      nt       = length(t)-1;
      for k = 1:nt
        if verbose
          newpp = ceil(100*k/nt);
          if newpp > perc+4
            perc = newpp;
            fprintf( '%3d%%\n', perc );
          end
        end

        % Integrate system of ODEs
        xnew = this.step( t(k), out(:,k), t(k+1)-t(k) );

        % Project solution to the invariants
        if project
          xnew = this.project( t(k+1), xnew );
        end

        % Check the norm of the projected solution
        normxnew = norm( xnew, inf );
        if normxnew > maxabs
          fprintf( 'DIAL_ODEsolver::integrate( %s ): At t(%d) = %g, ||x||_inf = %g, computation interrupted\n', this.m_solver, k, t(k), normxnew );
          break;
        end
        out(:,k+1) = xnew;
      end
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
  methods (Abstract)
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Generic advancing step for a generic numerical integration method:
    %>
    %> - *x_k* States value at \f$ k \f$-th time step \f$ \mathbf{x}(t_k) \f$
    %> - *t_k* Time step \f$ t_k \f$
    %> - *d_t* Advancing time step \f$ \Delta t\f$
    %>
    %> Returns the approximation of \f$ \mathbf{x_{k+1}}(t_{k}+\Delta t) \f$
    %
    step( this, x_k, t_k, d_t )
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
