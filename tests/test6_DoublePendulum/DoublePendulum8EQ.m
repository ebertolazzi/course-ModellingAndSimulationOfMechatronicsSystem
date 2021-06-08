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
classdef DoublePendulum8EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    L1;
    L2;
    m1;
    m2;
    gravity;
    % baumgarte stabilization
    omega;
    eta;
    npos;
  end
  methods (Access = private)
    function res__bigRHS = bigRHS( self, t, vars__ )
      % extract parameters
      g     = self.gravity;
      m1    = self.m1;
      m2    = self.m2;
      L1    = self.L1;
      L2    = self.L2;
      omega = self.omega;
      eta   = self.eta;

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
      res__2 = -m1 * g;
      res__4 = -m2 * g;
      t3 = L1 ^ 2;
      t4 = x1 ^ 2;
      t5 = y1 ^ 2;
      t7 = omega ^ 2;
      t15 = u1 ^ 2;
      t16 = 2 * t15;
      t17 = v1 ^ 2;
      res__5 = t7 * (t3 - t4 - t5) - 4 * eta * (x1 * u1 + y1 * v1) * omega - t16 - 2 * t17;
      t21 = x2 ^ 2;
      t27 = -x2 + x1;
      t32 = v1 - v2;
      t40 = u2 ^ 2;
      t42 = t32 ^ 2;
      res__6 = t7 * (-t4 + 2 * x2 * x1 - t21 + (L2 + y1 - y2) * (L2 - y1 + y2)) - 4 * omega * eta * (u1 * t27 - u2 * t27 + t32 * (-y2 + y1)) - t16 + 4 * u2 * u1 - 2 * t40 - 2 * t42;

      % store on output
      res__bigRHS = zeros(6,1);
      res__bigRHS(2) = res__2;
      res__bigRHS(4) = res__4;
      res__bigRHS(5) = res__5;
      res__bigRHS(6) = res__6;

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__JbigRHS = JbigRHS( self, t, vars__ )
      % extract parameters
      g     = self.gravity;
      m1    = self.m1;
      m2    = self.m2;
      L1    = self.L1;
      L2    = self.L2;
      omega = self.omega;
      eta   = self.eta;

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
      t1 = eta * omega;
      t4 = omega ^ 2;
      res__5_1 = -4 * u1 * t1 - 2 * x1 * t4;
      res__5_2 = -4 * v1 * t1 - 2 * y1 * t4;
      res__5_5 = -4 * x1 * t1 - 4 * u1;
      res__5_6 = -4 * y1 * t1 - 4 * v1;
      t15 = -x2 + x1;
      t22 = 4 * (omega * t15 / 2 + eta * (-u2 + u1)) * omega;
      res__6_1 = -t22;
      t23 = -y2 + y1;
      t30 = 4 * (omega * t23 / 2 + eta * (v1 - v2)) * omega;
      res__6_2 = -t30;
      res__6_3 = t22;
      res__6_4 = t30;
      res__6_5 = -4 * omega * t15 * eta - 4 * u1 + 4 * u2;
      res__6_6 = -4 * omega * t23 * eta - 4 * v1 + 4 * v2;
      res__6_7 = -res__6_5;
      res__6_8 = -res__6_6;
      
      % store on output
      res__JbigRHS = zeros(6,8);
      res__JbigRHS(5,1) = res__5_1;
      res__JbigRHS(5,2) = res__5_2;
      res__JbigRHS(5,5) = res__5_5;
      res__JbigRHS(5,6) = res__5_6;
      res__JbigRHS(6,1) = res__6_1;
      res__JbigRHS(6,2) = res__6_2;
      res__JbigRHS(6,3) = res__6_3;
      res__JbigRHS(6,4) = res__6_4;
      res__JbigRHS(6,5) = res__6_5;
      res__JbigRHS(6,6) = res__6_6;
      res__JbigRHS(6,7) = res__6_7;
      res__JbigRHS(6,8) = res__6_8;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__bigM = bigM( self, t, vars__ )

      g  = self.gravity;
      m1 = self.m1;
      m2 = self.m2;
      L1 = self.L1;
      L2 = self.L2;

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
      res__1_1 = m1;
      res__1_5 = 2 * x1;
      res__1_6 = -2 * x2 + 2 * x1;
      res__2_2 = m1;
      res__2_5 = 2 * y1;
      res__2_6 = -2 * y2 + 2 * y1;
      res__3_3 = m2;
      res__3_6 = -res__1_6;
      res__4_4 = m2;
      res__4_6 = -res__2_6;
      res__5_1 = res__1_5;
      res__5_2 = res__2_5;
      res__6_1 = res__1_6;
      res__6_2 = res__2_6;
      res__6_3 = res__3_6;
      res__6_4 = res__4_6;
      
      % store on output
      res__bigM = zeros(6,6);
      res__bigM(1,1) = res__1_1;
      res__bigM(1,5) = res__1_5;
      res__bigM(1,6) = res__1_6;
      res__bigM(2,2) = res__2_2;
      res__bigM(2,5) = res__2_5;
      res__bigM(2,6) = res__2_6;
      res__bigM(3,3) = res__3_3;
      res__bigM(3,6) = res__3_6;
      res__bigM(4,4) = res__4_4;
      res__bigM(4,6) = res__4_6;
      res__bigM(5,1) = res__5_1;
      res__bigM(5,2) = res__5_2;
      res__bigM(6,1) = res__6_1;
      res__bigM(6,2) = res__6_2;
      res__bigM(6,3) = res__6_3;
      res__bigM(6,4) = res__6_4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__bigETA = bigETA( self, t, vars__, mu )
      g  = self.gravity;
      m1 = self.m1;
      m2 = self.m2;
      L1 = self.L1;
      L2 = self.L2;

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
      t5 = -2 * x2 + 2 * x1;
      res__1 = m1 * mu1 + 2 * x1 * mu5 + mu6 * t5;
      t10 = -y2 + y1;
      t11 = 2 * t10;
      res__2 = m1 * mu2 + 2 * y1 * mu5 + mu6 * t11;
      t14 = -t5;
      res__3 = m2 * mu3 + mu6 * t14;
      res__4 = m2 * mu4 - mu6 * t11;
      res__5 = 2 * x1 * mu1 + 2 * y1 * mu2;
      res__6 = mu1 * t5 + mu2 * t11 + mu3 * t14 - 2 * t10 * mu4;

      % store on output
      res__bigETA = zeros(6,1);
      res__bigETA(1) = res__1;
      res__bigETA(2) = res__2;
      res__bigETA(3) = res__3;
      res__bigETA(4) = res__4;
      res__bigETA(5) = res__5;
      res__bigETA(6) = res__6;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__JbigETA = JbigETA( self, t, vars__, mu )

      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);
      mu4 = mu(4);
      mu5 = mu(5);
      mu6 = mu(6);

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
      res__1_1 = 2 * mu5 + 2 * mu6;
      t2 = 2 * mu6;
      res__1_3 = -t2;
      res__2_2 = res__1_1;
      res__2_4 = res__1_3;
      res__3_1 = res__2_4;
      res__3_3 = t2;
      res__4_2 = res__3_1;
      res__4_4 = res__3_3;
      res__5_1 = 2 * mu1;
      res__5_2 = 2 * mu2;
      res__6_1 = 2 * mu1 - 2 * mu3;
      res__6_2 = 2 * mu2 - 2 * mu4;
      res__6_3 = -res__6_1;
      res__6_4 = -res__6_2;
      
      % store on output
      res__JbigETA = zeros(6,8);
      res__JbigETA(1,1) = res__1_1;
      res__JbigETA(1,3) = res__1_3;
      res__JbigETA(2,2) = res__2_2;
      res__JbigETA(2,4) = res__2_4;
      res__JbigETA(3,1) = res__3_1;
      res__JbigETA(3,3) = res__3_3;
      res__JbigETA(4,2) = res__4_2;
      res__JbigETA(4,4) = res__4_4;
      res__JbigETA(5,1) = res__5_1;
      res__JbigETA(5,2) = res__5_2;
      res__JbigETA(6,1) = res__6_1;
      res__JbigETA(6,2) = res__6_2;
      res__JbigETA(6,3) = res__6_3;
      res__JbigETA(6,4) = res__6_4;
    end
  end

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = DoublePendulum8EQ( data, eta, omega )
      % call the constructor of the basic class
      neq  = 8;
      ninv = 4;
      self@DAC_ODEclass('DoublePendulum8EQ',neq,ninv);
      % setup of the parmater of the ODE

      self.gravity = data.gravity;
      self.L1      = data.L1;
      self.L2      = data.L2;
      self.m1      = data.m1;
      self.m2      = data.m2;
      self.eta     = eta;
      self.omega   = omega;
      self.npos    = 4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function setBaumgarte( self, eta, omega )
      self.eta   = eta;
      self.omega = omega;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__rhs = f( self, t, vars__ )
      npos = self.npos;
      %
      %       / f(q,v,t) \
      % RHS = |          |
      %       \ g(q,v,t) /
      %
      RHS = self.bigRHS( t, vars__ );
      %
      %
      %        / M(q,v,t)  Phi_q(q,t)^T \
      % BIGM = |                        |
      %        \ Phi_q(q,t)     0       /
      %
      BIGM = self.bigM( t, vars__ );
      SOL  = BIGM\RHS;
    
      % evaluate function
      res__rhs = zeros(2*npos,1);
      res__rhs(1:npos)        = vars__(npos+1:2*npos);
      res__rhs(npos+1:2*npos) = SOL(1:npos);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DfDx( self, t, vars__ )
      %
      %       / f(q,v,t) \
      % RHS = |          |
      %       \ g(q,v,t) /
      %
      RHS = self.bigRHS( t, vars__ );
      %
      %
      %        / M(q,v,t)  Phi_q(q,t)^T \
      % BIGM = |                        |
      %        \ Phi_q(q,t)     0       /
      %
      BIGM = self.bigM( t, vars__ );

      SOL  = BIGM\RHS;
      JETA = self.JbigETA( t, vars__, SOL );
      JRHS = self.JbigRHS( t, vars__ );
      JM   = BIGM\(JRHS-JETA);
      
      % combine all jacobians
      npos = self.npos;
      jac  = [ zeros(npos,npos) eye(npos); JM(1:npos,:) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__h = h( self, t, vars__ )
      g  = self.gravity;
      m1 = self.m1;
      m2 = self.m2;
      L1 = self.L1;
      L2 = self.L2;

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
      t1 = L1 ^ 2;
      t2 = x1 ^ 2;
      t3 = y1 ^ 2;
      res__1 = -t1 + t2 + t3;
      t4 = L2 ^ 2;
      t7 = x2 ^ 2;
      t10 = y2 ^ 2;
      res__2 = -2 * x1 * x2 - 2 * y1 * y2 + t10 + t2 + t3 - t4 + t7;
      res__3 = 2 * u1 * x1 + 2 * v1 * y1;
      t15 = -2 * x2 + 2 * x1;
      res__4 = u1 * t15 - u2 * t15 + 2 * (-y2 + y1) * (v1 - v2);

      % store on output
      res__h = zeros(4,1);
      res__h(1) = res__1;
      res__h(2) = res__2;
      res__h(3) = res__3;
      res__h(4) = res__4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DhDx = DhDx( self, t, vars__ )
      g  = self.gravity;
      m1 = self.m1;
      m2 = self.m2;
      L1 = self.L1;
      L2 = self.L2;

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
      res__1_1 = 2 * x1;
      res__1_2 = 2 * y1;
      res__2_1 = -2 * x2 + 2 * x1;
      res__2_2 = -2 * y2 + 2 * y1;
      res__2_3 = -res__2_1;
      res__2_4 = -res__2_2;
      res__3_1 = 2 * u1;
      res__3_2 = 2 * v1;
      res__3_5 = res__1_1;
      res__3_6 = res__1_2;
      res__4_1 = -2 * u2 + 2 * u1;
      res__4_2 = -2 * v2 + 2 * v1;
      res__4_3 = -res__4_1;
      res__4_4 = -res__4_2;
      res__4_5 = res__2_1;
      res__4_6 = res__2_2;
      res__4_7 = res__2_3;
      res__4_8 = res__2_4;
      
      % store on output
      res__DhDx = zeros(4,8);
      res__DhDx(1,1) = res__1_1;
      res__DhDx(1,2) = res__1_2;
      res__DhDx(2,1) = res__2_1;
      res__DhDx(2,2) = res__2_2;
      res__DhDx(2,3) = res__2_3;
      res__DhDx(2,4) = res__2_4;
      res__DhDx(3,1) = res__3_1;
      res__DhDx(3,2) = res__3_2;
      res__DhDx(3,5) = res__3_5;
      res__DhDx(3,6) = res__3_6;
      res__DhDx(4,1) = res__4_1;
      res__DhDx(4,2) = res__4_2;
      res__DhDx(4,3) = res__4_3;
      res__DhDx(4,4) = res__4_4;
      res__DhDx(4,5) = res__4_5;
      res__DhDx(4,6) = res__4_6;
      res__DhDx(4,7) = res__4_7;
      res__DhDx(4,8) = res__4_8;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
      DoublePendulumPlot( t, Z(1), Z(2), Z(3), Z(4), self.L1, self.L2 );
    end
  end
end
