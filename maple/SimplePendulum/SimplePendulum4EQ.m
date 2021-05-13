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
classdef SimplePendulum4EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    ell;
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
      L     = self.ell;
      omega = self.omega;
      eta   = self.eta;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
    
      % evaluate function
      res__2 = -m * g;
      t2 = L ^ 2;
      t3 = x ^ 2;
      t4 = y ^ 2;
      t6 = omega ^ 2;
      t14 = u ^ 2;
      t16 = v ^ 2;
      res__3 = t6 * (t2 - t3 - t4) - 4 * eta * (u * x + v * y) * omega - 2 * t14 - 2 * t16;

      % store on output
      res__bigRHS    = zeros(3,1);
      res__bigRHS(2) = res__2;
      res__bigRHS(3) = res__3;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__JbigRHS = JbigRHS( self, t, vars__ )
      % extract parameters
      omega = self.omega;
      eta   = self.eta;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = omega * eta;
      t4 = omega ^ 2;
      res__3_1 = -4 * u * t1 - 2 * x * t4;
      res__3_2 = -4 * v * t1 - 2 * y * t4;
      res__3_3 = -4 * x * t1 - 4 * u;
      res__3_4 = -4 * y * t1 - 4 * v;
      
      % store on output
      res__JbigRHS = zeros(3,4);
      res__JbigRHS(3,1) = res__3_1;
      res__JbigRHS(3,2) = res__3_2;
      res__JbigRHS(3,3) = res__3_3;
      res__JbigRHS(3,4) = res__3_4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__bigM = bigM( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.mass;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
    
      % evaluate function
      res__1_1 = m;
      res__1_3 = 2 * x;
      res__2_2 = m;
      res__2_3 = 2 * y;
      res__3_1 = res__1_3;
      res__3_2 = res__2_3;

      % store on output
      res__bigM      = zeros(3,3);
      res__bigM(1,1) = res__1_1;
      res__bigM(1,3) = res__1_3;
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

      % evaluate function
      res__1 = m * mu1 + 2 * x * mu3;
      res__2 = m * mu2 + 2 * y * mu3;
      res__3 = 2 * x * mu1 + 2 * y * mu2;

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

      % evaluate function
      res__1_1 = 2 * mu3;
      res__2_2 = res__1_1;
      res__3_1 = 2 * mu1;
      res__3_2 = 2 * mu2;
      
      % store on output
      res__JbigETA      = zeros(3,4);
      res__JbigETA(1,1) = res__1_1;
      res__JbigETA(2,2) = res__2_2;
      res__JbigETA(3,1) = res__3_1;
      res__JbigETA(3,2) = res__3_2;
    end
  end

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = SimplePendulum4EQ( mass, ell, gravity )
      % call the constructor of the basic class
      self@DAC_ODEclass('SimplePendulum4EQ',4);
      % setup of the parmater of the ODE
      self.mass    = mass;
      self.ell     = ell;
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
    function plot( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      tt = 0:pi/30:2*pi;
      xx = self.ell*cos(tt);
      yy = self.ell*sin(tt);
      hold off;
      plot(xx,yy,'LineWidth',2,'Color','red');
      LL = 1-self.ell/hypot(x,y);
      x0 = LL*x;
      y0 = LL*y;
      hold on;
      L = 1.5*self.ell;
      drawLine(-L,0,L,0,'LineWidth',2,'Color','k');
      drawLine(0,-L,0,L,'LineWidth',2,'Color','k');
      drawAxes(2,0.25,1,0,0);
      drawLine(x0,y0,x,y,'LineWidth',8,'Color','b');
      drawCOG( 0.1*self.ell, x0, y0 );
      fillCircle( 'r', x, y, 0.1*self.ell );
      axis([-L L -L L]);
      title(sprintf('time=%g',t));
      axis equal;
    end
  end
end
