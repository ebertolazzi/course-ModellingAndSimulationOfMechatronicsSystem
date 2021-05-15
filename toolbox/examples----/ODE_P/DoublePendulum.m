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
classdef DoublePendulum < ODEbaseClass_P
  properties (SetAccess = protected, Hidden = true)
    gravity;
    m1;
    m2;
    L1;
    L2;
  end
  methods
    function self = DoublePendulum( data )
      self@ODEbaseClass_P('DoublePendulum',8,4); % 8 equation 4 invariant
      self.gravity = data.gravity;
      self.m1      = data.m1;
      self.m2      = data.m2;
      self.L1      = data.L1;
      self.L2      = data.L2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function M = Mass( self, t, vars__ )
      M = diag([self.m1,self.m1,self.m2,self.m2]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__Phi = Phi( self, t, vars__ )
      L1 = self.L1;
      L2 = self.L2;
      % extract states
      x1 = vars__(1);
      y1 = vars__(2);
      x2 = vars__(3);
      y2 = vars__(4);

      % evaluate function
      t1 = L1 ^ 2;
      t2 = x1 ^ 2;
      t3 = y1 ^ 2;
      res__1 = -t1 + t2 + t3;
      t4 = L2 ^ 2;
      t7 = x2 ^ 2;
      t10 = y2 ^ 2;
      res__2 = -2 * x2 * x1 - 2 * y2 * y1 + t10 + t2 + t3 - t4 + t7;

      % store on output
      res__Phi    = zeros(2,1);
      res__Phi(1) = res__1;
      res__Phi(2) = res__2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__Phi_P = DPhiDp( self, t, vars__ )
      % extract states
      x1 = vars__(1);
      y1 = vars__(2);
      x2 = vars__(3);
      y2 = vars__(4);

      % evaluate function
      jac__1_1 = 2 * x1;
      jac__1_2 = 2 * y1;
      jac__2_1 = 2 * x1 - 2 * x2;
      jac__2_2 = -2 * y2 + 2 * y1;
      jac__2_3 = -jac__2_1;
      jac__2_4 = -jac__2_2;

      % store on output
      jac__Phi_P = zeros(2,4);
      jac__Phi_P(1,1) = jac__1_1;
      jac__Phi_P(1,2) = jac__1_2;
      jac__Phi_P(2,1) = jac__2_1;
      jac__Phi_P(2,2) = jac__2_2;
      jac__Phi_P(2,3) = jac__2_3;
      jac__Phi_P(2,4) = jac__2_4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__Phi_t = DPhiDt( self, t, vars__ )
      jac__Phi_t = zeros(2,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function A_res = A( self, t, vars__ )
      % extract states
      pos = vars__(1:4);
      vel = vars__(5:8);
      A_res = self.DPhiDp( t, pos ) * vel + self.DPhiDt( t, pos );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__A = DADp( self, t, vars__ )
      % extract states
      x1 = vars__(1);
      y1 = vars__(2);
      x2 = vars__(3);
      y2 = vars__(4);
      u1 = vars__(5);
      v1 = vars__(6);
      u2 = vars__(7);
      v2 = vars__(8);

      % evaluate function
      jac__1_1 = 2 * u1;
      jac__1_2 = 2 * v1;
      jac__2_1 = -2 * u2 + 2 * u1;
      jac__2_2 = 2 * v1 - 2 * v2;
      jac__2_3 = -jac__2_1;
      jac__2_4 = -jac__2_2;

      % store on output
      jac__A = zeros(2,4);
      jac__A(1,1) = jac__1_1;
      jac__A(1,2) = jac__1_2;
      jac__A(2,1) = jac__2_1;
      jac__A(2,2) = jac__2_2;
      jac__A(2,3) = jac__2_3;
      jac__A(2,4) = jac__2_4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__A = DADt( self, t, vars__ )
      % extract states
      jac__A = zeros(2,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function B_res = B( self, t, vars__ )
      % extract states
      vel   = vars__(5:8);
      B_res = -(self.DADp( t, vars__ ) * vel + self.DADt( t, vars__ ));
    end
    function res__gfun = gfun( self, t, vars__ )
      g  = self.gravity;
      m1 = self.m1;
      m2 = self.m2;
      % extract states
      x1 = vars__(1);
      y1 = vars__(2);
      x2 = vars__(3);
      y2 = vars__(4);
      u1 = vars__(5);
      v1 = vars__(6);
      u2 = vars__(7);
      v2 = vars__(8);

      % evaluate function
      res__1 = 0;
      res__2 = -m1 * g;
      res__3 = 0;
      res__4 = -m2 * g;

      % store on output
      res__gfun = zeros(4,1);
      res__gfun(1) = res__1;
      res__gfun(2) = res__2;
      res__gfun(3) = res__3;
      res__gfun(4) = res__4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__ode = f( self, t, vars__ )
      pos      = vars__(1:4);
      vel      = vars__(5:8);
      g        = self.gravity;
      Phi_P    = self.DPhiDp( t, pos );
      mass     = self.Mass( t, pos );
      M        = [ mass, Phi_P.'; Phi_P, zeros(2,2) ];
      rhs      = [ self.gfun( t, vars__ ); self.B( t, vars__ )];
      sol      = M\rhs;
      res__ode = [ vel; sol(1:4)];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__jode = DfDx( self, t, vars__ )
      g        = self.gravity;
      npos     = self.neq/2;
      pos      = vars__(1:npos);
      vel      = vars__(npos+1:end);
      g        = self.gravity;
      Phi_P    = self.DPhiDp( t, pos );
      mass     = self.Mass( t, pos );
      M        = [ mass, Phi_P.'; Phi_P, zeros(1,1) ];
      rhs      = [ self.gfun( t, vars__ ); self.B( t, vars__ )];
      sol      = M\rhs;
      vars_dot = sol(1:4);
      lambda   = sol(4:6);

      u1_dot = vars_dot(1);
      v1_dot = vars_dot(2);
      u2_dot = vars_dot(3);
      v2_dot = vars_dot(4);

      %
      %  / M      Phi_P^T \     d   / v_dot  \      d    / H(t,p,v,v_dot,lambda) \
      %  |                |  ------ |         | = ------ |                       |
      %  \ Phi_P    0     /  d{p,v} \ lambda /    d{p,v} \ W(t,p,v,v_dot)        /
      %
      % extract states
      x1 = vars__(1);
      y1 = vars__(2);
      x2 = vars__(3);
      y2 = vars__(4);
      u1 = vars__(5);
      v1 = vars__(6);
      u2 = vars__(7);
      v2 = vars__(8);
      lambda1 = lambda(1);
      lambda2 = lambda(2);

      % evaluate function
      jac__1_1 = -2 * lambda1 - 2 * lambda2;
      jac__1_3 = 2 * lambda2;
      jac__2_2 = jac__1_1;
      jac__2_4 = jac__1_3;
      jac__3_1 = jac__2_4;
      jac__3_3 = -jac__3_1;
      jac__4_2 = jac__3_1;
      jac__4_4 = jac__3_3;

      % store on output
      jac__Hx = zeros(4,8);
      jac__Hx(1,1) = jac__1_1;
      jac__Hx(1,3) = jac__1_3;
      jac__Hx(2,2) = jac__2_2;
      jac__Hx(2,4) = jac__2_4;
      jac__Hx(3,1) = jac__3_1;
      jac__Hx(3,3) = jac__3_3;
      jac__Hx(4,2) = jac__4_2;
      jac__Hx(4,4) = jac__4_4;

      % evaluate function
      jac__1_1 = -2 * u1_dot;
      jac__1_2 = -2 * v1_dot;
      jac__1_5 = -4 * u1;
      jac__1_6 = -4 * v1;
      jac__2_1 = -2 * u1_dot + 2 * u2_dot;
      jac__2_2 = -2 * v1_dot + 2 * v2_dot;
      jac__2_3 = -jac__2_1;
      jac__2_4 = -jac__2_2;
      jac__2_5 = 4 * u2 - 4 * u1;
      jac__2_6 = 4 * v2 - 4 * v1;
      jac__2_7 = -jac__2_5;
      jac__2_8 = -jac__2_6;

      % store on output
      jac__Wx = zeros(2,8);
      jac__Wx(1,1) = jac__1_1;
      jac__Wx(1,2) = jac__1_2;
      jac__Wx(1,5) = jac__1_5;
      jac__Wx(1,6) = jac__1_6;
      jac__Wx(2,1) = jac__2_1;
      jac__Wx(2,2) = jac__2_2;
      jac__Wx(2,3) = jac__2_3;
      jac__Wx(2,4) = jac__2_4;
      jac__Wx(2,5) = jac__2_5;
      jac__Wx(2,6) = jac__2_6;
      jac__Wx(2,7) = jac__2_7;
      jac__Wx(2,8) = jac__2_8;

      sol = M\[jac__Hx;jac__Wx];

      jac__jode = [eye(npos), zeros(npos,npos);sol(1:npos,:)];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = DfDt( self, t, vars___)
      res = zeros(8,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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
      jac__JH = [ self.DPhiDp( t, vars__ ), zeros(2,4); ...
                  self.DADp( t, vars__ ),  self.DPhiDp( t, vars__ ) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = DhDt( self, t, vars__ )
      res = zeros(4,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, vars__ )
      % extract states
      x1 = vars__(1);
      y1 = vars__(2);
      x2 = vars__(3);
      y2 = vars__(4);

      hold off;
      drawAxes( 2, 0.25, 3, 0, 0 );
      hold on;

      xm  = x1/2;
      ym  = y1/2;
      dx  = self.L1*x1/hypot(x1,y1);
      dy  = self.L1*y1/hypot(x1,y1);
      xx0 = xm - dx/2;
      yy0 = ym - dy/2;
      xx1 = xm + dx/2;
      yy1 = ym + dy/2;

      plot( [xx0,xx1], [yy0,yy1], 'LineWidth',4,'Color','red');
      fillCircle( 'red', xx0, yy0, 0.05 );
      fillCircle( 'red', xx1, yy1, 0.05 );

      xm  = (x1+x2)/2;
      ym  = (y1+y2)/2;
      dx  = self.L1*(x2-x1)/hypot(x2-x1,y2-y1);
      dy  = self.L1*(y2-y1)/hypot(x2-x1,y2-y1);
      xx0 = xm - dx/2;
      yy0 = ym - dy/2;
      xx1 = xm + dx/2;
      yy1 = ym + dy/2;

      plot( [xx0,xx1], [yy0,yy1], 'LineWidth',4,'Color','red');
      fillCircle( 'red', xx0, yy0, 0.05 );
      fillCircle( 'red', xx1, yy1, 0.05 );

      fillCircle( 'black', 0, 0, 0.05 );
      axis equal;
      axis([-1.1 1.1 -1.1 1.1]*(self.L1+self.L2));
    end
  end
end
