% Class container for the non-linear pendulum (DAE version)
classdef PendulumDAE < ODEsystem
  %
  properties (SetAccess = protected, Hidden = true)
    m_m;   % Pendulum mass (kg)
    m_l;   % Pendulum length (m)
    m_g;   % Gravity acceleration (m/s^2)
    m_X_0; % Initial conditions
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function this = PendulumDAE( m, l, g, X_0 )

      CMD = 'PendulumDAE::PendulumDAE(...): ';

      % Set the number of equations and the number of invariants
      num_eqns = 5;
      num_invs = 1;

      % Call the superclass constructor
      this@ODEsystem('PendulumODE', num_eqns, num_invs);

      % Check the input arguments
      assert(m > 0, ...
        [CMD, 'pendulum mass must be positive.']);
      assert(l > 0, ...
        [CMD, 'pendulum length must be positive.']);
      assert(g > 0, ...
        [CMD, 'gravity acceleration must be positive.']);
      assert(length(X_0) == num_eqns, ...
        [CMD, 'invalid initial conditions vector size.']);

      this.m_m   = m;
      this.m_l   = l;
      this.m_g   = g;
      this.m_X_0 = X_0;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = F( this, x, x_dot, ~ )
      out    = zeros(5,1);

      out(1) = x_dot(1) - x(3);
      out(2) = x_dot(2) - x(4);
      out(3) = this.m_m * x_dot(3) + x(5) * x(1);
      out(4) = this.m_m * x_dot(4) + x(5) * x(2) + this.m_m * this.m_g;
      out(5) = x(1)^2 + x(2)^2 - this.m_l^2;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function [JF_x, JF_x_dot] = JF( this, x, ~, ~ )
      JF_x     = zeros(5,5);
      JF_x_dot = zeros(5,5);

      JF_x(1,3) = -1;
      JF_x(2,4) = -1;
      JF_x(3,1) = x(5);
      JF_x(3,5) = x(1);
      JF_x(4,2) = x(5);
      JF_x(4,5) = x(2);
      JF_x(5,1) = 2*x(1);
      JF_x(5,2) = 2*x(2);

      JF_x_dot(1,1) = 1;
      JF_x_dot(2,2) = 1;
      JF_x_dot(3,3) = this.m_m;
      JF_x_dot(4,4) = this.m_m;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = H( this, x, ~ )

      CMD = 'PendulumODE::H(...): ';

      % Check the input arguments
      assert(size(x,1) == this.m_num_eqns, ...
        [CMD, 'invalid x vector length.']);

      % Evaluate the system invariant
      out = this.m_m.*this.m_g.*this.m_l.*(x(2,:) - this.m_X_0(2)) + ...
            0.5.*this.m_m.*this.m_l.*( ...
              x(3,:).^2 - this.m_X_0(3)^2 + x(4,:).^2 - this.m_X_0(4)^2 ...
            );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = JH( this, x, ~ )

      CMD = 'PendulumODE::JH(...): ';

      % Check the input arguments
      assert(size(x,1) == this.m_num_eqns, ...
        [CMD, 'invalid x vector length.']);

      % Evaluate the system gradient of the invariant
      out = [zeros(1,size(x,2)), ...
             this.m_m.*this.m_g.*this.m_l, ...
             this.m_m.*this.m_l.*x(3,:), ...
             this.m_m.*this.m_l.*x(4,:), ...
             zeros(1,size(x,2))];
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
end
