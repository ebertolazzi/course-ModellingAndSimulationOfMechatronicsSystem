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
%>
%> Class implementing the abstract function `step` for the 
%> advancing using **implicit** Runge-Kutta methods.
%> The user must simply define the Tableau of the Runge-Kutta method
%>
%> \rst
%> .. math::
%>
%>    \begin{array}{c|c}
%>       c & A \\
%>       \hline 
%>         & b^T
%>    \end{array}
%>
%> \endrst
%>
%> The advancing for the ODE \f$ x'=f(t,x) \f$ is done as follows
%>
%> \f[
%>     \begin{array}{rcl}
%>        x_{k+1} &=& x_k + \displaystyle\sum_{j=1}^s b_j K_j \\
%>        K_i     &=& h f\left( t_k + c_i \Delta t, x_k + \displaystyle\sum_{j=1}^s A_{ij} K_j \right),
%>        \qquad i=1,2,\ldots,s
%>     \end{array}
%> \f]
%>
%> where the coefficients \f$ \mathbf{K} = (K_1,K_2,\ldots,K_s)^T \f$ are the solution of 
%> \f$ \mathbf{F}(\mathbf{K}) = \mathbf{0} \f$ the nonlinear system
%>
%> \f[
%>     \mathbf{F}(\mathbf{K}) = 
%>     \left\{\begin{array}{rcl}
%>        F_1(K_1,K_2,\ldots,K_s) &=& 0, \\
%>        F_2(K_1,K_2,\ldots,K_s) &=& 0, \\
%>        &\vdots& \\
%>        F_s(K_1,K_2,\ldots,K_s) &=& 0,
%>     \end{array}\right.
%> \f]
%>
%> where
%>
%> \f[
%>     \begin{array}{rcl}
%>        F_1(K_1,K_2,\ldots,K_s) &=& K_1-h f\left( t_k + c_1 \Delta t, x_k + \displaystyle\sum_{j=1}^s A_{1j} K_j \right), \\
%>        F_2(K_1,K_2,\ldots,K_s) &=& K_2-h f\left( t_k + c_1 \Delta t, x_k + \displaystyle\sum_{j=1}^s A_{2j} K_j \right), \\
%>        &\vdots& \\    
%>        F_s(K_1,K_2,\ldots,K_s) &=& K_s-h f\left( t_k + c_s \Delta t, x_k + \displaystyle\sum_{j=1}^s A_{sj} K_j \right),
%>     \end{array}
%> \f]
%>
classdef DAC_ODEsolverRKimplicit < DAC_ODEsolver
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
    %>
    %> Initialize the class withe the name of the method
    %> and the tableau.
    %>
    function self = DAC_ODEsolverRKimplicit( solverName, A, b, c )
      self@DAC_ODEsolver( solverName );
      self.tol = 1e-8;
      self.A   = A;
      self.b   = b;
      self.c   = c;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Compute the residual \f$ \mathbf{F}(\mathbf{K}) \f$.
    %>
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
    %>
    %> Compute the Jacobian of the residual \f$ \mathbf{F}(\mathbf{K}) \f$:
    %>
    %> \f[ \frac{\partial\mathbf{F}(\mathbf{K})}{\partial \mathbf{K}} \f].
    %>
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
    %>
    %> Solve the implicit step \f$ \mathbf{F}(\mathbf{K})=\mathbf{0} \f$ by Newton method
    %>
    %> \f[ \mathbf{K}^{\ell+1} = \mathbf{K}^{\ell} -
    %>     \left(\frac{\partial\mathbf{F}(\mathbf{K}^{\ell})}{\partial \mathbf{K}}\right)^{-1}\mathbf{F}(\mathbf{K}^{\ell}) \f].
    %>
    function K = solveStepByNewton( self )
      ns  = length( self.c );
      K0  = self.dt * self.odeClass.f( self.t0, self.x0 );
      K   = repmat( K0(:), ns, 1);
      fun = @(K) self.stepResidual( K );
      jac = @(K) self.stepResidualJacobian( K );
      [K,ierr] = NewtonSolver( fun, jac, K );
      if ierr ~= 0
        fprintf( 1, 'solveStepByNewton do not converge ierr = %d\n', ierr );
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  Perform an implicit step by solving the residual \f$ \mathbf{F}(\mathbf{K})=\mathbf{0} \f$
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
