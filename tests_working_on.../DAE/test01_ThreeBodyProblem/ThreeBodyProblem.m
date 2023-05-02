%> Implementation of the Three Body Problem.
%>
%> **Problem Statement**
%>
%> The equations of motion are derived from the Lagrangian:
%>
%> \rst
%> .. math::
%>
%>   \mathcal{L} =
%>     \frac{1}{2} m_1 (u_1^2 + v_1^2) +
%>     \frac{1}{2} m_2 (u_2^2 + v_2^2) +
%>     \frac{1}{2} m_3 (u_3^2 + v_3^2) -
%>     \frac{G m_1 m_2}{\sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2}} -
%>     \frac{G m_1 m_3}{\sqrt{(x_1 - x_3)^2 + (y_1 - y_3)^2}} -
%>     \frac{G m_2 m_3}{\sqrt{(x_2 - x_3)^2 + (y_2 - y_3)^2}}
%>
%> The equations of motion are then derived by taking the partial derivatives of
%> the Lagrangian with respect to the generalized coordinates and setting them
%> equal to zero. The equations of motion written as a system of first order
%> ODEs are then:
%>
%> \rst
%> .. math::
%>
%>   \begin{cases}
%>      x_1' - u_1 = 0 & \\
%>      x_2' - u_2 = 0 & \\
%>      x_3' - u_3 = 0 & \\
%>      y_1' - v_1 = 0 & \\
%>      y_2' - v_2 = 0 & \\
%>      y_3' - v_3 = 0 & \\
%>      u_1' + G m_2\frac{x_1 - x_2}{d_12^3} + G m_3\frac{x_1 - x_3}{d_13^3} = 0 & \\
%>      u_2' + G m_3\frac{x_2 - x_3}{d_23^3} + G m_1\frac{x_2 - x_1}{d_12^3} = 0 & \\
%>      u_3' + G m_1\frac{x_3 - x_1}{d_13^3} + G m_2\frac{x_3 - x_2}{d_23^3} = 0 & \\
%>      v_1' + G m_2\frac{y_1 - y_2}{d_12^3} + G m_3\frac{y_1 - y_3}{d_13^3} = 0 & \\
%>      v_2' + G m_3\frac{y_2 - y_3}{d_23^3} + G m_1\frac{y_2 - y_1}{d_12^3} = 0 & \\
%>      v_3' + G m_1\frac{y_3 - y_1}{d_13^3} + G m_2\frac{y_3 - y_2}{d_23^3} = 0 & \\
%>   \end{cases}
%>
%> where:
%>
%> \rst
%> .. math::
%>
%>   \begin{cases}
%>      d_12 = \sqrt{(x_1 - x_2)^2 + (y_1 - y_2)^2} & \\
%>      d_13 = \sqrt{(x_1 - x_3)^2 + (y_1 - y_3)^2} & \\
%>      d_23 = \sqrt{(x_2 - x_3)^2 + (y_2 - y_3)^2} & \\
%>   \end{cases}
%>
%> and \f$ G \f$ is the gravitational constant, \f$ m_1 \f$ is the mass of the
%> first body, \f$ m_2 \f$ is the mass of the second body, and \f$ m_3 \f$ is the
%> mass of the third mass. A feasible set of initial conditions for creatinting
%> a stable orbit (infinity shaped like) are:
%>
%> \rst
%> .. math::
%>
%>   \begin{cases}
%>      x_1(0) =  0.97000436 \\
%>      x_2(0) = -0.97000436 \\
%>      x_3(0) =  0.0 \\
%>      y_1(0) = -0.24308753 \\
%>      y_2(0) =  0.24308753 \\
%>      y_3(0) =  0.0 \\
%>      u_1(0) =  \frac{0.93240737}{2} \\
%>      u_2(0) =  \frac{0.93240737}{2} \\
%>      u_3(0) = -0.93240737 \\
%>      v_1(0) =  \frac{0.86473146}{2} \\
%>      v_2(0) =  \frac{0.86473146}{2} \\
%>      v_3(0) = -0.86473146 \\
%>   \end{cases}
%>
%> \endrst
%
classdef ThreeBodyProblem < ODEsystem
  %
  properties (SetAccess = protected, Hidden = true)
    %
    %> Gravitational constant
    %
    m_G;
    %
    %> Body 1 mass
    %
    m_m_1;
    %
    %> Body 2 mass
    %
    m_m_2;
    %
    %> Body 3 mass
    %
    m_m_3;
    %
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function this = ThreeBodyProblem( G, m_1, m_2, m_3 )

      CMD = 'ThreeBodyProblem2D::ThreeBodyProblem2D(...): ';

      % Set the number of equations and the number of invariants
      num_eqns = 12;
      num_invs = 0;

      % Call the superclass constructor
      this@ODEsystem('ThreeBodyProblem2D', num_eqns, num_invs);

      % Check the input arguments
      assert(G > 0, ...
        [CMD, 'gravitational constant must be positive.']);
      assert(m_1 > 0, ...
        [CMD, 'mass 1 must be positive.']);
      assert(m_2 > 0, ...
        [CMD, 'mass 2 must be positive.']);
      assert(m_3 > 0, ...
        [CMD, 'mass 3 must be positive.']);

      this.m_G   = G;
      this.m_m_1 = m_1;
      this.m_m_2 = m_2;
      this.m_m_3 = m_3;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = F( this, x, x_dot, ~ )

      CMD = 'ThreeBodyProblem2D::F(...): ';

      % Check the input arguments
      assert(length(x) == this.m_num_eqns, ...
        [CMD, 'invalid x vector length.']);
      assert(length(x_dot) == this.m_num_eqns, ...
        [CMD, 'invalid x_dot vector length.']);

      % Compute the distances
      d_12 = sqrt((x(1) - x(2))^2 + (x(4) - x(5))^2);
      d_13 = sqrt((x(1) - x(3))^2 + (x(4) - x(6))^2);
      d_23 = sqrt((x(2) - x(3))^2 + (x(5) - x(6))^2);

      % Compute the output
      out = zeros(this.m_num_eqns,1);
      out(1)  = x_dot(1) - x(7);
      out(2)  = x_dot(2) - x(8);
      out(3)  = x_dot(3) - x(9);
      out(4)  = x_dot(4) - x(10);
      out(5)  = x_dot(5) - x(11);
      out(6)  = x_dot(6) - x(12);
      out(7)  = x_dot(7)  + ...
        this.m_G*this.m_m_2*(x(1) - x(2))/d_12^3 + ...
        this.m_G*this.m_m_3*(x(1) - x(3))/d_13^3;
      out(8)  = x_dot(8)  + ...
        this.m_G*this.m_m_3*(x(2) - x(3))/d_23^3 + ...
        this.m_G*this.m_m_1*(x(2) - x(1))/d_12^3;
      out(9)  = x_dot(9)  + ...
        this.m_G*this.m_m_1*(x(3) - x(1))/d_13^3 + ...
        this.m_G*this.m_m_2*(x(3) - x(2))/d_23^3;
      out(10) = x_dot(10) + ...
        this.m_G*this.m_m_2*(x(4) - x(5))/d_12^3 + ...
        this.m_G*this.m_m_3*(x(4) - x(6))/d_13^3;
      out(11) = x_dot(11) + ...
        this.m_G*this.m_m_3*(x(5) - x(6))/d_23^3 + ...
        this.m_G*this.m_m_1*(x(5) - x(4))/d_12^3;
      out(12) = x_dot(12) + ...
        this.m_G*this.m_m_1*(x(6) - x(4))/d_13^3 + ...
        this.m_G*this.m_m_2*(x(6) - x(5))/d_23^3;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function [JF_x, JF_x_dot] = JF( this, x, x_dot, ~ )

      CMD = 'ThreeBodyProblem2D::JF(...): ';

      % Check the input arguments
      assert(length(x) == this.m_num_eqns, ...
        [CMD, 'invalid x vector length.']);
      assert(length(x_dot) == this.m_num_eqns, ...
        [CMD, 'invalid x_dot vector length.']);

      % Compute the distances
      d_12 = sqrt((x(1) - x(2))^2 + (x(4) - x(5))^2);
      d_13 = sqrt((x(1) - x(3))^2 + (x(4) - x(6))^2);
      d_23 = sqrt((x(2) - x(3))^2 + (x(5) - x(6))^2);

      % Compute the output Jacobians of the three body problem state above
      JF_x_dot = eye(this.m_num_eqns);

      JF_x = [ ...
        0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0; ...
        0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0; ...
        0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0; ...
        0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0; ...
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0; ...
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1; ...
        this.m_G*this.m_m_2/d_12^3 - 3/2*this.m_G*this.m_m_2*(x(1) - x(2))*(2*x(1) - 2*x(2))/d_12^5 + this.m_G*this.m_m_3/d_13^3 - 3/2*this.m_G*this.m_m_3*(x(1) - x(3))*(2*x(1) - 2*x(3))/d_13^5, -this.m_G*this.m_m_2/d_12^3 - 3/2*this.m_G*this.m_m_2*(x(1) - x(2))*(2*x(2) - 2*x(1))/d_12^5, -this.m_G*this.m_m_3/d_13^3 - 3/2*this.m_G*this.m_m_3*(x(1) - x(3))*(2*x(3) - 2*x(1))/d_13^5, -3/2*this.m_G*this.m_m_2*(x(1) - x(2))*(2*x(4) - 2*x(5))/d_12^5 - 3/2*this.m_G*this.m_m_3*(x(1) - x(3))*(2*x(4) - 2*x(6))/d_13^5, -3/2*this.m_G*this.m_m_2*(x(1) - x(2))*(2*x(5) - 2*x(4))/d_12^5, -3/2*this.m_G*this.m_m_3*(x(1) - x(3))*(2*x(6) - 2*x(4))/d_13^5, 0, 0, 0, 0, 0, 0; ...
        -this.m_G*this.m_m_1/d_12^3 - 3/2*this.m_G*this.m_m_1*(x(2) - x(1))*(2*x(1) - 2*x(2))/d_12^5, this.m_G*this.m_m_3/d_23^3 - 3/2*this.m_G*this.m_m_3*(x(2) - x(3))*(2*x(2) - 2*x(3))/d_23^5 + this.m_G*this.m_m_1/d_12^3 - 3/2*this.m_G*this.m_m_1*(x(2) - x(1))*(2*x(2) - 2*x(1))/d_12^5, -this.m_G*this.m_m_3/d_23^3 - 3/2*this.m_G*this.m_m_3*(x(2) - x(3))*(2*x(3) - 2*x(2))/d_23^5, -3/2*this.m_G*this.m_m_1*(x(2) - x(1))*(2*x(4) - 2*x(5))/d_12^5, -3/2*this.m_G*this.m_m_3*(x(2) - x(3))*(2*x(5) - 2*x(6))/d_23^5 - 3/2*this.m_G*this.m_m_1*(x(2) - x(1))*(2*x(5) - 2*x(4))/d_12^5, -3/2*this.m_G*this.m_m_3*(x(2) - x(3))*(2*x(6) - 2*x(5))/d_23^5, 0, 0, 0, 0, 0, 0; ...
        -this.m_G*this.m_m_1/d_13^3 - 3/2*this.m_G*this.m_m_1*(x(3) - x(1))*(2*x(1) - 2*x(3))/d_13^5, -this.m_G*this.m_m_2/d_23^3 - 3/2*this.m_G*this.m_m_2*(x(3) - x(2))*(2*x(2) - 2*x(3))/d_23^5, this.m_G*this.m_m_1/d_13^3 - 3/2*this.m_G*this.m_m_1*(x(3) - x(1))*(2*x(3) - 2*x(1))/d_13^5 + this.m_G*this.m_m_2/d_23^3 - 3/2*this.m_G*this.m_m_2*(x(3) - x(2))*(2*x(3) - 2*x(2))/d_23^5, -3/2*this.m_G*this.m_m_1*(x(3) - x(1))*(2*x(4) - 2*x(6))/d_13^5, -3/2*this.m_G*this.m_m_2*(x(3) - x(2))*(2*x(5) - 2*x(6))/d_23^5, -3/2*this.m_G*this.m_m_1*(x(3) - x(1))*(2*x(6) - 2*x(4))/d_13^5 - 3/2*this.m_G*this.m_m_2*(x(3) - x(2))*(2*x(6) - 2*x(5))/d_23^5, 0, 0, 0, 0, 0, 0; ...
        -3/2*this.m_G*this.m_m_2*(x(4) - x(5))*(2*x(1) - 2*x(2))/d_12^5 - 3/2*this.m_G*this.m_m_3*(x(4) - x(6))*(2*x(1) - 2*x(3))/d_13^5, -3/2*this.m_G*this.m_m_2*(x(4) - x(5))*(2*x(2) - 2*x(1))/d_12^5, -3/2*this.m_G*this.m_m_3*(x(4) - x(6))*(2*x(3) - 2*x(1))/d_13^5, this.m_G*this.m_m_2/d_12^3 - 3/2*this.m_G*this.m_m_2*(x(4) - x(5))*(2*x(4) - 2*x(5))/d_12^5 + this.m_G*this.m_m_3/d_13^3 - 3/2*this.m_G*this.m_m_3*(x(4) - x(6))*(2*x(4) - 2*x(6))/d_13^5, -this.m_G*this.m_m_2/d_12^3 - 3/2*this.m_G*this.m_m_2*(x(4) - x(5))*(2*x(5) - 2*x(4))/d_12^5, -this.m_G*this.m_m_3/d_13^3 - 3/2*this.m_G*this.m_m_3*(x(4) - x(6))*(2*x(6) - 2*x(4))/d_13^5, 0, 0, 0, 0, 0, 0; ...
        -3/2*this.m_G*this.m_m_1*(x(5) - x(4))*(2*x(1) - 2*x(2))/d_12^5, -3/2*this.m_G*this.m_m_3*(x(5) - x(6))*(2*x(2) - 2*x(3))/d_23^5 - 3/2*this.m_G*this.m_m_1*(x(5) - x(4))*(2*x(2) - 2*x(1))/d_12^5, -3/2*this.m_G*this.m_m_3*(x(5) - x(6))*(2*x(3) - 2*x(2))/d_23^5, -this.m_G*this.m_m_1/d_12^3 - 3/2*this.m_G*this.m_m_1*(x(5) - x(4))*(2*x(4) - 2*x(5))/d_12^5, this.m_G*this.m_m_3/d_23^3 - 3/2*this.m_G*this.m_m_3*(x(5) - x(6))*(2*x(5) - 2*x(6))/d_23^5 + this.m_G*this.m_m_1/d_12^3 - 3/2*this.m_G*this.m_m_1*(x(5) - x(4))*(2*x(5) - 2*x(4))/d_12^5, -this.m_G*this.m_m_3/d_23^3 - 3/2*this.m_G*this.m_m_3*(x(5) - x(6))*(2*x(6) - 2*x(5))/d_23^5, 0, 0, 0, 0, 0, 0; ...
        -3/2*this.m_G*this.m_m_1*(x(6) - x(4))*(2*x(1) - 2*x(3))/d_13^5, -3/2*this.m_G*this.m_m_2*(x(6) - x(5))*(2*x(2) - 2*x(3))/d_23^5, -3/2*this.m_G*this.m_m_1*(x(6) - x(4))*(2*x(3) - 2*x(1))/d_13^5 - 3/2*this.m_G*this.m_m_2*(x(6) - x(5))*(2*x(3) - 2*x(2))/d_23^5, -this.m_G*this.m_m_1/d_13^3 - 3/2*this.m_G*this.m_m_1*(x(6) - x(4))*(2*x(4) - 2*x(6))/d_13^5, -this.m_G*this.m_m_2/d_23^3 - 3/2*this.m_G*this.m_m_2*(x(6) - x(5))*(2*x(5) - 2*x(6))/d_23^5, this.m_G*this.m_m_1/d_13^3 - 3/2*this.m_G*this.m_m_1*(x(6) - x(4))*(2*x(6) - 2*x(4))/d_13^5 + this.m_G*this.m_m_2/d_23^3 - 3/2*this.m_G*this.m_m_2*(x(6) - x(5))*(2*x(6) - 2*x(5))/d_23^5, 0, 0, 0, 0, 0, 0 ...
        ];
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function H( ~, ~, ~ )
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function JH( ~, ~, ~ )
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
