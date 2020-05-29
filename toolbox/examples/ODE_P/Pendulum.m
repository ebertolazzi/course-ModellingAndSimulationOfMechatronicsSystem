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
%%addpath('../ode_lib');
classdef Pendulum < ODEbaseClass_P
  properties (SetAccess = protected, Hidden = true)
    gravity;
    m;
    L;
  end
  methods
    function self = Pendulum( data )
      self@ODEbaseClass_P('Pendulum',4,2); % 8 equation 4 invariant
      self.gravity = data.gravity;
      self.m       = data.m;
      self.L       = data.L;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function M = Mass( self, t, vars__ )
      M = diag([self.m,self.m]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__Phi = Phi( self, t, vars__ )
      L = self.L;
      % extract states
      x = vars__(1);
      y = vars__(2);

      % evaluate function
      t1 = L ^ 2;
      t2 = x ^ 2;
      t3 = y ^ 2;
      res__1 = -t1 + t2 + t3;

      % store on output
      res__Phi = zeros(1,1);
      res__Phi(1) = res__1;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__DPhiDp = DPhiDp( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      % evaluate function
      jac__1_1 = 2 * x;
      jac__1_2 = 2 * y;
      % store on output
      jac__DPhiDp = zeros(1,2);
      jac__DPhiDp(1,1) = jac__1_1;
      jac__DPhiDp(1,2) = jac__1_2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__Phi_t = DPhiDt( self, t, vars__ )
      jac__Phi_t = zeros(1,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function A_res = A( self, t, vars__ )
      % extract states
      npos = self.neq/2;
      pos = vars__(1:npos);
      vel = vars__(npos+1:end);
      A_res = self.DPhiDp( t, pos ) * vel + self.DPhiDt( t, pos );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__A = DADp( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      % evaluate function
      jac__1_1 = 2 * u;
      jac__1_2 = 2 * v;
      % store on output
      jac__A = zeros(1,2);
      jac__A(1,1) = jac__1_1;
      jac__A(1,2) = jac__1_2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__A = DADt( self, t, vars__ )
      jac__A = zeros(1,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function B_res = B( self, t, vars__ )
      % extract states
      npos = self.neq/2;
      %pos = vars__(1:npos);
      vel = vars__(npos+1:end);
      B_res = -(self.DADp( t, vars__ ) * vel + self.DADt( t, vars__ ));
    end
    function res__gfun = gfun( self, t, vars__ )
      g = self.gravity;
      m = self.m;
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      % evaluate function
      res__2 = -m * g;
      % store on output
      res__gfun = zeros(2,1);
      res__gfun(2) = res__2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % interface function
    %            /   v   \
    % f(t,p,v) = |       |
    %            \ v_dot /
    function res__ode = f( self, t, vars__ )
      npos = self.neq/2;
      pos = vars__(1:npos);
      vel = vars__(npos+1:end);
      g        = self.gravity;
      %------
      Phi_P    = self.DPhiDp( t, pos );
      mass     = self.Mass( t, pos );
      %
      %  / M      Phi_P^T \ / v_dot  \    / g(t,p,v) \
      %  |                | |         | = |          |
      %  \ Phi_P    0     / \ lambda /    \ B(t,p,v) /
      %
      M        = [ mass, Phi_P.'; Phi_P, zeros(1,1) ];
      rhs      = [ self.gfun( t, vars__ ); self.B( t, vars__ )];
      sol      = M\rhs;
      v_dot    = sol(1:npos);
      res__ode = [ vel; v_dot ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % interface function
    function jac__jode = DfDx( self, t, vars__ )
      npos     = self.neq/2;
      pos      = vars__(1:npos);
      vel      = vars__(npos+1:end);
      g        = self.gravity;
      Phi_P    = self.DPhiDp( t, pos );
      mass     = self.Mass( t, pos );
      M        = [ mass, Phi_P.'; Phi_P, zeros(1,1) ];
      rhs      = [ self.gfun( t, vars__ ); self.B( t, vars__ )];
      sol      = M\rhs;
      vars_dot = sol(1:2);
      lambda1  = sol(3);

      %
      %  / M      Phi_P^T \     d   / v_dot  \      d    / H(t,p,v,v_dot,lambda) \
      %  |                |  ------ |         | = ------ |                       |
      %  \ Phi_P    0     /  d{p,v} \ lambda /    d{p,v} \ W(t,p,v,v_dot)        /
      %
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      u_dot = vars_dot(1);
      v_dot = vars_dot(2);

      jac__1_1 = -2 * lambda1;
      jac__2_2 = jac__1_1;

      % store on output
      jac__Hx = zeros(2,4);
      jac__Hx(1,1) = jac__1_1;
      jac__Hx(2,2) = jac__2_2;

      % evaluate function
      jac__1_1 = -2 * u_dot;
      jac__1_2 = -2 * v_dot;
      jac__1_3 = -4 * u;
      jac__1_4 = -4 * v;

      % store on output
      jac__Wx = zeros(1,4);
      jac__Wx(1,1) = jac__1_1;
      jac__Wx(1,2) = jac__1_2;
      jac__Wx(1,3) = jac__1_3;
      jac__Wx(1,4) = jac__1_4;

      sol = M\[jac__Hx;jac__Wx];

      jac__jode = [eye(npos), zeros(npos,npos);sol(1:npos,:)];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % interface function
    function res = DfDt( self, t, vars___)
      res = zeros(4,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % interface function
    function res = exact( self, t0, x0, t )
      res = []; % no exact solution
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % interface function
    function res__H = h( self, t, vars__ )
      res__H = [ self.Phi( t, vars__ ); self.A( t, vars__ ) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % interface function
    function jac__JH = DhDx( self, t, vars__ )
      jac__JH = [ self.DPhiDp( t, vars__ ), zeros(1,2); ...
                  self.DADp( t, vars__ ),  self.DPhiDp( t, vars__ ) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % interface function
    function res = DhDt( self, t, vars__ )
      res = zeros(2,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);

      hold off;
      drawAxes( 2, 0.25, 3, 0, 0 );
      hold on;

      xm  = x/2;
      ym  = y/2;
      dx  = self.L*x/hypot(x,y);
      dy  = self.L*y/hypot(x,y);
      xx0 = xm - dx/2;
      yy0 = ym - dy/2;
      xx1 = xm + dx/2;
      yy1 = ym + dy/2;

      plot( [xx0,xx1], [yy0,yy1], 'LineWidth',4,'Color','red');
      fillCircle( 'red', xx0, yy0, 0.05 );
      fillCircle( 'red', xx1, yy1, 0.05 );

      fillCircle( 'black', 0, 0, 0.05 );
      axis equal;
      axis([-1.1 1.1 -1.1 1.1]*self.L);
    end
  end
end
