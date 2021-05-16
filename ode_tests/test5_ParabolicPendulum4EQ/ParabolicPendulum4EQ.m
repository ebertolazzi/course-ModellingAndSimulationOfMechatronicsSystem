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
classdef ParabolicPendulum4EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    mass;
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
      m     = self.mass;
      omega = self.omega;
      eta   = self.eta;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = u ^ 2;
      res__1 = -(-4 * t1 + g) * x;
      res__2 = -2 * t1 - g / 2;
      t7 = x ^ 2;
      t8 = t7 ^ 2;
      t12 = y ^ 2;
      t14 = omega ^ 2;
      t37 = v ^ 2;
      res__3 = t14 * (-t8 + t7 * (2 * y - 1) - t12 + 1) - 8 * omega * (t7 * x * u - t7 * v / 2 - (y - 0.1e1 / 0.2e1) * u * x + v * y / 2) * eta - 12 * t7 * t1 + 8 * u * v * x + t1 * (4 * y - 2) - 2 * t37;

      % store on output
      res__bigRHS = zeros(3,1);
      res__bigRHS(1) = res__1;
      res__bigRHS(2) = res__2;
      res__bigRHS(3) = res__3;

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__JbigRHS = JbigRHS( self, t, vars__ )
      % extract parameters
      omega = self.omega;
      eta   = self.eta;
      g     = self.gravity;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
 
      % evaluate function
      t1 = u ^ 2;
      t2 = 4 * t1;
      res__1_1 = t2 - g;
      t3 = x * u;
      res__1_3 = 8 * t3;
      res__2_3 = -4 * u;
      t5 = x ^ 2;
      t6 = t5 * x;
      t12 = omega ^ 2;
      t14 = t5 * u;
      res__3_1 = t12 * (-4 * t6 + (4 * y - 2) * x) - 24 * omega * (t14 - v * x / 3 - (y - 0.1e1 / 0.2e1) * u / 3) * eta - 24 * t1 * x + 8 * u * v;
      t28 = t5 - y;
      res__3_2 = 2 * t12 * t28 + 8 * omega * eta * (t3 - v / 2) + t2;
      t41 = 8 * y - 4;
      res__3_3 = -8 * t6 * omega * eta - 24 * t14 + x * (omega * eta * t41 + 8 * v) + u * t41;
      res__3_4 = 4 * omega * t28 * eta - 4 * v + res__1_3;
      
      % store on output
      res__JbigRHS = zeros(3,4);
      res__JbigRHS(1,1) = res__1_1;
      res__JbigRHS(1,3) = res__1_3;
      res__JbigRHS(2,3) = res__2_3;
      res__JbigRHS(3,1) = res__3_1;
      res__JbigRHS(3,2) = res__3_2;
      res__JbigRHS(3,3) = res__3_3;
      res__JbigRHS(3,4) = res__3_4; 

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__bigM = bigM( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = x ^ 2;
      res__1_1 = 4 * t1 + 1;
      res__1_2 = 2 * x;
      res__1_3 = 4 * t1 * x - 4 * x * y + res__1_2;
      res__2_1 = res__1_2;
      res__2_2 = 1;
      res__2_3 = -2 * t1 + 2 * y;
      res__3_1 = res__1_3;
      res__3_2 = res__2_3;
      
      % store on output
      res__bigM = zeros(3,3);
      res__bigM(1,1) = res__1_1;
      res__bigM(1,2) = res__1_2;
      res__bigM(1,3) = res__1_3;
      res__bigM(2,1) = res__2_1;
      res__bigM(2,2) = res__2_2;
      res__bigM(2,3) = res__2_3;
      res__bigM(3,1) = res__3_1;
      res__bigM(3,2) = res__3_2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__bigETA = bigETA( self, t, vars__, mu )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);

      omega = self.omega;
      eta   = self.eta;

      % evaluate function
      t1 = x ^ 2;
      t2 = t1 * x;
      t8 = -4 * y + 2;
      res__1 = 4 * t2 * mu3 + 4 * t1 * mu1 + x * (mu3 * t8 + 2 * mu2) + mu1;
      res__2 = 2 * x * mu1 + mu2 + mu3 * (-2 * t1 + 2 * y);
      res__3 = x * mu1 * t8 + 4 * t2 * mu1 - 2 * t1 * mu2 + 2 * mu2 * y;

      % store on output
      res__bigETA = zeros(3,1);
      res__bigETA(1) = res__1;
      res__bigETA(2) = res__2;
      res__bigETA(3) = res__3;

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__JbigETA = JbigETA( self, t, vars__, mu )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);

      omega = self.omega;
      eta   = self.eta;
      g     = self.gravity;

      % evaluate function
      t1 = x * mu1;
      t3 = 2 * mu2;
      t4 = x ^ 2;
      t7 = 12 * t4 - 4 * y + 2;
      res__1_1 = mu3 * t7 + 8 * t1 + t3;
      res__1_2 = -4 * x * mu3;
      res__2_1 = res__1_2 + 2 * mu1;
      res__2_2 = 2 * mu3;
      res__3_1 = mu1 * t7 - 4 * x * mu2;
      res__3_2 = -4 * t1 + t3;
      
      % store on output
      res__JbigETA = zeros(3,4);
      res__JbigETA(1,1) = res__1_1;
      res__JbigETA(1,2) = res__1_2;
      res__JbigETA(2,1) = res__2_1;
      res__JbigETA(2,2) = res__2_2;
      res__JbigETA(3,1) = res__3_1;
      res__JbigETA(3,2) = res__3_2;
    end
  end

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = ParabolicPendulum4EQ( mass, gravity )
      % call the constructor of the basic class
      neq  = 4;
      ninv = 2;
      self@DAC_ODEclass('ParabolicPendulum4EQ',neq,ninv);
      % setup of the parmater of the ODE
      self.mass    = mass;
      self.gravity = gravity;
      self.eta     = 0;
      self.omega   = 0;
      self.npos    = 2;
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
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = x ^ 2;
      t2 = t1 ^ 2;
      t6 = y ^ 2;
      res__1 = t2 + t1 * (-2 * y + 1) + t6 - 1;
      res__2 = 4 * t1 * x * u - 2 * t1 * v + (-4 * y + 2) * u * x + 2 * y * v;

      % store on output
      res__h = zeros(2,1);
      res__h(1) = res__1;
      res__h(2) = res__2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DhDx = DhDx( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = x ^ 2;
      res__1_1 = 4 * t1 * x - 4 * x * y + 2 * x;
      res__1_2 = -2 * t1 + 2 * y;
      res__2_1 = u * (12 * t1 - 4 * y + 2) - 4 * x * v;
      res__2_2 = -4 * x * u + 2 * v;
      res__2_3 = res__1_1;
      res__2_4 = res__1_2;
      
      % store on output
      res__DhDx = zeros(2,4);
      res__DhDx(1,1) = res__1_1;
      res__DhDx(1,2) = res__1_2;
      res__DhDx(2,1) = res__2_1;
      res__DhDx(2,2) = res__2_2;
      res__DhDx(2,3) = res__2_3;
      res__DhDx(2,4) = res__2_4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
      ParabolicPendulumPlot( t, Z(1), Z(2) );
    end
  end
end
