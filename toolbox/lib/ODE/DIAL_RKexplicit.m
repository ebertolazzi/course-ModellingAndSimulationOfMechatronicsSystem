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
%> **explicit** Runge-Kutta integration methods. The user must simply 
%> define the Butcher tableau of the Runge-Kutta method:
%>
%> \rst
%> .. math::
%>
%>   \begin{array}{c|c}
%>     c & A \\
%>     \hline 
%>       & b^T
%>   \end{array}
%>
%> \endrst
%
classdef DIAL_RKexplicit < DIAL_ODEsolver
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
    function this = DIAL_RKexplicit( name, A, b, c, ~ )
      this@DIAL_ODEsolver( name );
      this.m_A = A;
      this.m_b = b;
      this.m_c = c;
      assert( istril(A),   'DIAL_RKexplicit::DIAL_RKexplicit(...): Found Runge-Kutta matrix A not as a lower triangular matrix' );
      assert( isrow(b),    'DIAL_RKexplicit::DIAL_RKexplicit(...): Found Runge-Kutta weights vector b not as a row vector' );
      assert( iscolumn(c), 'DIAL_RKexplicit::DIAL_RKexplicit(...): Found Runge-Kutta nodes vector c vector not as a column vector' );
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
      this.m_b = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the Runge-Kutta nodes vector (column vector)
    %
    function setC( this, in, ~ )
      this.m_c = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %>  Compute an integration step using the **explicit** Runge-Kutta method:
    %>
    %>  \f[
    %>     \begin{array}{rcl}
    %>        x_{k+1} &=& x_k + \displaystyle\sum_{j=1}^s b_j K_j \\
    %>        K_i     &=& h f\left( t_k + c_i \Delta t, x_k + \displaystyle\sum_{j=1}^{i-1} A_{ij} K_j \right),
    %>        \qquad i=1,2,\ldots,s
    %>     \end{array}
    %>  \f]
    %>
    %> - *x_k* States value at \f$ k \f$-th time step \f$ \mathbf{x}(t_k) \f$
    %> - *t_k* Time step \f$ t_k \f$
    %> - *d_t* Advancing time step \f$ \Delta t\f$
    %>
    %> Returns the approximation of \f$ \mathbf{x_{k+1}}(t_{k}+\Delta t) \f$
    %>
    function out = step( this, t_k, x_k, d_t, ~ )
      nx     = length( x_k );
      nc     = length( this.m_c );
      tt     = t_k + d_t * this.m_c;
      K      = zeros( nx, nc );
      K(:,1) = d_t * this.m_ode.f( tt(1), x_k );
      for i = 2:nc
        tmp = x_k;
        for j = 1:i-1
          tmp = tmp + this.m_A(i,j) * K(:,j);
        end
        K(:,i) = d_t * this.m_ode.f( tt(i), tmp );
      end
      out = x_k;
      for i = 1:nc
        out = out + this.m_b(i) * K(:,i);
      end
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
