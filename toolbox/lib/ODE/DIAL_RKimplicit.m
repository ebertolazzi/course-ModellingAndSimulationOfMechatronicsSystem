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
%> Class implementing the abstract function `step` for the 
%> advancing using **implicit** Runge-Kutta methods.
%> The user must simply define the Tableau of the Runge-Kutta method:
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
%> The advancing for the ODE \f$ x'=f(t,x) \f$ is done as follows:
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
%
classdef DIAL_RKimplicit < DIAL_ODEsolver
  %
  properties (SetAccess = protected, Hidden = true)
    %
    %> Runge-Kutta matrix
    %
    m_A;
    %
    %> Runge-Kutta weights vector (row vector)
    %
    m_b;
    %
    %> Runge-Kutta nodes vector (column vector)
    %
    m_c;
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Initialize the class with the method name and the Butcher tableau
    %>
    %> - *A* Runge-Kutta matrix
    %> - *b* Runge-Kutta weights vector (row vector)
    %> - *c* Runge-Kutta nodes vector (column vector)
    %
    function this = DIAL_RKimplicit( name, A, b, c , ~)
      assert( isrow(b),    'DIAL_RKimplicit::DIAL_RKimplicit(...): Found Runge-Kutta weights vector b not as a row vector' );
      assert( iscolumn(c), 'DIAL_RKimplicit::DIAL_RKimplicit(...): Found Runge-Kutta nodes vector c vector not as a column vector' );
      this@DIAL_ODEsolver( name );
      this.m_A = A;
      this.m_b = b;
      this.m_c = c;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Get the Runge-Kutta matrix
    %
    function out = getA( this, ~ )
      out = this.m_A;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Get the Runge-Kutta weights vector (row vector)
    %
    function out = getB( this, ~ )
      out = this.m_b;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Get the Runge-Kutta nodes vector (column vector)
    %
    function out = getC( this, ~ )
      out = this.m_c;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the Runge-Kutta matrix
    %
    function setA( this, in, ~ )
      this.m_A = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the Runge-Kutta weights vector (row vector)
    %
    function setB( this, in, ~ )
      assert( isrow(in), 'DIAL_RKimplicit::setB(...): Found Runge-Kutta weights vector b not as a row vector' );
      this.m_b = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the Runge-Kutta nodes vector (column vector)
    %
    function setC( this, in, ~ )
      assert( iscolumn(c), 'DIAL_RKimplicit::setC(...): Found Runge-Kutta nodes vector c vector not as a column vector' );
      this.m_c = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Compute the step residual \f$ \mathbf{F}(\mathbf{K}) \f$
    %
    function R = stepResidual( this, K, t_k, x_k, d_t, ~ )
      nc  = length(this.m_c);
      nx  = length(x_k);
      R   = zeros(nc*nx, 1);
      idx = 1:nx;
      for i = 1:nc
        tmp = x_k;
        jdx = 1:nx;
        for j = 1:nc
          tmp = tmp + this.m_A(i,j) * K(jdx);
          jdx = jdx + nx;
        end
        R(idx) = K(idx) - d_t * this.m_ode.f( t_k + this.m_c(i) * d_t, tmp );
        idx    = idx + nx;
      end
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Compute the Jacobian of \f$ \mathbf{F}(\mathbf{K}) \f$:
    %>
    %> \f[ \frac{\partial\mathbf{F}(\mathbf{K})}{\partial \mathbf{K}} \f].
    %
    function JR = stepJacobian( this, K, t_k, x_k, d_t, ~ )
      A   = this.m_A;
      c   = this.m_c;
      nc  = length(this.m_c);
      nx  = length(x_k);
      JR  = eye(nc*nx);
      idx = 1:nx;
      for i = 1:nc
        tmp = x_k;
        jdx = 1:nx;
        for j = 1:nc
          tmp = tmp + A(i,j) * K(jdx);
          jdx = jdx + nx;
        end
        ti  = t_k + c(i) * d_t;
        jdx = 1:nx;
        for j = 1:nc
          JR(idx,jdx) = JR(idx,jdx) - d_t * A(i,j)*this.m_ode.DfDx( ti, tmp );
          jdx = jdx + nx;
        end
        idx = idx + nx;
      end
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Solve the implicit step \f$ \mathbf{F}(\mathbf{K})=\mathbf{0} \f$ by Newton method
    %>
    %> \f[ \mathbf{K}^{\ell+1} = \mathbf{K}^{\ell} -
    %>     \left(\frac{\partial\mathbf{F}(\mathbf{K}^{\ell})}{\partial \mathbf{K}}\right)^{-1}\mathbf{F}(\mathbf{K}^{\ell}) \f].
    %
    function K = solveStep( this, t_k, x_k, d_t, ~ )
      ns  = length( this.m_c );
      K_0  = d_t * this.m_ode.f( t_k, x_k );
      K   = repmat( K_0(:), ns, 1);
      fun = @(K) this.stepResidual( K, t_k, x_k, d_t );
      jac = @(K) this.stepJacobian( K, t_k, x_k, d_t );
      [K, ierr] = NewtonSolver( fun, jac, K );
      if ierr ~= 0
        fprintf( 1, 'DIAL_RKimplicit::solveStep(...): Not converged flag = %d!\n', ierr );
      end
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Perform an implicit step by solving the residual \f$ \mathbf{F}(\mathbf{K})=\mathbf{0} \f$
    %
    function out = step( this, t_k, x_k, d_t, ~ )
      K   = this.solveStep( t_k, x_k, d_t );
      out = x_k + reshape( K, length(x_k), length(this.m_c) ) * this.m_b(:);
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end