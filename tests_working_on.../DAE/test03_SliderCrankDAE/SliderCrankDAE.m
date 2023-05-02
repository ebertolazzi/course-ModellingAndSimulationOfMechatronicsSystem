% Class container for the non-linear pendulum (DAE version)
classdef SliderCrankDAE < ODEsystem
  %
  properties (SetAccess = protected, Hidden = true)
    m_Ta;  % Constant torque applied to the crank (Nm)
    m_w;   % Constant rotational speed of the crank (1/(rad s))
    m_m;   % Crank mass (kg)
    m_l;   % Crank length (m)
    m_g;   % Gravity acceleration (m/x(3)^2)
    m_X_0; % Initial conditions
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function this = SliderCrankDAE( Ta, w, m, l, g, X_0 )

      CMD = 'SliderCrankDAE::SliderCrankDAE(...): ';

      % Set the number of equations and the number of invariants
      num_eqns = 9;
      num_invs = 0;

      % Call the superclass constructor
      this@ODEsystem('SliderCrankDAE', num_eqns, num_invs);

      % Check the input arguments
      assert(m > 0, ...
        [CMD, 'crank mass must be positive.']);
      assert(l > 0, ...
        [CMD, 'crank length must be positive.']);
      assert(g > 0, ...
        [CMD, 'gravity acceleration must be positive.']);
      assert(length(X_0) == num_eqns, ...
        [CMD, 'invalid initial conditions vector size.']);

      this.m_Ta  = Ta;
      this.m_w   = w;
      this.m_m   = m;
      this.m_l   = l;
      this.m_g   = g;
      this.m_X_0 = X_0;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = F( this, x, x_dot, t )
      out = [x_dot(1) - x(4);
             x_dot(2) - x(5);
              x_dot(3) - x(6);
              0.2e1 * x_dot(5) * this.m_l ^ 2 * this.m_m * cos(-x(2) + x(1)) + 0.2e1 * x(5) ^ 2 * this.m_l ^ 2 * this.m_m * sin(-x(2) + x(1)) + 0.7e1 / 0.3e1 * this.m_l ^ 2 * this.m_m * x_dot(4) + 0.5e1 / 0.2e1 * (this.m_g * this.m_m - 0.2e1 / 0.5e1 * x(8)) * this.m_l * cos(x(1)) + sin(x(1)) * this.m_l * x(7) + x(9) - this.m_Ta;
              0.2e1 * this.m_l * (this.m_m * this.m_l * x_dot(4) * cos(-x(2) + x(1)) - this.m_m * x(4) ^ 2 * this.m_l * sin(-x(2) + x(1)) + 0.4e1 / 0.3e1 * x_dot(5) * this.m_l * this.m_m + (this.m_g * this.m_m - x(8)) * cos(x(2)) + sin(x(2)) * x(7));
              0.3e1 * x_dot(6) * this.m_m + x(7);
              -cos(x(1)) * this.m_l - 0.2e1 * this.m_l * cos(x(2)) + x(3);
              -this.m_l * (0.2e1 * sin(x(2)) + sin(x(1)));
              -t * this.m_w + x(1)];
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function [JF_x, JF_x_dot] = JF( this, x, x_dot, ~ )
      JF_x = [0 0 0 -1 0 0 0 0 0;
              0 0 0 0 -1 0 0 0 0;
              0 0 0 0 0 -1 0 0 0;
              -0.2e1 * x_dot(5) * this.m_l ^ 2 * this.m_m * sin(-x(2) + x(1)) + 0.2e1 * x(5) ^ 2 * this.m_l ^ 2 * this.m_m * cos(-x(2) + x(1)) - 0.5e1 / 0.2e1 * (this.m_g * this.m_m - 0.2e1 / 0.5e1 * x(8)) * this.m_l * sin(x(1)) + cos(x(1)) * this.m_l * x(7) 0.2e1 * x_dot(5) * this.m_l ^ 2 * this.m_m * sin(-x(2) + x(1)) - 0.2e1 * x(5) ^ 2 * this.m_l ^ 2 * this.m_m * cos(-x(2) + x(1)) 0 0 0.4e1 * x(5) * this.m_l ^ 2 * this.m_m * sin(-x(2) + x(1)) 0 sin(x(1)) * this.m_l -cos(x(1)) * this.m_l 1;
              0.2e1 * this.m_l * (-this.m_m * this.m_l * x_dot(4) * sin(-x(2) + x(1)) - this.m_m * x(4) ^ 2 * this.m_l * cos(-x(2) + x(1))) 0.2e1 * this.m_l * (this.m_m * this.m_l * x_dot(4) * sin(-x(2) + x(1)) + this.m_m * x(4) ^ 2 * this.m_l * cos(-x(2) + x(1)) - (this.m_g * this.m_m - x(8)) * sin(x(2)) + cos(x(2)) * x(7)) 0 -0.4e1 * this.m_l ^ 2 * this.m_m * x(4) * sin(-x(2) + x(1)) 0 0 0.2e1 * this.m_l * sin(x(2)) -0.2e1 * this.m_l * cos(x(2)) 0;
              0 0 0 0 0 0 1 0 0;
              sin(x(1)) * this.m_l 0.2e1 * this.m_l * sin(x(2)) 1 0 0 0 0 0 0;
              -cos(x(1)) * this.m_l -0.2e1 * this.m_l * cos(x(2)) 0 0 0 0 0 0 0;
              1 0 0 0 0 0 0 0 0];

      JF_x_dot = [1 0 0 0 0 0 0 0 0;
                  0 1 0 0 0 0 0 0 0;
                  0 0 1 0 0 0 0 0 0;
                  0 0 0 0.7e1 / 0.3e1 * this.m_l ^ 2 * this.m_m 0.2e1 * this.m_l ^ 2 * this.m_m * cos(-x(2) + x(1)) 0 0 0 0;
                  0 0 0 0.2e1 * this.m_l ^ 2 * this.m_m * cos(-x(2) + x(1)) 0.8e1 / 0.3e1 * this.m_l ^ 2 * this.m_m 0 0 0 0;
                  0 0 0 0 0 0.3e1 * this.m_m 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0;
                  0 0 0 0 0 0 0 0 0];

    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = H( this, ~, ~ )

    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = JH( this, ~, ~ )

    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
end
