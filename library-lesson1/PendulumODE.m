% Class container for the non-linear pendulum (ODE version)
classdef PendulumODE < Indigo.Systems.Implicit
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
    function this = PendulumODE( m, l, g, X_0 )

      CMD = 'PendulumODE::PendulumODE(...): ';

      % Set the number of equations and the number of invariants
      num_eqns = 2;
      num_invs = 1;
      num_veil = 0;

      % Call the superclass constructor
      this@Indigo.Systems.Implicit('PendulumODE', num_eqns, num_veil, num_invs);

      % Check the input arguments
      assert(m > 0, [CMD, 'pendulum mass must be positive.']);
      assert(l > 0, [CMD, 'pendulum length must be positive.']);
      assert(g > 0, [CMD, 'gravity acceleration must be positive.']);
      assert(length(X_0) == num_eqns, [CMD, 'invalid initial conditions vector size.']);

      this.m_m   = m;
      this.m_l   = l;
      this.m_g   = g;
      this.m_X_0 = X_0;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = F( this, x, x_dot, ~, ~ )

      % extract parameters
      theta = x(1);
      omega = x(2);

      theta_dot = x_dot(1);
      omega_dot = x_dot(2);

      g = this.m_g;
      l = this.m_l;

      % Evaluate the system
      out    = [ theta_dot - omega; omega_dot + (g/l) * sin(theta) ];
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function res = JF_x( this, x, ~, ~, ~ )

      % extract parameters
      theta = x(1);
      omega = x(2);

      g = this.m_g;
      l = this.m_l;

      % Evaluate the system Jacobians
      res      = zeros(2,2);
      res(1,2) = -1.0;
      res(2,1) = (g/l) * cos(theta);
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function res = JF_x_dot( this, x, ~, ~, ~ )
      res = eye(2);
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function res = JF_v( this, x, ~, ~, ~ )
      res = zeros( this.m_num_eqns, this.m_num_veils );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = h( this, x, ~, ~ )

      % extract parameters
      theta = x(1,:);
      omega = x(2,:);

      m  = this.m_m;
      g  = this.m_g;
      l  = this.m_l;
      x0 = this.m_X_0;

      % Evaluate the system invariant
      out = -m.*g.*l.*(cos(theta) - cos(x0(1))) + 0.5.*m.*l^2.*(omega.^2 - x0(2)^2);
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = Jh_x( this, x, ~, ~ )

      % extract parameters
      theta = x(1,:);
      omega = x(2,:);

      m  = this.m_m;
      g  = this.m_g;
      l  = this.m_l;
      x0 = this.m_X_0;

      % Evaluate the system gradient of the invariant
      out = [m.*g.*l.*sin(theta), m.*l^2.*omega];
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = Jh_v( this, x, ~, ~ )
      % Evaluate the system gradient of the invariant
      out = zeros( this.m_num_invs, this.m_num_veil );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = Jv_x( this, ~, ~ )
      % Evaluate the system gradient of the invariant
      out = zeros( this.m_num_veil, this.m_num_eqns );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = v( this, ~, ~ )
      % Evaluate the system gradient of the invariant
      out = zeros( this.m_num_veil, 1 );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
