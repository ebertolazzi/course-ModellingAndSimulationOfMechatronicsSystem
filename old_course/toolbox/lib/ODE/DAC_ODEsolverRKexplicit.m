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
%> advancing using **explicit** Runge-Kutta methods.
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
classdef DAC_ODEsolverRKexplicit < DAC_ODEsolver
  properties (SetAccess = protected, Hidden = true)
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
    function self = DAC_ODEsolverRKexplicit( solverName, A, b, c )
      self@DAC_ODEsolver( solverName );
      self.A = A;
      self.b = b;
      self.c = c;
      % some check
      for i=1:size(A,1)-1
        for j=i+1:size(A,2)
          if A(i,j) ~= 0
            error( sprintf('find A(%d,%d) = %g ~= in the tableau A\n',i,j,A(i,j) ) );
          end
        end
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %>  Advance using the **explicit** RK methods
    %>
    %>  \f[
    %>     \begin{array}{rcl}
    %>        x_{k+1} &=& x_k + \displaystyle\sum_{j=1}^s b_j K_j \\
    %>        K_i     &=& h f\left( t_k + c_i \Delta t, x_k + \displaystyle\sum_{j=1}^{i-1} A_{ij} K_j \right),
    %>        \qquad i=1,2,\ldots,s
    %>     \end{array}
    %>  \f]
    %>
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
